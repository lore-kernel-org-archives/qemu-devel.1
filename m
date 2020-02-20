Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6252C11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832E9207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsGZFyL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832E9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nhG-0001KM-MG
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4ngZ-0000MS-BS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4ngY-0002Me-9W
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:24:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4ngY-0002MG-55
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582212257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vqhN619sXaUMI2jy+9H8P33nxD7cZcEuXAotBuYdok=;
 b=WsGZFyL34+uWGn+brf2agc1rN2D4l/QjnoPJLZX98FMiqGJEr7nzKMsXGoYzgVXbNWYQiU
 dV8FoEBA/tbjA2D0OE08oO5FsPDXPSmId9yMYJkoBebYXa8LVSyFxV3pGQKTi7+1JfGCGe
 5DRnC8l3GVnmd5gH+VqHOk1G+7m7tqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-PfaOqCgzODmIvvB_I5j--Q-1; Thu, 20 Feb 2020 10:24:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694E48DF5E4;
 Thu, 20 Feb 2020 15:24:10 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC3C686815;
 Thu, 20 Feb 2020 15:24:08 +0000 (UTC)
Subject: Re: [RFC PATCH v3 06/27] qcow2: Add dummy has_subclusters() function
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <bebe4058df5210ac3293e917ad6b61abac398f60.1577014346.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5480ed47-7e2e-764a-9efb-9e9e6e699e44@redhat.com>
Date: Thu, 20 Feb 2020 09:24:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bebe4058df5210ac3293e917ad6b61abac398f60.1577014346.git.berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: PfaOqCgzODmIvvB_I5j--Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/22/19 5:36 AM, Alberto Garcia wrote:
> This function will be used by the qcow2 code to check if an image has
> subclusters or not.
> 
> At the moment this simply returns false. Once all patches needed for
> subcluster support are ready then QEMU will be able to create and
> read images with subclusters and this function will return the actual
> value.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 6823d3f68f..1db3fc5dbc 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -495,6 +495,12 @@ typedef enum QCow2MetadataOverlap {
>   
>   #define INV_OFFSET (-1ULL)
>   
> +static inline bool has_subclusters(BDRVQcow2State *s)
> +{
> +    /* FIXME: Return false until this feature is complete */
> +    return false;
> +}
> +
>   static inline uint64_t get_l2_entry(BDRVQcow2State *s, uint64_t *l2_slice,
>                                       int idx)
>   {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


