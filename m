Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D02BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3E52073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4jPEOB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3E52073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2nz-0007ky-W4
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 05:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jD2nK-00078o-ET
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jD2nH-0001H0-Rq
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:09:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30177
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jD2nH-0001Fz-NC
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584176959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRMUyENc3g/RHTswQmxQyUO6aGdckYhKlN18jJr4+YU=;
 b=A4jPEOB9cAmCvKCai6cERabc8JtKqktuB4RdklqsaWz2ZMReSGCUxjHAc8VAXJIgYBZquw
 biW132MtReAVnqON/9ekS6kHEszuF4QUXBJnF4Q1JOO99NuVToa2/A9323Qzj8B3UtSakG
 4qzIc0HSpMZ/XSbJrHhM/G+azzSENGs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-UaFCnryLOqWDicwAjmG6Kg-1; Sat, 14 Mar 2020 05:09:13 -0400
X-MC-Unique: UaFCnryLOqWDicwAjmG6Kg-1
Received: by mail-ed1-f71.google.com with SMTP id b100so10408322edf.15
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 02:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xckDGVjuhSL6TRR+x/mIlmi+wnsKOm703mb20mYsioQ=;
 b=R6gqPoi0tSLAVQPaEjO9QtImyGYY7u54lWA83MDM2kM0x8w39SwHQawKjQqROfm1d7
 TIqGoReAnaisTnwXrGdpiqriqjsb/admMy5y5Yq7XwSyz/mxg5hvMmvMVijEZjVMOgXm
 S7edUMgxCghJ8WtYtC8h0yqMBBy7ViBBy5P9odJU/koddnHs1uTs1Ts5peergBSjcJE7
 qTygma53XaP57YBkTCW1tFUfKX25Qx3zGMrNfRg/FiFVLDl+lbVf5XKFIIJ67mkfxG2A
 jVyQKWoNN4jC+J/wpQsc9NJ3o1XseghpdmtP+caZkVPgk9lV5i6rs7l1vjyy+A4btKSR
 CEbQ==
X-Gm-Message-State: ANhLgQ2aQ27KZLQ1lgb9KsdTS0fTyxcOt2XBSRDpyMqJsaDpqr1sGOGy
 ZX6TPktSuQbvts0xZ+ZDTvuJ6zGgz7VHVDImsqtyEzN3TbMFMzFR9CBcWR0/axy/yY2Po6RxKcy
 CM4S+XClz0KjUOq0=
X-Received: by 2002:a05:6402:22a1:: with SMTP id
 cx1mr349260edb.138.1584176950946; 
 Sat, 14 Mar 2020 02:09:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vulGKbzS/RVwW1oPcgFO7m/T2pKTw1oc3lzRRkxxb49NK3OrNgIWegLDdU9R8GG8MHQ/9XgBg==
X-Received: by 2002:a05:6402:22a1:: with SMTP id
 cx1mr349237edb.138.1584176950624; 
 Sat, 14 Mar 2020 02:09:10 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id by13sm496752edb.51.2020.03.14.02.09.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 02:09:10 -0700 (PDT)
Subject: Re: [PATCH v1] mips/mips_malta: Allow more than 2G RAM
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200228032613.1049955-1-jiaxun.yang@flygoat.com>
 <20200303004137.1099502-1-jiaxun.yang@flygoat.com>
 <6b4a7564-eac6-7bd3-b1c0-e9c7ac4e0c80@redhat.com>
 <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9f08408-9c1e-36d9-869b-bac250c6f027@redhat.com>
Date: Sat, 14 Mar 2020 10:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gEtCtAnsnkO4_E8rqje=n1bHXY_+BXC5P2h5Ld0umNtQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>, Yunqiang Su <ysu@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Burton <paul.burton@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

(+Aurelien for Debian)
(+Peter regarding changing default)

