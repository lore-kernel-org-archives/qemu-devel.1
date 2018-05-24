Received: from eggs.gnu.org ([2001:4830:134:3::10]:50129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLmHU-0006Im-F2
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLmHP-0001PJ-TG
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:11:32 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLmHP-0001Oj-PA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:11:27 -0400
Received: by mail-ot0-x241.google.com with SMTP id m11-v6so1069771otf.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 02:11:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
	<bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
	<22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 10:11:06 +0100
Message-ID: <CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 23 May 2018 at 21:52, Laszlo Ersek <lersek@redhat.com> wrote:
> On 05/23/18 22:40, Auger Eric wrote:
>> On 05/23/2018 07:45 PM, Laszlo Ersek wrote:
>
>>> Regarding the second patch, I do believe we need "more sophistication"
>>> there. For example, I guess it could be possible to distinguish "-cpu
>>> cortex-a15" from "-cpu cortex-a57" somehow, and stick with the low/small
>>> ECAM in the former case. (The 32-bit firmware already runs on cortex-a15
>>> only, and not on cortex-a57, according to my testing.)
>>
>> So we should detect we are in ACPI boot  + aarch32 mode to force legacy
>> ECAM region, right?
>
> Agree about the aarch32 subcondition.
>
> However, "ACPI vs. DT" is not the right "other" subcondition here;
> instead we should (minimally) check "firmware vs. no firmware". See the
> "firmware_loaded" boolean field.

Won't it also break a guest which is just Linux loaded not via
firmware which is an aarch32 kernel without LPAE support?

thanks
-- PMM
