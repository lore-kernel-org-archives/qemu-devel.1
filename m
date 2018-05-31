Received: from eggs.gnu.org ([2001:4830:134:3::10]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOKi1-0004Dt-D8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOKhy-00039u-9H
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:21:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOKhy-000378-2R
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:21:26 -0400
Received: by mail-wr0-f196.google.com with SMTP id j1-v6so32455986wrm.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:21:25 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-24-peter.maydell@linaro.org>
	<c049f864-304d-f8ee-4b2f-1476a602be30@redhat.com>
	<CAFEAcA_ErfYKnVrp=Dv9mNg55Y+=fFmg4eEMddGdMxUGVb9ztA@mail.gmail.com>
	<530bef1b-a143-1566-3089-32629ab250b8@redhat.com>
	<CAFEAcA94JAccGhbhSrBkTHUV+dLR-EvYQW_nuB9FodtLTDQPZw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c7e4c537-2174-005b-fa15-0e8286e540ad@redhat.com>
Date: Thu, 31 May 2018 12:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94JAccGhbhSrBkTHUV+dLR-EvYQW_nuB9FodtLTDQPZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 30/05/2018 19:35, Peter Maydell wrote:
> On 30 May 2018 at 17:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 21/05/2018 17:02, Peter Maydell wrote:
>>> On 21 May 2018 at 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> Why do the levels have to be migrated at all?  It should be enough if
>>>> the IRQ level is either migrated manually, or restored (e.g. in
>>>> post_save callbacks) through other data that is migrated.
>>> This is standard behaviour for devices: they track their
>>> inbound irq/gpio lines, and then that becomes internal state for
>>> them that must be migrated.
>>
>> But or_irq's input are another device's outbound lines, so tracking them
>> should not be necessary.  The other device would do it for or_irq.
> 
> There's no mechanism in qemu_irq for the destination end to ask
> the source end about its current value. The information flow
> is strictly one-way.

On postload, the source must call qemu_set_irq and that will cause an
update of the or_irq, won't it?

Paolo
