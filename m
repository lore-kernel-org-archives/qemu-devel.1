Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DBC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C678820661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez1OPulu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C678820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTvx-0004Hj-UU
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYTvG-0003bu-NX
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:22:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYTvF-0003cp-Pi
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589286128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVjh1fUqEHRpKtJHi5GiqdeGtGkJSiYif7/DKL042Cs=;
 b=ez1OPuluRFGrmzr0JNxV02DlehnVDwWSwp9v3NULV/Fo1cGwXoiETl8jR/Z0IAowze5MDq
 Ka1UMAwa75Gzsflg7IEEcP7uhci4QMzq9YVvLQTo9LpbDmEL4gV00x9cPQflBwahKvYG+w
 cfG7+gaWrGRjrplzqd4ckS3zJDwm4Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-iLieCZL7N2OlhmcSfjnFkA-1; Tue, 12 May 2020 08:22:06 -0400
X-MC-Unique: iLieCZL7N2OlhmcSfjnFkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64EA4107ACF2;
 Tue, 12 May 2020 12:22:05 +0000 (UTC)
Received: from kaapi (unknown [10.40.193.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0E93100034E;
 Tue, 12 May 2020 12:22:02 +0000 (UTC)
Date: Tue, 12 May 2020 17:51:59 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
In-Reply-To: <20200507105718.1319187-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2005121750580.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Ren Ding <rding@gatech.edu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 7 May 2020, P J P wrote --+
| Hello,
| 
| * This series fixes an OOB access issue which may occur when a guest user
|   sets 's->reply_queue_head' field to a negative(or large positive) value,
|   via 'struct mfi_init_qinfo' object in megasas_init_firmware().
| 
| * Second patch updates other numeric fields of MegasasState to unsigned type.
| 
| Thank you.
| ---
| Prasad J Pandit (2):
|   megasas: use unsigned type for reply_queue_head
|   megasas: use unsigned type for positive numeric fields
| 
|  hw/scsi/megasas.c | 40 ++++++++++++++++++++--------------------
|  1 file changed, 20 insertions(+), 20 deletions(-)

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


