Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855B9C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D875206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c/b35j+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D875206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVrO-0000Fo-W3
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ioVnK-0006DV-Hs
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ioVnI-0006BC-03
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:03:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:54247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ioVnH-000690-HA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578330230;
 bh=yWFe0Onbvm6qBgL8ZG2WjFP8FVoNdy2nijjaTEwmNdY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=c/b35j+nH9FvEAEpdP49s/RvUoRZdYcc1U2sR3he1VmlpUa8cKXy9cED+3efxjXkQ
 gdE4GZE9Sgpp8j5j6ioxJotT9BwfFl7zucR8yMExIKohJ2YdPqyKt9mFezj+NhPcug
 1K/gb2FSfdnq78UfkA3iF5Tj9f3mmIHVKFkwYrFM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.165.237]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1imbRi3VqZ-008Wn6; Mon, 06
 Jan 2020 18:03:49 +0100
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
To: Igor Mammedov <imammedo@redhat.com>
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
 <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
 <20200103105434.050d28ea@redhat.com>
 <6fa7bcd3-ee67-cc84-fd4e-d3677e3ae51a@redhat.com>
 <20200106114828.6bc96b23@redhat.com>
 <8ef57947-dba6-9273-0b1e-7f0c052795da@gmx.de>
 <20200106172411.5a6f2efe@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <a54bf2ab-a0ae-5374-300c-77d7bc926330@gmx.de>
Date: Mon, 6 Jan 2020 18:03:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106172411.5a6f2efe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iSefGX8o28iuAxVcW7tSHImQb9mqLpdE1fHRjt1UuEv777d9UJ4
 L7Sj9+XO4M6NnVtc5LgqHFBKG9qdgkT6NZgz2SfavisjbR25fpVZHFJ/+myx8XyKViWMU1J
 bRzJCZqAC4d067Yht09aUa/+HP8PDuPtSvAwLYDt8ESBdeEEJkj2movFLZPoxBrcoGG9ZVy
 xIFVUAndVLqIVlAFlYSYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wwtxacTIk2I=:l4pXaiUKzg+uAIIT4gML/B
 GFIGWkuNHI5Ha7kRlNbelVB5S8B65tZpZ8RwfE+EeHGocXj+0SBiu1kew3OMECPgKCFiLu5mU
 2/1aizKUpP0wUIZTsWzAIFNyQwxWVx26OIei4EFpl+v4vLqzpDnWf0IBTZfPu9Dh3rqA8G0jy
 yPtC+l5X8MhtRp41S0IWxlYpsLQupHtdGlPbnplnxPb7UlIz4pWK/lvu7eZl4VJ8Qtz6bGjef
 Uia5EG3DVJAvaviVRKSFV9VSp2PJwRVFwDg/YMrf6rYd42s28YJKvCwB25Ey1qMQHzDqu5yGk
 +Ig8M9a6MqK8qKj9c/ujMrZ3o9gO+cm00eqEkL20o3Hs1Q7ZA+g7b5KCTBAbjHs+cu87L65ho
 4CWwWymCGQ8tfdY0CnQAbV0VjGNdrUk1eSVOZ+eFx6cMxCNv9a6KnXacIS/VaOrIUZ7CxaFov
 2AzzWFYApd8v6hbD6RHGc1AaEM4HwA7fbV7GtocfaVcsu26N5AljxiZFq/quwZVrg2wQCp7bd
 2AK48PWOdrKKrKjYOKan0ILzjy5Yv/kIhrmwTUIi+HTDXk+oG3BVS0AdnYe4OB6tvc9WeEUG8
 uuc2bqV48rHnytzR42rov+yRsbgTSP+udcci/7zREFbNuNJOaVv6x5OyJg57Yw95x4gtMr8q4
 0GqFIek4rprmFvNICsrxIEXiTf1aCi6DO6GgU7YyOcEvvnP4juoDL4PdIiw8Y3QnFwwMIvQnj
 xBR+m1izbNNg123ZhXS3c4OjvEH5tyOSwUfV6bltXIPn4MI99V2sh07ONqdiW4pERusQtneyI
 zUdaqkboD2iH6r2uXuAXrsz/TjANJtMbHKRTgWD8muprsggAZTF+ZU7H/baZTengbACNqIk6D
 Yxx7klr5dorFpPyHyvOxr9Nvznu71tUY8p8hBBhG/ZMXQemLtVLGHqGpc+dxFKjEC1sXxwt2n
 fWHg9JMwf473aoZlo1gKDaNHlTU9XMWxDNHxfx2tt7W4/fgB/EEyW4HTxZ/hPDQLYMA+pdYPZ
 tJSm5jsgvCm7d52EbzubaK1ctRq16U1YUQ6tBqpb0sjZ9xof2Pd5gaRFJcSmS8cr+nXRe/c4U
 qbHmKXp8AXEYK+UPaCrLtcyjbX2W/h3x+sunJX3HN8fCD4kKiizTnR0acnOEuEhsOHZ6MJ5nC
 HHMgRyg+Lojm0h9s9HnrNxrunn9jqlL7Jtf2OsyGnWqngudP7kkYHPUTpVUbYtjqKtXSDmwki
 YmG0ifhCauESkC6JCXZwDEA71YYiREGfaUNCo1Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.01.20 17:24, Igor Mammedov wrote:
