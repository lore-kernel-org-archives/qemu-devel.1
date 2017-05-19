Received: from eggs.gnu.org ([2001:4830:134:3::10]:43930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBkTG-0003xe-Jq
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBkTC-0006uR-H2
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBkTC-0006tj-8C
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:09:38 -0400
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
	<149519768822.696.3542847712358809127@c05f1edc8ed1>
	<20170519155105.GE30573@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8666f1e4-d36e-8fe3-a2ae-ca11719f0c4b@redhat.com>
Date: Fri, 19 May 2017 18:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170519155105.GE30573@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dvwPFUWibbeAR22wv3Bbvk5ak3sOHs0Nt"
Subject: Re: [Qemu-devel] [PULL 00/20] Misc patches for 2017-05-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dvwPFUWibbeAR22wv3Bbvk5ak3sOHs0Nt
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <8666f1e4-d36e-8fe3-a2ae-ca11719f0c4b@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/20] Misc patches for 2017-05-19
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
 <149519768822.696.3542847712358809127@c05f1edc8ed1>
 <20170519155105.GE30573@stefanha-x1.localdomain>
In-Reply-To: <20170519155105.GE30573@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 19/05/2017 17:51, Stefan Hajnoczi wrote:
>> This series seems to have some coding style problems. See output below=
 for
>> more information:
> Yikes, on second thought I've dropped the pull request for now.
>=20
> Please look at these coding style violations.

These are just a sample program, so I didn't really care much.  But
these three aren't:

Checking PATCH 17/20: vhost-user-scsi: Introduce vhost-user-scsi host
device...
ERROR: do not use C99 // comments
#216: FILE: hw/scsi/vhost-user-scsi.c:145:
+    // Turn on predefined features supported by this device

ERROR: do not use C99 // comments
#261: FILE: hw/scsi/vhost-user-scsi.c:190:
+    // Add the bootindex property for this object

ERROR: do not use C99 // comments
#265: FILE: hw/scsi/vhost-user-scsi.c:194:
+    // Set boot index according the the device config

total: 3 errors, 0 warnings, 382 lines checked

so I guess I'll fix the sample program too.

Paolo


--dvwPFUWibbeAR22wv3Bbvk5ak3sOHs0Nt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlkfGLoACgkQv/vSX3jH
roOBVgf/cHLqt+O7mDs1KEXjzrcvUsw9uTk5jvlCay1UZ/TyPOybp3IoAi9KMaP0
Y7sUK5VXLF70cDXuiHa0msd1w++K3cGfpoVDtMbvvPAnV3Fr8YR03H5Q7tWBXfoH
A1Lm17ERN2pw1a7Rwh0HjjQcv1/ucv87QZ/M8ECgxT5O+d42jBaNtbgYJzdvvJSL
MH+EuJy/tVUKlOo4xoATqc8ipqSgtdRlhtgL8NGeXdIZfe6LkSmy7o5wbqnN2yat
muj4LHSWYx+WAa1FrGm4iyR78zKn4mXqAmxnRU8TH3EWG+Fn98pI56aGsMFzeUD/
U4vT1WsTb7Su+I8R3qlVa72zdGjsoA==
=+LJ5
-----END PGP SIGNATURE-----

--dvwPFUWibbeAR22wv3Bbvk5ak3sOHs0Nt--
