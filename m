Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288F62067B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkrPKwHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288F62067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3sq-0003QB-6h
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc3rV-00026K-E2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc3rS-0005i5-Ee
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604915597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CM6/dZc+cX9dCGBB/uloPgqYimw1JApK4H5qSBPnPpA=;
 b=YkrPKwHkXfe64E+UQZHBSl5XIsLSLylA3k9Y8B/0/aZvIECtH2aV1f9a+veeHn6X0u3Z4W
 RLVvgiXjng/pvfyH8d3dvp3Gk4HdYYrxhunO+tLz7YvGu+wBf4roMap36yfaTH8BX9q+jD
 bRRepdu2exDQ7+1yC/B3NZAuveWUAOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-3bEu1rdfO1KpL9VHeL6qHQ-1; Mon, 09 Nov 2020 04:53:13 -0500
X-MC-Unique: 3bEu1rdfO1KpL9VHeL6qHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 331038015FA;
 Mon,  9 Nov 2020 09:53:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC2D62A14;
 Mon,  9 Nov 2020 09:53:10 +0000 (UTC)
Subject: Re: [PATCH] block: Fix some code style problems, "foo* bar" should be
 "foo *bar"
To: shiliyang <shiliyang@huawei.com>, kwolf@redhat.com
References: <b7e77b38-6115-9a3d-5668-f51737476400@huawei.com>
 <3211f389-6d22-46c1-4a16-e6a2ba66f070@huawei.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e798f2f7-3daf-6307-020b-32fd3e20949f@redhat.com>
Date: Mon, 9 Nov 2020 10:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3211f389-6d22-46c1-4a16-e6a2ba66f070@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30.10.20 04:35, shiliyang wrote:
> There have some code style problems be found when read the block driver code.
> So I fixes some problems of this error, ERROR: "foo* bar" should be "foo *bar".
> 
> Signed-off-by: Liyang Shi <shiliyang@huawei.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> ---
>   block/blkdebug.c |  2 +-
>   block/dmg.c      |  2 +-
>   block/qcow2.c    |  4 ++--
>   block/qcow2.h    |  6 +++---
>   block/vpc.c      | 10 +++++-----
>   5 files changed, 12 insertions(+), 12 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


