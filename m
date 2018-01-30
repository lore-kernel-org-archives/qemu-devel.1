Received: from eggs.gnu.org ([2001:4830:134:3::10]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egXhj-0002no-H9
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egXhi-00070n-JI
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:20:11 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egXhi-0006zb-Dq
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:20:10 -0500
Received: by mail-oi0-x241.google.com with SMTP id k15so8055764oib.1
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 07:20:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517318239-15764-1-git-send-email-peter.maydell@linaro.org>
References: <1517318239-15764-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 15:19:49 +0000
Message-ID: <CAFEAcA9WEM=eSa-7sFCV0ue5wHcRfvRC8EmA+9VEdsG85+9vCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user/signal.c: Rename MC_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, "patches@linaro.org" <patches@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 30 January 2018 at 13:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> The SPARC code in linux-user/signal.c defines a set of
> MC_* constants. On some SPARC hosts these are also defined
> by sys/ucontext.h, resulting in build failures:
>
> linux-user/signal.c:2786:0: error: "MC_NGREG" redefined [-Werror]
>  #define MC_NGREG 19
>
> In file included from /usr/include/signal.h:302:0,
>                  from include/qemu/osdep.h:86,
>                  from linux-user/signal.c:19:
> /usr/include/sparc64-linux-gnu/sys/ucontext.h:59:0: note: this is the location of the previous definition
>  # define MC_NGREG __MC_NGREG
>
> Rename all these constants to SPARC_MC_* to avoid the clash.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This has just started causing failures on the SPARC build
> box I use for merge tests (presumably due to a system
> header update), so I'm planning to apply this to master as
> a buildfix.

Now applied, thanks. I threw in a cc of qemu-stable too,
since otherwise stable point releases won't build on these hosts.

-- PMM
