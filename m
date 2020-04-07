Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FED2C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596B3206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duuyvJcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596B3206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLreW-0003xn-Ip
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLrdX-0003I2-61
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLrdV-0002xH-2A
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:03:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLrdU-0002x0-VP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 13:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586279020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFcrQtnbq9bGO2WHRbOIRBXA+nrThr7Gu72V5uBbUYE=;
 b=duuyvJcGggZdlp/GX7gTILqi2EaiBueqgYQoK79ChLNQrC3A/fKATypyZZIhuiXMFSo3xB
 nzTiRjsWgDC9KtD13fPFlvicGho9oGHLIX2v1sFaLo6EWo4JJLnEjx4Kuawmq1+rbQtEqt
 On2wxeUvJ16L0vAZF4kNHTMH1/EeSt0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-bEbLIF80OfKbOHUdAIrQOw-1; Tue, 07 Apr 2020 13:03:35 -0400
X-MC-Unique: bEbLIF80OfKbOHUdAIrQOw-1
Received: by mail-ed1-f71.google.com with SMTP id q29so3978606edc.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 10:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9e7fiOmxM++2ZZJ8ql55IWjO/GeN9bp7lW3qHRePFjI=;
 b=AH3+LfWZAfBHB5+9r7cfZA5Zy5SvhyUK8eao73P/Jhgk+POnafgv0xBy993xszFvEY
 rpyfmtCDOo4ck/swt2UiPt9/E0YEc75v8p3AiNzievTXzKF7fxhCc0695UZtBFmGmXOk
 sqOvecH72ZCddQYSZGoc2u5rBqzB2lLxTRBLI+hmvXJu5RQgl2jJHDM+b4LCdRIKx3HF
 sgFsNyxiHFk0cUDJ1hU11RsbS1dH2vB3LVeyGnSZAdUgqryi8/9o+yxsXm7MT/9+1toc
 yZ3exjvYF1wVnBmn6ezyyYLVflKVrBnestYGSjgOorp6HqCG2b92CyFokgbJNxRxJrk2
 cU7w==
X-Gm-Message-State: AGi0PubCvGaIrZm7qD5Er++1IZiVz2cyp+Otmvr4Wql2OrROSKVVZq13
 Ccwhu+L6T1fajhOnvY+c+7ghD2SgMK2OCvWcIPLbaaH2KL4X1BWOhIwqv/cyxUF1Ii9cn3PS6pa
 OTY7EB+8LBnzPQQc=
X-Received: by 2002:a50:a0c7:: with SMTP id 65mr2923460edo.7.1586279013828;
 Tue, 07 Apr 2020 10:03:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJFgpcWkqylcqDENaKDBPafK2IOZb/rARY7e9EnHDacoAsw6RTxuIoBaN1MZRXm6cwp52eDkg==
X-Received: by 2002:a50:a0c7:: with SMTP id 65mr2923415edo.7.1586279013445;
 Tue, 07 Apr 2020 10:03:33 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f17sm2691656edj.86.2020.04.07.10.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 10:03:32 -0700 (PDT)
Subject: Re: [PATCH for-5.0 v2 2/3] fw_cfg: Migrate ACPI table mr sizes
 separately
To: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
 <20200403101827.30664-3-shameerali.kolothum.thodi@huawei.com>
 <00b69974-4b63-0c7c-c6ad-ed0f2eb712b9@redhat.com>
 <20200407103340-mutt-send-email-mst@kernel.org>
 <5b91cf11-79b8-aa00-8f64-f56a3f67c641@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b282fb86-ef49-ff64-1540-aaeeaeadf517@redhat.com>
