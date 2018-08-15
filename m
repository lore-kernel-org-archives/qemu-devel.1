Received: from eggs.gnu.org ([2001:4830:134:3::10]:59899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fq1ao-0003nI-JX
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fq1al-0005GC-F9
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:36:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53136 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1fq1al-00050c-2H
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:36:27 -0400
in-reply-to: <CAFEAcA-fEe2TsRpd5Q1i7Z-0MC67o0xkfgLW1ifV64HpfL2czg@mail.gmail.com>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <2515-5b748080-b-e0a2440@99331474>
date: Wed, 15 Aug 2018 21:35:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQVUxMPz09P3V0Zi04P3E/?=
 =?utf-8?q?_00/19=5D_MIPS_queue_for_QEMU_upstream=2C_August_14=2C_2018?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


These functions are used in the patches that follow in nanoMIPS series,=
 but not submitted in this pull request.

Ok, I will reorganize the patches so that there is no such case, and wi=
ll send the new pull request soon.

Do we require that bisect works for clang builds too (meaning that afte=
r each patch, clang build must be success)?

Aleksandar

-------- Original Message --------
Subject: Re: [PULL 00/19] MIPS queue for QEMU upstream, August 14, 2018=

Date: Wednesday, August 15, 2018 21:20 CEST
From: Peter Maydell <peter.maydell@linaro.org>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC: QEMU Developers <qemu-devel@nongnu.org>
References: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-r=
k.com>


=C2=A0On 14 August 2018 at 19:16, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 38441756b70eec5807b5f60dad11a93a91=
199866:
>
> Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)
>
> are available in the git repository at:
>
> https://github.com/AMarkovic/qemu tags/mips-queue-aug-14-2018
>
> for you to fetch changes up to 20d4e01b6486b15d1f3d9ff2d51bba2bf00ebf=
94:
>
> qemu-doc: Amend MIPS-related items (2018-08-14 19:59:03 +0200)
>
> ----------------------------------------------------------------
> MIPS queue for QEMU upstream, August 14, 2018
>
> This is the first part of nanoMIPS support for QEMU. It contains
> various fixes and improvements that are related to nanoMIPS support,
> or are discovered while working on nanoMIPS support. Most of them are=

> fairly simple changes, but each of them has its own significance and
> importance for nanoMIPS support.
>
> The second part that contains QEMU support for core nanoMIPS
> functionality will remain under review for some time.
>
> The third part that mainly contains Linux user support will likely
> remain under review for some longer period.
>
> ----------------------------------------------------------------

Hi; this fails to build on clang:

/home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:1749:20:
error: unused function 'gen=5Fop=5Faddr=5Faddi' [-Werror,-Wunused-funct=

ion]
static inline void gen=5Fop=5Faddr=5Faddi(DisasContext *ctx, TCGv ret, =
TCGv base,
^
/home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:1921:20:
error: unused function 'check=5Fxnp' [-Werror,-Wunused-function]
static inline void check=5Fxnp(DisasContext *ctx)
^
2 errors generated.

The functions do appear to be genuinely unused.

thanks
-- PMM


=C2=A0
