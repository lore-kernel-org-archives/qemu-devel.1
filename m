Received: from eggs.gnu.org ([209.51.188.92]:45330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqiF2-0005HB-Co
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqiF0-0001E1-Hj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:41:07 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqiEw-00011J-Rh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:41:03 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so1242792otk.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 09:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20190130192403.13754-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190130192403.13754-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 17:40:50 +0000
Message-ID: <CAFEAcA_3_VAMM+Tc-kWoCZfGO_DJXDKqEHcFHCnf8SDQkJQ3uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Luc Michel <luc.michel@greensocs.com>

On Wed, 30 Jan 2019 at 19:24, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
> kill the inferior. Handle 'vKill' the same way 'k' was handled in the
> presence of single process.
>
> Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
> (f|s)ThreadInfo and ThreadExtraInfo")
>
> Cc: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - terminate QEMU in the vKill packet handler regardless of whatever the
>   PID is or how many processes are attached [Luc Michel]
>

Thanks; I'll take this via target-arm.next since I took the
multiprocess-support gdbstub patches.

-- PMM
