Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5124C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBDF2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiIAht3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBDF2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmhB-0000IV-VX
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwmgS-00080y-I1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwmgR-0001nW-MT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:43:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwmgR-0001nH-IB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580301783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=FvXvAkmqhrZHFv0sRmyOkcUOeluyCy7+nBqCOIBqqpU=;
 b=OiIAht3nXSyUmlsekYzzEo6H0HUKzRT4iyQuxPPyevb6h0pQTotF9nf32fPYPbtflFpEtD
 K63sQT9PkoNBhpr642kzFBfq4SeRqi33ZF3K2/Sw5cg6FVA8RdQhUCCa8gyLK0I/mPcAd7
 i4lNvXV6ZFQ4Gf4Si1dao6s1eE1OFlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-6HCQ_vdXOfKaS87q-vHMaQ-1; Wed, 29 Jan 2020 07:42:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7726F107ACC5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 12:42:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B644688834;
 Wed, 29 Jan 2020 12:42:57 +0000 (UTC)
Subject: Re: [PATCH 0/2] net: Drop legacy "name" from -net and remove NetLegacy
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <20191206053640.29368-1-thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <03e4ddf8-dfa9-8e41-72fe-fd0363188c58@redhat.com>
Date: Wed, 29 Jan 2020 13:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206053640.29368-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6HCQ_vdXOfKaS87q-vHMaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/12/2019 06.36, Thomas Huth wrote:
> It's time to remove the deprecated "name" parameter from -net.
> 
> Please have a closer look at the second patch ... I think it should be
> fine, but I'm not 100% sure whether it's ok for all cases to drop NetLegacy,
> so please double-check.
> 
> Thomas Huth (2):
>   net: Drop the legacy "name" parameter from the -net option
>   net: Drop the NetLegacy structure, always use Netdev instead
> 
>  net/net.c            | 84 +++++++-------------------------------------
>  qapi/net.json        | 53 +---------------------------
>  qemu-deprecated.texi | 12 ++++---
>  3 files changed, 20 insertions(+), 129 deletions(-)

Ping?

 Thomas


