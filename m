Received: from eggs.gnu.org ([2001:4830:134:3::10]:54675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIbSY-0004Yo-Do
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIbSV-00044d-TU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:01:50 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIbSV-00044Q-NK
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:01:47 -0400
Received: by mail-pf0-x241.google.com with SMTP id f189-v6so183959pfa.7
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:01:47 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-11-richard.henderson@linaro.org>
	<CAFEAcA8kszX4c8WjMabKm6otWFgak8jVJ69o9N2M+uCYfcxFCA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2e44bb94-a702-c11c-aada-9762c962e853@linaro.org>
Date: Tue, 15 May 2018 08:01:43 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8kszX4c8WjMabKm6otWFgak8jVJ69o9N2M+uCYfcxFCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 10/28] target/arm: convert conversion
 helpers to fpst/ahp_flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/15/2018 03:08 AM, Peter Maydell wrote:
> On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> Instead of passing env and leaving it up to the helper to get the
>> right fpstatus we pass it explicitly. There was already a get_fpstatus
>> helper for neon for the 32 bit code. We also add an get_ahp_flag() for
>> passing the state of the alternative FP16 format flag. This leaves
>> scope for later tracking the AHP state in translation flags.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> ---
>> v4
>>   - remove neon_fcvt_*; they are now identical to vfp_fcvt_*.
>>   - add flags to vfp_fcvt_* helper decls.
>>   - add some missing tcg_temp_free_*.
>> v5
>>   - always use get_fpstatus_ptr(false) for FZ, since FZ16 is
>>     supposed to be supressed.
>> ---
> 
>> @@ -9053,12 +9066,17 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
>>              } else {
>>                  TCGv_i32 tcg_lo = tcg_temp_new_i32();
>>                  TCGv_i32 tcg_hi = tcg_temp_new_i32();
>> +                TCGv_ptr fpst = get_fpstatus_ptr(true);
> 
> Still the wrong fpstatus here...

Bah.  Got em now.  Thanks.


r~
