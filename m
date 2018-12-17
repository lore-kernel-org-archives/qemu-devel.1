Received: from eggs.gnu.org ([2001:4830:134:3::10]:42541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYwho-0007Ur-2Z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYwhj-0003uY-5v
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:29:24 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYwhi-0003tt-N8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:29:19 -0500
Received: by mail-wr1-x444.google.com with SMTP id s12so12711905wrt.4
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 09:29:18 -0800 (PST)
References: <20181217150116.10446-1-alex.bennee@linaro.org>
	<87mup4gmep.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87mup4gmep.fsf@linaro.org>
Date: Mon, 17 Dec 2018 17:29:16 +0000
Message-ID: <87lg4ogiz7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH  v1 0/4] de-macrofy softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Hi,
>>
> <snip>
>>
>> Unfortunately in my simple boot test I see a slight performance
>> degradation:
>>
>> original: 10 times (100.00%), avg time 5.358 (0.02 varience/0.13 deviati=
on)
>> demacro: 10 times (100.00%), avg time 5.760 (0.08 varience/0.29 deviatio=
n)
>
> Moving stuff back into cputlb seems to help:
>
>  10 times (100.00%), avg time 5.583 (0.03 varience/0.17 deviation)

See:

  https://github.com/stsquad/qemu/tree/ldst/demacrofy-v2

Which:

  - keeps everything in cputlb (dropping the externs)
  - factors out unaligned handling
  - uses __always_inline__ instead of __flatten__

>
>>
>> Emilio,
>>
>> Any chance you could run this through your more comprehensive benchmark
>> suite?
>>
>> Alex Benn=C3=A9e (4):
>>   accel/tcg: export some cputlb functions
>>   accel/tcg: introduce softmmu.c
>>   accel/tcg: use TLB helpers from softmmu.o
>>   accel/tcg: remove softmmu_template.h
>>
>>  accel/tcg/Makefile.objs      |   1 +
>>  accel/tcg/cputlb.c           |  63 +----
>>  accel/tcg/cputlb.h           |  21 ++
>>  accel/tcg/softmmu.c          | 452 +++++++++++++++++++++++++++++++++++
>>  accel/tcg/softmmu_template.h | 446 ----------------------------------
>>  5 files changed, 485 insertions(+), 498 deletions(-)
>>  create mode 100644 accel/tcg/cputlb.h
>>  create mode 100644 accel/tcg/softmmu.c
>>  delete mode 100644 accel/tcg/softmmu_template.h


--
Alex Benn=C3=A9e
