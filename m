Received: from eggs.gnu.org ([2001:4830:134:3::10]:40743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkZy-0004tM-Bi
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkZx-0006RR-K0
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:59:34 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:33114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTkZx-0006Pf-Ec
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:59:33 -0400
Received: by mail-ot0-x232.google.com with SMTP id h6-v6so10244985otj.0
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 01:59:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a99ad0cb-89f5-1241-7992-d133546e28c7@redhat.com>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-7-peter.maydell@linaro.org>
	<a99ad0cb-89f5-1241-7992-d133546e28c7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 09:59:11 +0100
Message-ID: <CAFEAcA8AfiaJqJxgbOothdY8JDZ3dK9qLCVZL=k=J_nxtwMXJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/13] hw/misc/tz-mpc.c: Implement
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

On 14 June 2018 at 21:14, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 06/04/2018 05:29 PM, Peter Maydell wrote:
>> Implement the missing registers for the TZ MPC.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>>  static MemTxResult tz_mpc_reg_read(void *opaque, hwaddr addr,
>>                                     uint64_t *pdata,
>>                                     unsigned size, MemTxAttrs attrs)
>>  {
>> +    TZMPC *s = TZ_MPC(opaque);
>>      uint64_t r;
>>      uint32_t offset = addr & ~0x3;
> I don't get where do we check if the access is secure or not. Shouldn't
> we test attrs.secure somewhere (PPROT[1] == 0)? Also the spec says
> IDregs can be read by any type of access. Where is this differentiation
> done?

I'd missed that bit of the spec -- yes, we should be checking
attrs.secure to see if we should allow access to the non-ID registers.
For the MPS2 boards it doesn't matter because the registers are
in a part of the memory map that is enforced as secure-access-only
by the IDAU.

thanks
-- PMM
