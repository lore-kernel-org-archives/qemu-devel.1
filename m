Received: from eggs.gnu.org ([2001:4830:134:3::10]:33332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDAJR-0002Nz-L3
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDAJP-0005Xb-PW
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:34:12 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDAJP-0005P8-89
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 11:34:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id u22so30140989ota.12
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 08:34:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Oct 2018 16:33:48 +0100
Message-ID: <CAFEAcA93VVqL7V4kq6zGOq-DuuZ_0=h28hEvEH1sVjCeuo9+Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27]MIPS pull request for October 2018 -
 part 1
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

On 17 October 2018 at 13:33, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181012-pull-request' into staging (2018-10-12 16:45:51 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-1
>
> for you to fetch changes up to 5eb2c6f2a5cc56a84ac73b0025cc006064606f73:
>
>   target/mips: Add opcodes for nanoMIPS EVA instructions (2018-10-17 13:44:56 +0200)
>
> ----------------------------------------------------------------
> MIPS queue October 2018, part 1
>
> Variety of MIPS fixes and improvements.
> ----------------------------------------------------------------

Hi; I get a build failure for mips linux-user with clang:


/home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:2486:20:
error: unused function 'check_pw' [-Werror,-Wunused-function]
static inline void check_pw(DisasContext *ctx)
                   ^
1 error generated.

check_pw() is defined unconditionally but only used
inside ifndef CONFIG_USER_ONLY guards.

thanks
-- PMM
