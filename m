Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0665C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4F32078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeaI/1ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4F32078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJul-000255-Jc
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKJu2-0001Tf-Ki
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKJu0-0002KG-9f
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:50:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKJu0-0002JB-6D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585911019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyrINhvaXuzlDVuWWMS/Llp2G7IXlgrYOXxtuPZXbdQ=;
 b=JeaI/1ZV5m5pWEUD1Vmfg/iRpw22QHwkqCF1rYLYCk2XaClFtU36DiOQBsL3UOzm7ZeGrm
 xFhR2UvJprd8D/JtdDs+n2qB/NR78p1F7JWBtiMnH2/TIcHQYns2YViUO0f83hXsxclyVg
 BtKyT4H5BqVNUIC0imY6TjJ1V+D/pmQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-Jwe5KqulMG-3COOSCAC2sA-1; Fri, 03 Apr 2020 06:50:15 -0400
X-MC-Unique: Jwe5KqulMG-3COOSCAC2sA-1
Received: by mail-ed1-f72.google.com with SMTP id i61so5139391edc.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 03:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O8O05iEobAlBTy+rNcrf24PgymJ5aC8/OkSpNAk7lSw=;
 b=cTWohaXkh/jo5A3im+MNBtDn51GQY3vTIqnrmTv6xhGpktbFAyR43x/iuBykrAOr1v
 CN1MmApW/3djyNCbGs110oSiSA/SjQSb7KGmBhibhcjtBGxMJIFDpUKc9kc5TEzIF13w
 BAaxyeo8hRU9qsi40z8ymxzD/9z1Yw4KXjPk/sJeXh9HKCWOVU1Bk19XeDmoQDuy2Khi
 UtAOmPyovzTaIpTIoHV0cp6PyjhCTvXRBYqiwwsnm93t22yADB1MalCwM7mWKC/dTgtC
 O7V0InE3vMo0zovfkI436ZrqrryowsjWGE/MTjeA5hnT3Z3FB6QIQ54K8hFgWsnzJcN6
 7Y/g==
X-Gm-Message-State: AGi0Puaiw9ZR8H9b5/k6viNAw8WbIjiUbLhmLj0fZfr75zDOKgWOwv4X
 8GcAV6ChredzBXSepmpFV1zDf77jyPNNN9qMYJz6GH0L46B5AygnFIudUCNEgA+xzTPMfB1d1KL
 iohpuGuJLQrtINH0=
X-Received: by 2002:a17:906:6d55:: with SMTP id
 a21mr7373489ejt.186.1585911014423; 
 Fri, 03 Apr 2020 03:50:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypIFL5qqID1vmSa9SQkjp3CEN+oCqCe1xXBgJFk/jiZ0hUkVtOZ2hITsnj/yIKvHMmD+6/wyTQ==
X-Received: by 2002:a17:906:6d55:: with SMTP id
 a21mr7373457ejt.186.1585911014066; 
 Fri, 03 Apr 2020 03:50:14 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p4sm1576021eju.57.2020.04.03.03.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 03:50:13 -0700 (PDT)
Subject: Re: [PATCH for-5.0 v2 3/3] exec: Fix for qemu_ram_resize() callback
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com,
 imammedo@redhat.com
References: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
 <20200403101827.30664-4-shameerali.kolothum.thodi@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a350c04a-786d-639c-6754-024fc10e92b6@redhat.com>
Date: Fri, 3 Apr 2020 12:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403101827.30664-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 david@redhat.com, dgilbert@redhat.com, xuwei5@hisilicon.com,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 12:18 PM, Shameer Kolothum wrote:
> From: David Hildenbrand <david@redhat.com>
>=20
> Summarizing the issue:
> 1. Memory regions contain ram blocks with a different size,  if the
>     size is  not properly aligned. While memory regions can have an
>     unaligned size, ram blocks can't. This is true when creating
>     resizable memory region with  an unaligned size.
> 2. When resizing a ram block/memory region, the size of the memory
>     region  is set to the aligned size. The callback is called with
>     the aligned size. The unaligned piece is lost.
>=20
> Because of the above, if ACPI blob length modifications happens
> after the initial virt_acpi_build() call, and the changed blob
> length is within the PAGE size boundary, then the revised size
> is not seen by the firmware on Guest reboot.
>=20
> Hence make sure callback is called if memory region size is changed,
> irrespective of aligned or not.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> [Shameer: added commit log]
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
> Please find previous discussion here,
> https://patchwork.kernel.org/patch/11432375/#23216751
> ---
>   exec.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index de9d949902..2874bb5088 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2074,11 +2074,23 @@ static int memory_try_enable_merging(void *addr, =
size_t len)
>    */
>   int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
>   {
> +    const ram_addr_t unaligned_size =3D newsize;
> +
>       assert(block);
>  =20
>       newsize =3D HOST_PAGE_ALIGN(newsize);
>  =20
>       if (block->used_length =3D=3D newsize) {
> +        /*
> +         * We don't have to resize the ram block (which only knows align=
ed
> +         * sizes), however, we have to notify if the unaligned size chan=
ged.
> +         */
> +        if (unaligned_size !=3D memory_region_size(block->mr)) {
> +            memory_region_set_size(block->mr, unaligned_size);
> +            if (block->resized) {
> +                block->resized(block->idstr, unaligned_size, block->host=
);
> +            }
> +        }
>           return 0;
>       }
>  =20
> @@ -2102,9 +2114,9 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t new=
size, Error **errp)
>       block->used_length =3D newsize;
>       cpu_physical_memory_set_dirty_range(block->offset, block->used_leng=
th,
>                                           DIRTY_CLIENTS_ALL);
> -    memory_region_set_size(block->mr, newsize);
> +    memory_region_set_size(block->mr, unaligned_size);
>       if (block->resized) {
> -        block->resized(block->idstr, newsize, block->host);
> +        block->resized(block->idstr, unaligned_size, block->host);
>       }
>       return 0;
>   }
>=20


