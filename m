Received: from eggs.gnu.org ([2001:4830:134:3::10]:59720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYugk-0002gN-TZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYugf-00068V-UJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:47:54 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYugf-00066Z-MP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:47:49 -0400
Received: by mail-pf0-x244.google.com with SMTP id y24-v6so76141pfe.12
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:47:49 -0700 (PDT)
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-6-richard.henderson@linaro.org>
	<CAFEAcA8zTOm6eesQVF_1_VY=JsVGpvoWstBwfL32ggARPPzOnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2aadcec2-e73e-baba-1851-b7894c561999@linaro.org>
Date: Fri, 29 Jun 2018 07:47:45 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zTOm6eesQVF_1_VY=JsVGpvoWstBwfL32ggARPPzOnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/arm: Add ID_ISAR6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/29/2018 01:40 AM, Peter Maydell wrote:
>>      cpu->id_isar5 = 0x00000000;
>> +    cpu->id_isar6 = 0x00000000;
...
>>      cpu->id_isar5 = 0x00000000;
>> +    cpu->id_isar6 = 0x00000000;
...
>>      cpu->id_isar5 = 0x00000000;
>> +    cpu->id_isar6 = 0x00000000;
...
>>      cpu->id_isar5 = 0x0;
>> +    cpu->id_isar6 = 0x0;
...
> The ARMCPU struct fields should all be initially cleared to
> zero, so you don't really need to explicitly zero-initialize
> isar6 all over the place like this. (Compare isar5, which is
> I think only set in CPUs that are new enough that their TRMs
> mentioned it.)

Actually, the fact that isar5 is explicitly set to 0
in many places is the reason that I initialize isar6.


r~
