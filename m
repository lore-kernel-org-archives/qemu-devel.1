Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC80C2D0C2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 20:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9395921655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Z1pdMMMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9395921655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in6rL-0007Y3-DV
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 15:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1in6nE-0006Dk-Gu
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1in6nC-00088I-Os
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:10:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:60115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1in6nC-00087X-BG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577995784;
 bh=e9/BKcjvA0EEoiSKwVr7QOOLHFqlBFsnAI04RQy1w3I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Z1pdMMMXBtlDIqEksHrss6u+vQ8UQBcZVWrcGhG9cQPt+Cit43ymxbrEgyRBz4T6U
 iFxou8Ciza8BNTf9pN3RXK4xKPeA3yxUt5Ufhb9R4KHQUPrwj0Gj26Jc++FRHEMDsj
 hHyJ5cWK+snZZPO9IYGaR3VNCe6r9o+FixxxOQc8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.183.77]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1jbDKv3Ucs-00tj0N; Thu, 02
 Jan 2020 21:09:43 +0100
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
 <20200102151223.73e1448b@redhat.com>
 <a3017f38-b32b-de32-9896-b287253d0fa2@redhat.com>
 <20200102160827.790b8ed2@redhat.com>
 <f073e703-5caf-e63c-ef1b-04fa7ab51716@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <aa4d2f06-6931-b3f5-3a20-6c7633514a73@gmx.de>
Date: Thu, 2 Jan 2020 21:09:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f073e703-5caf-e63c-ef1b-04fa7ab51716@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tcZl5s0svCcf9aFS8x+/Lb4LAQ12IpBmxlA3PhWpxkbzEt/Dcrv
 ClH2sYnq5qrJ57e8ehXRCcqEGQe+D8adOufzpti4t9T6SVpC7dn3LkFOyq9oLDJUUvwYNIa
 4wpZZVchX6USbb1PJmOur337mLTHQ4wQkqtDa3nqCy6jgK5Y09uGVJwpmlIHPRCdLOhk3fb
 oPsr1C6Fbv9ac5ESw7CNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cGOn1h0xZuM=:ZhknxiMugdBCn1ISC7ByAo
 /G4a8oVHpXm1CFytq2QV5tStZ991ocmPZdOioXit3oFU/CSZMOY1fj56sgT0+8pJyLUfdsiHe
 s3gSf0ZiG3Xol0dVCNw0qDWM7d3diHHaouseL8CWczBwzOs0VpFfYvG4lKI+QSNyZsAP0j5/f
 rA8xXmzzHQeJ/KBmBRaWMsgRs9PonlOkx59eIoZtpzlBkkNs9usgv6SmkFwnYjyN2dXsmJeJJ
 XzvnVf7gpG0fvaXQO+zJlRs7nO2CN/XnwYAxjhu4GUUB4FtD3pv6K2Fc/IHzDKuGbZcAQAEQT
 osvivgaMZG9AvmeumEOIWBCuJroXJYONPwpYrAsEAgfz7BaVwrba2XX4aRgc/fIkB07/BsAcc
 qXwiT8Bl2QDQgxQ5ObBSqB8FxMH2uuEgIN8GemqIp1ZJAZa7KwMCmZlNkDO3dS6EDmm1rB3pX
 aRj0IyAS523KzRRRSLEV01BPxEE8CzmYTMdHNZVmYJdfW2Xuo9rEMsh49YDpoQnAyvPMaHtjp
 v4J7ef3M2JuQQbGzEEexyD4v32ZueVDADfy7Cb2j6JXdbPLlm9+oyXJFSF3Sbq495LtQYFl3w
 Hoq0AzH/qba2Mx2nqNk0BEElZrMWCHXyfCltE3sERak0WIY3/U6pzj0aT6Rmz4Tbj2PUA7J/P
 wrvQT9hdVEVXjpvUz5CeoP7eKo+Kd810jAaNTzsYw7fbWanhctPMdTW6VG6ByP3ADF4TAqTUl
 Ge8NiZqWfoKbd7RPnKhlCQB+o6T//xLb78XLGEjdI8Bdk5wtXR2c1oNLvID81akDg/3BtJybH
 DGSSjNuCwCCVMOrvquMKBqzSKmIVs7Ik/qgaCsY9seoy3Kkp7gqch0QdkAMKR5HqMEr2K/SXp
 ntQd4dOX8sxEGr9LQDrhhbNe9geqi6twM0PzY1ukyVtjrapHwd5v91ZtQQA6ES26GN6MoBEH0
 WPosGu9yFouICvyHVZdfNcN3tMiaxrgs8i8e5zKEHCIgIdsZRFMld9RkeBe0mmKFIWDE2Boah
 I27I2ObKL9l7hdPyxF7BfO2yXPqWKANQg5MWanL+TF1kh2whgJ1o08Hol2YQHSbYI6xNawkIf
 pNNPjveWnG3Xv6aF2M+TXA5xtAEN81YcMrQx6jMRy+4DhcOShTOMBuilgF6WvVrq6iBujihIS
 EBRCzGH2l1OXyubMDa+wgQ19luHOv+iIVy9FuDIa4AKwfC9jDOqyQujGJY/nKFliQBZhxJohc
 N1RPJ0+GOdXW2vIAhIcoImRRctQ7mXW8SICKtlQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.01.20 16:49, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/2/20 4:08 PM, Igor Mammedov wrote:
