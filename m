Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBAC20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik8f7vBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBAC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUVj-0007vJ-1i
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgUUz-0007N2-RN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:36:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jgUUw-0005Sy-P9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591194964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGpF+TaOk5L0CyYti80AWYHu6h/shp3aOggYFlntv2Q=;
 b=ik8f7vBk+EXqDd6b2n7WePgtAIqG4/Bd0s/dOxH2CdGLfVmK4ckUg09RQGbDhcXq3hpqLz
 9fKMTYu0x7uAuM0vt48KNUXFh6WMIOTaeYKdkeen+Wq0GK2svqBjFXfZn+tSHXHBIufO72
 WbHJgdThpcEyM+gt/YA2CpqGx5ZVPWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-ZnQHrChTPVKTaHN7-rnABg-1; Wed, 03 Jun 2020 10:36:01 -0400
X-MC-Unique: ZnQHrChTPVKTaHN7-rnABg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E07B918A0761;
 Wed,  3 Jun 2020 14:35:59 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08ABD78FC9;
 Wed,  3 Jun 2020 14:35:52 +0000 (UTC)
Date: Wed, 3 Jun 2020 20:05:50 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] ati-vga: increment mm_index in ati_mm_read/write
In-Reply-To: <20200603134404.xdb2koul7fatv4ez@sirius.home.kraxel.org>
Message-ID: <nycvar.YSQ.7.77.849.2006031952260.62159@xnncv>
References: <20200603124732.1137892-1-ppandit@redhat.com>
 <20200603134404.xdb2koul7fatv4ez@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
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
Cc: Ren Ding <rding@gatech.edu>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Wed, 3 Jun 2020, Gerd Hoffmann wrote --+
| Hmm, why modify mm_index?  Shouldn't we just check it is non-zero
| before calling ati_mm_read/ati_mm_write?

  if (s->regs.mm_index & BIT(31)) {
     ...
  } else {
     ati_mm_write(s, s->regs.mm_index + addr - MM_DATA, data, size);
  }

Exit condition for recursion is to set (mm_index & BIT(31)), so recursion 
would continue even with non-zero values I think.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


