Received: from eggs.gnu.org ([2001:4830:134:3::10]:57530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAymE-000602-5X
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAymA-00087t-2P
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:50:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gAym9-00086T-Rd
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:50:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A7F77D0E7
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 14:50:49 +0000 (UTC)
Date: Fri, 12 Oct 2018 16:50:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181012145044.GB4585@dhcp-200-186.str.redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-31-armbru@redhat.com>
	<a93edd67-8c1a-bb2d-7b52-db46b1e2abbd@redhat.com>
	<87in27vhwc.fsf@dusky.pond.sub.org>
	<5e5d426c-75f5-98ca-ddcf-729bc7656c99@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <5e5d426c-75f5-98ca-ddcf-729bc7656c99@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 30/31] blockdev: Convert drive_new() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.10.2018 um 14:28 hat Max Reitz geschrieben:
> >>> @@ -1155,8 +1155,7 @@ static void default_drive(int enable, int snaps=
hot, BlockInterfaceType type,
> >>>          drive_enable_snapshot(NULL, opts, NULL);
> >>>      }
> >>> =20
> >>> -    dinfo =3D drive_new(opts, type);
> >>> -    assert(dinfo);
> >>> +    dinfo =3D drive_new(opts, type, &error_abort);
> >>
> >> Which means the assertion is still necessary here.
> >=20
> > I see very little value in assert(p) right before *p.  Matter of taste,
> > I guess.  Do you want me to keep it?
>=20
> True.  "An assertion looks better to the user" isn't an argument,
> considering the user shouldn't ever see assertions either.

The point that could be made is that it documents that we're aware that
drive_new() can return NULL generally, but we've made sure that with the
specific options passed it doesn't happen here, so not having any error
handling is not a bug, but intended.

> So feel free to drop it indeed.

I don't mind either way.

Kevin

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbwLTEAAoJEH8JsnLIjy/WDQ0P/A7ZZlphAQMsIZ2/LRzNvSpM
gY/IKH7EKDA6jp8LA+JuZR/Jxb3qXFKrT/JR+TKj2EC+oYul9vCe4uuSdB+5kBDr
6Z/qc5RbSl5jctcp10piqUSOJrDpk29pjH3iEyI9zETtv5lj4REZ3fp079SUUteA
uhTIeKFVRHKGOpy13w6RMlRwT9Dohcchb3EzzFuKQd+laCb4FPVJ0pVS7jESUw+B
zKRhAYeqgg1rD4B6UGs8XuK3rbasmt1bSvVFrELJAEJiR5957RnqrrJuEZ4+ceY6
KeBUQpS350uVRm7vRBJwx1bIeik6KY6s9e4wF2j3kYvs/PYC+THKOM1PkeG+jKiz
z+vo9Xp0CaLiHhKaQdeNTxYwPawMTO8QngJUCP5/fQLHd0ALpIrL5d2bmTodThvY
sXrFNSmNYwsi23TPiUhPrP7PyhGYU0LNwjefsh26MSDb8DgVcvsFEy93qQ/MO73v
reCxnf/8gAjw3kip7a+dFVC71WSipAScpBCZZAea6VGTxwzZKtLyGsh5ozeU/Bu1
9T8pVSn825XdsALPZT+Zarmqg9ZW18Fc0dxu38A2EH/3+lxjlyzU9Qk8V3idCbhS
/FiHBqXaiCECwaOp8r/3qMmRuM47lagOZIGrhrGrX+69CHfA7nmZgkMAeRYBjJrl
dmDicO+RjKUTgMw1iH/W
=xcw8
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
