Received: from eggs.gnu.org ([2001:4830:134:3::10]:33675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS1Cr-0008LZ-SE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS1Cr-0000L9-0h
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:43:45 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:36288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cS1Cq-0000KU-O4
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:43:44 -0500
Received: by mail-ua0-x233.google.com with SMTP id 96so35781052uaq.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:43:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAF++6AOnuOzwiiPRJEGatzX7LuoJKU5ij2xWRLkKbxhytJscqA@mail.gmail.com>
References: <CAF++6AOnuOzwiiPRJEGatzX7LuoJKU5ij2xWRLkKbxhytJscqA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2017 12:43:23 +0000
Message-ID: <CAFEAcA87460MwQA2bjOxm-z6nfkNobQZC8X1qEFKZioWsznR3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-discuss] system_clock_scale unset in
 hw/intc/armv7m_nvic.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hanley <jhanley@dgtlrift.com>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 January 2017 at 12:35, James Hanley <jhanley@dgtlrift.com> wrote:
> How should system_clock_scale be set in hw/intc/armv7m_nvic.c - there is no
> API for the global, and I've defaulted the global to SYSTICK_SCALE which
> seems to work, but is not obvious.  This was needed as this value was set to
> zero and the arm firmware was selecting the external clock source causing
> zero to be returned from systick_scale() and the interrupt to run
> continuously.

If I recall correctly, this is an external-to-the-CPU thing
(wired up by the SoC or the board), which suggests that it
ought to be a property on the CPU object (or perhaps on a
currently-nonexistent container object which has the CPU
and the NVIC and the other M profile devices).

As the code stands today, I think the answer is that the
board has to set the global -- this is what stellaris.c does.

thanks
-- PMM
