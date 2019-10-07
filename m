Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF889C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 20:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24E421479
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 20:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24E421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHZWj-0000fK-NP
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 16:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iHZVu-000086-Fv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 16:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iHZVt-0006GO-4B
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 16:21:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iHZVo-0006E5-K8; Mon, 07 Oct 2019 16:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6AD910C093E;
 Mon,  7 Oct 2019 20:21:42 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E334E5DA2C;
 Mon,  7 Oct 2019 20:21:41 +0000 (UTC)
Subject: Re: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
 <20191007160451.27334-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
Date: Mon, 7 Oct 2019 15:21:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191007160451.27334-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 07 Oct 2019 20:21:43 +0000 (UTC)
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
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, dplotnikov@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 11:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> Make it more obvious how to add new fields to the version 3 header and
> how to interpret them.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/qcow2.txt | 26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..3f2855593f 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -79,9 +79,9 @@ The first cluster of a qcow2 image contains the file header:
>                       Offset into the image file at which the snapshot table
>                       starts. Must be aligned to a cluster boundary.
>   
> -If the version is 3 or higher, the header has the following additional fields.
> -For version 2, the values are assumed to be zero, unless specified otherwise
> -in the description of a field.
> +For version 2, header is always 72 bytes length and finishes here.
> +For version 3 or higher the header length is at least 104 bytes and has at
> +least next five fields, up to the @header_length field.

This hunk seems okay.

>   
>            72 -  79:  incompatible_features
>                       Bitmask of incompatible features. An implementation must
> @@ -165,6 +165,26 @@ in the description of a field.
>                       Length of the header structure in bytes. For version 2
>                       images, the length is always assumed to be 72 bytes.
>   
> +Additional fields (version 3 and higher)
> +
> +The following fields of the header are optional: if software don't know how to
> +interpret the field, it may safely ignore it. Still the field must be kept as is
> +when rewriting the image.

if software doesn't know how to interpret the field, it may be safely 
ignored, other than preserving the field unchanged when rewriting the 
image header.

Missing:

If header_length excludes an optional field, the value of 0 should be 
used for that field.

> @header_length must be bound to the end of one of
> +these fields (or to @header_length field end itself, to be 104 bytes).

We don't use the @header_length markup anywhere else in this file, 
starting to do so here is odd.

I would suggest a stronger requirement:

header_length must be a multiple of 4, and must not land in the middle 
of any optional 8-byte field.

Or maybe even add our compression type extension with 4 bytes of 
padding, so that we could go even stronger:

header_length must be a multiple of 8.

> +This definition implies the following:
> +1. Software may support some of these optional fields and ignore the others,
> +   which means that features may be backported to downstream Qemu independently.

I don't think this belongs in the spec.  Ideally, we add fields so 
infrequently that backporting doesn't have to worry about backporting 
field 2 while skipping field 1.

> +2. Software may check @header_length, if it knows optional fields specification
> +   enough (knows about the field which exceeds @header_length).

Again, I don't think this adds anything.  Since we already documented 
fields are optional, and that if header_length is too short, the missing 
field is treated as 0, software that knows about a longer header_length 
will already handle it correctly.

> +3. If @header_length is higher than the highest field end that software knows,
> +   it should assume that additional fields are correct, @header_length is
> +   correct and keep @header_length and additional unknown fields as is on
> +   rewriting the image.
> +3. If we want to add incompatible field (or a field, for which some its values
> +   would be incompatible), it must be accompanied by incompatible feature bit.
> +
> +        < ... No additional fields in the header currently ... >
> +

I'm still not seeing the value in adding any of this paragraph to the 
spec.  Maybe in the commit message that accompanies the spec change, but 
the spec is clear enough if it documents how optional header fields are 
to be managed (treat as 0 if missing, preserve on write if unknown, and 
with a mandated alignment to avoid having to worry about other issues).

>   Directly after the image header, optional sections called header extensions can
>   be stored. Each extension has a structure like the following:
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

