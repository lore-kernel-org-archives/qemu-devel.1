Received: from eggs.gnu.org ([2001:4830:134:3::10]:54899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31F1-0001Rs-H8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d31Ew-0007CV-JH
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:14:55 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:33498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d31Ew-0007C6-CH
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:14:50 -0400
Received: by mail-it0-x241.google.com with SMTP id z67so21761782itb.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:14:50 -0700 (PDT)
In-Reply-To: <CAFEAcA8dxiTdoWryTNDi347Cuwf3wULaWCSxJo9FsSaoTPJWHQ@mail.gmail.com>
References: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
	<CAFEAcA8dxiTdoWryTNDi347Cuwf3wULaWCSxJo9FsSaoTPJWHQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8FE39B6C-988A-46BA-95F6-D8A2ECDC6E1C@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 25 Apr 2017 10:14:47 -0400
Subject: Re: [Qemu-devel] [PATCH 1/9] Add ppc.risu file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On Apr 25, 2017, at 4:14 AM, Peter Maydell wrote:

> On 25 April 2017 at 04:17, G 3 <programmingkidx@gmail.com> wrote:
>> Add the ppc.risu file. It defines the format for various PowerPC
>> instructions.
>>
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>>  ppc.risu | 527
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 527 insertions(+)
>>  create mode 100644 ppc.risu
>>
>> diff --git a/ppc.risu b/ppc.risu
>> new file mode 100644
>> index 0000000..b6d6aee
>> --- /dev/null
>> +++ b/ppc.risu
>> @@ -0,0 +1,527 @@
>> +#################################################################### 
>> ###########
>> +# File: ppc.risu
>> +# Date: 3-27-2017
>> +# Description: Specifies PowerPC instruction test patterns.
>> +#################################################################### 
>> ###########
>
> Missing copyright and license statement.
>
>> +
>> +.mode ppc
>> +
>> +# Note: register r1 cannot be used because it is the stack pointer.
>> +# The branching, VEA, and OEA instructions cannot be used here  
>> currently.
>> +
>> +ADD PPC 011111 rD:5 rA:5 rB:5 OE:1 100001010 Rc:1 \
>> +!constraints { $rD != 1 && $rA != 1 && $rB != 1; }
>> +
>> +ADDC PPC 011111 rD:5 rA:5 rB:5 OE:1 000001010 Rc:1 \
>> +!constraints { $rD != 1 && $rA != 1 && $rB != 1; }
>> +
>> +ADDE PPC 011111 rD:5 rA:5 rB:5 OE:1 010001010 Rc:1 \
>> +!constraints { $rD != 1 && $rA != 1 && $rB != 1; }
>
>
> There's an awful lot of duplication with ppc64 here. Is it
> worth trying to share?
>
>
> thanks
> -- PMM

That would be difficult. There are a lot of new instructions in ppc64  
that don't exist in ppc32.
