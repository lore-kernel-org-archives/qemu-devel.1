Received: from eggs.gnu.org ([2001:4830:134:3::10]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq1LO-0006dK-R7
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq1LM-0001oM-C7
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:20:34 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fq1LG-0001nP-Le
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 15:20:28 -0400
Received: by mail-oi0-x233.google.com with SMTP id 8-v6so3863941oip.0
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 12:20:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 20:20:05 +0100
Message-ID: <CAFEAcA-fEe2TsRpd5Q1i7Z-0MC67o0xkfgLW1ifV64HpfL2czg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] MIPS queue for QEMU upstream,
 August 14, 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 August 2018 at 19:16, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:
>
>   Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-aug-14-2018
>
> for you to fetch changes up to 20d4e01b6486b15d1f3d9ff2d51bba2bf00ebf94:
>
>   qemu-doc: Amend MIPS-related items (2018-08-14 19:59:03 +0200)
>
> ----------------------------------------------------------------
> MIPS queue for QEMU upstream, August 14, 2018
>
> This is the first part of nanoMIPS support for QEMU. It contains
> various fixes and improvements that are related to nanoMIPS support,
> or are discovered while working on nanoMIPS support. Most of them are
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
error: unused function 'gen_op_addr_addi' [-Werror,-Wunused-funct
ion]
static inline void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base,
                   ^
/home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:1921:20:
error: unused function 'check_xnp' [-Werror,-Wunused-function]
static inline void check_xnp(DisasContext *ctx)
                   ^
2 errors generated.

The functions do appear to be genuinely unused.

thanks
-- PMM
