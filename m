Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E7C2BB84
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D5922403
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOCCWE14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D5922403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIb6A-0003yB-9Z
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 13:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIb4T-0002lG-5y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:18:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kIb4Q-00006b-SM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 13:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600276693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YxwmUV9PFeFO5bihGt/woh/fWj8+U8dQiAeznkCW3Qg=;
 b=hOCCWE14fAFRa8n75W7qVcU1hUs9VgaQLLcy40sBiG7tjzR4+dSfuJA39PHev4Bos8yV7y
 JKe6JXLxivKz5G6YSUhYnOKs1qZ63F2L+hbA7Th/4K7rJwKnROP9pn/MgEMoPsUFTpubBY
 Pq0aeJwK4o+dXQ9JOZqMXUKyJaunPy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-2YNd8GHYP9KI6hGIHEia1w-1; Wed, 16 Sep 2020 13:18:09 -0400
X-MC-Unique: 2YNd8GHYP9KI6hGIHEia1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0978186DD23;
 Wed, 16 Sep 2020 17:18:07 +0000 (UTC)
Received: from kaapi (ovpn-112-169.phx2.redhat.com [10.3.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 522AA78809;
 Wed, 16 Sep 2020 17:18:05 +0000 (UTC)
Date: Wed, 16 Sep 2020 22:48:02 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
In-Reply-To: <20200903183138.2161977-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.78.906.2009162247070.10832@xnncv>
References: <20200903183138.2161977-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 13:09:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 4 Sep 2020, P J P wrote --+
| From: Prasad J Pandit <pjp@fedoraproject.org>
| 
| When cancelling an i/o operation via ide_cancel_dma_sync(),
| a block pointer may be null. Add check to avoid null pointer
| dereference.
| 
|  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fide_nullptr1
|  ==1803100==Hint: address points to the zero page.
|  #0 blk_bs ../block/block-backend.c:714
|  #1 blk_drain ../block/block-backend.c:1715
|  #2 ide_cancel_dma_sync ../hw/ide/core.c:723
|  #3 bmdma_cmd_writeb ../hw/ide/pci.c:298
|  #4 bmdma_write ../hw/ide/piix.c:75
|  #5 memory_region_write_accessor ../softmmu/memory.c:483
|  #6 access_with_adjusted_size ../softmmu/memory.c:544
|  #7 memory_region_dispatch_write ../softmmu/memory.c:1465
|  #8 flatview_write_continue ../exec.c:3176
|  ...
| 
| Reported-by: Ruhr-University <bugs-syssec@rub.de>
| Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| ---
|  hw/ide/core.c | 1 +
|  hw/ide/pci.c  | 5 ++++-
|  2 files changed, 5 insertions(+), 1 deletion(-)
| 
| Update v2: use an assert() call
|  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.html
| 
| diff --git a/hw/ide/core.c b/hw/ide/core.c
| index f76f7e5234..8105187f49 100644
| --- a/hw/ide/core.c
| +++ b/hw/ide/core.c
| @@ -718,6 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
|       * whole DMA operation will be submitted to disk with a single
|       * aio operation with preadv/pwritev.
|       */
| +    assert(s->blk);
|      if (s->bus->dma->aiocb) {
|          trace_ide_cancel_dma_sync_remaining();
|          blk_drain(s->blk);
| diff --git a/hw/ide/pci.c b/hw/ide/pci.c
| index b50091b615..b47e675456 100644
| --- a/hw/ide/pci.c
| +++ b/hw/ide/pci.c
| @@ -295,7 +295,10 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
|      /* Ignore writes to SSBM if it keeps the old value */
|      if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
|          if (!(val & BM_CMD_START)) {
| -            ide_cancel_dma_sync(idebus_active_if(bm->bus));
| +            IDEState *s = idebus_active_if(bm->bus);
| +            if (s->blk) {
| +                ide_cancel_dma_sync(s);
| +            }
|              bm->status &= ~BM_STATUS_DMAING;
|          } else {
|              bm->cur_addr = bm->addr;


Ping...! (needs review)
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


