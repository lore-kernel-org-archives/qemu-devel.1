Received: from eggs.gnu.org ([2001:4830:134:3::10]:49646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpPS-00075b-8y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpPO-0001Vr-Dp
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:57:34 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:46477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXpPO-0001VU-5z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:57:30 -0400
Received: by mail-pf0-x243.google.com with SMTP id q1-v6so8200119pff.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:57:29 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-28-richard.henderson@linaro.org>
	<CAFEAcA90Wp1N8e25SXLmnJOHPeQNZMvd_Xd1G-oJmtzHDaepgw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0ed8012-5212-7c8c-dbf3-3b4688da09e4@linaro.org>
Date: Tue, 26 Jun 2018 07:57:25 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90Wp1N8e25SXLmnJOHPeQNZMvd_Xd1G-oJmtzHDaepgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 27/35] target/arm: Implement SVE MOVPRFX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2018 05:24 AM, Peter Maydell wrote:
>> + * TODO: The implementation so far could handle predicated merging movprfx.
>> + * The helper functions as written take an extra source register to
>> + * use in the operation, but the result is only written when predication
>> + * succeeds.  For unpredicated movprfx, we need to rearrange the helpers
>> + * to allow the final write back to the destination to be unconditional.
>> + * For predicated zering movprfz, we need to rearrange the helpers to
> 
> "zeroing". Should that be "movprfx" or is "movprfz" a thing? (the SVE
> spec doesn't mention it.)

Yes, typo for movprfx.

> 
>> + * allow the final write back to zero inactives.
>> + *
>> + * In the meantime, just emit the moves.
>> + */
>> +
>> +static bool trans_MOVPRFX(DisasContext *s, arg_MOVPRFX *a, uint32_t insn)
>> +{
>> +    return do_mov_z(s, a->rd, a->rn);
>> +}
> 
> A bit confusing that do_mov_z() does the sve_access_check() for us
> but do_sel_z() and do_movz_zpz() do not...

Yes.  I regret do_mov_z does the check, but that patch is already in mainline,
and fixing it up isn't a necessity or a priority.


r~
