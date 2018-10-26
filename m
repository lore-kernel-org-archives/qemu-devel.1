Received: from eggs.gnu.org ([2001:4830:134:3::10]:51932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gG2tT-0001bB-Fo
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gG2tH-0005Ji-9h
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gG2tG-0005Go-Rr
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95DEA80F9A
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 14:15:05 +0000 (UTC)
Date: Fri, 26 Oct 2018 15:14:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181026141458.GA493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<nycvar.YSQ.7.76.1810261213001.8270@xnncv>
	<20181026094208.GD31390@redhat.com>
	<20181026095943.GG31390@redhat.com>
	<4e377111-8b95-c65a-e456-a7a8a4580ecb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e377111-8b95-c65a-e456-a7a8a4580ecb@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: P J P <ppandit@redhat.com>, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Fri, Oct 26, 2018 at 12:03:35PM +0200, Paolo Bonzini wrote:
> On 26/10/2018 11:59, Daniel P. Berrang=C3=A9 wrote:
> > I should also say that QEMU as an upstream project has multiple goals=
.
> > Running KVM guests with modern PV hardware is only one of them, albei=
t
> > a widely used one. Being able to run old legacy OS with old hardware,
> > and running arbitrary embedded boards/devices with emulation are both
> > use cases that QEMU project aims to address. To eliminate all the old
> > "crufty" device emulation in name of improving security for KVM, woul=
d
> > be to eliminate core use cases of the project. THis is why we're tryi=
ng
> > to persue the direction of making it easier for vendors to disable
> > features and devices they don't wish to support & thus limit their
> > downstream CVE exposure.
>=20
> Indeed.  If we had to deprecate a feature just because it had an
> off-by-one bug, no C program would grow beyond 1000 lines of code...

One thing we should do, however, is to make it clear which of the
device models we consider secure, and which we consider only usable
in a friendly guest environment, as we have very different code
maintainership & quality standards for different parts of QEMU.

Essentially virtio devices, and then only a handful of the emulated
devices are things we consider suitable for usage in secure envs.
Likewise for machine types probably.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
