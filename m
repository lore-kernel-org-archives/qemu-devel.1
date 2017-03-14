Received: from eggs.gnu.org ([2001:4830:134:3::10]:36874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cnd47-00042x-BB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cnd43-0003uy-Bf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:24:03 -0400
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:38421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cnd43-0003uo-6z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:23:59 -0400
Received: by mail-it0-x22b.google.com with SMTP id m27so43969507iti.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 20:23:59 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.57839.1489090092.22737.qemu-devel@nongnu.org>
Date: Mon, 13 Mar 2017 23:23:56 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C652FA5-CADE-432E-BA79-979CDD7261EE@gmail.com>
References: <mailman.57839.1489090092.22737.qemu-devel@nongnu.org>
Subject: [Qemu-devel]  [PATCH Risu v2 0/3] PPC64 Improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Mar 9, 2017, at 3:08 PM, qemu-devel-request@nongnu.org wrote:

> v2:
> - applied code review
>=20
> This patchset include initial support to PPC64 (Big-Endian), that is =
pretty=20
> much the same: only some fixes in configure and risugen.
> Also, it adds a better random initialization of VSX registers.
>=20
> Jose Ricardo Ziviani (3):
>  risugen_ppc64: Load random 128-bit data to VSX registers
>  configure: Add initial support to PPC64 (big endian)
>  risugen,risugen_ppc64.pm: Add support ppc64 (big-endian)
>=20
> configure        |  9 ++++-----
> risugen          |  6 +++++-
> risugen_ppc64.pm | 44 +++++++++++++++++++++++++++++++++-----------
> 3 files changed, 42 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.7.4

Are there plans on adding 32 bit PowerPC support to Risu?=
