Received: from eggs.gnu.org ([209.51.188.92]:44489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggsko-0008H0-Ca
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggskm-0000gP-Mx
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:53:18 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggskm-0000cl-B6
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:53:16 -0500
Received: by mail-ot1-x32d.google.com with SMTP id a11so3676707otr.10
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 06:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20181217202602.31113-1-r.bolshakov@yadro.com>
In-Reply-To: <20181217202602.31113-1-r.bolshakov@yadro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 14:53:03 +0000
Message-ID: <CAFEAcA_zYU5FtxW2NFmhyoC5qaV8_T6P7TBkV8zUKW1hf-b=XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/2] Improve qemu-thread support on macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 17 Dec 2018 at 20:46, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
>
> Hello,
>
> I've hit a case where QEMU hangs not responding to anything except
> SIGKILL. It turned out to be a SIGSEGV in vCPU thread that was lost by
> masking all signals.
>
> By blocking too many signals QEMU relies on undefined behaviour that
> seems to work on Linux. It's documented in POSIX reference and
> sigprocmask(2). Indeed signalfd(2) on Linux notes that it can't be used
> to receive SIGSEGV and SIGFPE.
>
> It's not clear what do with SIGBUS on macOS. We can't blindly unblock it
> as it's used for memory preallocation.
>
> Also the RFC adds support for thread naming on macOS. Some threads
> (signalfd_compat and rcu_call) are created before debug-threads=on is
> parsed and don't get their names though.

Applied to master, thanks.

-- PMM
