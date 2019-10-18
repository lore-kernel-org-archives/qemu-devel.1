Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B529CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F60E21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F60E21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLStf-0006wB-US
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLSs2-000542-5V
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLSs0-00045k-PO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:04:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLSry-00044E-2I; Fri, 18 Oct 2019 10:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31EB9881363;
 Fri, 18 Oct 2019 14:04:41 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9330210013A1;
 Fri, 18 Oct 2019 14:04:40 +0000 (UTC)
Subject: Re: [PATCH v8 3/3] docs: qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <29df7fb8-8218-2228-9575-e84e369a7d9a@redhat.com>
Date: Fri, 18 Oct 2019 09:04:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018094758.7124-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 18 Oct 2019 14:04:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 dplotnikov@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> The patch add new additional field to qcow2 header: compression_type,
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
> index b971e59b1a..4eabd81363 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -109,6 +109,12 @@ least next five fields, up to the @header_length field.
>                                   An External Data File Name header extension may
>                                   be present if this bit is set.
>   
> +                    Bit 3:      Compression type bit.  If this bit is set,
> +                                non-default compression is used for compressed
> +                                clusters. In this case, @header_length must
> +                                be at least 105 and @compression_type field
> +                                must be non-zero.

I want to insist on 8-byte alignment, so this should be at least 112.

Also, as pointed out in v7, use of the decoration '@header_length' and 
'@compression_type' is not consistent with the rest of the document. 
Drop the @.

> +
>                       Bits 3-63:  Reserved (set to 0)
>   
>            80 -  87:  compatible_features
> @@ -183,7 +189,18 @@ It's allowed for the header end to cut some field in the middle (in this case
>   the field is considered as absent), but in this case the part of the field
>   which is covered by @header_length must be zeroed.
>   
> -        < ... No additional fields in the header currently ... >
> +              104:  compression_type
> +                    Defines the compression method used for compressed clusters.
> +                    A single compression type is applied to all compressed image
> +                    clusters.
> +                    If incompatible compression type bit is set: the field must
> +                    exist (i.e. @header_length >= 105) and must be non-zero (
> +                    which means non-zlib compression type)
> +                    If incompatible compression type bit is unset: the field
> +                    may not exist (if @header_length < 105) or it must be zero
> +                    (which means zlib).
> +                    Available compression type values:
> +                        0: zlib <https://www.zlib.net/>
>   

One byte for the field is fine, but I'd still explicitly document 7 
bytes of unused padding, since I want to insist on an 8-byte multiple.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

