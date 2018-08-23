Received: from eggs.gnu.org ([2001:4830:134:3::10]:46388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsmiM-0001b7-9r
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsmiL-0006Ip-9u
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:19:42 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:40375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsmiL-0006Ib-3y
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:19:41 -0400
Received: by mail-oi0-x22b.google.com with SMTP id l202-v6so1441810oig.7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:19:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534858316-12945-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 11:19:20 +0100
Message-ID: <CAFEAcA-hb1yVNy=GHvksLJ5MuNEk-8UKROEyjvZRjV8muQ1YiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/46] MIPS queue August 21, 2018 v3
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

On 21 August 2018 at 14:31, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa22d88:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-21 11:36:15 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-aug-21-2018
>
> for you to fetch changes up to 7bfa634d0a73b74f2b84a5cd13d055e61210c356:
>
>   target/mips: Add definition of nanoMIPS I7200 CPU (2018-08-21 14:59:32 +0200)
>
> ----------------------------------------------------------------
> MIPS queue August 21, 2018 v3
>
> In v2, the initial ('since') commit was wrong.
> In v1, there were three missing "Reviewed-by" lines. Please use
>
> ----------------------------------------------------------------

Hi; I'm afraid this fails to build on clang for the linux-user
targets:

/home/petmay01/linaro/qemu-for-merges/target/mips/translate.c:1947:20:
error: unused function 'check_cp0_mt' [-Werror,-Wunused-function]
static inline void check_cp0_mt(DisasContext *ctx)
                   ^
1 error generated.

This function is only called inside #ifndef CONFIG_USER_ONLY
sections, but the function definition is not similarly guarded.

thanks
-- PMM