> On Mon, 6 Jan 2020 12:28:51 +0100
> Helge Deller <deller@gmx.de> wrote:
>
>> On 06.01.20 11:48, Igor Mammedov wrote:
>>> On Sat, 4 Jan 2020 16:00:19 +0100
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>
>>>> On 1/3/20 10:54 AM, Igor Mammedov wrote:
>>>>> On Thu, 2 Jan 2020 21:22:12 +0100
>>>>> Helge Deller <deller@gmx.de> wrote:
>>>>>
>>>>>> On 02.01.20 18:46, Igor Mammedov wrote:
>>>>>>> Previous patch drops silent ram_size fixup and makes
>>>>>>> QEMU error out with:
>>>>>>>
>>>>>>>   "RAM size more than 3840m is not supported"
>>>>>>>
>>>>>>> when user specified -m X more than supported value.
>>>>>>>
>>>>>>> User shouldn't be bothered with starting QEMU with valid CLI,
>>>>>>> so for the sake of user convenience allow using -m 4G vs -m 3840M.
>>>>>>>
>>>>>>> Requested-by: Helge Deller <deller@gmx.de>
>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>> ---
>>>>>>> v2:
>>>>>>>    - make main ram -1 prio, so it wouldn't conflict with other reg=
ions
>>>>>>>      starting from 0xf9000000
>>>>>>>
>>>>>>> I dislike it but if you feel it's really necessary feel free to ac=
k it.
>>>>
>>>> Hard to find the v2 buried in the other series with my email client.
>>>>
>>>>>>>
>>>>>>> should be applied on top of:
>>>>>>>    "hppa: drop RAM size fixup"
>>>>>>
>>>>>> Hello Igor,
>>>>>> I appreciate that you are trying to make it more cleaner.
>>>>>> But, can't you merge both of your patches to one patch?
>>>>>> Right now you have one patch "hppa: drop RAM size fixup", which is
>>>>>> what I think is wrong. Then you add another one which somehow
>>>>>> fixes it up again and adds other stuff.
>>>>> 1st patch bring it in line with other boards adding
>>>>> proper error check but without changing RAM size.
>>>>> While 2nd is changing device model (mapped RAM size) and
>>>>> clearly documents that it's a hack for user convenience,
>>>>> Hence I'd prefer to keep both separated.
>>>>>
>>>>>> Having everything in one single patch makes your full change more
>>>>>> understandable.
>>>>>>
>>>>>> Is it necessary to introduce clamped_ram_size and not continue with
>>>>>> ram_size (even if you would add it as static local variable)?
>>>>> it's necessary since ram_size is global which should be kept =3D=3D =
MachineState::ram_size.
>>>>> Later on I plan to remove the former altogether and maybe
>>>>> MachineState::ram_size aa well, since it could be read with
>>>>> memory_region_size(MachineState::ram).
>>>>
>>>> Why insist on clamping the ram? We recommend to model what the hardwa=
re
>>>> does, and the hardware uses a full DIMM of DRAM, so 4GB, not less.
>>> I'm not adding 4Gb support here (it's out of scope of this series),
>>> all this patch does is making pre-existing global ram_size fixup,
>>> this board only business and naming it clamped_ram_size to match
>>> its current usage
>>
>> Ok.
>>
>>> (along with explicitly documenting the deviation from
>>> other boards why it was requested to keep fixup 'for user convenience'
>>> instead of going for correct and simpler error message telling
>>> how much RAM user could specify on CLI).
>>
>> No, here you are wrong.
>> This machine, same as all 32-bit x86 based machines, expect users
>> to insert memory modules of e.g. 1GB, 2GB and so on.
>> And ROM memory and other regions overlap the RAM in some regions
>> if required.
>> So, it's not "user convenience", but it's correct behaviour of the
>> code to simply allow 4GB and then don't blend in the memory which can't
>> be accessed.
>> Giving a error message that "you can only insert 3841MB" would be WRONG=
.
>>
>>>> What are the new problem introduced by using 4GB? I only see advantag=
es
>>>> doing so. This doesn't break your series. This doesn't break the CLI.
>>>> Am I missing something?
>>>
>>> Well, board was fixing up global ram_size and then used it to
>>>  - pass clamped value to guest via register
>>>  - pass it to load load_image_targphys()
>>>  - perform various checks
>>>  - affects reset sequence
>>
>> ... which is all OK, because it mimics the real hardware.
>>
>>> This patch keeps all of that in the same state
>>> (I'd suspect changing above points, would break guest)
>>
>> Yep (unless I change the SeaBIOS ROM code).

> Does real HW pass in cpu[0]->env.gr[26] full 4Gb or clamped size?

No, because of the simple reason that real hardware uses a
propriatary HP Firmware, and that it's not started from some emulation
layer like qemu. So it has to find way itself to detect how much RAM
was plugged into the machine.

The functionality of giving the ram size in %r26 was done by me,
otherwise I don't know how SeaBIOS should detect how much RAM the
user wanted the machine to have. That's changeable if you have another
idea. Doesn't on x86 the ram size is given in some emulated RTC register?

>> Anyway, I'm tired to discuss this.
>> Your patch isn't wrong by itself, I just think it's changing unnecessar=
y
>> too much code and uses wrong wording for the commit message.

> Let me prepare v3 which hopefully will make is smaller and
> with commit message corrected.
> How about following wording:
> "
>     hppa: allow max ram size upto 4Gb
>
>     Previous patch drops silent ram_size fixup and makes
>     QEMU error out with:
>
>      "RAM size more than 3840m is not supported"
>
>     when user specified -m X more than currently supported
>     value.
>
>     However real hardware allows to plug in up to 4Gb RAM
>     into memory slots. So allow user specify up to 4Gb and
>     map all of it into guest address space.
>
> PS:
>     guest will still see 3840m being reported in
>     cpu[0]->env.gr[26] and loose ~248Mb, as it doesn't
>     have other means to discover RAM above firmware ROM.
> "

Why make it so complicated?

I see:
+    if (machine->ram_size > 4 * GiB) {
+        error_report("RAM size more than 4Gb is not supported");

what type is machine->ram_size?
If it's a 32bit unsigned integer this check is useless, and if it's a 64bi=
t
integer it would be too big for a 32bit-only platform anyway.

So, I'd suggest to drop your wrong patch #43.

If you don't want to drop it, my suggestion for a commit message is:

hppa: Revert last wrong patch and give warning if user specified > 4GB RAM


Helge

>
>> But just apply it as long as it doesn't break anything.
>>
>> Helge
>>
>>> If you have an alternative patch that enables to use full 4Gb,
>>> I'd include on respin as far as it doesn't change user supplied
>>> global ram_size && ms->ram_size && uses generic ms->ram &&
>>> preferably on top of
>>>  "[PATCH 44/86] hppa: use memdev for RAM"
>>> so it would be easier to drop it if there would opposition to it
>>> without affecting series.
>>>
>>>>>>> ---
>>>>>>>   hw/hppa/machine.c | 21 +++++++++++----------
>>>>>>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>>>> index ebbf44f..0302983 100644
>>>>>>> --- a/hw/hppa/machine.c
>>>>>>> +++ b/hw/hppa/machine.c
>>>>>>> @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, u=
int64_t addr)
>>>>>>>
>>>>>>>   static HPPACPU *cpu[HPPA_MAX_CPUS];
>>>>>>>   static uint64_t firmware_entry;
>>>>>>> +static ram_addr_t clamped_ram_size;
>>>>>>>
>>>>>>>   static void machine_hppa_init(MachineState *machine)
>>>>>>>   {
>>>>>>> @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *mach=
ine)
>>>>>>>       long i;
>>>>>>>       unsigned int smp_cpus =3D machine->smp.cpus;
>>>>>>>
>>>>>>> -    ram_size =3D machine->ram_size;
>>>>>>> -
>>>>>>>       /* Create CPUs.  */
>>>>>>>       for (i =3D 0; i < smp_cpus; i++) {
>>>>>>>           char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
>>>>>>> @@ -90,12 +89,14 @@ static void machine_hppa_init(MachineState *ma=
chine)
>>>>>>>       }
>>>>>>>
>>>>>>>       /* Limit main memory. */
>>>>>>> -    if (ram_size > FIRMWARE_START) {
>>>>>>> -        error_report("RAM size more than %d is not supported", FI=
RMWARE_START);
>>>>>>> +    if (machine->ram_size > 4 * GiB) {
>>>>>>> +        error_report("RAM size more than 4Gb is not supported");
>>>>>>>           exit(EXIT_FAILURE);
>>>>>>>       }
>>>>>>> +    clamped_ram_size =3D machine->ram_size > FIRMWARE_START ?
>>>>>>> +        FIRMWARE_START : machine->ram_size;
>>>>>>>
>>>>>>> -    memory_region_add_subregion(addr_space, 0, machine->ram);
>>>>>>> +    memory_region_add_subregion_overlap(addr_space, 0, machine->r=
am, -1);
>>>>>>>
>>>>>>>       /* Init Dino (PCI host bus chip).  */
>>>>>>>       pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
>>>>>>> @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *ma=
chine)
>>>>>>>       qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx6=
4
>>>>>>>                     "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n=
",
>>>>>>>                     firmware_low, firmware_high, firmware_entry);
>>>>>>> -    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_EN=
D) {
>>>>>>> +    if (firmware_low < clamped_ram_size || firmware_high >=3D FIR=
MWARE_END) {
>>>>>>>           error_report("Firmware overlaps with memory or IO space"=
);
>>>>>>>           exit(1);
>>>>>>>       }
>>>>>>> @@ -204,7 +205,7 @@ static void machine_hppa_init(MachineState *ma=
chine)
>>>>>>>                  (1) Due to sign-extension problems and PDC,
>>>>>>>                  put the initrd no higher than 1G.
>>>>>>>                  (2) Reserve 64k for stack.  */
>>>>>>> -            initrd_base =3D MIN(ram_size, 1 * GiB);
>>>>>>> +            initrd_base =3D MIN(clamped_ram_size, 1 * GiB);
>>>>>>>               initrd_base =3D initrd_base - 64 * KiB;
>>>>>>>               initrd_base =3D (initrd_base - initrd_size) & TARGET=
_PAGE_MASK;
>>>>>>>
>>>>>>> @@ -232,7 +233,7 @@ static void machine_hppa_init(MachineState *ma=
chine)
>>>>>>>        * various parameters in registers. After firmware initializ=
ation,
>>>>>>>        * firmware will start the Linux kernel with ramdisk and cmd=
line.
>>>>>>>        */
>>>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
>>>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>>>>
>>>> Helge, is this the code using this register?
>>>>
>>>> https://github.com/hdeller/seabios-hppa/blob/parisc-qemu-5.0/src/pari=
sc/head.S#L139
>>>>
>>>>>>>       cpu[0]->env.gr[25] =3D kernel_entry;
>>>>>>>
>>>>>>>       /* tell firmware how many SMP CPUs to present in inventory t=
able */
>>>>>>> @@ -255,11 +256,11 @@ static void hppa_machine_reset(MachineState =
*ms)
>>>>>>>       }
>>>>>>>
>>>>>>>       /* already initialized by machine_hppa_init()? */
>>>>>>> -    if (cpu[0]->env.gr[26] =3D=3D ram_size) {
>>>>>>> +    if (cpu[0]->env.gr[26] =3D=3D clamped_ram_size) {
>>>>>>>           return;
>>>>>>>       }
>>>>>>>
>>>>>>> -    cpu[0]->env.gr[26] =3D ram_size;
>>>>>>> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>>>>>>>       cpu[0]->env.gr[25] =3D 0; /* no firmware boot menu */
>>>>>>>       cpu[0]->env.gr[24] =3D 'c';
>>>>>>>       /* gr22/gr23 unused, no initrd while reboot. */
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>>
>


