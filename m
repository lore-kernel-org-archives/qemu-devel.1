Received: from eggs.gnu.org ([2001:4830:134:3::10]:34077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfF5-0000Fz-LP
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfF4-0004eq-QB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:41:55 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:37928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVfF4-0004eO-Ce
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:41:54 -0400
Received: by mail-oi0-x229.google.com with SMTP id d5-v6so7274oib.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 08:41:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ba4603d-8b79-ccef-907b-98254ccd7e71@redhat.com>
References: <20180620132032.28865-1-peter.maydell@linaro.org>
	<20180620132032.28865-3-peter.maydell@linaro.org>
	<8ba4603d-8b79-ccef-907b-98254ccd7e71@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 16:41:33 +0100
Message-ID: <CAFEAcA-Lx0-MQYAQJ53fTP90LC1uzdnsMC1eO2VMR_2B3mUZJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/8] hw/misc/tz-mpc.c: Implement
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 20 June 2018 at 16:26, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 06/20/2018 03:20 PM, Peter Maydell wrote:
>> Implement the missing registers for the TZ MPC.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> @@ -127,7 +182,7 @@ static MemTxResult tz_mpc_reg_write(void *opaque, hwaddr addr,
>>      if (!attrs.secure && offset < A_PIDR4) {
>>          /* NS accesses can only see the ID registers */
> When reading
> "Identification registers can be read by any type of access." I
> understand all others can only be read by secure accesses. So I would
> have expected the same check on read side.

The check is there for reads too, it's in patch 1.

> Eric
>>          qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "TZ MPC register read: NS access to offset 0x%x\n",
>> +                      "TZ MPC register write: NS access to offset 0x%x\n",
>>                        offset);

...this change should have been squashed into patch 2 (I cut-n-pasted
the check from the read function to the write function, forgot
to update the string, noticed that later but put the string fix into
the wrong patch).

Sorry about the confusion.

thanks
-- PMM