Date: Tue, 7 Apr 2020 19:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5b91cf11-79b8-aa00-8f64-f56a3f67c641@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 shannon.zhaosl@gmail.com, linuxarm@huawei.com, qemu-devel@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, dgilbert@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, xuwei5@hisilicon.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 4:54 PM, David Hildenbrand wrote:
> On 07.04.20 16:34, Michael S. Tsirkin wrote:
>> On Tue, Apr 07, 2020 at 04:17:46PM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> On 4/3/20 12:18 PM, Shameer Kolothum wrote:
>>>> Any sub-page size update to ACPI MRs will be lost during
>>>> migration, as we use aligned size in ram_load_precopy() ->
>>>> qemu_ram_resize() path. This will result in inconsistency in
>>>> FWCfgEntry sizes between source and destination. In order to avoid
>>>> this, save and restore them separately during migration.
>>>>
>>>> Up until now, this problem may not be that relevant for x86 as both
>>>> ACPI table and Linker MRs gets padded and aligned. Also at present,
>>>> qemu_ram_resize() doesn't invoke callback to update FWCfgEntry for
>>>> unaligned size changes. But since we are going to fix the
>>>> qemu_ram_resize() in the subsequent patch, the issue may become
>>>> more serious especially for RSDP MR case.
>>>>
>>>> Moreover, the issue will soon become prominent in arm/virt as well
>>>> where the MRs are not padded or aligned at all and eventually have
>>>> acpi table changes as part of future additions like NVDIMM hot-add
>>>> feature.
>>>>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>> v1 --> v2
>>>>    - Changed *_mr_size from size_t to uint64_t to address portability.
>>>>    - post_copy only done if sizes are not aligned.
>>>>
>>>> Please find previous discussions here,
>>>> https://patchwork.kernel.org/patch/11339591/#23140343
>>>> ---
>>>>    hw/core/machine.c         |  1 +
>>>>    hw/nvram/fw_cfg.c         | 91 ++++++++++++++++++++++++++++++++++++=
++-
>>>>    include/hw/nvram/fw_cfg.h |  6 +++
>>>>    3 files changed, 97 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index de0c425605..c1a444cb75 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
>>>>        { "usb-redir", "suppress-remote-wake", "off" },
>>>>        { "qxl", "revision", "4" },
>>>>        { "qxl-vga", "revision", "4" },
>>>> +    { "fw_cfg", "acpi-mr-restore", "false" },
>>>>    };
>>>>    const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
>>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>>> index 179b302f01..4be6c9d9fd 100644
>>>> --- a/hw/nvram/fw_cfg.c
>>>> +++ b/hw/nvram/fw_cfg.c
>>>> @@ -39,6 +39,7 @@
>>>>    #include "qemu/config-file.h"
>>>>    #include "qemu/cutils.h"
>>>>    #include "qapi/error.h"
>>>> +#include "hw/acpi/aml-build.h"
>>>>    #define FW_CFG_FILE_SLOTS_DFLT 0x20
>>>> @@ -610,6 +611,55 @@ bool fw_cfg_dma_enabled(void *opaque)
>>>>        return s->dma_enabled;
>>>>    }
>>>> +static bool fw_cfg_acpi_mr_restore(void *opaque)
>>>> +{
>>>> +    FWCfgState *s =3D opaque;
>>>> +    bool mr_aligned;
>>>> +
>>>> +    mr_aligned =3D QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_p=
age_size) &&
>>>> +                 QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_pa=
ge_size) &&
>>>> +                 QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page=
_size);
>>>> +    return s->acpi_mr_restore && !mr_aligned;
>>>
>>> This code is hard to review.
>>>
>>> Is this equivalent?
>>>
>>>      if (!s->acpi_mr_restore) {
>>>          return false;
>>>      }
>>>      if (!QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_size)) =
{
>>>          return false;
>>>      }
>>>      if (!QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_size))=
 {
>>>          return false;
>>>      }
>>>      if (!QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size)) {
>>>          return false;
>>>      }
>>>      return true;
>>
>> I think I prefer the original version though. Matter of taste?
>=20
> At least I find the original code fairly easy to read - just as the
> proposed alternative. So, yes, matter of taste I'd say.

OK :)


