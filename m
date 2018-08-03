Received: from eggs.gnu.org ([2001:4830:134:3::10]:56938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1flWM8-0003E3-3A
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1flWM7-0008HD-Ad
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:26:44 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:40198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1flWM7-0008FL-3g
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:26:43 -0400
Received: by mail-it0-x243.google.com with SMTP id h23-v6so7475606ita.5
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:26:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_mVGSicjN=wwJY8OCJ-j=DtdLjDvM9U-dC3dQ=RQQXMQ@mail.gmail.com>
References: <20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvCKkzim+-Z4Y69fWg6igZ7V6gaWhjKJZ0m0G0dhbwOFyw@mail.gmail.com>
	<20180725112621.imdzdkntpmh3n5og@kamzik.brq.redhat.com>
	<CAHmQWvCfHFSU7RGKG5t6=m7ZSWZjf3TeqOo3cX2KT-GSiN3mPw@mail.gmail.com>
	<20180726102855.x6ffdoqjpejpyae7@kamzik.brq.redhat.com>
	<CAKv+Gu-ffZRNmACH6YieNsg=AHxJxYoXHsBGf6C=nOvFfTu7Sg@mail.gmail.com>
	<20180726111109.w24jk6ehklimige7@kamzik.brq.redhat.com>
	<CAKv+Gu80KfwZft4t1HtOXPuijuPLV80K9iW+BsTgs7WcnosMXA@mail.gmail.com>
	<20180726114158.am7kgc3jekxg55i5@kamzik.brq.redhat.com>
	<CAFEAcA8YH4p__zT1o0s3vNZOsyWZn3XPLgkNeT+jSJpmjvFTUw@mail.gmail.com>
	<20180726123509.qyadwbz4skwashcj@kamzik.brq.redhat.com>
	<CAFEAcA-Zv5xV2VwMCfGXUv8oT+gC_dgn8Q3M1v3FBjry7TbXVA@mail.gmail.com>
	<CAHmQWvB1zgaLi++BhGEs1Emb0-5HOrzCcPrHJDoxx-8Be9df1g@mail.gmail.com>
	<CAFEAcA_mVGSicjN=wwJY8OCJ-j=DtdLjDvM9U-dC3dQ=RQQXMQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 3 Aug 2018 11:26:41 +0200
Message-ID: <CAKv+Gu8sCjfL=uKy4nM6pcRneUzw2YG79CuOVBH3TeNOXf689A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 3 August 2018 at 11:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 August 2018 at 10:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> The 'sbsa' machine won't consume QEMU generated ACPI, so it won't
>> touch or add new ACPI tables.
>>
>> UEFI relies on its ACPI to load OS, but currently it still needs DT
>> from QEMU to pass some info, one example is CPU number.
>>
>> So, the 'sbsa' code implementation should be like this:
>> A separate file, no ACPI codes, a little necessary DT codes.
>>
>> "Necessary DT codes" doesn't include so many peripheral devices nodes,
>> so the code overlap with virt won't be so much (contrary to sbsa.c
>> with all the DT codes), then no need to separate the common part to a
>> third file, and virt.c can be untouched or only a minor change with
>> few lines.
>
> Would the real hardware you are trying to be an example
> for use DT for this? It seems a bit unlikely to me.
>

Yes, as a matter of fact. There is work underway both on the EDK2 and
the ARM-TF side to rely less on static descriptions, and more on DT to
instantiate drivers and ACPI tables at runtime rather than at build
time.
