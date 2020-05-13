Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8092CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7481A206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaFkKBZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7481A206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpct-0004QS-Ik
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYpRl-0001vp-3H
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:21:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYpRi-0006R5-M5
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuEqRupYE5OjBe7MH68MRWjpGHUpJmPaF+5jOcJraX0=;
 b=DaFkKBZJL7vQbxd4K6Xj4CJl2xasCpYVkwgdiYziYsQKYm77CALPLSvK8afVJPjfWb3vCV
 s0CCjzFoSsVokcv1Mg7N42sC4kQh6lQjRhanKe8AfOeZthbn5EWtgiTgPqdwKppufcU2hX
 a1EmKA+hUpMLNhvrRT/98Qqhx74yPtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-ENMldBJzNlO9ZztFobBqFg-1; Wed, 13 May 2020 07:21:03 -0400
X-MC-Unique: ENMldBJzNlO9ZztFobBqFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB2DB100CCC2;
 Wed, 13 May 2020 11:21:02 +0000 (UTC)
Received: from kaapi (unknown [10.74.9.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 145F26E6FC;
 Wed, 13 May 2020 11:20:57 +0000 (UTC)
Date: Wed, 13 May 2020 16:50:52 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] megasas: use unsigned type for reply_queue_head
In-Reply-To: <CAFEAcA8Y67h_Kc=M2i5xGz-sQpJwZ++n8wB8szdv0ziViUfmqw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.2005131647000.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <20200507105718.1319187-2-ppandit@redhat.com>
 <CAFEAcA8Y67h_Kc=M2i5xGz-sQpJwZ++n8wB8szdv0ziViUfmqw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 12 May 2020, Peter Maydell wrote --+
| > +    uint16_t reply_queue_head;
| 
| Using a 16-bit type here means that code like this:
| 
|     s->reply_queue_head = ldl_le_pci_dma(pcid, s->producer_pa);
|     s->reply_queue_head %= MEGASAS_MAX_FRAMES;
| 
| suddenly does a truncation of the 32-bit loaded value before
| the modulus operation, which is a bit odd, though since
| MEGASAS_MAX_FRAMES happens to be a power of 2 the end
| result won't change.

Yes, 16-bit also for its range of value is limitted to MEGASAS_MAX_FRAMES=2048.
 
| It's also a bit weird to change reply_queue_head's type
| but not reply_queue_tail or reply_queue_len.

That's in the second patch.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


