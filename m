Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679F2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7F8206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gre3Vo7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7F8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Rn-0003Dk-FH
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jg9R0-0002Lp-B5
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:06:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jg9Qz-0003Ex-In
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591113996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPH62mZD1AEzvI5aQHJ8V1H0vjdruEW3QS7rhanTJi8=;
 b=Gre3Vo7d1smMh8cV0AqGhXzdTKeK01YldzjU9dXndz7uw+I6PnMswRXKBunxdZ7Fa/H35H
 zRsPhhOQjnkHoeFJTbmAbH0dg2gAPk5g3MCcCZ1HNtRJB5QqzrUDupQQ5ElEBJcknNY/3Z
 l6sedAoddMunMkG8nfQUT3PLngv4QqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-4xVD2Y3kOBOkhsyc34X86A-1; Tue, 02 Jun 2020 12:06:08 -0400
X-MC-Unique: 4xVD2Y3kOBOkhsyc34X86A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BDCB18A0775;
 Tue,  2 Jun 2020 16:06:01 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DB925C1D6;
 Tue,  2 Jun 2020 16:05:59 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] iotests: Add extension names to qcow2.py dump
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c309df7a-2ecc-92cc-a4cc-6621a09a1c12@redhat.com>
Date: Tue, 2 Jun 2020 11:05:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591019293-211155-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 8:48 AM, Andrey Shinkevich wrote:
> Header extension:         Feature table
> magic                     0x6803f857
> length                    192
> data                      <binary>
> 
> The change incurs modification of the output in 031, 036 and 061 test
> cases.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/031.out  | 22 +++++++++++-----------
>   tests/qemu-iotests/036.out  |  4 ++--
>   tests/qemu-iotests/061.out  | 18 +++++++++---------
>   tests/qemu-iotests/qcow2.py | 23 ++++++++++++++++++++---
>   4 files changed, 42 insertions(+), 25 deletions(-)
> 

> +++ b/tests/qemu-iotests/061.out

> @@ -491,7 +491,7 @@ wrote 65536/65536 bytes at offset 2147483648
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   wrote 65536/65536 bytes at offset 3221225472
>   64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -    (0.00/100%)
>      (12.50/100%)
>      (25.00/100%)
>      (37.50/100%)
>      (50.00/100%)
>      (62.50/100%)
>      (75.00/100%)
>      (87.50/100%)
>      (100.00/100%)
>      (100.00/100%)
> +    (0.00/100%)    (12.50/100%)    (25.00/100%)    (37.50/100%)    (50.00/100%)    (62.50/100%)    (75.00/100%)    (87.50/100%)    (100.00/100%)    (100.00/100%)
>   No errors were found on the image.

This hunk looks odd.  But it is not necessarily wrong.  Occurs a couple 
of times.

> +++ b/tests/qemu-iotests/qcow2.py
> @@ -6,19 +6,36 @@ import string
>   
>   class QcowHeaderExtension:
>   
> +    QCOW2_EXT_MAGIC_BACKING_FORMAT = 0xE2792ACA
> +    QCOW2_EXT_MAGIC_FEATURE_TABLE = 0x6803f857

Why the inconsistency between capitalization in these constants?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


