Received: from eggs.gnu.org ([2001:4830:134:3::10]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fXV8I-0006aA-3H
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fXV8G-0000PV-UN
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:18:30 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fXV8G-0000Or-Ow
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:18:28 -0400
Received: by mail-yw0-x242.google.com with SMTP id t18-v6so962708ywg.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 10:18:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <44235a41-902c-5e6d-302c-9ca880b2f444@amsat.org>
References: <20180623215313.1252-1-f4bug@amsat.org>
	<2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
	<CAMo8BfJWemPTt3fTO5RwGub+1wzyBs3xfh_zY+LBVOhocZ-d3w@mail.gmail.com>
	<20180625165931.GA16777@flamenco>
	<44235a41-902c-5e6d-302c-9ca880b2f444@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 25 Jun 2018 10:18:27 -0700
Message-ID: <CAMo8BfL75KKw8U-dJ-FqEGTWeN853J=hWUUNZRt9U93_viyCXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Jun 25, 2018 at 10:10 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> On 06/25/2018 01:59 PM, Emilio G. Cota wrote:
>> On Sat, Jun 23, 2018 at 20:24:09 -0700, Max Filippov wrote:
>>> # first bad commit: [0b5c91f74f3c83a36f37740969df8c775c997e69]
>>> translate-all: use per-page locking in !user-mode
>>>
>>> Emilio, could you please take a look? The following test locks up QEMU:
>>>
>>> qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting -icount
>>> 6  -kernel ./test_mmu.tst
>>>
>>> test_mmu.tst binary may be found here:
>>> http://jcmvbkbc.spb.ru/~dumb/tmp/201806232022/test_mmu.tst
>>
>> Thanks for the test case.
>>
>> I submitted a patch that fixes this for me--see this thread:
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07236.html
>
> Thanks, this works :)
>
> Alex nicer test output using:
>
> tests/tcg/xtensa/Makefile.system
>  run-%.tst: %.tst
> -       $(SIM) $(SIMFLAGS) ./$<
> +       $(SIM) -monitor null $(SIMFLAGS) ./$<

This makefile is also usable with another simulator (xtensa ISS) which woul=
d
not understand this option. Could it be added to the proper SIMFLAGS instea=
d?

--=20
Thanks.
-- Max
