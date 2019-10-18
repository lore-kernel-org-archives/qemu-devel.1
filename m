Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8091FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15354222C6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15354222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLT7G-00064O-1W
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLSo7-0000k5-EF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLSo1-0002Cv-EV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLSnq-0002AF-WC; Fri, 18 Oct 2019 10:00:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48EEE79705;
 Fri, 18 Oct 2019 14:00:25 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F42614C4;
 Fri, 18 Oct 2019 14:00:24 +0000 (UTC)
Subject: Re: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <71ad0b78-65da-9a39-4c12-f78449cdca9c@redhat.com>
Date: Fri, 18 Oct 2019 09:00:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018094758.7124-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 18 Oct 2019 14:00:25 +0000 (UTC)
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
> Make it more obvious how to add new fields to the version 3 header and
> how to interpret them.
> 
> The specification is adjusted so for new defined optional fields:

The specification is adjusted to make it clear that future fields are 
optional:

> 
> 1. Software may support some of these optional fields and ignore the
>     others, which means that features may be backported to downstream
>     Qemu independently.
> 3. If @header_length is higher than the highest field end that software
>     knows, it should assume that topmost unknown additional fields are
>     correct, and keep additional unknown fields as is on rewriting the
>     image.
> 3. If we want to add incompatible field (or a field, for which some its
>     values would be incompatible), it must be accompanied by
>     incompatible feature bit.
> 
> Also the concept of "default is zero" is clarified, as it's strange to
> say that the value of the field is assumed to be zero for the software
> version which don't know about the field at all and don't know how to
> treat it be it zero or not.
> 

I'd also mention that we want to enforce 8-byte alignment in this cover 
letter.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/qcow2.txt | 26 +++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..4709f3bb30 100644
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

For version 2, the header is exactly 72 bytes in length, and finishes here.
For version 3 or higher, the header length is at least 104 bytes, 
including the next fields through header_length.

>   
>            72 -  79:  incompatible_features
>                       Bitmask of incompatible features. An implementation must
> @@ -164,6 +164,26 @@ in the description of a field.
>           100 - 103:  header_length
>                       Length of the header structure in bytes. For version 2
>                       images, the length is always assumed to be 72 bytes.
> +                    For version 3 it's at least 104 bytes.

I'd also add a sentence that this field must be a multiple of 8.

> +
> +Additional fields (version 3 and higher)
> +
> +The following fields of the header are optional: if software doesn't know how
> +to interpret the field, it may be safely ignored, other than preserving the
> +field unchanged when rewriting the image header.

Maybe:

if software doesn't know how to interpret the field, it may be safely 
ignored unless a corresponding incompatible feature flag bit is set; 
however, the field should be preserved unchanged when rewriting the 
image header.

> +
> +For all additional fields zero value equals to absence of field (absence is
> +when field.offset + field.size > @header_length). This implies
> +that if software want's to set fields up to some field not aligned to multiply
> +of 8 it must align header up by zeroes. And on the other hand, if software
> +need some optional field which is absent it should assume that it's value is
> +zero.

Maybe:

Each optional field that does not have a corresponding incompatible 
feature bit must support the value 0 that gives the same default 
behavior as when the optional field is omitted.

> +
> +It's allowed for the header end to cut some field in the middle (in this case
> +the field is considered as absent), but in this case the part of the field
> +which is covered by @header_length must be zeroed.
> +
> +        < ... No additional fields in the header currently ... >

Do we even still need this if we require 8-byte alignment?  We'd never 
be able to cut a single field in the middle, but I suppose you are 
worried about cutting a 2-field 16-byte addition tied to a single 
feature in the middle.  But that's not going to happen in practice.  The 
only time the header will be longer than 104 bytes is if at least one 
documented optional feature has been implemented/backported, and that 
feature will be implemented in its entirety.  If you backport a later 
feature but not the earlier, you're still going to set header_length to 
the boundary of the feature that you ARE backporting.  Thus, I argue 
that blindly setting header_length to 120 prior to the standard ever 
defining optional field(s) at 112-120 is premature, and that if we ever 
add a feature requiring bytes 112-128 for a new feature, you will never 
see a valid qcow2 file with a header length of 120.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

