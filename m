Received: from eggs.gnu.org ([2001:4830:134:3::10]:52154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXVGH-0003nV-KW
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXVGD-0005Ar-Dw
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:26:45 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXVGD-0005AW-8f
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:26:41 -0400
Received: by mail-qt0-x241.google.com with SMTP id l10-v6so12676441qtj.0
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:26:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
	<CAMo8BfJWemPTt3fTO5RwGub+1wzyBs3xfh_zY+LBVOhocZ-d3w@mail.gmail.com>
	<20180625165931.GA16777@flamenco>
	<44235a41-902c-5e6d-302c-9ca880b2f444@amsat.org>
	<CAMo8BfL75KKw8U-dJ-FqEGTWeN853J=hWUUNZRt9U93_viyCXQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a26cea44-ea0e-252b-0f22-f6cfa5c5a4b6@amsat.org>
Date: Mon, 25 Jun 2018 14:26:36 -0300
MIME-Version: 1.0
In-Reply-To: <CAMo8BfL75KKw8U-dJ-FqEGTWeN853J=hWUUNZRt9U93_viyCXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 06/25/2018 02:18 PM, Max Filippov wrote:
> On Mon, Jun 25, 2018 at 10:10 AM, Philippe Mathieu-Daudé
> <f4bug@amsat.org> wrote:
>> On 06/25/2018 01:59 PM, Emilio G. Cota wrote:
>>> On Sat, Jun 23, 2018 at 20:24:09 -0700, Max Filippov wrote:
>>>> # first bad commit: [0b5c91f74f3c83a36f37740969df8c775c997e69]
>>>> translate-all: use per-page locking in !user-mode
>>>>
>>>> Emilio, could you please take a look? The following test locks up QEMU:
>>>>
>>>> qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting -icount
>>>> 6  -kernel ./test_mmu.tst
>>>>
>>>> test_mmu.tst binary may be found here:
>>>> http://jcmvbkbc.spb.ru/~dumb/tmp/201806232022/test_mmu.tst
>>>
>>> Thanks for the test case.
>>>
>>> I submitted a patch that fixes this for me--see this thread:
>>>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07236.html
>>
>> Thanks, this works :)
>>
>> Alex nicer test output using:
>>
>> tests/tcg/xtensa/Makefile.system
>>  run-%.tst: %.tst
>> -       $(SIM) $(SIMFLAGS) ./$<
>> +       $(SIM) -monitor null $(SIMFLAGS) ./$<
> 
> This makefile is also usable with another simulator (xtensa ISS) which would
> not understand this option. Could it be added to the proper SIMFLAGS instead?

OK, good to know.
