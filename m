Received: from eggs.gnu.org ([2001:4830:134:3::10]:34497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK1Pp-0001lw-0O
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK1N2-0002hf-0I
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:26:17 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK1N1-0002gJ-Ny
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 08:26:15 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so1151801otk.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 05:26:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3988cd7b9d292017537f75c2eed70295a3a84718.1541447021.git.alistair.francis@wdc.com>
References: <3988cd7b9d292017537f75c2eed70295a3a84718.1541447021.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 13:25:53 +0000
Message-ID: <CAFEAcA8wLiNgW43tasbZHfjmOxQ209UdpHqCMHNcyQ25G9XcTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv: spike: Fix memory leak in
 the board init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>

On 5 November 2018 at 19:44, Alistair Francis <Alistair.Francis@wdc.com> wrote:
> Coverity caught a malloc() call that was never freed. This patch ensures
> that we free the memory but also updates the allocation to use
> g_strdup_printf() instead of malloc().
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
