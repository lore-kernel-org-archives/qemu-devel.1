Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FA9C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2509E2064A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg3dhZ8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2509E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyAj-0003IN-7T
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVyA3-0002YF-Ml
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:03:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jVyA1-0007wf-7C
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588687380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWcxnVLFK4nmVscBRZrQ+DSnmddrmJNBE1g9bW+1Jss=;
 b=Sg3dhZ8n3+AU7HyI5uO+LzJmF7h30Vp9AHswGp/BC9XGwdzcpdPDq0Gs8gMUqhoPo7unNX
 vKOrRdOuzbKjr6I1vvJZdc0OdP0wsJmaQabx4aD0bYXSHZhb9K/u5sCViD4vrN0KWftJtU
 yBr5ZQl04X1y0FzUP+mW9rjA6ptBpNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-w03ej_LRPBCyFGmcNz07cA-1; Tue, 05 May 2020 10:02:52 -0400
X-MC-Unique: w03ej_LRPBCyFGmcNz07cA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05AC80183C;
 Tue,  5 May 2020 14:02:51 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 988265D9D5;
 Tue,  5 May 2020 14:02:51 +0000 (UTC)
Subject: Re: [PATCH] iotests/055: Use cache.no-flush for vmdk target
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200505064618.16267-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8f0e1827-09f0-7c97-011e-efb7592607a4@redhat.com>
Date: Tue, 5 May 2020 09:02:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505064618.16267-1-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 1:46 AM, Kevin Wolf wrote:
> 055 uses the backup block job to create a compressed backup of an
> $IMGFMT image with both qcow2 and vmdk targets. However, cluster
> allocation in vmdk is very slow because it flushes the image file after
> each L2 update.
> 
> There is no reason why we need this level of safety in this test, so
> let's disable flushes for vmdk. For the blockdev-backup tests this is
> achieved by simply adding the cache.no-flush=on to the drive_add() for
> the target. For drive-backup, the caching flags are copied from the
> source node, so we'll also add the flag to the source node, even though
> it is not vmdk.
> 
> This can make the test run significantly faster (though it doesn't make
> a difference on tmpfs). In my usual setup it goes from ~45s to ~15s.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/055 | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


