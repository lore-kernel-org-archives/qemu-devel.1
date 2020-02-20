Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A5C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A599B207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOCY7mII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A599B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4mpJ-0008P6-Sz
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4moW-0007mu-P3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4moU-0000zJ-Gu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:28:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4moU-0000yv-9J
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582208905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lR3lwpEW6s1UVCXXUeu0vvXjUHIsQfD1vBxZ+6Lc1R8=;
 b=LOCY7mIIH3s0guy3/V+d+R1gIFUOW5VyXm74IPKLgvb+u+g4nXQjlTUvrlkUZK7JDZLtu/
 bxazo79hAXv456ZtMIe1CJ8pVgeZiQXyuzJl8kUWlNd1kSnVUuO+KlPSmoWEhbqwTl6g1b
 FXs2YO/1ViVUfzttoTPpBkypVwiTsDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-gydX_HEUOOqNRvpGOChuqA-1; Thu, 20 Feb 2020 09:28:21 -0500
X-MC-Unique: gydX_HEUOOqNRvpGOChuqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4F8A1005512;
 Thu, 20 Feb 2020 14:28:19 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E7CA1001B2C;
 Thu, 20 Feb 2020 14:28:18 +0000 (UTC)
Subject: Re: [RFC PATCH v3 05/27] qcow2: Document the Extended L2 Entries
 feature
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3a946970-5a26-6c40-a212-0aefdccef509@redhat.com>
Date: Thu, 20 Feb 2020 08:28:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/22/19 5:36 AM, Alberto Garcia wrote:
> Subcluster allocation in qcow2 is implemented by extending the
> existing L2 table entries and adding additional information to
> indicate the allocation status of each subcluster.
> 
> This patch documents the changes to the qcow2 format and how they
> affect the calculation of the L2 cache size.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   docs/interop/qcow2.txt | 68 ++++++++++++++++++++++++++++++++++++++++--
>   docs/qcow2-cache.txt   | 19 +++++++++++-
>   2 files changed, 83 insertions(+), 4 deletions(-)

This adds a new feature bit; where is the corresponding patch to qcow2.c 
to advertise the feature bit name in the optional feature name table?

/me reads ahead

good, patch 25 covers it.  Quick comment added there as a result.


> +== Extended L2 Entries ==
> +
> +An image uses Extended L2 Entries if bit 3 is set on the incompatible_features
> +field of the header.
> +
> +In these images standard data clusters are divided into 32 subclusters of the
> +same size. They are contiguous and start from the beginning of the cluster.
> +Subclusters can be allocated independently and the L2 entry contains information
> +indicating the status of each one of them. Compressed data clusters don't have
> +subclusters so they are treated like in images without this feature.

Grammar; I'd suggest:

...don't have subclusters, so they are treated the same as in images 
without this feature.

Are they truly the same, or do you still need to document that the extra 
64 bits of the extended L2 entry are all zero?

> +
> +The size of an extended L2 entry is 128 bits so the number of entries per table
> +is calculated using this formula:
> +
> +    l2_entries = (cluster_size / (2 * sizeof(uint64_t)))
> +
> +The first 64 bits have the same format as the standard L2 table entry described
> +in the previous section, with the exception of bit 0 of the standard cluster
> +descriptor.
> +
> +The last 64 bits contain a subcluster allocation bitmap with this format:
> +
> +Subcluster Allocation Bitmap (for standard clusters):
> +
> +    Bit  0 -  31:   Allocation status (one bit per subcluster)
> +
> +                    1: the subcluster is allocated. In this case the
> +                       host cluster offset field must contain a valid
> +                       offset.
> +                    0: the subcluster is not allocated. In this case
> +                       read requests shall go to the backing file or
> +                       return zeros if there is no backing file data.
> +
> +                    Bits are assigned starting from the most significant one.
> +                    (i.e. bit x is used for subcluster 31 - x)
> +

Missing trailing '.'

> +        32 -  63    Subcluster reads as zeros (one bit per subcluster)
> +
> +                    1: the subcluster reads as zeros. In this case the
> +                       allocation status bit must be unset. The host
> +                       cluster offset field may or may not be set.

Why must the allocation bit be unset?  When we preallocate, we want a 
cluster to reserve space, but still read as zero, so the combination of 
both bits set makes sense to me.

> +                    0: no effect.
> +
> +                    Bits are assigned starting from the most significant one.
> +                    (i.e. bit x is used for subcluster 63 - x)

and again.

> +
> +Subcluster Allocation Bitmap (for compressed clusters):
> +
> +    Bit  0 -  63:   Reserved (set to 0)
> +                    Compressed clusters don't have subclusters,
> +                    so this field is not used.
>   
>   == Snapshots ==
>   
> diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
> index d57f409861..04eb4ce2f1 100644
> --- a/docs/qcow2-cache.txt
> +++ b/docs/qcow2-cache.txt
> @@ -1,6 +1,6 @@
>   qcow2 L2/refcount cache configuration
>   =====================================
> -Copyright (C) 2015, 2018 Igalia, S.L.
> +Copyright (C) 2015, 2018-2019 Igalia, S.L.

Our review is late; you could add 2020 if desired, now.

>   Author: Alberto Garcia <berto@igalia.com>
>   
>   This work is licensed under the terms of the GNU GPL, version 2 or
> @@ -222,3 +222,20 @@ support this functionality, and is 0 (disabled) on other platforms.
>   This functionality currently relies on the MADV_DONTNEED argument for
>   madvise() to actually free the memory. This is a Linux-specific feature,
>   so cache-clean-interval is not supported on other systems.
> +
> +
> +Extended L2 Entries
> +-------------------
> +All numbers shown in this document are valid for qcow2 images with normal
> +64-bit L2 entries.
> +
> +Images with extended L2 entries need twice as much L2 metadata, so the L2
> +cache size must be twice as large for the same disk space.
> +
> +   disk_size = l2_cache_size * cluster_size / 16
> +
> +i.e.
> +
> +   l2_cache_size = disk_size * 16 / cluster_size
> +
> +Refcount blocks are not affected by this.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


