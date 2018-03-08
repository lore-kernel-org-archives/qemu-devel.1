Received: from eggs.gnu.org ([2001:4830:134:3::10]:57543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etsay-0004s6-Gb
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etsau-0003Dg-FS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:16:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etsau-0003DY-9Z
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:16:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E64104000787
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 10:16:15 +0000 (UTC)
Date: Thu, 8 Mar 2018 10:16:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308101604.GF4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180308074507.nwho4tddsoxb3b7v@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308074507.nwho4tddsoxb3b7v@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, lersek@redhat.com

On Thu, Mar 08, 2018 at 08:45:07AM +0100, Gerd Hoffmann wrote:
> > Suggested approach
> > ------------------
> >=20
> > Based on an upstream discussion on 'virt-tools'[1] mailing list and s=
ome
> > Bugzillas, Gerd Hoffmann, Laszlo Ersek and Dan Berrang=C3=A9 had a su=
ggestion
> > to define a firmware metadata format and file (example in [1]):
> >=20
> >   - For each firmware file we need a metadata file in a well defined
> >     location, e.g. /usr/share/qemu/bios/ that lists stuff like:
> >=20
> >       - Path to the firmware binary
> >       - Path to the pre-built OVMF 'vars' file (if any)
>=20
> How to load the binary (using -bios, -pflash, possibly also -kernel, fo=
r
> uboot @ arm).

I wonder if there's value in also using this for describing secondary
device specific ROMs like iPXE and friends.

>=20
> >       - Support architectures - associated QEMU feature flags (Secure
> >         Boot)
>=20
> Also machine types.  ovmf builds with smm don't boot on pc.  coreboot
> has hardware-specific roms too, so the pc build wouldn't boot on q35 an=
d
> visa versa.  Same on arm, where the firmware typically is board-specifi=
c.
>=20
> >       - If the binary provides / requires SMM (System Management Mode=
)
>=20
> Possibly a more generic "flags" or "properties" thing, I can easily
> imagine that simliar requirements show up on other platforms too.
>=20
> Also a "name" and a "description" field would be useful.
>=20
> cheers,
>   Gerd
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
