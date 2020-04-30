Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA7C83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8918A2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDyi8sjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8918A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3KE-00041a-K8
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3JS-0003WP-VM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3I8-0003Hq-BG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:08:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22616
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3I7-0003B0-UO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588230446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3c8d61KDPRNp6u4YbeVoX+aotdy+RoWV0Hz8n9lEmk=;
 b=RDyi8sjV+GRHb6E+zbzZUiv91jT4FdqjihLxxRXG12SiLNkUbmuJBcqsfVkC7ytc3k7M0U
 NDg9kZTsxMxSaP2fRi7p2iwyl+Plqg/7btRyuq4qrO7bm5pYkppqYgpvmo6hdOdnHtu/Rb
 8aSBLeLyaJ1z4RKnYULP0g2/Tcm1/So=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-QWmMKThcO0yuk1V2Bbau-Q-1; Thu, 30 Apr 2020 03:07:24 -0400
X-MC-Unique: QWmMKThcO0yuk1V2Bbau-Q-1
Received: by mail-wr1-f70.google.com with SMTP id t8so3361892wrq.22
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y0kIa7cQMBJKZi8KeivkwsenLGA0Z5LZsW3mpgemZcs=;
 b=WAjVQv+9gzJBPHdwTp1+/ZU/cGLMsHgaVJ4YRNKG2T49YwiU/f25u5fq98qWukxe9N
 ZrHTxPXeA9/iRc0YEtIi2aeMLuaZhbLtsjGpXL5N9RivmjHBVWNtP/SLBSamJrlIFBiR
 9Zcsz/ZFdCxmowx1li6NoSP0MONeq5McVippMJ+unrXdexhRf0FJk4bE9L7hogTbASjG
 i9A4PYmms8r/LKaW7IpnH5UVhDKHUppn9fYOuzpMCDnlS+2W0Yg6cz9LrxEg1V8pz+4e
 K3/HbdJwhUX2ZwNgMywmrpnnNzaaZhgfZ0TID1vfkp8OTiI93VRZiDeh/B3u227k/tSh
 ID3Q==
X-Gm-Message-State: AGi0PuZhO7FdtH/SxuOJXP7/ns96BtrFpKAMm7yiMbGGyHm7F1SzxSLH
 wnNFD8j8M5CTbM2d/MveWzXP6tY9lCAuNyBxo5o+CdmP0wM6QJpI/tjnvDeWVX7Zr1wDngzoJgu
 /Uq3VJTLtK+8bbgk=
X-Received: by 2002:adf:84c1:: with SMTP id 59mr2215777wrg.350.1588230443551; 
 Thu, 30 Apr 2020 00:07:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypL6aLKfIVsogMKbLDoopJgcHl6zmRsBV3W8rmeMiRSLAUBJ1B6PaHaMoLy6a3ua3qnNgPR/mw==
X-Received: by 2002:adf:84c1:: with SMTP id 59mr2215763wrg.350.1588230443367; 
 Thu, 30 Apr 2020 00:07:23 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id x13sm11323921wmc.5.2020.04.30.00.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 00:07:22 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com,
 alex.williamson@redhat.com
References: <20200430051558.28991-1-yan.y.zhao@intel.com>
 <20200430051923.29159-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f99563d-8b52-9cc9-50b2-6e2de7a305b6@redhat.com>
Date: Thu, 30 Apr 2020 09:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430051923.29159-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: xin.zeng@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 7:19 AM, Yan Zhao wrote:
> for ram device regions, drop guest writes if the regions is read-only.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   memory.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index 601b749906..90a748912f 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -34,6 +34,7 @@
>   #include "sysemu/accel.h"
>   #include "hw/boards.h"
>   #include "migration/vmstate.h"
> +#include "qemu/log.h"
>  =20
>   //#define DEBUG_UNASSIGNED
>  =20
> @@ -1307,12 +1308,19 @@ static uint64_t memory_region_ram_device_read(voi=
d *opaque,
>       return data;
>   }
>  =20
> -static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> -                                           uint64_t data, unsigned size)
> +static MemTxResult memory_region_ram_device_write(void *opaque, hwaddr a=
ddr,
> +                                           uint64_t data, unsigned size,
> +                                           MemTxAttrs attrs)

Style alignment is now of and can be adjusted easily.

>   {
>       MemoryRegion *mr =3D opaque;
>  =20
>       trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, dat=
a, size);
> +    if (mr->readonly) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid write to read only ram device region addr=
 0x%"
> +                       HWADDR_PRIx" size %u\n", addr, size);

Style alignment of here too.

Otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        return MEMTX_ERROR;
> +    }
>  =20
>       switch (size) {
>       case 1:
> @@ -1328,11 +1336,12 @@ static void memory_region_ram_device_write(void *=
opaque, hwaddr addr,
>           *(uint64_t *)(mr->ram_block->host + addr) =3D data;
>           break;
>       }
> +    return MEMTX_OK;
>   }
>  =20
>   static const MemoryRegionOps ram_device_mem_ops =3D {
>       .read =3D memory_region_ram_device_read,
> -    .write =3D memory_region_ram_device_write,
> +    .write_with_attrs =3D memory_region_ram_device_write,
>       .endianness =3D DEVICE_HOST_ENDIAN,
>       .valid =3D {
>           .min_access_size =3D 1,
>=20


