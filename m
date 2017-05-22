Received: from eggs.gnu.org ([2001:4830:134:3::10]:44849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dCn2X-0006Sm-Gc
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dCn2R-0002He-46
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:06:25 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:36449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dCn2Q-0002Gh-V0
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:06:19 -0400
Received: by mail-io0-x243.google.com with SMTP id f102so13202011ioi.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:06:17 -0700 (PDT)
In-Reply-To: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 22 May 2017 09:06:08 -0400
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sandipan Das <sandipandas1990@gmail.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>


On May 22, 2017, at 4:32 AM, qemu-devel-request@nongnu.org wrote:

> Message: 2
> Date: Mon, 22 May 2017 12:33:29 +0530
> From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> To: Sandipan Das <sandipandas1990@gmail.com>
> Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
> 	joserz@linux.vnet.ibm.com
> Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
> 	doubleword instructions
> Message-ID:
> 	<87a865nzjy.fsf@abhimanyu.i-did-not-set--mail-host-address--so- 
> tickle-me>
> 	
> Content-Type: text/plain
>
> Sandipan Das <sandipandas1990@gmail.com> writes:
>
>> The patterns for the following instructions are fixed:
>>  * Rotate Left Doubleword then Clear Right (rldcr[.])
>>  * Rotate Left Doubleword Immediate then Clear Right (rldicr[.])
>>  * Rotate Left Doubleword Immediate then Mask Insert (rldimi[.])
>>
>> Signed-off-by: Sandipan Das <sandipandas1990@gmail.com>
>> ---
>>  ppc64.risu | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/ppc64.risu b/ppc64.risu
>> index 28df9da..0f29248 100644
>> --- a/ppc64.risu
>> +++ b/ppc64.risu
>> @@ -1451,7 +1451,7 @@ RLDCLd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6  
>> 10001 \
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 &&  
>> $ra != 13 && $rb != 13; }
>>
>>  # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then  
>> Clear Right
>> -RLCDR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
>> +RLDCR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 &&  
>> $ra != 13 && $rb != 13; }
>>  # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then  
>> Clear Right
>>  RLDCRd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10011 \
>> @@ -1472,17 +1472,17 @@ RLDICLd PPC64LE 011110 rs:5 ra:5 sh:5 mb:6  
>> 000 sha:1 1 \
>>  !constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>>
>>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword  
>> Immediate then Clear Right
>> -RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00010 \
>> +RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 001 sha:1 0 \
>
>    RLDICR PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0
>
> Also "rb:5" be changed as "sh:5"?
>
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 &&  
>> $ra != 13 && $rb != 13; }
>>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword  
>> Immediate then Clear Right
>> -RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00011 \
>> +RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 001 sha:1 1 \
>
>    RLDICRd PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0
>
>
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 &&  
>> $ra != 13 && $rb != 13; }
>>
>>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword  
>> Immediate then Mask Insert
>> -RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00110 \
>> +RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 011 sha:1 0 \
>
>    RLDIMI PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 0
>
>
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 &&  
>> $ra != 13 && $rb != 13; }
>>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword  
>> Immediate then Mask Insert
>> -RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00111 \
>> +RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 011 sha:1 1 \
>
>    RLDIMId PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 1
>
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 &&  
>> $ra != 13 && $rb != 13; }
>>
>>  # format:M book:I page:102 v:P1 SR rlwimi[.] Rotate Left Word  
>> Immediate then Mask Insert
>> -- 
>> 2.7.4
>
> Regards,
> Nikunj

Hello I have also done some work risu. My patches add ppc32 support.  
Well my patches were made to work with Mac OS X but they are required  
to work with Linux. Do you think you could help port these patches to  
Linux?

ppc.risu:
https://patchwork.kernel.org/patch/9697489/

risu_ppc.c:
https://patchwork.kernel.org/patch/9697491/

risu_reginfo_ppc.c:
https://patchwork.kernel.org/patch/9697493/

risu_reginfo_ppc.h:
https://patchwork.kernel.org/patch/9697495/

risugen_ppc.pm:
https://patchwork.kernel.org/patch/9697497/

Add ppc support to configure:
https://patchwork.kernel.org/patch/9697499/

Add verbose option:
https://patchwork.kernel.org/patch/9697501/

Add end of test message:
https://patchwork.kernel.org/patch/9697503/

Add more descriptive comment for mismatch or end of test condition:
https://patchwork.kernel.org/patch/9697505/
