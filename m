Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A1AC282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99376206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 22:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSuGspRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99376206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iox19-0002y8-NP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 17:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iox0Y-0002Tp-5d
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iox0X-00089L-15
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:07:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iox0W-00088m-U4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 17:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578434844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kGeT5wxtKe56teBB7SeAyaJh8LtVo80CmHEW+rBFdA=;
 b=iSuGspRb5RSKbs8GXKAZevRsvdp4ZyAUKRd02vFlPpCTMXBaRfRKHO83RoYjYs4yhmNgv0
 sgKToA0hDkzkojeMaxyWk+EZogD2u6Y4mUfCHsv6eFrYFw1im99vzz0CeYvugpB2pGlq/k
 xB5UIzv4lKE/wYe3gB7L2tdkIhLMGcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-A3y4XiZwMF2ue-1OeqlaoA-1; Tue, 07 Jan 2020 17:07:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F9D5800D41;
 Tue,  7 Jan 2020 22:07:18 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8147E5C1BB;
 Tue,  7 Jan 2020 22:07:17 +0000 (UTC)
Subject: Re: [PATCH 1/2] qcow2: introduce Qcow2Metadata structure
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <534be317-976c-56c8-ee27-7031b40acc85@redhat.com>
Date: Tue, 7 Jan 2020 16:07:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1577447039-400109-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: A3y4XiZwMF2ue-1OeqlaoA-1
X-Mimecast-Spam-Score: 0
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/27/19 5:43 AM, Andrey Shinkevich wrote:
> The preliminary patch to provide an extendable structure for dumping
> QCOW2 metadata allocations in image.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   qapi/block-core.json | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 207 insertions(+), 1 deletion(-)
> 

> +
> +##
> +# @Qcow2BitmapTbl:
> +#

Any reason we must abbreviate instead of spelling this out as Table?

> +# QCOW2 bitmap table information
> +#
> +# @table-entries: list of bitmap table entries
> +#
> +# @location: bitmap table offset and size in image
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'Qcow2BitmapTbl',
> +  'data': {'table-entries': ['Qcow2BitmapTblEntry'],
> +           'location': 'Qcow2Allocation' } }
> +
> +##
> +# @Qcow2BitmapTblEntry:

Similar question


> +{ 'struct': 'Qcow2BitmapTblEntry',
> +  'data': {'type': 'Qcow2BitmapTblEntryType',
> +           '*cluster': 'Qcow2Allocation' } }
> +
> +##
> +# @Qcow2BitmapTblEntryType:
> +#
> +# An enumeration of cluster types in bitmap table
> +#
> +# @all-zeros: cluster should be read as all zeros

While there are multiple 'zeros' in the code base, 'zeroes' appears to 
be the more common spelling.


> @@ -215,6 +418,8 @@
>   #                       field is present if the driver for the image format
>   #                       supports it
>   #
> +# @viscera: encapsulates QCOW2 tables allocation information

Missing a '(since 5.0)' tag.  Interesting choice of name; not one I 
would have picked out of the air.  Would 'metadata' be any more of a 
reasonable name?

> +#
>   # Since: 1.4
>   #
>   ##
> @@ -223,7 +428,8 @@
>              '*image-end-offset': 'int', '*corruptions': 'int', '*leaks': 'int',
>              '*corruptions-fixed': 'int', '*leaks-fixed': 'int',
>              '*total-clusters': 'int', '*allocated-clusters': 'int',
> -           '*fragmented-clusters': 'int', '*compressed-clusters': 'int' } }
> +           '*fragmented-clusters': 'int', '*compressed-clusters': 'int',
> +           '*viscera': 'Qcow2Metadata' } }

The field is listed as optional, but the docs don't describe what 
controls whether it is present or absent.  Is that worth adding?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


