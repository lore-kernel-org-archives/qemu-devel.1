Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC14E206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRsbSRsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC14E206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXbx-0003j8-VT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixXYx-0001Me-PZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixXYv-0000eN-S2
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:46:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixXYu-0000cz-4p
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580481983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pA3IjnwPGSF+rXafnzUTcCnKhTtrvSphpVfV3ecgEIs=;
 b=QRsbSRsROynqjYii1QuqNgxBCX/cXTcJc64BIWxhjZ+/o2dS2oU+yUMvsdT3R8uS+0TCZW
 NTwWa3TZPiSBw/Uc/BXhojS/3FwmH69WMmm0r8nzDJZjXALaQEwdpCwVX2DAgrNAvUgPKh
 kNMSpOX9L6llU0rflokhlaffMzMSmQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-btUnjkMFPJuaI7_w9kF18Q-1; Fri, 31 Jan 2020 09:46:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C98C818A6EE1;
 Fri, 31 Jan 2020 14:46:13 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E14CD60BE1;
 Fri, 31 Jan 2020 14:46:12 +0000 (UTC)
Subject: Re: [PATCH v11 2/2] docs: qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee6b018a-be33-ed77-c4b9-4894c685d30a@redhat.com>
Date: Fri, 31 Jan 2020 08:46:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131142219.3264-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: btUnjkMFPJuaI7_w9kF18Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dplotnikov@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 8:22 AM, Vladimir Sementsov-Ogievskiy wrote:
> The patch adds a new additional field to the qcow2 header: compression_type,
> which specifies compression type. If field is absent or zero, default
> compression type is set: ZLIB, which corresponds to current behavior.
> 
> New compression type (ZSTD) is to be added in further commit.
> 
> Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/qcow2.txt | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 823cc266e0..3a8d5c0c6e 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -109,6 +109,11 @@ the next fields through header_length.
>                                   An External Data File Name header extension may
>                                   be present if this bit is set.
>   
> +                    Bit 3:      Compression type bit.  If this bit is set,
> +                                a non-default compression is used for compressed
> +                                clusters. The compression_type field must be
> +                                present and not zero.
> +

I'm still not sold on this.  What's wrong with:

            Bit 3:      Compression type bit.  If this bit is set,
                        a non-default compression may be used for
                        compressed clusters, and the compression_type
                        field must be present.

>                       Bits 3-63:  Reserved (set to 0)
>   
>            80 -  87:  compatible_features
> @@ -190,7 +195,19 @@ present*, if not altered by a specific incompatible bit.
>   to the field's offset. Also, all additional fields are not present for
>   version 2.
>   
> -        < ... No additional fields in the header currently ... >
> +              104:  compression_type
> +
> +                    Defines the compression method used for compressed clusters.
> +                    All compressed clusters in an image use the same compression
> +                    type.
> +
> +                    If the incompatible bit "Compression type" is set: the field
> +                    must be present and non-zero (which means non-zlib
> +                    compression type). Otherwise, this field must not be present
> +                    or must be zero (which means zlib).

            If the incompatible bit "Compression type" is set: the field
            must be present. Otherwise, this field must not be present
            or must be zero (which means zlib).  It is recommended but
            not required that the "Compression type" bit be clear if this
            field is present but zero.

> +
> +                    Available compression type values:
> +                        0: zlib <https://www.zlib.net/>
>   
>   
>   === Header padding ===
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


