Received: from eggs.gnu.org ([209.51.188.92]:53890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmK2I-0003OU-Ii
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmK2D-0002qi-2D
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:01:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gmK2C-0002qB-Pq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:01:45 -0500
References: <154825338186.21.2661799743092991292@ebba9967afc0>
	<e15a4bfd-ce73-62c8-3338-d35a429951b8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <47263739-35c6-b711-dc94-3af62f5a2bbe@redhat.com>
Date: Wed, 23 Jan 2019 09:01:28 -0600
MIME-Version: 1.0
In-Reply-To: <e15a4bfd-ce73-62c8-3338-d35a429951b8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AVXjaIDlEOtuE3198QjuH3iMbVauMartg"
Subject: Re: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org, no-reply@patchew.org
Cc: fam@euphon.net, aik@ozlabs.ru, alex.williamson@redhat.com, groug@kaod.org, eric.auger.pro@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AVXjaIDlEOtuE3198QjuH3iMbVauMartg
From: Eric Blake <eblake@redhat.com>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org,
 no-reply@patchew.org
Cc: fam@euphon.net, aik@ozlabs.ru, alex.williamson@redhat.com,
 groug@kaod.org, eric.auger.pro@gmail.com
Message-ID: <47263739-35c6-b711-dc94-3af62f5a2bbe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
References: <154825338186.21.2661799743092991292@ebba9967afc0>
 <e15a4bfd-ce73-62c8-3338-d35a429951b8@redhat.com>
In-Reply-To: <e15a4bfd-ce73-62c8-3338-d35a429951b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 8:44 AM, Auger Eric wrote:

>> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
>> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified=
 bound 256 equals destination size [-Werror=3Dstringop-truncation]
>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> does not seem to be related to my patch.

Known false alarm; the patchew processing queue is backlogged, and is
testing patches against a version of qemu.git that does not yet have
patches for newer gcc compliance incorporated, while at the same time
having recently upgraded its testing environment to use the newer gcc
that warns.  Commit 97b583f4 will silence the noise, once patchew
catches up to using it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AVXjaIDlEOtuE3198QjuH3iMbVauMartg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIgcgACgkQp6FrSiUn
Q2ry/wf/YYKKOTigqoIVma6EANg6KY+kftAFqN3aLtVUT0BtSA/Rqq1H8dM4ZFvy
mQ/LHEVRvyM0SIJNOsSacIR/8yyJefqu417xrVMrRzeKlJFMZncLXJ4Rbg5RfVcO
n4mowOwkdXx3mwsFz0T0RCPHAEBCQn9FodOHMldP/89qKNPvhuGLGgcsfcCNC0no
5zuq+e/sy+RuMTjXw+EPb+jShUOogaeO8Q3F2GdK6MTzW+/YBjlzEku5cA+DHkgT
f01TjBlXXyOhJhCrnDOkbnuDY5gCS6z441i5JfGkoKJHAC35PzI/7EBQ+9pEw3xT
N6ORmfECV8ezEldhGk5d7S6V2HWUYg==
=6Edy
-----END PGP SIGNATURE-----

--AVXjaIDlEOtuE3198QjuH3iMbVauMartg--
