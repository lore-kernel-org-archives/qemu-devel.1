Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F85AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E295722370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHZC0M3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E295722370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyum-0006bP-31
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZycp-0004Tq-A1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:53:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZycm-0008O3-1U
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604418806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvogv/zGwg3nacSEYlK24KMhbxoTlaXr3ZZ8FhJ1LHQ=;
 b=XHZC0M3TAOKwFPv9TMylao7d+dOndZ1O6fAXnf7nKnR4x2SL9h9koDWGZMa/dRJPlvuRwi
 Ei+NzoWyshLxuja6w8Jp+Lr4i9kkTeJjbHwInNerW9oMI6WrNpnPfMBYQopysEFJ4/TtFb
 VOv/wEOkmrcsi21z+UJSQP55x59qw50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-6jKc1TDtNtm-OdrEABJEiw-1; Tue, 03 Nov 2020 10:53:18 -0500
X-MC-Unique: 6jKc1TDtNtm-OdrEABJEiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0A6064155;
 Tue,  3 Nov 2020 15:53:17 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.195.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BB055B4B6;
 Tue,  3 Nov 2020 15:53:15 +0000 (UTC)
Subject: Re: [PATCH v2] qcow2: Document and enforce the QCowL2Meta invariants
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20201007161323.4667-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b1af7494-15da-cd1f-1bd3-fb9480608a4e@redhat.com>
Date: Tue, 3 Nov 2020 16:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007161323.4667-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.10.20 18:13, Alberto Garcia wrote:
> The QCowL2Meta structure is used to store information about a part of
> a write request that touches clusters that need changes in their L2
> entries. This happens with newly-allocated clusters or subclusters.
> 
> This structure has changed a bit since it was first created and its
> current documentation is not quite up-to-date.
> 
> A write request can span a region consisting of a combination of
> clusters of different types, and qcow2_alloc_host_offset() can
> repeatedly call handle_copied() and handle_alloc() to add more
> clusters to the mix as long as they all are contiguous on the image
> file.
> 
> Because of this a write request has a list of QCowL2Meta structures,
> one for each part of the request that needs changes in the L2
> metadata.
> 
> Each one of them spans nb_clusters and has two copy-on-write regions
> located immediately before and after the middle region touched by that
> part of the write request. Even when those regions themselves are
> empty their offsets must be correct because they are used to know the
> location of the middle region.
> 
> This was not always the case but it is not a problem anymore
> because the only two places where QCowL2Meta structures are created
> (calculate_l2_meta() and qcow2_co_truncate()) ensure that the
> copy-on-write regions are correctly defined, and so do assertions like
> the ones in perform_cow().
> 
> The conditional initialization of the 'written_to' variable is
> therefore unnecessary and is removed by this patch.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h         | 19 +++++++++++--------
>  block/qcow2-cluster.c |  5 +++--
>  block/qcow2.c         | 19 +++++++++++++++----
>  3 files changed, 29 insertions(+), 14 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


