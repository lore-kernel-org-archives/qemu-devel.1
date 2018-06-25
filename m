Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXV0n-0000wT-8w
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXV0k-0003kC-Cj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:10:45 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXV0k-0003jv-0F
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:10:42 -0400
Received: by mail-qt0-x241.google.com with SMTP id x23-v6so2427217qto.7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:10:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
	<CAMo8BfJWemPTt3fTO5RwGub+1wzyBs3xfh_zY+LBVOhocZ-d3w@mail.gmail.com>
	<20180625165931.GA16777@flamenco>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44235a41-902c-5e6d-302c-9ca880b2f444@amsat.org>
Date: Mon, 25 Jun 2018 14:10:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180625165931.GA16777@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 06/25/2018 01:59 PM, Emilio G. Cota wrote:
> On Sat, Jun 23, 2018 at 20:24:09 -0700, Max Filippov wrote:
>> # first bad commit: [0b5c91f74f3c83a36f37740969df8c775c997e69]
>> translate-all: use per-page locking in !user-mode
>>
>> Emilio, could you please take a look? The following test locks up QEMU:
>>
>> qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting -icount
>> 6  -kernel ./test_mmu.tst
>>
>> test_mmu.tst binary may be found here:
>> http://jcmvbkbc.spb.ru/~dumb/tmp/201806232022/test_mmu.tst
> 
> Thanks for the test case.
> 
> I submitted a patch that fixes this for me--see this thread:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07236.html

Thanks, this works :)

Alex nicer test output using:

tests/tcg/xtensa/Makefile.system
 run-%.tst: %.tst
-       $(SIM) $(SIMFLAGS) ./$<
+       $(SIM) -monitor null $(SIMFLAGS) ./$<
