Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFECAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB43A2078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwXsXmJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB43A2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKMYc-0007Ci-Rr
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKMXg-0006JM-2D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKMXf-0003tb-1A
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:39:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKMXe-0003tI-Ta
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585921166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LFf5S60hh4aoIBnSJ56VUr02qB1rzy3wiVeTGa6KS4I=;
 b=JwXsXmJHYcAjnoWct1Rv4MZm92IPt0ghrW6leeoOTV6yRQJgRKNHDXdvR7240mTBy+EUdo
 Ofk0yC8rsvj5KFA0g1IAuCfrIFivtjzPz9EfaYT0nzNBc3Ncf9t4Z+2osHaccyG1BaUNiA
 Hsb5Su+3EnIk60eNlJ+1byF4YO+VtIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Fgrycq5QNL2WJ46vx81hgQ-1; Fri, 03 Apr 2020 09:39:21 -0400
X-MC-Unique: Fgrycq5QNL2WJ46vx81hgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D128149C2;
 Fri,  3 Apr 2020 13:39:20 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE3F31001B30;
 Fri,  3 Apr 2020 13:39:19 +0000 (UTC)
Subject: Re: [PATCH] iotests/common.pattern: Quote echos
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200403101134.805871-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4ebf9849-ad4a-3eb7-e265-1d8f933324ea@redhat.com>
Date: Fri, 3 Apr 2020 08:39:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403101134.805871-1-mreitz@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 5:11 AM, Max Reitz wrote:
>>From time to time, my shell decides to repace the bracketed numbers here
> by the numbers inside (i.e., "=== Clusters to be compressed [1]" is
> printed as "=== Clusters to be compressed 1").  That makes tests that

Namely, any time your environment has a file named '1' in the directory 
where you are running iotests.

> use common.pattern fail.  Prevent that from happening by quoting the
> arguments to all echos in common.pattern.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/common.pattern | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/common.pattern
> index 4f5e5bcea0..4caa5de187 100644
> --- a/tests/qemu-iotests/common.pattern
> +++ b/tests/qemu-iotests/common.pattern
> @@ -23,7 +23,7 @@ do_is_allocated() {
>       local count=$4
>   
>       for ((i=1;i<=$count;i++)); do
> -        echo alloc $(( start + (i - 1) * step )) $size
> +        echo "alloc $(( start + (i - 1) * step )) $size"

No real change on this line because $size is safe, but also no harm at 
being consistent, and makes it easier to not have to audit $size for 
being safe.

>       # Write the clusters to be compressed
> -    echo === Clusters to be compressed [1]
> +    echo '=== Clusters to be compressed [1]'

This one is definitely needed to avoid inadvertent globbing.

>       # Read them
> -    echo === Read used/compressed clusters
> +    echo '=== Read used/compressed clusters'

And this one does not buy any safety, but again consistency doesn't hurt.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


