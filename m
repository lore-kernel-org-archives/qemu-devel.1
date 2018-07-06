Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTy4-0002cN-19
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTy0-0006Hb-4b
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:52:24 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fbTxz-0006Gl-U9
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:52:20 -0400
Received: by mail-qt0-x243.google.com with SMTP id h5-v6so10469850qtm.13
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:52:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530877732-26557-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530877732-26557-3-git-send-email-aleksandar.markovic@rt-rk.com>
	<BN7PR08MB4868AC9B85699C8293579F63C6470@BN7PR08MB4868.namprd08.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2782023-f98c-c425-1897-07595f5ba1fb@amsat.org>
Date: Fri, 6 Jul 2018 13:52:14 -0300
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868AC9B85699C8293579F63C6470@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/8] target/mips: Workaround for
 checkpatch.pl hanging on msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Hi Aleksandar,

On 07/06/2018 12:38 PM, Aleksandar Markovic wrote:
> Hi, Paolo,
> 
> It was an incredibly fast fix! :)
> 
> I already confirmed that the fix fixes the problem on msa_helper.c. I would nevertheless like to have this workaround applied. Can you perhaps give it "Reviewed-by"?
> 
> Regards,
> Aleksandar
> 
> 
>> Subject: [PATCH v4 2/8] target/mips: Workaround for checkpatch.pl hanging on > msa_helper.c
>>
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> If checkpatch.pl is applied (using switch "-f") on file
>> target/mips/msa_helper.c, it will hang.
>>
>> This is a workaround by correcting the source file. The workaround is
>> found by partial deleting and undeleting of the code in msa_helper.c
>> in binary search fashion.
>>
>> The bug (for checkpatch.pl) is already reported to the qemu-devel list.
>>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>  target/mips/msa_helper.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
>> index c74e3cd..1691b70 100644
>> --- a/target/mips/msa_helper.c
>> +++ b/target/mips/msa_helper.c
>> @@ -2750,8 +2750,8 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, > uint32_t wd,
>>
>>  #define FMAXMIN_A(F, G, X, _S, _T, BITS, STATUS)                    \
>>      do {                                                            \
>> -        uint## BITS ##_t S = _S, T = _T;                            \
>> -        uint## BITS ##_t as, at, xs, xt, xd;                        \
>> +        uint## BITS ## _t S = _S, T = _T;                           \
>> +        uint## BITS ## _t as, at, xs, xt, xd;                       \

I'm not sure it's worth having this but you are the maintainer so your
choice :) What is unclear to me is, while changing this, why only fix
the suffix and not also the prefix? That is:

            uint<space>## BITS ##<space>_t S = _S, T = _T;

>>          if (NUMBER_QNAN_PAIR(S, T, BITS, STATUS)) {                 \
>>              T = S;                                                  \
>>          }                                                           \
>> --
>> 2.7.4
