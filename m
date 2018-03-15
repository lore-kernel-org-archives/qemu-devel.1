Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewZhw-0001GE-JI
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewZhv-0002bH-TN
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:42:40 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:44808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewZhv-0002aN-NO
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:42:39 -0400
Received: by mail-oi0-x233.google.com with SMTP id b8so6853197oib.11
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 13:42:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGaT8w6dsthvR4GUsbGZLXe0JDGFtP6RkjMPWj5yjmHF8fQs0g@mail.gmail.com>
References: <CAGaT8w45tJ32EVj20RFjmG9=WvZBfAuF_j3BgXsFy5ZmPef-Ow@mail.gmail.com>
	<CAFEAcA_BQxw-nQj8nfuLgRwx=uKg_Hvz+ku=P-Qj4oLG_FOAfA@mail.gmail.com>
	<CAGaT8w6dsthvR4GUsbGZLXe0JDGFtP6RkjMPWj5yjmHF8fQs0g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 20:42:18 +0000
Message-ID: <CAFEAcA90d29ge0x+0NLwziZukieee0J9=-Cb_uvmKkWE8p82dA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ARM64 Interrupt handling on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijen Raval <bjraval123@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2018 at 20:24, Brijen Raval <bjraval123@gmail.com> wrote:
> On Thu, Mar 15, 2018 at 2:59 AM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>> Exception 5 is IRQ. (These numbers are all internal to QEMU, and
>> don't have any architectural or guest-visible relevance. They're
>> the EXCP_* constants defined at the top of target/arm/cpu.h.)
>
>
> Yup I checked out the QEMU source and confirmed above. So is there any way
> to find out what is the IRQ for?

You would need to look at what the state of the interrupt controller
is. You can turn on all the tracepoints in the GIC with -d trace:gic*
(though to understand what it's saying you may need to have
some familiarity with the GIC spec and/or look at the code).

thanks
-- PMM
