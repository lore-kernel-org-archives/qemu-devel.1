Received: from eggs.gnu.org ([2001:4830:134:3::10]:39474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewSWX-0007ai-K8
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewSWR-0008Br-T3
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:02:25 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:37987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewSWR-0008Aw-O7
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 09:02:19 -0400
Received: by mail-ot0-x22b.google.com with SMTP id 95-v6so6753683ote.5
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 06:02:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313155918.23591-1-laurent@vivier.eu>
References: <20180313155918.23591-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 13:01:57 +0000
Message-ID: <CAFEAcA8JBqAEj=JhH+Tfni=c4AnqfivseSFmNgxZfYYqiw5JGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] M68k for 2.12 patches
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

On 13 March 2018 at 15:59, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 59667bb167f773965ce6547352f312eff0d4d523:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-03-13 14:02:47 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to 02f9124ebe26c36f0f7ed58085bd963e4372b2cd:
>
>   target/m68k: implement fcosh (2018-03-13 16:35:05 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (11):
>   target/m68k: implement ftan
>   target/m68k: implement fsin
>   target/m68k: implement fcos
>   target/m68k: implement fsincos
>   target/m68k: implement fatan
>   target/m68k: implement fasin
>   target/m68k: implement facos
>   target/m68k: implement fatanh
>   target/m68k: implement ftanh
>   target/m68k: implement fsinh
>   target/m68k: implement fcosh
>
>  target/m68k/fpu_helper.c            |   61 ++
>  target/m68k/helper.h                |   11 +
>  target/m68k/softfloat.c             | 1637 +++++++++++++++++++++++++++++++++++
>  target/m68k/softfloat.h             |   11 +
>  target/m68k/softfloat_fpsp_tables.h |  267 ++++++
>  target/m68k/translate.c             |   38 +
>  6 files changed, 2025 insertions(+)

Applied, thanks.

-- PMM