>> On Thu, 2 Jan 2020 15:17:14 +0100
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>
>>> On 1/2/20 3:12 PM, Igor Mammedov wrote:
>>>> On Thu, 2 Jan 2020 13:06:33 +0100
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>> =C2=A0=C2=A0
>>>>> On 1/2/20 12:31 PM, Helge Deller wrote:
>>>>>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>>>>>>> If user provided non-sense RAM size, board will complain and
>>>>>>>> continue running with max RAM size supported.
>>>>>>>> Also RAM is going to be allocated by generic code, so it won't be
>>>>>>>> possible for board to fix things up for user.
>>>>>>>>
>>>>>>>> Make it error message and exit to force user fix CLI,
>>>>>>>> instead of accepting non-sense CLI values.
>>>>>>>>
>>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>>>> ---
>>>>>>>> =C2=A0=C2=A0 =C2=A0 hw/hppa/machine.c | 3 ++-
>>>>>>>> =C2=A0=C2=A0 =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-=
)
>>>>>>>>
>>>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>>>>> index 5d0de26..25f5afc 100644
>>>>>>>> --- a/hw/hppa/machine.c
>>>>>>>> +++ b/hw/hppa/machine.c
>>>>>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *mac=
hine)
>>>>>>>> =C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main =
memory. */
>>>>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWA=
RE_START) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D=
 ram_size =3D FIRMWARE_START;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM siz=
e more than %d is not supported", FIRMWARE_START);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
>>>>>>>
>>>>>>> $ qemu-system-hppa -m 3841m
>>>>>>> qemu-system-hppa: invalid accelerator kvm
>>>>>>> qemu-system-hppa: falling back to tcg
>>>>>>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>>>>>>
>>>>>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned fo=
rmat, we can simply use "RAM size more than 3840m is not supported". Is th=
at OK with you?
>>>>>>
>>>>>> I don't really like that change.
>>>>>>
>>>>>> We currently only emulate a 32-bit system, and for those 4GB is the=
 maximum.
>>>>>> So, if I start my machine with "qemu-system-hppa -m 4G", the curren=
t code
>>>>>> then automatically uses the maximum possible of 3841MB (which is li=
mited by
>>>>>> firmware start address).
>>>>>> I don't expect users to know the excact 3841MB number.
>>>>>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB=
 or 4GB,
