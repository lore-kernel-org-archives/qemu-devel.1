Received: from eggs.gnu.org ([2001:4830:134:3::10]:33236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXCL-0000p3-1F
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPXCE-00072J-Jm
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:26:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPXCE-0006zY-BY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:25:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so6707455wrr.12
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:25:53 -0800 (PST)
References: <20181120203811.18406-1-jcmvbkbc@gmail.com>
	<3526a4e0-2b26-dfc5-4b81-9fdf94734398@redhat.com>
	<CAMo8Bf+oCDyOmpj9mNZF1nL3X7JgZU5fidDd-LZNGEG9dOPHew@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d8733646-4ee4-df53-24c1-b89f1d8a1569@redhat.com>
Date: Wed, 21 Nov 2018 19:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAMo8Bf+oCDyOmpj9mNZF1nL3X7JgZU5fidDd-LZNGEG9dOPHew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: xtfpga: provide default
 memory sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 21/11/18 13:21, Max Filippov wrote:
> Hi Philippe,
> 
> thanks for your review.
> 
> On Wed, Nov 21, 2018 at 4:00 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>> On 20/11/18 21:38, Max Filippov wrote:
>>>    static const TypeInfo xtfpga_lx200_nommu_type = {
>>> @@ -632,6 +636,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
>>>        mc->init = xtfpga_ml605_init;
>>>        mc->max_cpus = 4;
>>>        mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
>>> +    mc->default_ram_size = 256 * MiB;
>>
>> Isn't it 512 MB for the ML605?
> 
> There's 512MB on the board, but the Tensilica prototyping
> user's guide for the ML605 only documents 256MB in the memory
> map section. But now that you've mentioned it I recall that in reality
> both ML605 and KC705 had all onboard memory minus 128MB
> mapped for cores with MMU.
> 
>>>    }
>>>
>>>    static const TypeInfo xtfpga_ml605_type = {
>>> @@ -648,6 +653,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
>>>        mc->init = xtfpga_ml605_nommu_init;
>>>        mc->max_cpus = 4;
>>>        mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
>>> +    mc->default_ram_size = 256 * MiB;
>>
>> Ditto.
> 
> For noMMU cores there's only 256MB window available for
> the system memory, so it's capped at 256MB.

This totally makes sense.

> 
> I'll send an updated v2.

Thanks!

Phil.
