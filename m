Received: from eggs.gnu.org ([2001:4830:134:3::10]:46783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGJ9-0003Wc-AR
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAGJ4-0002bl-TC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAGJ4-0002ZR-LY
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:45:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9606380466
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:45:00 +0000 (UTC)
References: <20170503104257.5127-1-dgilbert@redhat.com>
	<dcdd1530-4e73-f998-b85f-06db4f1c4b63@redhat.com>
	<20170515121301.GF2089@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fda5da7f-bf09-c834-042c-9246b81f0e3d@redhat.com>
Date: Mon, 15 May 2017 08:44:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170515121301.GF2089@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="snAbvSLPxcCB2xKK4KTbp3IAqax2rrSsW"
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com, kwolf@redhat.com, kashyap@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--snAbvSLPxcCB2xKK4KTbp3IAqax2rrSsW
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com,
 kwolf@redhat.com, kashyap@redhat.com
Message-ID: <fda5da7f-bf09-c834-042c-9246b81f0e3d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
References: <20170503104257.5127-1-dgilbert@redhat.com>
 <dcdd1530-4e73-f998-b85f-06db4f1c4b63@redhat.com>
 <20170515121301.GF2089@work-vm>
In-Reply-To: <20170515121301.GF2089@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 07:13 AM, Dr. David Alan Gilbert wrote:

>>> +#ifndef CONFIG_LIVE_BLOCK_MIGRATION
>>> +    if (params.blk || params.shared) {
>>> +        error_setg(errp, "QEMU compiled without old-style block migr=
ation. "
>>> +                         "Use drive_mirror+NBD.");
>>
>> error_setg() should not be used with '.' (it should be a single phrase=
,
>> here you are trying to stuff in two sentences).  error_append_hint() c=
an
>> be used to supply the advice about using drive_mirror+NBD as the
>> alternative.
>>
>> Otherwise this looks reasonable to me.
>=20
> Done as:
>         error_setg(errp, "QEMU compiled without old-style block migrati=
on");
>         error_append_hint(errp, "Use drive_mirror+NBD.\n");
>=20
> (All the places I can see seem to have . and \n in append_hint)

That's correct. The hint has to supply its own newline, because we have
places where we construct the hint through several append calls in a row
(only the last one adds the newline).  Looks good to me!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--snAbvSLPxcCB2xKK4KTbp3IAqax2rrSsW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGbDOAAoJEKeha0olJ0NqRBUH/1GL2AvU3ixQUg4rz8Fi+OFC
VOEEmdDgQd67U9CHdysKAlRLzn7lq5WqQ8jDsLU/JmT0OqOx4rL36TG8s3anRPZD
WKBvJ7HbwnNZ+qXf9eeArv+AHEtzM1oD27TG/QxGDthUWlNqFb5S1zvZsHnc+EAJ
CABJ1B8Rk0MYMYJU1buZaNiFf4ci4PKD8Qy55OhnT5J1+jg15ZsDdIjSqPHd+jc/
sHnZWWyDa5NzQ5E1VEb4Cyi8y3uljqUYfbQYMAF6idi5TYB6ISDIgyKdelCl4NU8
tg8po31KETLdoqlvKyYaWMkhJp25nfQ/aMrFM9lopL3zlM2rdqLDgpUoxr1NHzU=
=KwP/
-----END PGP SIGNATURE-----

--snAbvSLPxcCB2xKK4KTbp3IAqax2rrSsW--
