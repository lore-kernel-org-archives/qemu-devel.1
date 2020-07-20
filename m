Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4925CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D4022B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9tcab9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D4022B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVOX-000097-BH
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jxVMi-0005AF-PK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:57:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jxVMe-0007UY-74
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595249870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2jei6jn6+qaZvhntd7P/M/6NH/LCzrWCsrXh5HzAzcA=;
 b=R9tcab9xuPZRfYlAQl5vEEuDyMpN9Nkm1uRLgHQ81A+GvV0DIvbLh4y0z4UohsLXzrqjBx
 SADeKp6yns0NJ6jmIdqpVe/s4vc/oXfgzY7XtqZzrUgJqR7rPcWrTe8r+1J5eHAEqcyNWB
 xEbTeWkOmqeURJ0o6hLwIMOS93sVb54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-TmKq61NKOW-s9KntribgmQ-1; Mon, 20 Jul 2020 08:57:46 -0400
X-MC-Unique: TmKq61NKOW-s9KntribgmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F507100CCC3;
 Mon, 20 Jul 2020 12:57:45 +0000 (UTC)
Received: from kaapi (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AA1F6FECD;
 Mon, 20 Jul 2020 12:57:43 +0000 (UTC)
Date: Mon, 20 Jul 2020 18:27:41 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] net: check payload length limit for all frames
In-Reply-To: <CAKXe6SKV8=B2rb6EY72W17r6-oz5nx9VQndH9gSyafubOU4rJg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.78.906.2007201822290.4380@xnncv>
References: <20200716192335.1212638-1-ppandit@redhat.com>
 <CAKXe6SKL3aNiOKKLEMof6GGNjYLcX9fvfSf-0PBSX48rh4--FQ@mail.gmail.com>
 <20200717012151.tlfmc6hsfia22f4e@mozz.bu.edu>
 <4e4909ae-db2f-4a32-ae5c-d52149e80a8c@redhat.com>
 <nycvar.YSQ.7.78.906.2007171016480.950384@xnncv>
 <3620abab-a464-8e3c-d5b9-0bd80b35e2f1@redhat.com>
 <nycvar.YSQ.7.78.906.2007171326100.4380@xnncv>
 <CAKXe6SJbJaEepRVFtNy=5fhJrw8+Gax=mcwFuhfXrHTgo+wmog@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2007200752230.4380@xnncv>
 <20200720033304.sttpqr337xsf4rna@mozz.bu.edu>
 <CAKXe6SKV8=B2rb6EY72W17r6-oz5nx9VQndH9gSyafubOU4rJg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Mon, 20 Jul 2020, Li Qiang wrote --+
| This seems is the same issue as LP#1886362 . Look at the free path. Here the 
| 'e1000e_write_to_rx_buffers' trigger DMA and then go to address space 
| dispatch. So the DMA is not RAM but a MMIO range. Then we go to another send 
| path, and in that we frees the 'iov'.

  Cool. Thanks so much for the confirmation Li.
 
| Alex do you tried my patch to solve LP#1886362 ? I have tried it and it 
| seems no this UAF triggered.

He mentioned that your patch fixes both issues:
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05367.html
    ...
    > On the other hand, I cannot reproduce either issue with Li's patch:
    > Message-Id: <20200716161453.61295-1-liq3ea@163.com>


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


