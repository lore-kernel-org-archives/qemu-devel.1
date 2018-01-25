Received: from eggs.gnu.org ([2001:4830:134:3::10]:57160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eekyd-00066P-66
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eekyc-0007Kr-CI
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:06:15 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eekyc-0007K8-6P
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:06:14 -0500
Received: by mail-pf0-x231.google.com with SMTP id e76so6218273pfk.1
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:06:13 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-13-richard.henderson@linaro.org>
	<CAFEAcA9Nqc_bz=QY7F0RuCMvBX1m=JCDWjyoF37SOS0A+8CFLQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b8d9631e-6587-f8dd-65ba-2a56facdb9f4@linaro.org>
Date: Thu, 25 Jan 2018 09:06:08 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Nqc_bz=QY7F0RuCMvBX1m=JCDWjyoF37SOS0A+8CFLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10.5 12/20] target/arm: Use vector
 infrastructure for aa64 add/sub/logic
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

On 01/25/2018 08:44 AM, Peter Maydell wrote:
>> +/* Return the offset info CPUARMState of the "whole" vector register Qn.  */
>> +static inline int vec_full_reg_offset(DisasContext *s, int regno)
>> +{
>> +    assert_fp_access_checked(s);
>> +    return offsetof(CPUARMState, vfp.regs[regno * 2]);
>> +}
> 
> This function is already in the preparatory SVE code in target-arm.next,
> so it should go away on rebase...

Ok.

> 
>> +
>> +/* Return the byte size of the "whole" vector register, VL / 8.  */
>> +static inline int vec_full_reg_size(DisasContext *s)
>> +{
>> +    /* FIXME SVE: We should put the composite ZCR_EL* value into tb->flags.
>> +       In the meantime this is just the AdvSIMD length of 128.  */
>> +    return 128 / 8;
>> +}
> 
> ...and this is fixed in your other patchset with the leftovers from
> that preparatory set, right? What's the plan for what sequence we
> put these into master?

I had previously assumed that this patch set would go in before all of the
other SVE prep work, though it doesn't seem to be working out that way...

I'd like this one to go in next, fwiw.

> Have you done risu-testing on this patchset?

Yes, I've run the full set of aarch64 risu tests.


r~
