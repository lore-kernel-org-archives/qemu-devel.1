Received: from eggs.gnu.org ([2001:4830:134:3::10]:45003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAJD-0007Tg-D4
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAJA-0007r6-8I
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:03:03 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:39462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNAJA-0007r2-1l
	for qemu-devel@nongnu.org; Mon, 28 May 2018 01:03:00 -0400
Received: by mail-qt0-x22f.google.com with SMTP id f1-v6so13582549qtj.6
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 22:02:59 -0700 (PDT)
Received: from [192.168.1.11] ([138.117.48.222])
	by smtp.gmail.com with ESMTPSA id
	g57-v6sm2823574qte.52.2018.05.27.22.02.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 27 May 2018 22:02:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <404a1921-710c-9ba1-349a-f68430aa0a1d@amsat.org>
Date: Mon, 28 May 2018 02:02:52 -0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="DdFlh7Us1GdO9Z3Kfj7PTLyr9pFT4t0xj"
Subject: [Qemu-devel] What is the best git-way to add a new board?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DdFlh7Us1GdO9Z3Kfj7PTLyr9pFT4t0xj
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <404a1921-710c-9ba1-349a-f68430aa0a1d@amsat.org>
Subject: What is the best git-way to add a new board?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

What is the best git-way to add a new board?
Thinking about testing/review.

The following ways occurred to me:


1/ how RISC-V boards got merged

  Add devices individually,
  finally add the board and default-configs/Makefile rules at once.

PRO: commits are easier to cherry-pick/rebase
CON: you can not test a single patch until applying the whole series
     harder (less interest) to write qtests


1bis/ example of the Smartfusion2 board

  Variant of 1/, but also modify the default-configs/Makefile to
  build each device.

PRO: single patch can be test without much troubles,
     unit/acceptance tests can be run without applying the whole series,
     different people can work in parallel.
CON: no integration test until the last 'board' commit


2/ Reverse Polish testing

  Add a board stub (all devices as UnimplementedDevice) and Makefile
  rule, then for each new device, replace the unimp board entry,
    modify the default-configs/Makefile,
    add unit/acceptance tests

PRO: you can add an integration test since the first board commit :)
       (enforcing Test Driven Development),
     allow unpaid contributor to slowly push his work upstream
       instead of painful rebases or his work lost by change of
       interest or worth issues.
CON: not acceptable by upstream except with good integration test
     integration test might not be upstream-able due to license
       incompatibilities (JTAG-extracted firmwares...)

The use of UnimplementedDevice is now a bit enforced by the
ignore_memory_transaction_failures flag.


Regards,

Phil.


--DdFlh7Us1GdO9Z3Kfj7PTLyr9pFT4t0xj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsLjXwACgkQ4+MsLN6t
wN67YRAAl3huzZuczLuWcEqsq8B+EXqjef2l6yd6rOgdEGCkexaU8gU+u5tG7dJ6
baxva0+UXyoj98kFwWW00iopzH+3dLW1e4dqvEpCAiEdh45Kvfie4iDb2cssez2D
V2U43GDpJZ7QAxu8KauO7c0UIEBv6VLzl58s4bfC9YBT3Q394CPo0eEbHnmXEA4J
mwuWSNbt1pE5+cI0Y6RFc6CZSfZVDaUbwlaRcIkHi/YHkOsPr4rH3SvBZXF+m+sX
mxKMz+8lHqGG/hTJ8QNK36woFAb2zVqyPd4/5jHv3aZahVAWQkOvwU2CRa9bw6kM
TtBGCTUj7oZgFYDIYIARdbNIIShwVrg9KxgwxMAqfslGftNUsGGNUqDWufufyBwY
p18fb8vrl0gi2cXDonhK/ggjZNzejmO0ZRengior+s/BElJ8Dt72iECQqNu5PWY/
cNUgyP4YTWbWZhz/BWKywk4UkaKd0IDAP95W+jxoXXbOOCRyZPBX8wHWYbELY1Ks
dIDr9i5PDC7lFR9CyVuhTSxlZc+eYL25XSRm8X6R6nUnVJ71flG0KHzKFAvha/cm
pkRU0sOvEUI+e63EtOe7mEeY6cWXqVgwjFAOVYR7iqiQT0Jxm6m0EoRclzdG74wK
L6P2EQEW8Z8YJhxCwqP6prjdLs26vER5J/u9OKtUU2+DY1iRSEQ=
=bUtV
-----END PGP SIGNATURE-----

--DdFlh7Us1GdO9Z3Kfj7PTLyr9pFT4t0xj--
