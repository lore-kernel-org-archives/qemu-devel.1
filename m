Received: from eggs.gnu.org ([2001:4830:134:3::10]:48982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1f7zjt-0005C9-BP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1f7zjq-0006pE-00
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:43:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1f7zjp-0006na-NR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:43:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3G8dTGI006653
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 04:43:47 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hcqs5a811-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 04:43:47 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Mon, 16 Apr 2018 09:43:44 +0100
References: <1523657288-6587-1-git-send-email-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 16 Apr 2018 10:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <1523657288-6587-1-git-send-email-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BxdougYu1y6jG1lWH7RD30HUwGszMfaVI"
Message-Id: <73328409-4fa9-2a76-ce2f-0e6b4537fad9@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Small fixes for s390x QEMU boot menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BxdougYu1y6jG1lWH7RD30HUwGszMfaVI
From: Janosch Frank <frankja@linux.ibm.com>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com,
 borntraeger@de.ibm.com
Cc: gor@linux.ibm.com
Message-ID: <73328409-4fa9-2a76-ce2f-0e6b4537fad9@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] Small fixes for s390x QEMU boot menu
References: <1523657288-6587-1-git-send-email-walling@linux.ibm.com>
In-Reply-To: <1523657288-6587-1-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.04.2018 00:08, Collin Walling wrote:
> Change Log:
>=20
>     v2
>=20
>         - added r-b's
>         - s/zipl_println/zipl_print_entry
>             - prints entry and returns entry number
>         - while loop now handles valid_entries

Series reviewed-by: Janosch Frank <frankja@linux.ibm.com>

>=20
> These patches fix the following:
>=20
>     - The QEMU zIPL boot menu does not allow accurate selection of
>         non-sequential entries.
>=20
>     - The QEMU zIPL boot menu does not have all the capabilities of the=

>         real zIPL menu (such as commandline args). We should print a di=
fferent
>         banner to reflect this.
>=20
>     - The loadparm array in main.c can end up being not null terminated=
 when
>         converted to an integer via atoui.
>=20
>     - A loadparm set to an empty string does not allow a boot menu.
>=20
>=20
> Collin Walling (4):
>   pc-bios/s390-ccw: rename MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
>   pc-bios/s390-ccw: fix loadparm initialization and int conversion
>   pc-bios/s390-ccw: fix non-sequential boot entries (eckd)
>   pc-bios/s390-ccw: fix non-sequential boot entries (enum)
>=20
>  hw/s390x/ipl.c              |  2 ++
>  pc-bios/s390-ccw/bootmap.c  | 16 +++++++------
>  pc-bios/s390-ccw/bootmap.h  |  2 --
>  pc-bios/s390-ccw/main.c     | 14 +++++------
>  pc-bios/s390-ccw/menu.c     | 58 +++++++++++++++++++++++++++++++------=
--------
>  pc-bios/s390-ccw/s390-ccw.h |  4 +++-
>  6 files changed, 61 insertions(+), 35 deletions(-)
>=20



--BxdougYu1y6jG1lWH7RD30HUwGszMfaVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa1GI7AAoJEBcO/8Q8ZEV5MvAQALxaz7giuqsWGvBAXbySq9jV
u5PzsLmHFs315ybufy/oh7rF5CErRistnGi8rLX+8M/Q5Qx5DIlrqB5hKXAAw9f1
5DKGFzrkCaOMfxowZzBlmYiU1Uk6UZKHEEKisljxyWwxve2pwrX8aHLK39Fyu80B
j75liBuzqF+vXG45AjmOYJ/7OA7QFdD1oXXwutSP+nJbNQGWxGXipEBDwj+t/Jyb
AT4g80yTEI+hakrRsZZIt+VfHJIdU2A7Ea+akDpAkEgnwpzeeD7nB138p22O2mf4
+9biOg6DOrLbKo7e/FDEoo8ES9octeUcMn0KaXnolzx7e+EuSRWdmKl1zbwn2hQ7
mBjfs3YWJnw/KEFARKhdZnv1VPww1shYBrwYWWAkVzTm3GV/jy/n90708rWzDmDy
uOP4co5d9204jbAG3qHmTv7wSzYsWGM9LGXIuOE9PGF4RmHhV104tL3y4DhhdaZs
XJ1CbfO0f+dkWgm11E8E/XFC9QssPVkpT+vnibuu9VjpVBoZqskegh+UQ84mqg/7
Ulos1P/AXIVfdf10R24tJNP4ZS2JUiKWaYT4bd6l02mlP0SSS+DpfeuJtcx+pmwD
dLx1ei/q0se/9r3MH+eDBx0VJ9fjgdrlDz5H/lrHV5CtWm/2AmY09M5lFR52tPgp
eT4oH5jELHEnwa2dPHzl
=YeIk
-----END PGP SIGNATURE-----

--BxdougYu1y6jG1lWH7RD30HUwGszMfaVI--
