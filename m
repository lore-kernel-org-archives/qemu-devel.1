Received: from eggs.gnu.org ([2001:4830:134:3::10]:45356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbQ3G-00034K-RX
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbQ3C-00056W-Vl
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:41:30 -0400
References: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
	<eb53939b-4a90-2e7b-32df-3dbe75169d3b@redhat.com>
	<20180706011849.GK3450@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afa973b5-f32e-c88e-ad2b-9edb864f6477@redhat.com>
Date: Fri, 6 Jul 2018 14:41:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180706011849.GK3450@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ckYzEOjlqbS96d6sQOvA6iEmveyv0GwgC"
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Add comment explaining ignored
 errors from fdt operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Pilippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ckYzEOjlqbS96d6sQOvA6iEmveyv0GwgC
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>, Alexander Graf <agraf@suse.de>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Pilippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Message-ID: <afa973b5-f32e-c88e-ad2b-9edb864f6477@redhat.com>
Subject: Re: [PATCH] sam460ex: Add comment explaining ignored errors from fdt
 operations
References: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
 <eb53939b-4a90-2e7b-32df-3dbe75169d3b@redhat.com>
 <20180706011849.GK3450@umbus.fritz.box>
In-Reply-To: <20180706011849.GK3450@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/07/2018 03:18, David Gibson wrote:
>> Ok, but why would it even fail?  Maybe it's not this case, but even if=

>> it's not fatal for the OS, generating different device trees silently
>> seems like a recipe for Heisenbugs.
> Yes, quite.  Especially since the most likely errors I can see here
> would actually indicate something has already gone horribly wrong with
> the device tree construction, so a missing clock-frequency is the
> least of our troubles.
>=20
> I think using _FDT() here would be a better approach.

Or qemu_fdt_setprop_cell, which is there exactly for this reason.
Volunteers needed to report it in checkpatch! :)

Paolo


--ckYzEOjlqbS96d6sQOvA6iEmveyv0GwgC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAls/Y24ACgkQv/vSX3jH
roOwDQgAlzpKpkLEMfl4OA6KcTte/dpdeKru763iRdsJUTTqwsZdlC4+HSmGfUyQ
Z6fF0Ag9KIdEAaH89FHV5PIZRvCRLA8hnlwWgddqlG0lPvpaUScJSMAhDYO/QKW9
PaldvA4ri2h4tzbaEd9G/k80DeEdCmnuyQzBe6AwIT3xQTs5guF/DJOV+ZgrHQNl
35wfOjXllC8xFR+UmMjQHoaoj3PxwG7wlwWkmdSnMmb8/vJFaTbsAFxtkHaL8cjN
AmagByzcg9sFYzNdDz+PZQ4vrMUmpFdd9vbs0nBxr4Fx2c9RbMSEOm/of3Hb4CWS
mw3NnDm6Z58S7zXVKlfrZ1kLc9glbw==
=z/r+
-----END PGP SIGNATURE-----

--ckYzEOjlqbS96d6sQOvA6iEmveyv0GwgC--
