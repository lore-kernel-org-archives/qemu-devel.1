Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B755EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3222C2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7rqZ839"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3222C2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7Uz-0002lI-2X
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc7Pn-0006kZ-Od
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:41:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kc7Pl-0001Jp-Qw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYmBXwN6RuPXc6s/3jx/jr6UDT8z+j2zKrqPmFDeEUA=;
 b=h7rqZ839V/2eFVqSwEtPE+EvmpauPe6hMFkQfhnu9YR9rh69aIsgry/Msf2Hc/PGR/O8ZK
 KZgtqNGwKJAuRiYcL2nFfBUsPZDBoKB8zwCyVewL5bsMAdRQnJE7DXTpH7qtkwiNDSDLHb
 evgFVS9sXfTpuSbMwDRbv01T83oGXRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-K2SZ4BAyOAW6hOgPPZG1aA-1; Mon, 09 Nov 2020 08:40:54 -0500
X-MC-Unique: K2SZ4BAyOAW6hOgPPZG1aA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742BF801FDE;
 Mon,  9 Nov 2020 13:40:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2485760C56;
 Mon,  9 Nov 2020 13:40:50 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] block: drop tighten_restrictions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
 <20201106124241.16950-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d8ded6ef-fd4d-6c8b-1f57-d81e1675f080@redhat.com>
Date: Mon, 9 Nov 2020 14:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106124241.16950-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, berto@igalia.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.11.20 13:42, Vladimir Sementsov-Ogievskiy wrote:
> The only users of this thing are:
>   1. bdrv_child_try_set_perm, to ignore failures on loosen restrictions
>   2. assertion in bdrv_replace_child
>   3. assertion in bdrv_inactivate_recurse
> 
> Assertions are not enough reason for overcomplication the permission
> update system. So, look at bdrv_child_try_set_perm.
> 
> We are interested in tighten_restrictions only on failure. But on
> failure this field is not reliable: we may fail in the middle of
> permission update, some nodes are not touched and we don't know should
> their permissions be tighten or not. So, we rely on the fact that if we
> loose restrictions on some node (or BdrvChild), we'll not tighten
> restriction in the whole subtree as part of this update (assertions 2
> and 3 rely on this fact as well). And, if we rely on this fact anyway,
> we can just check it on top, and don't pass additional pointer through
> the whole recursive infrastructure.
> 
> Note also, that further patches will fix real bugs in permission update
> system, so now is good time to simplify it, as a help for further
> refactorings.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block.c | 88 +++++++++++----------------------------------------------
>   1 file changed, 17 insertions(+), 71 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


