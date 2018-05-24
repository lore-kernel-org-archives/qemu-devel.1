Received: from eggs.gnu.org ([2001:4830:134:3::10]:45080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLtZV-0002Im-Je
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLtZU-0005CF-Pm
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:58:37 -0400
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
	<bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
	<22c4e504-a7b4-e6dd-b2cc-618d306b6f0c@redhat.com>
	<CAFEAcA9LMV_-vVAwUkuY=uw2Gf6XLvsgmi8y0PgHPJnQZkWC0w@mail.gmail.com>
	<550464ac-5155-6311-d0f7-92c7c0813f82@redhat.com>
	<CAFEAcA-hobu_=VKhYQ+UZ1WX_JFfwCarkPKQhiBtXc3fre57rg@mail.gmail.com>
	<ee204f5f-600f-2425-a1ff-0418b4611e96@redhat.com>
	<a8485329-0986-c99b-ad64-ec5af0a987b8@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <694034a3-9d4c-3e7e-759d-6fd8f8cfd9c8@redhat.com>
Date: Thu, 24 May 2018 18:58:22 +0200
MIME-Version: 1.0
In-Reply-To: <a8485329-0986-c99b-ad64-ec5af0a987b8@redhat.com>
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
To: Auger Eric <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

On 05/24/18 16:09, Auger Eric wrote:
> Hi Laszlo,
> 
> On 05/24/2018 03:59 PM, Laszlo Ersek wrote:
>> On 05/24/18 15:07, Peter Maydell wrote:
>>> On 24 May 2018 at 13:59, Laszlo Ersek <lersek@redhat.com> wrote:
>>>> On 05/24/18 11:11, Peter Maydell wrote:
>>>>> Won't it also break a guest which is just Linux loaded not via
>>>>> firmware which is an aarch32 kernel without LPAE support?
>>>>
>>>> Does such a thing exist? (I honestly have no clue.)
>>>
>>> Yes, it does; LPAE isn't a mandatory kernel config option.
>>> This is why we have the machine 'highmem' option, so that
>>> we can run on those kernels by not putting anything above
>>> the 4G boundary. Looking back at the history on that, we
>>> opted at the time for "default to highmem on, and if you're
>>> running an non-lpae kernel you need to turn it off manually".
>>
>> Ah, OK, I didn't know that.
>>
>>> So we can handle those kernels by just not putting ECAM
>>> above 4G if highmem is false.
>>
>> The problem is we can have a combination of 32-bit UEFI firmware (which
>> certainly lacks LPAE) and a 32-bit kernel which supports LPAE.
> 
> Is it what happens with the FW you provided to me? There is no LPAE in it?

That's the case, to my knowledge.

Thanks
Laszlo
