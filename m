Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA40C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263D520679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWcX8z1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263D520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDstR-0004mN-Bn
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jDrNh-0007gi-OI
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jDrNf-0005F3-GH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:10:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jDrNf-000547-Av
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 11:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584371414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfGd9xKvwNXlcDZ+fm3+orD1Aux3z5WgdpEb/HIGigM=;
 b=TWcX8z1mBk1OXo9HXbjxi+xprmoDZb2Tx2GelvwLZaax2I8J156dB7uM7osnLmQQHAaLgq
 VAhoMcWOI8ZVTNusGnNzlEvS/rxHLMFERuKFRYInViEPlGbYA7FZy5rF3OTvYUQ8QEAXO4
 Id0czy30yaREU47GFqoFIS7rVls1Y04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-UUzhDEdDP8KyRCfSD3qTNw-1; Mon, 16 Mar 2020 11:10:12 -0400
X-MC-Unique: UUzhDEdDP8KyRCfSD3qTNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49175102C8D5;
 Mon, 16 Mar 2020 15:10:10 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD8B91001B34;
 Mon, 16 Mar 2020 15:10:09 +0000 (UTC)
Subject: Re: [PATCH v3 01/34] qemu-doc: Belatedly document QMP command arg &
 result deprecation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <25da4d26-094d-e74c-d0d6-8e159c96191f@redhat.com>
Date: Mon, 16 Mar 2020 10:10:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315144653.22660-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 9:46 AM, Markus Armbruster wrote:
> A number of deprecated QMP arguments and results were missed in commit
> eb22aeca65 "docs: document deprecation policy & deprecated features in
> appendix" (v2.10.0):
> 

> 
> Since then, we missed a few more:
> 
> * Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.1.0)
>    deprecated block-commit arguments @base and @top.
> 
> * Commit 4db6ceb0b5 "block/dirty-bitmap: add recording and busy
>    properties" (v4.0.0) deprecated query-named-block-nodes result
>    @dirty-bitmaps member @status, not just query-block.
> 
> Make up for all that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/system/deprecated.rst | 48 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 44 insertions(+), 4 deletions(-)

Should we remove any of these features that have been deprecated long 
enough?  But that can be separate, having this patch just add mention 
that was previously forgotten is fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


