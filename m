Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61448C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3C120EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3C120EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHjfw-0004rO-UJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kHjd6-0002bh-Me
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:14:28 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:51822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kHjd4-0000Yo-EA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:14:28 -0400
From: Andreas =?ISO-8859-1?Q?K=2E_H=FCttel?= <dilfridge@gentoo.org>
To: qemu-devel@nongnu.org, libc-alpha@sourceware.org
Subject: riscv32 wait() problem, qemu or glibc?
Date: Mon, 14 Sep 2020 11:14:16 +0300
Message-ID: <9435182.tdPhlSkOF2@farino>
Organization: Gentoo Linux
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6224825.MDQidcC6GM";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=140.211.166.183;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 04:14:24
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart6224825.MDQidcC6GM
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,=20

first of all, sorry for crossposting, but I'm dealing with many moving and=
=20
experimental parts here...=20

Situation: riscv32 (ilp32) qemu-user [1] chroot, Linux [2], glibc [3], gcc =
[4]

The following small program outputs "child exited with status 40", which is=
=20
rather unexpected (it should be 42). Any idea what is going on?

(This is a simplified version of code in a configure test. The test has oth=
er=20
potential issues [5], but in any case it cant produce useful results on=20
riscv32 right now.)

TIA,=20
Andreas

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

main(c, v)
     int c;
     char **v;
{
  pid_t pid, p;
  int s, i, n;

  s =3D 0;
  pid =3D fork();
  if (pid =3D=3D 0)
    exit (42);

  /* wait for the process */
  p =3D wait(&s);
  if (p !=3D pid)
    exit (255);

  if (WIFEXITED(s))
  {
     int r=3DWEXITSTATUS(s);
     printf("child exited with status %i\n",r);
  }
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


[1] qemu built from git master, Sep 12, 2020 16:30:37 EEST
[2] host kernel is 5.8.8
[3] glibc-2.32 with the rv32 patch series backported from master
[4] (Gentoo 10.2.0-r1 p2)
[5] https://lists.gnu.org/archive/html/bug-bash/2020-09/msg00033.html

=2D-=20
Andreas K. H=FCttel
dilfridge@gentoo.org
Gentoo Linux developer=20
(council, qa, toolchain, base-system, perl, libreoffice)
--nextPart6224825.MDQidcC6GM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE50NBr50KpJKM5MK59n+4O2olsAAFAl9fJlhfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEU3
NDM0MUFGOUQwQUE0OTI4Q0U0QzJCOUY2N0ZCODNCNkEyNUIwMDAACgkQ9n+4O2ol
sACXIQ//W7G1t3QWIbSKDsLQ2EQ8bF7J20tL/lBp9iLi6p+KDfdKXK37Tw7X9i9L
EDbrduT7VHHss3HukZNxuTf6aXbD9YPq+FmZK9CqlCwcGQjelTS3W9oFO3ldHyZZ
W4LH0hF+l7sqOoZsRhGlz5OvTvGtUCjz7R2dW7VHFGRNxmzOyLgDIaynMEEtksgl
Qv2RyjaMVdhM9aQUCxpwckzWVOn1Vtzsbfeu9GwFTsXYfTvZKLKQBRZ15uxOc3Vy
T2pzqOHgmJDBTzf8fFcHqs9z7iD/7LVhinoJpvDhIRg3msSbssp/X5p2nY3mhw6l
Bgs2f1f7jC5WQRXaA7wOxDYcTiL3DD6+hmt1yvggEGIazuXSX8o4d5Jytjo+K5uw
Ef05rhiRZDedu8oF/YkWsbwTjrC5cGvOWGfW5XC2gyfJ0vUlMRd2nB4u7mG+MBiN
TIDALESbIAtsw/SLnkXWziY6abNfx7OBi0KZgkVnROm4tl7pUnI/V8I7R63JjVte
S3dVBq+IrfStXSbSGhfQNnxVBO+UxtbYwiiYrPGVnWSFZORy/H3ZLosem7EJMBsu
82lNf9Pq6pPVhCNnP/6WwInvM45xrh0py+nSLlRYN8lVPHajRwgW4owhj88edBcX
e4m5p82gQR4+VypcDsj2OVatKZCzNSPB7WkYn1ZfFnOF0Qoz6EE=
=U7kY
-----END PGP SIGNATURE-----

--nextPart6224825.MDQidcC6GM--




