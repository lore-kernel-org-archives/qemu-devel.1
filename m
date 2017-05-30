Received: from eggs.gnu.org ([2001:4830:134:3::10]:49055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFkhV-00016G-De
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dFkhR-0003hd-L5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dFkhR-0003hG-E2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 13:12:53 -0400
Date: Tue, 30 May 2017 18:12:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170530171251.GU21566@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
	<CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
	<20170530140103.GI32274@thinpad.lan.raisama.net>
	<CAFEAcA8zh4-EJfoW89woUEJngJQdEaOpZYceGCpfNbO99XCD8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zh4-EJfoW89woUEJngJQdEaOpZYceGCpfNbO99XCD8w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>

On Tue, May 30, 2017 at 06:08:04PM +0100, Peter Maydell wrote:
> On 30 May 2017 at 15:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, May 30, 2017 at 11:45:55AM +0100, Peter Maydell wrote:
> >> Hi all; I'm afraid this patch breaks compilation on OSX:
> >
> > It looks like this wasn't detected by travis-ci because the build
> > is not using -Werror:
> > https://travis-ci.org/ehabkost/qemu/jobs/236485778#L3881
> 
> Hmm. It would be nice to fix that. configure doesn't enable -Werror
> by default on OSX because it doesn't handle some of the pragmas
> to disable warnings that we use, but on the typical OSX build
> the warnings that we use the pragmas to suppress don't get
> generated anyway, so -Werror works in practice. It needs
> configure '--extra-cflags=-Werror' to turn on.
> (It might also need --disable-vnc-sasl depending on OSX version
> since Apple helpfully added a pile of deprecation warnings to
> their version of the sasl headers without suggesting what to
> use instead.)

The same warnings hit libvirt on OS-X too and some pragmas were
sufficient to shut it up

    _Pragma ("GCC diagnostic push")
    _Pragma ("GCC diagnostic ignored \"-Wdeprecated-declarations\"")

    .... sasl code...

    _Pragma ("GCC diagnostic pop")


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
