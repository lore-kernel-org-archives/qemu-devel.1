Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5D12072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuTay27E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5D12072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYro-0008LD-A0
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jMYqy-0007Rq-10
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jMYqw-0002hm-UJ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:12:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jMYqw-0002hO-Qk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586445146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUfG0198tCse+qrgUkKq2eWyxNFi1WwoEqSa2S+HeJs=;
 b=FuTay27EMjkffcJmvlK5af+TZEAo8w64nOshkAC0KTLL6arevL4m9t4l3tSXpkXKaithI1
 blbHLPUOq51V0H+uBaZnxzi72F1+e6/XeQBvjCGNJkWHKfkpwopUu+7Iu/ige3EzZ0MrtW
 +9sPq23FaHSlM94Himvj+LemGrmjEAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-dDb9qoXjNqm4hx1wDF5USg-1; Thu, 09 Apr 2020 11:12:20 -0400
X-MC-Unique: dDb9qoXjNqm4hx1wDF5USg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5F21005509;
 Thu,  9 Apr 2020 15:12:18 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 265DB10013A1;
 Thu,  9 Apr 2020 15:12:17 +0000 (UTC)
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
Date: Thu, 9 Apr 2020 10:12:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
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

On 3/17/20 1:16 PM, Alberto Garcia wrote:
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
> 

> +== Extended L2 Entries ==
> +
> +An image uses Extended L2 Entries if bit 4 is set on the incompatible_features
> +field of the header.
> +
> +In these images standard data clusters are divided into 32 subclusters of the
> +same size. They are contiguous and start from the beginning of the cluster.
> +Subclusters can be allocated independently and the L2 entry contains information
> +indicating the status of each one of them. Compressed data clusters don't have
> +subclusters so they are treated the same as in images without this feature.
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

Hmm - raw external files are incompatible with backing files.  Should we 
also document that extended L2 entries are incompatible with raw 
external files?  (The text here reminded me about it, but it would be 
the text earlier at the incompatible feature bits that we edit if we 
want that additional restriction; compare to the restriction in the 
autoclear bit 1).  After all, when raw external file is enabled, the 
entire image is allocated, at which point subclusters don't make much sense.

And in stating that, it looks like we have a pre-existing hole in that 
header bytes 8-15 don't mention the incompatibility with autoclear (when 
things are incompatible, it's best to mention the restriction from both 
sides, rather than only one of the sides, to make sure the reader 
notices the restriction regardless of which field they look up first). 
But tweaking that would be a separate patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


