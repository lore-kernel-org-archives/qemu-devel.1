Received: from eggs.gnu.org ([2001:4830:134:3::10]:34909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f81iR-0000jc-OY
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f81iQ-0002sz-Tl
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:50:31 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f81iQ-0002sr-ON
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:50:30 -0400
Received: by mail-ot0-x244.google.com with SMTP id g23-v6so1688116oti.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 03:50:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180415094638.3278-1-laurent@vivier.eu>
References: <20180415094638.3278-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 11:50:09 +0100
Message-ID: <CAFEAcA_7Rp2S-b2gtCScosf0drD4F9JFjzD=E27TG8xFSdfiSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] m68k fixes for 2.12-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 April 2018 at 10:46, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 38e83a71d02e026d4a6d0ab1ef9855c4924c2c68:
>
>   Update version for v2.12.0-rc3 release (2018-04-11 19:03:24 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to 000761dc0c97d70e7314db3e8f52783880325a22:
>
>   m68k: fix exception stack frame for 68000 (2018-04-15 11:37:58 +0200)
>
> ----------------------------------------------------------------
> This patch fixes a problem with the exception stack for
> 68000 only CPU. As we use 68040 for linux-user and coldfire
> for softmmu, I don't think we should trigger a -rc4
> only for that, so merge this only if a -rc4 is needed
> by something else.
> ----------------------------------------------------------------
>
> Pavel Dovgalyuk (1):
>   m68k: fix exception stack frame for 68000
>
>  target/m68k/op_helper.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Applied, thanks.

-- PMM
