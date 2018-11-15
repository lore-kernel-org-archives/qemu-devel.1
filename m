Received: from eggs.gnu.org ([2001:4830:134:3::10]:60748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNLvM-0005Kz-RA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNLvI-000776-Rf
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:59:27 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNLvG-0006cX-QH
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:59:23 -0500
Received: by mail-ot1-x342.google.com with SMTP id u3so13725924ota.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 09:59:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_8cgFgCvs6jZ0rb-QPf60YkdPJgpu0SzCh3SfKYD560w@mail.gmail.com>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
	<20181102134112.26370-2-richard.henderson@linaro.org>
	<CAFEAcA_8cgFgCvs6jZ0rb-QPf60YkdPJgpu0SzCh3SfKYD560w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 17:59:00 +0000
Message-ID: <CAFEAcA8JwMpb=Ptrqz3svecn8gar2o9=VH-NY0hgUF8EsmbDiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-4.0 1/4] target/arm: Move
 id_aa64mmfr* to ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 15 November 2018 at 16:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 2 November 2018 at 13:41, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> At the same time, define the fields for these registers,
>> and use those defines in arm_pamax().
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

...though since you'll need a v2 anyway, maybe add the v8.5
fields in ID_AA64MMFR0 ?

FIELD(ID_AA64MMFR0, TGran16_2, 32, 4)
FIELD(ID_AA64MMFR0, TGran64_2, 36, 4)
FIELD(ID_AA64MMFR0, TGran4_2, 40, 4)
FIELD(ID_AA64MMFR0, ExS, 44, 4)

thanks
-- PMM
