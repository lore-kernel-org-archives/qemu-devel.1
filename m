Received: from eggs.gnu.org ([2001:4830:134:3::10]:48757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1cqi1i-0004bf-7R
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1cqi1e-0008OJ-4v
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:18:18 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1cqi1d-0008O5-TT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:18:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id n141so26504627qke.3
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:18:13 -0700 (PDT)
Date: Wed, 22 Mar 2017 11:18:10 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170322151810.GA17564@morn.lan>
References: <87bmstu19t.fsf@dusky.pond.sub.org>
	<1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
	<20170322132549.3d7e2a49@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170322132549.3d7e2a49@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS]  Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org, =?iso-8859-1?B?TOFzemzzIMlyc2Vr?= <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Wed, Mar 22, 2017 at 01:25:49PM +0100, Igor Mammedov wrote:
> On Wed, 22 Mar 2017 11:03:44 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> > On 22.03.2017 10:08, Markus Armbruster wrote:
> > > Are we now ready to accept a simple & stupid patch that actually helps
> > > users, say letting boards that care declare minimum and maximum RAM
> > > size?  And make PC reject RAM size less than 1MiB, even though "someone"
> > > might conceivably have firmware that works with less?  
> > 
> > I'd say enforce a minimum RAM size on the normal "pc" and "q35" machine,
> > but still allow smaller sizes on the "isapc" machine. So if "someone"
> > comes around and claims to have a legacy firmware that wants less memory
> > than 1MiB, just point them to the isapc machine.
> > Just my 0.02 €.
> 
> We can print warning that minimum size will be enforced in 1-2
> releases since 2.9/10 and when it's enforced send users that need
> less to an old qemu version.

I did not think that QEMU ever worked on an x86 machine with less than
1MiB of ram.  Certainly SeaBIOS has never supported it.  I'm pretty
sure that Bochs BIOS (qemu < v0.12) did not support it either - its
ram detection system assumed a minimum of 1MiB.

My $.02 - I agree with Markus - place a minimum limit of 1MiB on x86
machines.  If someone is writing a new firmware, updating QEMU to
change the limit is the very least of their concerns.

-Kevin
