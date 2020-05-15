Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B768B20727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7FvgNjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B768B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeCP-0001WE-Vn
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeBJ-0000O6-2D
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:31:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZeBI-0001vX-91
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589563890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPcEtRrxrVfJocKoflV6kb8Wr1wsfvdPIIaiDWwj8ws=;
 b=e7FvgNjoQB4LN1K1M6iuFSo/BK7O182sUAOx3dLewtBKzqUOXfWW9vWOJr4I3NyBolAe6d
 wFULJskb3vtFOmAT0Ht3zq47YAPzjMGJYlP/PsqQmZiupwmEZns/bYsjhErnUcqJKv9fIm
 mp6ByMRqOBwVKFTNlhxybjd3j6medFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405--jL3b5WhOi6IGVWzXqCGLQ-1; Fri, 15 May 2020 13:31:26 -0400
X-MC-Unique: -jL3b5WhOi6IGVWzXqCGLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374778014D7;
 Fri, 15 May 2020 17:31:25 +0000 (UTC)
Received: from [10.3.114.84] (ovpn-114-84.phx2.redhat.com [10.3.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC09F600F5;
 Fri, 15 May 2020 17:31:24 +0000 (UTC)
Subject: Re: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
To: Raphael Pour <raphael.pour@hetzner.com>, qemu-devel@nongnu.org
References: <158946069407.13639.5714365663552293557@45ef0f9c86ae>
 <ece77427-d918-d766-b2bc-08cf7d4660bc@redhat.com>
 <d8ddc993-9816-836e-a3de-c6edab9d9c49@hetzner.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8e552e6c-a291-f309-c684-e6ceafe47eaa@redhat.com>
Date: Fri, 15 May 2020 12:31:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d8ddc993-9816-836e-a3de-c6edab9d9c49@hetzner.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 1:36 AM, Raphael Pour wrote:
>>From e5749541494abcdcaa37d752172741e1bc38e984 Mon Sep 17 00:00:00 2001
> From: Raphael Pour <raphael.pour@hetzner.com>
> Date: Fri, 15 May 2020 08:30:50 +0200
> Subject: [PATCH] qemu-nbd: Close inherited stderr
> 
> Close inherited stderr of the parent if fork_process is false.
> Otherwise no one will close it. (introduced by e6df58a5)
> 
> Signed-off-by: Raphael Pour <raphael.pour@hetzner.com>
> ---
>   qemu-nbd.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Thanks. It might have been easier posting this as a standalone v3 rather 
than buried in reply to v2, but I have now queued it to go in through my 
NBD tree (I plan on doing a pull request Monday).

I've also taken the liberty to amend the commit message as follows, to 
give more context into why the fix is needed:

     qemu-nbd: Close inherited stderr

     Close inherited stderr of the parent if fork_process is false.
     Otherwise no one will close it. (introduced by e6df58a5)

     This only affected 'qemu-nbd -c /dev/nbd0'.

     Signed-off-by: Raphael Pour <raphael.pour@hetzner.com>
     Message-Id: <d8ddc993-9816-836e-a3de-c6edab9d9c49@hetzner.com>
     Reviewed-by: Eric Blake <eblake@redhat.com>
     [eblake: Enhance commit message]
     Signed-off-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


