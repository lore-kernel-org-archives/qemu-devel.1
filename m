Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9BC206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfciTrmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9BC206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7jW-0001Oy-Lh
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jo7ih-0000vT-3U
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:53:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jo7if-0001so-2n
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593014026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7R1V7/AvzM+8qsf4gjyg+F8chi58KmJxzyB6Wdl/64A=;
 b=cfciTrmTCf521q/2ovxA4ymQxdwtXADyASElBaE+YuF83Wq/HqF3YQC14imsbK7ep+J735
 cnTlxdqHSu9tfMXjoC6ez/gi47gOl09pINBcLSClPgSbXNzT6/v8sfJxl+tDn5q+FbMelB
 pkAy8uUXPeTsxQMe/p1FUkg2pr0uGHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-xV8iFMJiP1WaXhQaQvc2JA-1; Wed, 24 Jun 2020 11:53:45 -0400
X-MC-Unique: xV8iFMJiP1WaXhQaQvc2JA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E03818FE860
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 15:53:44 +0000 (UTC)
Received: from work-vm (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 906F3512FE;
 Wed, 24 Jun 2020 15:53:37 +0000 (UTC)
Date: Wed, 24 Jun 2020 16:53:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
Message-ID: <20200624155335.GF2665@work-vm>
References: <20200623145506.439100-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623145506.439100-1-mst@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
> since that change makes unit tests much slower for all developers, while it's not
> a robust way to fix migration tests. Migration tests need to find
> a more robust way to discover a reasonable bandwidth without slowing
> things down for everyone.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Yeh, I'd hoped something else could provide another way but I hadn't
realised how this worked;  You don't hit auto-converge until you've done
two passes, since we're running ~100MByte of dirty memory, that means
it wont hit the autoconverge stage until
2x100MByte/1MByte bandwidth=200 seconds

I'm actually measuring 130 seconds, which seems sane to me, since
there's a lot of overlap; so yeh we need to find a different way to set
this up.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> ---
>  tests/qtest/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index dc3490c9fa..21ea5ba1d2 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
> -    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
> +    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
>  
>      /* To check remaining size after precopy */
>      migrate_set_capability(from, "pause-before-switchover", true);
> -- 
> MST
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


