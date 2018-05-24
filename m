Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLpqS-0000v5-LY
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLpqO-0008FP-FG
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:59:52 -0400
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
	<bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
	<22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
	<CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <550464ac-5155-6311-d0f7-92c7c0813f82@redhat.com>
Date: Thu, 24 May 2018 14:59:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Auger Eric <eric.auger@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 05/24/18 11:11, Peter Maydell wrote:
> On 23 May 2018 at 21:52, Laszlo Ersek <lersek@redhat.com> wrote:
>> On 05/23/18 22:40, Auger Eric wrote:
>>> On 05/23/2018 07:45 PM, Laszlo Ersek wrote:
>>
>>>> Regarding the second patch, I do believe we need "more sophistication"
>>>> there. For example, I guess it could be possible to distinguish "-cpu
>>>> cortex-a15" from "-cpu cortex-a57" somehow, and stick with the low/small
>>>> ECAM in the former case. (The 32-bit firmware already runs on cortex-a15
>>>> only, and not on cortex-a57, according to my testing.)
>>>
>>> So we should detect we are in ACPI boot  + aarch32 mode to force legacy
>>> ECAM region, right?
>>
>> Agree about the aarch32 subcondition.
>>
>> However, "ACPI vs. DT" is not the right "other" subcondition here;
>> instead we should (minimally) check "firmware vs. no firmware". See the
>> "firmware_loaded" boolean field.
> 
> Won't it also break a guest which is just Linux loaded not via
> firmware which is an aarch32 kernel without LPAE support?

Does such a thing exist? (I honestly have no clue.)

If it does, then there are two options:
- don't enable the new ECAM range by default (always take an explicit
option),
- offer both ECAM ranges and let the guest pick one (I should add that I
have no idea whether exposing such *alternatives* is possible via DT and
ACPI; i.e., "pick one but not both").

Thanks
Laszlo
