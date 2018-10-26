Received: from eggs.gnu.org ([2001:4830:134:3::10]:52052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFyeY-0006TS-K5
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFyeU-0000Wz-Sj
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFyeQ-0000V0-Gj
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:43:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FD983001FB6
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:43:27 +0000 (UTC)
Date: Fri, 26 Oct 2018 10:43:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181026094314.GE31390@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<b833e608-007a-c77f-9e35-41175203b634@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b833e608-007a-c77f-9e35-41175203b634@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt]  [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Prasad J Pandit <ppandit@redhat.com>

On Fri, Oct 26, 2018 at 09:48:35AM +0100, Cole Robinson wrote:
> On 10/25/2018 09:37 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
> > > While being at it deprecate cirrus too.
> > >=20
> > > Reason (short version): use stdvga instead.
> > > Verbose version:
> > >      https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-consider=
ed-harmful
> >=20
> > Every single one of my guests is using cirrus. This wasn't an explici=
t
> > choice on my part, so I believe it is being used as the default in
> > virt-install.
> >=20
>=20
> virt-manager/virt-install 2.0.0 will never explicitly set cirrus, but t=
hat
> release is quite new. The previous release's default for x86 was roughl=
y:
>=20
> if using spice graphics:
>     use qxl
> elif guest os is windows:
>     use vga
> else:
>     use cirrus
>=20
> It was definitely sub optimal. Maybe your virt-install commands were
> explicitly setting --graphics vnc which would trigger cirrus in that ca=
se.

Yep, I've always tended to use vnc, since QXL has historically been a
pretty buggy & unreliable device model with guests often breaking.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