>>>>>> but not "3841MB".
>>>>>
>>>>> Thanks for the explanation. This deserves a comment in the source fi=
le
>>>>> IMHO (and displaying a warning to the user that the behavior is chan=
ged).
>>>>>
>>>>> I understand the CPU can't access this DRAM area because the ROM is
>>>>> mapped there. What about other devices, can they do DMA access to it=
?
>>>>>
>>>>> Igor: If this complicates your series too much, I think we can direc=
tly
>>>>> allocate up-to 4GiB and not worry about the 256MiB lost.
>>>>
>>>> Do you mean
>>>> s/"RAM size more than %d is not supported"/"RAM size more than 4Gb is=
 not supported"/
>>>
>>> Works for me! You can keep my R-b with this change, thanks.
>>
>> Well, it's not that simple.
>> Do we map whole 4G in address space, if yes then we have to "unbreak"
>> firmware mapping and use overlap mapping or do we map only portion of i=
t?
>> Both would make code more confusing and all for the sake of user conven=
ience
>> so they won't have to change their CLI?
>
> I was thinking about this patch:
>
> -- >8 --
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5d0de26140..fa0b6a9536 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -91,15 +91,16 @@ static void machine_hppa_init(MachineState *machine)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
> -=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram_si=
ze =3D FIRMWARE_START;
> +=C2=A0=C2=A0=C2=A0 if (ram_size > 4 * GiB) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Can not model =
more than 4GB of RAM");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Main memory region. */
> =C2=A0=C2=A0=C2=A0=C2=A0 ram_region =3D g_new(MemoryRegion, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0 memory_region_allocate_system_memory(ram_region=
, OBJECT(machine),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ram", ram_size);
> -=C2=A0=C2=A0=C2=A0 memory_region_add_subregion(addr_space, 0, ram_regio=
n);
> +=C2=A0=C2=A0=C2=A0 memory_region_add_subregion_overlap(addr_space, 0, r=
am_region, -1);
>
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Init Dino (PCI host bus chip).=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 pci_bus =3D dino_init(addr_space, &rtc_irq, &se=
rial_irq);


I haven't tested this patch, but that one seems good.

Helge


> ---
>
> $ hppa-softmmu/qemu-system-hppa -m 3840m -S -monitor stdio
> QEMU 4.2.50 monitor - type 'help' for more information
> (qemu) info mtree
> address-space: memory
> =C2=A0 0000000000000000-ffffffffffffffff (prio 0, i/o): system
> =C2=A0=C2=A0=C2=A0 0000000000000000-00000000efffffff (prio -1, ram): ram
> =C2=A0=C2=A0=C2=A0 00000000f0000000-00000000f07fffff (prio 0, ram): firm=
ware
> =C2=A0=C2=A0=C2=A0 00000000f9000000-00000000f90007ff (prio 0, i/o): isa-=
io
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000f9000020-00000000f9000021 (prio 0=
, i/o): pic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000f9000070-00000000f9000071 (prio 0=
, i/o): rtc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000f9000070-00000000f900=
0070 (prio 0, i/o): rtc-index
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000f90000a0-00000000f90000a1 (prio 0=
, i/o): pic
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000f90004d0-00000000f90004d0 (prio 0=
, i/o): elcr
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000f90004d1-00000000f90004d1 (prio 0=
, i/o): elcr
> =C2=A0=C2=A0=C2=A0 00000000fff80000-00000000fff80fff (prio 0, i/o): dino
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fff80064-00000000fff80067 (prio 0=
, i/o): pci-conf-idx
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fff80068-00000000fff8006b (prio 0=
, i/o): pci-conf-data
> =C2=A0=C2=A0=C2=A0 00000000fff83800-00000000fff83807 (prio 0, i/o): seri=
al
> =C2=A0=C2=A0=C2=A0 00000000fffb0000-00000000fffb0003 (prio 0, i/o): cpu0=
-io-eir
>


