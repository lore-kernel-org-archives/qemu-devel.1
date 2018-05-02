Received: from eggs.gnu.org ([2001:4830:134:3::10]:50013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDqPS-00062O-Hl
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDqPO-0006mt-Mh
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:58:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDqPO-0006mf-Gv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:58:54 -0400
Date: Wed, 2 May 2018 12:58:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180502115844.GO3308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Apr 27, 2018 at 06:42:07PM +0200, Thomas Huth wrote:
> On 27.04.2018 18:24, Peter Maydell wrote:
> > On 27 April 2018 at 17:17, Thomas Huth <thuth@redhat.com> wrote:
> >> By the way, just another crazy idea for v3.0 (i.e. feel free to turn it
> >> down immediately ;-)): Since compilation and testing time for QEMU is
> >> really huge, what do you think if we got rid of some QEMU binaries?
> >> qemu-system-aarch64 is a superset of qemu-system-arm, qemu-system-x86_64
> >> is a superset of qemu-system-i386 and qemu-system-ppc64 is a superset of
> >> qemu-system-ppc (and qemu-system-ppcemb). Would be feasible to get rid
> >> of the subset binaries with some work? (I think they were especially
> >> useful on 32-bit machines in the past, but most people are using 64-bit
> >> machines nowadays, aren't they?).
> > 
> > I think Markus' backward-compatibility rubber chicken may prevent
> > us from removing those executables...
> 
> Markus seems currently to be in the mood to cut down the testing time
> (see the current qom-test mail thread), so maybe we can convince him ... ;-)
> 
> > (In the utopian far future I'd like us to have just one QEMU
> > executable that could handle all architectures at once :-))
> 
> Yes, that would be great ... but that's really distant future, I guess.

I'm curious what is the compelling benefit of having a single fat QEMU
binary that included all archiectures at once ?

>From a security POV I find it desirable for us to go in the other direction
away from monolithic binaries that include everything. We've started that
work with turning various pieces of QEMU into loadable modules. In the future
we might see some pieces being moved into completely separate binaries. eg we
could have a core QEMU binary and separate binaries for GTK, SPICE, VNC, etc
frontends.

If each target architecture could be a loadable module, it might be
acceptable, but I wouldn't much like the idea of having every architecture
compiled into a single binary. Distros like to build every QEMU feature,
but users reasonably don't want to expand their attack surface by having
all features installed, so being able to install packages for each target
arch separately is a compelling benefit of current set of QEMU per-target
binaries that I wouldn't want to loose.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
