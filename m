Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B8C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F36217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZnMoXpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F36217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcwq-0005KU-2H
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itcw9-0004pX-CQ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itcw4-0006ZW-MH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:42:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itcw4-0006Yy-Hu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579549327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzK1VKW3jUbgEbuIxBp+zwxcK3Dlwts3QzwdqhODRDo=;
 b=YZnMoXpjjSG4VHEQbHOWjQDYYacQULcHcgglomH3XaLhOvWrVPK+iy7mUToWhb1AOC3bMY
 CSZNMiAxugIjXmoddLf4N05UREQlfwolT9CkWCrsuasJ6Yd18TYjko9zD+xiioMcLhUU06
 MXHwGZoLHLlFOFr5dEl+dKSWlyZaoow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-tLHacFxpNpqXzOEJyea2Vw-1; Mon, 20 Jan 2020 14:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19EF1800D4E;
 Mon, 20 Jan 2020 19:42:03 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3340C7C35A;
 Mon, 20 Jan 2020 19:42:01 +0000 (UTC)
Subject: Re: [PATCH v10 1/2] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200120171345.24345-1-vsementsov@virtuozzo.com>
 <20200120171345.24345-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e457c8c4-ae37-9b30-5580-40b34bbf458c@redhat.com>
Date: Mon, 20 Jan 2020 13:42:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120171345.24345-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: tLHacFxpNpqXzOEJyea2Vw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dplotnikov@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 11:13 AM, Vladimir Sementsov-Ogievskiy wrote:
> Make it more obvious how to add new fields to the version 3 header and
> how to interpret them.
> 
> The specification is adjusted so for new defined optional fields:

s/so for/so that for/

> 
> 1. Software may support some of these optional fields and ignore the
>     others, which means that features may be backported to downstream
>     Qemu independently.
> 2. If we want to add incompatible field (or a field, for which some its
>     values would be incompatible), it must be accompanied by
>     incompatible feature bit.
> 
> Also the concept of "default is zero" is clarified, as it's strange to
> say that the value of the field is assumed to be zero for the software
> version which don't know about the field at all and don't know how to
> treat it be it zero or not.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/qcow2.txt | 44 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..355925c35e 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file header:
>                       Offset into the image file at which the snapshot table
>                       starts. Must be aligned to a cluster boundary.
>   
> -If the version is 3 or higher, the header has the following additional fields.
> -For version 2, the values are assumed to be zero, unless specified otherwise
> -in the description of a field.
> +For version 2, the header is exactly 72 bytes in length, and finishes here.
> +For version 3 or higher, the header length is at least 104 bytes, including
> +the next fields through header_length.
>   
>            72 -  79:  incompatible_features
>                       Bitmask of incompatible features. An implementation must
> @@ -164,6 +164,44 @@ in the description of a field.
>           100 - 103:  header_length
>                       Length of the header structure in bytes. For version 2
>                       images, the length is always assumed to be 72 bytes.
> +                    For version 3 it's at least 104 bytes and must be a multiple
> +                    of 8.
> +
> +
> +=== Additional fields (version 3 and higher) ===
> +
> +In general, these fields are optional and may be safely ignored by the software,
> +as well as filled by zeros (which is equal to field absence), if software needs

We're inconsistent on 'zeros' (git grep has 201 hits) vs. 'zeroes' (688 
hits); I prefer the latter, but won't object if you don't tweak it since 
this is the first use of either spelling in qcow2.txt.

> +to set field B, but does not care about field A, which precedes B. More

s/A, which/A which/

> +formally, additional fields have the following compatibility rules:
> +
> +1. If the value of the additional field must not be ignored for correct
> +handling of the file, it will be accompanied by a corresponding incompatible
> +feature bit.
> +
> +2. If there are no unrecognized incompatible feature bits set, an unknown
> +additional field may be safely ignored other than preserving its value when
> +rewriting the image header.
> +
> +3. An explicit value of 0 will have the same behavior as when the field is not
> +present*, if not altered by a specific incompatible bit.
> +
> +*. A field is considered not present when header_length is less or equal to the

s/less/less than/

> +field's offset. Also, all additional fields are not present for version 2.
> +
> +        < ... No additional fields in the header currently ... >
> +
> +
> +=== Header padding ===
> +
> +@header_length must be a multiple of 8, which means that if the end of the last
> +additional field is not aligned, some padding is needed. This padding must be
> +zeroed, so that, if some existing (or future) additional field will fall into

s/that, if/that if/

> +the padding, it will be interpreted accordingly to point [3.] of the previous
> +paragraph, i.e.  in the same manner as when this field is not present.
> +
> +
> +=== Header extensions ===
>   
>   Directly after the image header, optional sections called header extensions can
>   be stored. Each extension has a structure like the following:
> 

We're down to few enough grammar nits that I'm happy with:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


