Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipandas1990@gmail.com>) id 1dChlB-0005A2-4r
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipandas1990@gmail.com>) id 1dChl7-0001HN-Ps
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:28:08 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sandipandas1990@gmail.com>)
	id 1dChl7-0001HB-IU
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:28:05 -0400
Received: by mail-pf0-x241.google.com with SMTP id w69so18119220pfk.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 00:28:05 -0700 (PDT)
References: <1495433816-4265-1-git-send-email-sandipandas1990@gmail.com>
	<87a865nzjy.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Sandipan Das <sandipandas1990@gmail.com>
Message-ID: <7132ead3-2b4c-ae8d-a5b9-d9e483c9ff63@gmail.com>
Date: Mon, 22 May 2017 12:57:59 +0530
MIME-Version: 1.0
In-Reply-To: <87a865nzjy.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, joserz@linux.vnet.ibm.com

On Monday 22 May 2017 12:33 PM, Nikunj A Dadhania wrote:
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
>> @@ -1451,7 +1451,7 @@ RLDCLd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10001 \
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>>
>>  # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then Clear Right
>> -RLCDR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
>> +RLDCR PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10010 \
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>>  # format:MDS book:I page:103 PPC SR rldcr Rotate Left Dword then Clear Right
>>  RLDCRd PPC64LE 011110 rs:5 ra:5 rb:5 mb:6 10011 \
>> @@ -1472,17 +1472,17 @@ RLDICLd PPC64LE 011110 rs:5 ra:5 sh:5 mb:6 000 sha:1 1 \
>>  !constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
>>
>>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
>> -RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00010 \
>> +RLDICR PPC64LE 011110 rs:5 ra:5 rb:5 me:6 001 sha:1 0 \
> 
>    RLDICR PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0
> 
> Also "rb:5" be changed as "sh:5"?

Yes, I missed that.

> 
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>>  # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
>> -RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00011 \
>> +RLDICRd PPC64LE 011110 rs:5 ra:5 rb:5 me:6 001 sha:1 1 \
> 
>    RLDICRd PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0
> 
> 
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>>
>>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
>> -RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00110 \
>> +RLDIMI PPC64LE 011110 rs:5 ra:5 rb:5 me:6 011 sha:1 0 \
> 
>    RLDIMI PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 0
> 
> 
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>>  # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
>> -RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 00111 \
>> +RLDIMId PPC64LE 011110 rs:5 ra:5 rb:5 me:6 011 sha:1 1 \
> 
>    RLDIMId PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 1
> 
>>  !constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
>>
>>  # format:M book:I page:102 v:P1 SR rlwimi[.] Rotate Left Word Immediate then Mask Insert
>> -- 
>> 2.7.4
> 
> Regards,
> Nikunj
> 

With Regards,
Sandipan
