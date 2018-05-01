Received: from eggs.gnu.org ([2001:4830:134:3::10]:60828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fDSOZ-00084M-EQ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rafaelkioji@gmail.com>) id 1fDSOV-0006Nv-3B
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:20:27 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:37365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rafaelkioji@gmail.com>)
	id 1fDSOU-0006Nj-TI
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:20:23 -0400
Received: by mail-pf0-x22e.google.com with SMTP id e9so4860070pfi.4
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 03:20:22 -0700 (PDT)
References: <1fa7369f-9c6d-73c6-77e1-7911a9538d82@gmail.com>
	<87vac7adz2.fsf@linaro.org>
From: Rafael Kioji <rafaelkioji@gmail.com>
Message-ID: <8f27190a-3875-2eea-4138-172e590f4eb2@gmail.com>
Date: Tue, 1 May 2018 18:20:14 +0800
MIME-Version: 1.0
In-Reply-To: <87vac7adz2.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Translation block identification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

This logging flag prints what I want. But I really wanted is to get this 
info inside the QEMU source code. Why am I not able to lookup the 
symbols in the translator.c file the way I showed?

Kind regards,
Rafael

On 5/1/2018 6:04 PM, Alex Bennée wrote:
> Rafael Kioji <rafaelkioji@gmail.com> writes:
>
>> Dear all,
>>
>> During translation how can I identify what is the basic block of the
>> guest code? I wanted to know whether the block being translated is the
>> beginning of a function and get its name.
>>
>> My current approach involves looking up the symbol associated with the
>> first PC of the translation block. But no symbol is ever found. What I
>> did was to add the following code in the function "translator_loop" at
>> "accel/tcg/translator.c":
>>
>>   printf("sym: %lu %s\n", tb->pc, lookup_symbol(tb->pc));
>>
>> The function lookup_symbol is defined in the file "./disas.c". I am
>> compiling my application with symbols (-g). My target arch is ARM.
> If you run QEMU with the debug flags you should see name resolution for
> each basic block. e.g.
>
>    qemu-arm -d in_asm prog
>
> --
> Alex Bennée
