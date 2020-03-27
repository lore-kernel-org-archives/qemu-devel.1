Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A621C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E502082D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XESwfyqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E502082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHoeR-0007sW-JZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 09:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHode-0007SV-Dk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHodc-0003m5-98
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:03:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHodb-0003jL-V1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585314183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXEGQdW7jUMoHIRWi7oKF7yHYQVCVXxsGoM5LfrEDLs=;
 b=XESwfyqUsVFJXeWrfOcnLUaTNUCBJbxULMbF2UhhNu8ZhnF0SLhlR3dIPEQ9SQMcuPJAsC
 Iacw7HTxCXNEFS0E5t3nv7kBM71wtn8tx7YLCSlzH2jRp6aPBaL0qiPqrteeUGChBRZBve
 CGaf6vPl0jjoCPhR2caI3NrefIVarsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-p3Z2IlQ_OhChBJwKkc3f_w-1; Fri, 27 Mar 2020 09:03:01 -0400
X-MC-Unique: p3Z2IlQ_OhChBJwKkc3f_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A0A98017DF;
 Fri, 27 Mar 2020 13:03:00 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5663E1001B07;
 Fri, 27 Mar 2020 13:02:59 +0000 (UTC)
Subject: Re: [PATCH] monitor/hmp-cmds: add units for mirate_parameters.
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d5576e1b-24bf-2f68-b58c-c9edf37c3f4c@redhat.com>
Date: Fri, 27 Mar 2020 08:02:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 2:32 AM, Mao Zhongyi wrote:

In the subject: s/mirate/migrate/

> When running:
> (qemu) info migrate_parameters
> announce-initial: 50 ms
> announce-max: 550 ms
> announce-step: 100 ms
> compress-wait-thread: on
> ...
> max-bandwidth: 33554432 bytes/second
> downtime-limit: 300 milliseconds
> x-checkpoint-delay: 20000
> ...
> xbzrle-cache-size: 67108864
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


