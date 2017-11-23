Received: from eggs.gnu.org ([2001:4830:134:3::10]:39227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHs0H-0006Jx-3v
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eHs0D-0008Ro-33
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:57:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eHs0C-0008RE-Sj
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:57:17 -0500
Date: Thu, 23 Nov 2017 13:57:09 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171123135709.GP8166@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
	<8cd1c0b3-8386-d41e-ccfb-1a2073cdf4fb@redhat.com>
	<16011ac4-77c4-af75-5754-5f9586d6d629@redhat.com>
	<20171123130908.6ab004d3.cohuck@redhat.com>
	<b3b9837e-c6b0-d718-faaf-1ef198256634@redhat.com>
	<20171123133924.60e9f616.cohuck@redhat.com>
	<1519a9dc-5f0b-7ddd-18ac-d1f33782656d@redhat.com>
	<CAFEAcA_G_oG==OprY+NCGELyZx+rxgNFBMwQtLeGf6JsSHOQYw@mail.gmail.com>
	<fb4911b9-af89-a0a3-031a-964bf093aa59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb4911b9-af89-a0a3-031a-964bf093aa59@redhat.com>
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Sergio =?utf-8?B?QW5kcsOpcyBHw7NtZXo=?= Del Real <sergio.g.delreal@gmail.com>, Alex Bligh <alex@alex.org.uk>

On Thu, Nov 23, 2017 at 02:51:51PM +0100, Paolo Bonzini wrote:
> On 23/11/2017 14:13, Peter Maydell wrote:
> > On 23 November 2017 at 13:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> In theory I don't like it either (and I hadn't thought about it until
> >> today).  In practice, qemu-kvm is not going away from
> >> blogs/scripts/tutorials in a decade, so we might as well embrace it...
> > Isn't this distro-specific? In ubuntu by default there isn't
> > any wrapper, and if you do install the optional 'qemu-kvm' package
> > the wrapper it provides is /usr/bin/kvm, not /usr/bin/qemu-kvm.
> 
> Fedora also has no wrapper in the qemu-system-x86 package, and only
> "qemu-kvm" installs one.  In practice if you install the virtualization
> package group you get it.  What about Ubuntu?

Actually not quite correct. Historically '/usr/bin/qemu-kvm' is provided
by whichever 'qemu-system-$ARCH'  RPM matches your name arch. With recent
modularization, its now provided by 'qemu-system-$ARCH-core'. So everyone
will have qemu-kvm if they've installed the sub-RPM matching their host
arch.

The 'qemu-kvm' RPM is just an empty RPM that depends on whichever
'qemu-system-$ARCH' matches your host, and thus provides '/usr/bin/qemu-kvm'
This is just convenience to let downstream app RPMs depend on qemu-kvm
instead of a big set of per-arch conditionals.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
