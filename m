Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A331C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9878217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3trvmgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9878217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itd1j-0008PQ-JN
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itd0U-0007mt-No
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itd0Q-0000mV-OH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:46:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35983)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itd0Q-0000m2-JZ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579549597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3/6FuKMIpHgWsov45Mlf++g84UlyegX9k2RhHIW4UA=;
 b=d3trvmgK7NIRaaeVHD2nntnJaq6Z2ZX+7OgGBgtaLc82tEK1YFrErEw8zM1qEDFJtIFOed
 xHczsZMSoqCdn2hbhcFhMRuBJXZ30gHUtbTmtQ2ITmXIQnQtQ05rF8vO6rUGGXZiSgqInE
 GKqBGmOmDdScxGOkPEbIk2EZQcSv9JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-bt64b-NSPVy3J-12FKt1XQ-1; Mon, 20 Jan 2020 14:46:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A2FE800D53;
 Mon, 20 Jan 2020 19:46:30 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC6661CB;
 Mon, 20 Jan 2020 19:46:29 +0000 (UTC)
Subject: Re: [PATCH v10 2/2] docs: qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <679ba957-0b47-27ab-0684-e066ca8a6196@redhat.com>
Date: Mon, 20 Jan 2020 13:46:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120171345.24345-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bt64b-NSPVy3J-12FKt1XQ-1
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

On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
> The patch add new additional field to qcow2 header: compression_type,

s/add/adds a/
s/to/to the/

> which specifies compression type. If field is absent or zero, default
> compression type is set: ZLIB, which corresponds to current behavior.
> 
> New compression type (ZSTD) is to be added in further commit.

It would be nice to have that patch as part of the same series, but it 
has already been posted to the list separately, so I'm okay with this 
series as just doc word-smithing while we get that patch series in soon.

> 
> Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/qcow2.txt | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 355925c35e..4569f0dba3 100644
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

Why must the compression_type field be non-zero?  If this bit is set, an 
older qemu cannot use the image, regardless of the contents of the 
compression_type field, so for maximum back-compat, a sane app will 
never set this bit when compression_type is zero.  But there is nothing 
technically wrong with setting this bit even when compression_type is 0, 
and newer qemu would still manage to use the image correctly with zlib 
compression if it were not for this arbitrary restriction.

> +
>                       Bits 3-63:  Reserved (set to 0)
>   
>            80 -  87:  compatible_features
> @@ -189,7 +194,16 @@ present*, if not altered by a specific incompatible bit.
>   *. A field is considered not present when header_length is less or equal to the
>   field's offset. Also, all additional fields are not present for version 2.
>   
> -        < ... No additional fields in the header currently ... >
> +              104:  compression_type
> +                    Defines the compression method used for compressed clusters.
> +                    All compressed clusters in an image use the same compression
> +                    type.
> +                    If the incompatible bit "Compression type" is set: the field

Ragged edge formatting looks awkward.  Either this is one paragraph 
("type.  If") or there should be a blank line to make it obvious there 
are two paragraphs.

> +                    must be present and non-zero (which means non-zlib
> +                    compression type). Otherwise, this field must not be present
> +                    or must be zero (which means zlib).
> +                    Available compression type values:
> +                        0: zlib <https://www.zlib.net/>

I'm still not sure I agree with the mandate that the field must be 
non-zero when the incompatible feature bit is set.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


