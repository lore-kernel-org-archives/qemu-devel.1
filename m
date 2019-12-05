Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C1C2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AB221823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfoyaKI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AB221823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvmf-0002YG-1K
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icvh4-0005lm-AJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icvh1-0000z1-F7
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icvgr-0000vv-D1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575569844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orfiozfnZ5AZQzOrLmhMrDKMMXCkH0l6KBzRGzGc0rM=;
 b=GfoyaKI7gstP1QiJvJLQWSM8ehxcNe/3WJqtxYdQGDPyjjGe/17S3CPEQ4h+Jq/hElwkU1
 1V92jYQYjfJZmrNmfSFpDR8IMZhve2hR5WA6eCXfiqksKohLZtoX0SieIr+wJEU2BZ30JG
 Ej7KN8PgQ4ZGb494J0umMQWpOFcY488=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-U3y7p4R0P_amZVQYAeRWpg-1; Thu, 05 Dec 2019 13:17:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6704F800C74;
 Thu,  5 Dec 2019 18:17:20 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA216013A;
 Thu,  5 Dec 2019 18:17:19 +0000 (UTC)
Subject: Re: [PATCH v8 06/21] qdev-monitor: well form error hint helpers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0991f52e-853a-5f34-99d5-6c047593f8af@redhat.com>
Date: Thu, 5 Dec 2019 12:17:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: U3y7p4R0P_amZVQYAeRWpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, armbru@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 11:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
> switch errp paramter to Error *const * type, as it has uncommon
> behavior: not change the pointer to return error, but operate on
> already existent error object.
> Rename functions to be error_append_*_hint.

qbus_error_append_*_hint

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qdev-monitor.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 

> -static void qbus_list_dev(BusState *bus, Error **errp)
> +static void qbus_error_append_dev_list_hint(BusState *bus,
> +                                            Error *const *errp)

Or, since you copy-and-paste this commit message in v9, you could use 
*_error_append_*_hint between the commits for less one-off fixing per 
message.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


