Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F07FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B522065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRYB3JL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B522065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhIkX-0005Ae-JP
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 16:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhIjk-0004fW-DN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:14:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jhIjj-00068O-Mq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591388082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qEjKxAUBgCb+x8TkU1fA0gBcUMGXA3D7I/o28M/uW0E=;
 b=KRYB3JL4VaB7PLiaizl5AghELlDX1HIYgeYeBoldAh92gsfsXFrV2U+Mj9wDd93aZA7bFT
 M+x9TjTNUIpYHLH4Qwe2rIQROAQmqbKuJsaXL9/VNCfFbTh2+NCc6tvqMJOWqXIPWa5itf
 3qzTEWvTxAV0b5jAh6i9vd3Ckooo88s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Zvr6yqkzOFaXEdEUvL_Gqg-1; Fri, 05 Jun 2020 16:14:34 -0400
X-MC-Unique: Zvr6yqkzOFaXEdEUvL_Gqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1C0A800685;
 Fri,  5 Jun 2020 20:14:32 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5527F10013D5;
 Fri,  5 Jun 2020 20:14:32 +0000 (UTC)
Subject: Re: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate
 module
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bba065d2-cdd9-08f0-1e02-31f314ecfb0c@redhat.com>
Date: Fri, 5 Jun 2020 15:14:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604174135.11042-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 12:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> We are going to enhance qcow2 format parsing by adding more structure
> classes. Let's split format parsing from utility code.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py        | 161 +----------------------------
>   tests/qemu-iotests/qcow2_format.py | 157 ++++++++++++++++++++++++++++
>   2 files changed, 161 insertions(+), 157 deletions(-)
>   create mode 100644 tests/qemu-iotests/qcow2_format.py
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 539f5a186b..d9c41668fd 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -1,163 +1,10 @@
>   #!/usr/bin/env python3
> -
>   import sys

Pre-existing: no copyright blurb on the old file...

> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -0,0 +1,157 @@
> +import struct
> +import string
> +

It would be nice to fix that, and have one on the new file as well.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


