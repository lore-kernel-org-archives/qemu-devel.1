Received: from eggs.gnu.org ([2001:4830:134:3::10]:56073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fO50m-00050o-Rj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fO50m-0001tq-2H
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:35:48 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fO50l-0001rV-U6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 13:35:47 -0400
Received: by mail-ot0-x241.google.com with SMTP id y10-v6so22086860otg.10
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 10:35:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <530bef1b-a143-1566-3089-32629ab250b8@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
	<c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
	<CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
	<530bef1b-a143-1566-3089-32629ab250b8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 May 2018 18:35:25 +0100
Message-ID: <CAFEAcA94JAccGhbhSrBkTHUV+dLR-EvYQW_nuB9FodtLTDQPZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 23/27] hw/core/or-irq: Support more than 16
 inputs to an OR gate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 30 May 2018 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/05/2018 17:02, Peter Maydell wrote:
>> On 21 May 2018 at 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Why do the levels have to be migrated at all?  It should be enough if
>>> the IRQ level is either migrated manually, or restored (e.g. in
>>> post_save callbacks) through other data that is migrated.
>> This is standard behaviour for devices: they track their
>> inbound irq/gpio lines, and then that becomes internal state for
>> them that must be migrated.
>
> But or_irq's input are another device's outbound lines, so tracking them
> should not be necessary.  The other device would do it for or_irq.

There's no mechanism in qemu_irq for the destination end to ask
the source end about its current value. The information flow
is strictly one-way.

thanks
-- PMM
