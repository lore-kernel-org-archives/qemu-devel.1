Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F4C433F2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1B920771
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHk16dHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1B920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxmk-0007L2-EJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juxm7-0006pH-Tg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:41:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juxm6-0002JH-2g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594644097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0kaOHztGH4ZHU+GBjCanJyU6n2U1dT4EFNuVUQ0iiE=;
 b=DHk16dHTvy2hYbB2tJB09/FBn03F47ctHmqQneg6ZQPpru08P9PWlV/12ECje/uA7xZ8N0
 gjRUe0CAY3lTEkD9PVL85T25X9HvNlE6YIXz7L5g8Ji7hugzYp6X2ZC7d6UNpzMahFJV/Y
 cy1D0p8lQ5Yq/E4+bA3NczbC5DtvKEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-fXNQnfWcMGe0m-Tu8XZJeA-1; Mon, 13 Jul 2020 08:41:33 -0400
X-MC-Unique: fXNQnfWcMGe0m-Tu8XZJeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FE2680BCAA;
 Mon, 13 Jul 2020 12:41:31 +0000 (UTC)
Received: from [10.3.112.134] (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF42D5BAD5;
 Mon, 13 Jul 2020 12:41:30 +0000 (UTC)
Subject: Re: [PATCH v9 00/10] iotests: Dump QCOW2 dirty bitmaps metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f3a12181-8344-90b9-8c78-4a33263a2d53@redhat.com>
Date: Mon, 13 Jul 2020 07:41:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 7/13/20 2:27 AM, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in the qcow2_format.py.
> 
> v9:
>    01: In patch 0003, removed explicit constructor in the class Qcow2BitmapExt.
>    02: In patch 0004, the format string was changed.
>   
> 
> Andrey Shinkevich (10):
>    qcow2: Fix capitalization of header extension constant.
>    qcow2_format.py: make printable data an extension class member
>    qcow2_format.py: change Qcow2BitmapExt initialization method
>    qcow2_format.py: dump bitmap flags in human readable way.
>    qcow2_format.py: Dump bitmap directory information
>    qcow2_format.py: pass cluster size to substructures
>    qcow2_format.py: Dump bitmap table serialized entries
>    qcow2.py: Introduce '-j' key to dump in JSON format
>    qcow2_format.py: collect fields to dump in JSON format
>    qcow2_format.py: support dumping metadata in JSON format
> 
>   block/qcow2.c                      |   2 +-
>   docs/interop/qcow2.txt             |   2 +-
>   tests/qemu-iotests/291.out         |  90 ++++++++++++++++

Test 291 no longer outputs bitmap metadata (see commit 24b861c038); 
which means your patches to 291.out don't make sense.  You'll want to 
respin this to follow the advice in that commit of having a separate 
iotest just for qcow2.py output testing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


