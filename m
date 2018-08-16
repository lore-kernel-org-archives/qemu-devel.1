Received: from eggs.gnu.org ([2001:4830:134:3::10]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLEw-0005cx-5t
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLEv-0005ct-E6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:35:14 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqLEv-0005cX-7h
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:35:13 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so9088413oib.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:35:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180816120533.6587-1-rka@sysgo.com>
References: <20180816120533.6587-1-rka@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:34:52 +0100
Message-ID: <CAFEAcA9DB_xNyxsFbWL9aNcV_ZoUAhj2B+d8Y7gg9qOLCQgFvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: crash on conditional instr
 in it block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 August 2018 at 13:05, Roman Kapl <rka@sysgo.com> wrote:
> If an instruction is conditional (like CBZ) and it is executed conditionally
> (using the ITx instruction), a jump to undefined label is generated.
> CBZ in IT block is an unpredictable behavior, and honouring the condition code
> is allowed by the spec in this case (constrained unpredictable, ARMv8, section
> K1.1.7).
>
> Fix the 'skip on condtion' code to create a new label only if it does not
> already exist. Previously multiple labels were created, but only the last one of
> them was set.
>
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
> v1 -> v2
>  Split arm_conditional_skip into arm_gen_condlabel and arm_skip_unless to
>  a) cover all usages
>  b) do not force callers to ^1 the condition
>
>  Add note about CBZ in IT block to the commit message.



Applied to target-arm.next, thanks.

-- PMM
