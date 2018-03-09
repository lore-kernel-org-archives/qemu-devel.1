Received: from eggs.gnu.org ([2001:4830:134:3::10]:50567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGDw-0002c8-Oo
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGDq-0004Pq-C7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:30:08 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euGDq-0004Pc-6G
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:30:02 -0500
Received: by mail-wm0-x244.google.com with SMTP id 139so3322431wmn.2
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:30:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
	<CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e34d8f0-7dd8-e69a-3a00-7b5e7d635325@amsat.org>
Date: Fri, 9 Mar 2018 12:29:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Michael,

On 03/09/2018 12:17 PM, Michael Clark wrote:
> On Fri, 9 Mar 2018 at 11:45 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> 
>> On 9 March 2018 at 04:22, Michael Clark <mjc@sifive.com> wrote:
>>> I need to dig into this. I'll need to take the assertions out, or run
>> with
>>> tracing to see which fcvt test is triggering this unreachable piece of
>>> code. FYI. I can look into it.
>>
>>>
>> ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_int_and_pack:
>>> code should not be reached
>>> qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6           ${QEMU}
>>> -nographic -machine spike_v1.10 -kernel $i
>>
>> This looks like maybe it's the issue Richard Jones sent a patch for ?
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01005.html
> 
> 
> Thanks. Seems I wasn’t on the ‘cc.
> 
> We need this patch in our downstream repo... We also need to automate
> riscv-tests in the riscv.org repo .travis.yml so we can pick these things
> up automatically...

What about upstreaming the QEMU part of your .travis.yml?