On 3/14/20 4:25 AM, Aleksandar Markovic wrote:
> On Thu, Mar 5, 2020 at 11:18 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Please post new patches as v2, and do not post them as reply to v1.
>>
>> On 3/3/20 1:41 AM, Jiaxun Yang wrote:
>>> When malta is coupled with MIPS64 cpu which have 64bit
>>> address space, it is possible to have more than 2G RAM.
>>>
>>> So we removed ram_size check and overwrite memory
>>> layout for these targets.
>>>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Suggested-by: Yunqiang Su <ysu@wavecomp.com>
>>> --
>>> v1: Do not overwrite cmdline when we don't have highmem.
>>> ---
>>>    hw/mips/mips_malta.c | 29 +++++++++++++++++++++++------
>>>    1 file changed, 23 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>> index 6e7ba9235d..4267958f35 100644
>>> --- a/hw/mips/mips_malta.c
>>> +++ b/hw/mips/mips_malta.c
>>> @@ -98,7 +98,8 @@ typedef struct {
>>>    } MaltaState;
>>>
>>>    static struct _loaderparams {
>>> -    int ram_size, ram_low_size;
>>> +    unsigned int ram_low_size;
>>> +    ram_addr_t ram_size;
>>>        const char *kernel_filename;
>>>        const char *kernel_cmdline;
>>>        const char *initrd_filename;
>>> @@ -1023,6 +1024,7 @@ static int64_t load_kernel(void)
>>>    {
>>>        int64_t kernel_entry, kernel_high, initrd_size;
>>>        long kernel_size;
>>> +    char mem_cmdline[128];
>>>        ram_addr_t initrd_offset;
>>>        int big_endian;
>>>        uint32_t *prom_buf;
>>> @@ -1099,20 +1101,33 @@ static int64_t load_kernel(void)
>>>        prom_buf =3D g_malloc(prom_size);
>>>
>>>        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filen=
ame);
>>> +
>>> +    memset(&mem_cmdline[0], 0, sizeof(mem_cmdline));
>>> +    if (loaderparams.ram_size > 0x10000000) {
>>
>> Please use 256 * MiB.
>>
>>> +        /*
>>> +         * Always use cmdline to overwrite mem layout
>>> +         * as kernel may reject large emesize.
>>> +         */
>>> +        sprintf(&mem_cmdline[0],
>>> +                "mem=3D0x10000000@0x00000000 mem=3D0x%" PRIx64 "@0x900=
00000",
>>> +                loaderparams.ram_size - 0x10000000);
>>
>> Ditto.
>>
>> Also please use g_strdup_printf("mem=3D0x%" PRIx64 "@...")/g_free.
>>
>>> +    }
>>> +
>>>        if (initrd_size > 0) {
>>>            prom_set(prom_buf, prom_index++,
>>> -                 "rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s",
>>> -                 xlate_to_kseg0(NULL, initrd_offset),
>>> +                 "%s rd_start=3D0x%" PRIx64 " rd_size=3D%" PRId64 " %s=
",
>>> +                 &mem_cmdline[0], xlate_to_kseg0(NULL, initrd_offset),
>>>                     initrd_size, loaderparams.kernel_cmdline);
>>>        } else {
>>> -        prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmd=
line);
>>> +        prom_set(prom_buf, prom_index++, "%s %s", &mem_cmdline[0],
>>> +                 loaderparams.kernel_cmdline);
>>>        }
>>>
>>>        prom_set(prom_buf, prom_index++, "memsize");
>>>        prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_low_size=
);
>>>
>>>        prom_set(prom_buf, prom_index++, "ememsize");
>>> -    prom_set(prom_buf, prom_index++, "%u", loaderparams.ram_size);
>>> +    prom_set(prom_buf, prom_index++, "%lu", loaderparams.ram_size);
>>>
>>>        prom_set(prom_buf, prom_index++, "modetty0");
>>>        prom_set(prom_buf, prom_index++, "38400n8r");
>>> @@ -1253,12 +1268,14 @@ void mips_malta_init(MachineState *machine)
>>>        /* create CPU */
>>>        mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
>>>
>>> -    /* allocate RAM */
>>> +#ifdef TARGET_MIPS32
>>> +    /* MIPS32 won't accept more than 2GiB RAM due to limited address s=
pace */
>>
>> Cc'ing Paul Burton due to commit 94c2b6aff43.
>>
>>>        if (ram_size > 2 * GiB) {
>>>            error_report("Too much memory for this machine: %" PRId64 "M=
B,"
>>>                         " maximum 2048MB", ram_size / MiB);
>>
>> This is annoying, because the CoreLV/CoreFPGA core cards only have 4
>> DIMM slots for PC-100 SDRAM, and the Memory Controller of the GT=E2=80=
=9364120A
>> north bridge accept at most 256 MiB per SCS for address decoding, so we
>> have a maximum of 1 GiB on 32-bit boards.
>>
>> In 64-bit emulation we use the a 20Kc core, provided by the Core20K core
>> card which doesn't use the GT=E2=80=9364120A but the Bonito64. So the mo=
del is
>> incorrect... The Bonito64 indeed allow more memory.
>>
>> Maybe it is time to consider that for 64-bit targets, since we are not
>> modelling a Malta core board, we can name it the official 'virt' machine=
...
>>
>=20
> Philippe, I almost agree 100% with you wrt last three paragraphs.
> (in any case, I know much less than you about details of GT-64120A
> and Bonito64, but I trust you).
>=20
> The only area I have a slightly different opinion is that I believe we
> should never declare Malta as a virtual board, and try to be within the
> boundaries of physical capabilities of real boards, even if in software
> (QEMU) we could "enhance" some features.
>=20
> If we want MIPS virtual board, than we should devise a full blown
> virtual board, similar to what was already done for MIPS Android
> emulator. I really don't want some real/virtual frankenstein in QEMU
> upstream just because it is convenient for let's say a particular
> test setup.

IIUC today all distributions supporting MIPS ports are building their=20
MIPS packages on QEMU instances because it is faster than the native=20
MIPS hardware they have.

Since one (or two?) years, some binaries (Linux kernel? QEMU?) are=20
failing to link because the amount of guest memory is restricted to 2GB=20
(probably advance of linker techniques, now linkers use more memory).

YunQiang, is this why you suggested this change?

See:
- https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.html
-=20
https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-January=
/004844.html

I believe most of the QEMU Malta board users don't care it is a Malta=20
board, they only care it is a fast emulated MIPS machine.
Unfortunately it is the default board.

However 32-bit MIPS port is being dropped on Debian:
https://lists.debian.org/debian-mips/2019/07/msg00010.html

Maybe we can sync with the Malta users, ask them to switch to the Boston=20
machines to build 64-bit packages, then later reduce the Malta board to 1GB=
.
(The Boston board is more recent, but was not available at the time=20
users started to use QEMU to build 64-bit packages).

Might it be easier starting introducing a malta-5.0 machine restricted=20
to 1GB?

>=20
> Aleksandar
>=20
>>>            exit(1);
>>>        }
>>> +#endif
>>>
>>>        /* register RAM at high address where it is undisturbed by IO */
>>>        memory_region_add_subregion(system_memory, 0x80000000, machine->=
ram);
>>>
>>
>>
>=20


