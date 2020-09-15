Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3826CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE02220720
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE02220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGAu-0002JG-Ul
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kIG9n-0001Ri-Vi; Tue, 15 Sep 2020 14:58:23 -0400
Received: from smtp.gentoo.org ([2001:470:ea4a:1:5054:ff:fec7:86e4]:53397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kIG9i-0008GL-8g; Tue, 15 Sep 2020 14:58:23 -0400
From: Andreas =?ISO-8859-1?Q?K=2E_H=FCttel?= <dilfridge@gentoo.org>
To: qemu-devel@nongnu.org, libc-alpha@sourceware.org, qemu-riscv@nongnu.org
Subject: Re: riscv32 wait() problem, qemu or glibc?
Date: Tue, 15 Sep 2020 21:57:57 +0300
Message-ID: <2629181.rzyxZ31qjY@farino>
Organization: Gentoo Linux
In-Reply-To: <9435182.tdPhlSkOF2@farino>
References: <9435182.tdPhlSkOF2@farino>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3100299.CJZsxu672h";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 14:58:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--nextPart3100299.CJZsxu672h
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Not sure if this helps in any way, but I tried if the problem is specific t=
o=20
the return value 42. Leading to more confusing results... though this looks=
=20
more like an emulator problem than a libc problem to me now.

Happy to debug further, but with limited ideas on how to proceed.

(riscv-ilp32 chroot) farino /tmp # ./wait-test=20
child wants to return 34 (0x22), parent received 32 (0x20), difference -2
child wants to return 35 (0x23), parent received 33 (0x21), difference -2
child wants to return 36 (0x24), parent received 34 (0x22), difference -2
child wants to return 37 (0x25), parent received 35 (0x23), difference -2
child wants to return 38 (0x26), parent received 36 (0x24), difference -2
child wants to return 39 (0x27), parent received 37 (0x25), difference -2
child wants to return 40 (0x28), parent received 38 (0x26), difference -2
child wants to return 41 (0x29), parent received 39 (0x27), difference -2
child wants to return 42 (0x2A), parent received 40 (0x28), difference -2
child wants to return 43 (0x2B), parent received 41 (0x29), difference -2
child wants to return 44 (0x2C), parent received 42 (0x2A), difference -2
child wants to return 45 (0x2D), parent received 43 (0x2B), difference -2
child wants to return 46 (0x2E), parent received 44 (0x2C), difference -2
child wants to return 47 (0x2F), parent received 45 (0x2D), difference -2
child wants to return 48 (0x30), parent received 46 (0x2E), difference -2
child wants to return 49 (0x31), parent received 47 (0x2F), difference -2
child wants to return 50 (0x32), parent received 48 (0x30), difference -2
child wants to return 51 (0x33), parent received 49 (0x31), difference -2
child wants to return 52 (0x34), parent received 50 (0x32), difference -2
child wants to return 53 (0x35), parent received 51 (0x33), difference -2
child wants to return 54 (0x36), parent received 52 (0x34), difference -2
child wants to return 55 (0x37), parent received 53 (0x35), difference -2
child wants to return 56 (0x38), parent received 54 (0x36), difference -2
child wants to return 57 (0x39), parent received 55 (0x37), difference -2
child wants to return 58 (0x3A), parent received 56 (0x38), difference -2
child wants to return 59 (0x3B), parent received 57 (0x39), difference -2
child wants to return 60 (0x3C), parent received 58 (0x3A), difference -2
child wants to return 61 (0x3D), parent received 59 (0x3B), difference -2
child wants to return 62 (0x3E), parent received 60 (0x3C), difference -2
child wants to return 63 (0x3F), parent received 61 (0x3D), difference -2
child wants to return 64 (0x40), parent received 62 (0x3E), difference -2
child wants to return 162 (0xA2), parent received 160 (0xA0), difference -2
child wants to return 163 (0xA3), parent received 161 (0xA1), difference -2
child wants to return 164 (0xA4), parent received 162 (0xA2), difference -2
child wants to return 165 (0xA5), parent received 163 (0xA3), difference -2
child wants to return 166 (0xA6), parent received 164 (0xA4), difference -2
child wants to return 167 (0xA7), parent received 165 (0xA5), difference -2
child wants to return 168 (0xA8), parent received 166 (0xA6), difference -2
child wants to return 169 (0xA9), parent received 167 (0xA7), difference -2
child wants to return 170 (0xAA), parent received 168 (0xA8), difference -2
child wants to return 171 (0xAB), parent received 169 (0xA9), difference -2
child wants to return 172 (0xAC), parent received 170 (0xAA), difference -2
child wants to return 173 (0xAD), parent received 171 (0xAB), difference -2
child wants to return 174 (0xAE), parent received 172 (0xAC), difference -2
child wants to return 175 (0xAF), parent received 173 (0xAD), difference -2
child wants to return 176 (0xB0), parent received 174 (0xAE), difference -2
child wants to return 177 (0xB1), parent received 175 (0xAF), difference -2
child wants to return 178 (0xB2), parent received 176 (0xB0), difference -2
child wants to return 179 (0xB3), parent received 177 (0xB1), difference -2
child wants to return 180 (0xB4), parent received 178 (0xB2), difference -2
child wants to return 181 (0xB5), parent received 179 (0xB3), difference -2
child wants to return 182 (0xB6), parent received 180 (0xB4), difference -2
child wants to return 183 (0xB7), parent received 181 (0xB5), difference -2
child wants to return 184 (0xB8), parent received 182 (0xB6), difference -2
child wants to return 185 (0xB9), parent received 183 (0xB7), difference -2
child wants to return 186 (0xBA), parent received 184 (0xB8), difference -2
child wants to return 187 (0xBB), parent received 185 (0xB9), difference -2
child wants to return 188 (0xBC), parent received 186 (0xBA), difference -2
child wants to return 189 (0xBD), parent received 187 (0xBB), difference -2
child wants to return 190 (0xBE), parent received 188 (0xBC), difference -2
child wants to return 191 (0xBF), parent received 189 (0xBD), difference -2
child wants to return 192 (0xC0), parent received 190 (0xBE), difference -2
(riscv-ilp32 chroot) farino /tmp #

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>

main(c, v)
     int c;
     char **v;
{
 for(int z=3D0; z<255; z++){
  pid_t pid, p;
  int s, i, n;

  s =3D 0;
  pid =3D fork();
  if (pid =3D=3D 0)
    exit(z);

  /* wait for the process */
  p =3D wait(&s);
  if (p !=3D pid)
    exit (255);

  if (WIFEXITED(s))
  {
     int r=3DWEXITSTATUS(s);
     if (z!=3Dr) {
      printf("child wants to return %i (0x%X), parent received %i (0x%X),=20
difference %i\n",z,z,r,r,r-z);
     }
  }
 }
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Am Montag, 14. September 2020, 11:14:16 EEST schrieb Andreas K. H=FCttel:
> Hi,
>=20
> first of all, sorry for crossposting, but I'm dealing with many moving and
> experimental parts here...
>=20
> Situation: riscv32 (ilp32) qemu-user [1] chroot, Linux [2], glibc [3], gcc
> [4]
>=20
> The following small program outputs "child exited with status 40", which =
is
> rather unexpected (it should be 42). Any idea what is going on?
>=20
> (This is a simplified version of code in a configure test. The test has
> other potential issues [5], but in any case it cant produce useful results
> on riscv32 right now.)
>=20
> TIA,
> Andreas
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #include <stdlib.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/wait.h>
>=20
> main(c, v)
>      int c;
>      char **v;
> {
>   pid_t pid, p;
>   int s, i, n;
>=20
>   s =3D 0;
>   pid =3D fork();
>   if (pid =3D=3D 0)
>     exit (42);
>=20
>   /* wait for the process */
>   p =3D wait(&s);
>   if (p !=3D pid)
>     exit (255);
>=20
>   if (WIFEXITED(s))
>   {
>      int r=3DWEXITSTATUS(s);
>      printf("child exited with status %i\n",r);
>   }
> }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> [1] qemu built from git master, Sep 12, 2020 16:30:37 EEST
> [2] host kernel is 5.8.8
> [3] glibc-2.32 with the rv32 patch series backported from master
> [4] (Gentoo 10.2.0-r1 p2)
> [5] https://lists.gnu.org/archive/html/bug-bash/2020-09/msg00033.html


=2D-=20
Andreas K. H=FCttel
dilfridge@gentoo.org
Gentoo Linux developer=20
(council, qa, toolchain, base-system, perl, libreoffice)
--nextPart3100299.CJZsxu672h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE50NBr50KpJKM5MK59n+4O2olsAAFAl9hDrVfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEU3
NDM0MUFGOUQwQUE0OTI4Q0U0QzJCOUY2N0ZCODNCNkEyNUIwMDAACgkQ9n+4O2ol
sAAA7RAAmwB93YGZ4EW1Y2wl5aOAX7UblNRY2oiO9JX9n8KxKkbW+I2aMflqSX9Z
PdaaVfWQelH1D6Ey/UUbB4SOsubp7KNjCRiopADCNPmBbwbQPkz4dcoYe5vISeQu
Ybc55nQcbXqvyp5t+lQFBHSgYNSJQKEu5Cu3zHGQ2gBhh58qGuDLQ++fhdTHAUxp
y1q/32PQ1SQnoLEVrjRkGL3Bu3QYteIYNHwDdEaye/+mW/FVdbUi7XZiUqT/fb+u
XEY2aF8wm1IK3unGrzdcFB0qkSS1QcAn7YaCn7SpHO4n56wWIDs5k52VMPxPiaXC
bRgLmbgSrxEaRQvcUhIvm4Hgt2uMcsUnimFsSKfMAuF9Eq6cLiSI2Il+tGuw6qU+
wJPYknjB8Ohe6rRf8VnWWd31Cz7pA42fdb4F+sfYm2WOQrUCA4PzB0/uXzKA59yD
bTBnOyTM33e4ooNog6MA9BzqUtUB9prz5xlLRKNvAQxo+a/2MCJifpGUj52qAqs/
J6fqiOe7bvlfca3xYgZ1XyeN9vKIc357NuGlU8wLTH0xFa/1f+2/AHNl7osea90d
QWrFPrXJprzQzj/XviqC+HSGmaRskPg4AZwJG6OSjaWF0oVa3McUS8sCbW88suPm
uzrt2jx5TeZPQ7xT5d86luaMmOzrC7pHPsrteiBX6fMy2au6fak=
=qjPY
-----END PGP SIGNATURE-----

--nextPart3100299.CJZsxu672h--




