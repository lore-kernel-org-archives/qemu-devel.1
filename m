Received: from eggs.gnu.org ([2001:4830:134:3::10]:38215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fcvzo-0000rH-Qy
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fcvzk-000624-RG
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:00:12 -0400
Date: Tue, 10 Jul 2018 17:59:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180710165951.GF1612@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<CAFEAcA8AZK+Nsts2bPKAw-F=j5dFB0MBD5AO_9zf1ztbAYGWVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8AZK+Nsts2bPKAw-F=j5dFB0MBD5AO_9zf1ztbAYGWVQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On Tue, Jul 10, 2018 at 04:09:38PM +0100, Peter Maydell wrote:
> On 10 July 2018 at 15:22, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Tue, 10 Jul 2018 07:59:15 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> >> In addition to actively pulling libvirt developers into review of
> >> deprecation patches, we should pursue the idea to optionally let QEMU
> >> fail on use of deprecated features, then have libvirt run its test suite
> >> that way.
> >
> > What about the following:
> >
> > qemu_deprecated_option("old_option", "modern_option");
> >
> > Which would then print (in normal operation)
> >
> > "WARNING: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
> >
> > to the monitor (or to stderr? to both?).
> >
> > If you start QEMU with a -no-deprecated-options switch, it would print
> >
> > "ERROR: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
> 
> I'd prefer to see more hand-tailored deprecation messages that can
> be more detailed about exactly what the new syntax needs to be.
> The ideal would be if you could get right down to the detailed
> level of "replace -old_thing -with_foo=x with -device new_thing,foo=x"...

Agreed, the more detail we can provide the better for users.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
