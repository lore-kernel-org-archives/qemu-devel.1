Received: from eggs.gnu.org ([2001:4830:134:3::10]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXE0Z-0007LA-Bo
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXE0W-0002Lx-2e
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:33:39 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXE0V-0002Iw-GS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:33:35 -0500
Received: by mail-ot1-x344.google.com with SMTP id v23so160139otk.9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 15:33:35 -0800 (PST)
References: <cover.1544643238.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <89a7db22-6744-0fb5-e543-847569e942c4@linaro.org>
Date: Wed, 12 Dec 2018 17:33:31 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1544643238.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/23] Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 12/12/18 1:42 PM, Alistair Francis wrote:
> As this is all new work (so can't cause regressions) I'm starting the
> patch series process with what we have so far. That way others can help
> contribute and test. If anyone has strong feelings for missing functionality
> let me know and we can work on adding that before this is merged.

I'd be ok merging this immediately after the bswap patches currently queued on
my tcg-next-2 branch.  Which for you just means defining
TCG_TARGET_HAS_MEMORY_BSWAP to 0 and fixing the one MAINTAINERS entry.

Anything else can be fixed or improved via normal development.


r~
