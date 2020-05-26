Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B8AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EBC2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YULifFV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EBC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTs4-00017R-AG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jdTrS-0000gy-GA
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:18:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jdTrP-0003zD-25
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590477528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmP9Y6PwbL3kpkvdhk7OEI6yLuh+MLADB97Xb2BGvQ0=;
 b=YULifFV2Vh0/I39YMjc0HuijSCT27cVhcDGdEKQM9Dy1GbC55rHwPj1ShVaadIC364BlKf
 PCbC4IBkJRkvUB7yS+7MSTAPzoxX4mBNJjMwL7Vq8Jwr4VvyFMjeX4XHU2M5fyNzn0XxY8
 0HHkxu9mvg7Sdhvecy3a2uwSbmevucs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-TnF5FoCWOSOlAfO65OwGwg-1; Tue, 26 May 2020 03:18:44 -0400
X-MC-Unique: TnF5FoCWOSOlAfO65OwGwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D9931005512;
 Tue, 26 May 2020 07:18:43 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 125E579C35;
 Tue, 26 May 2020 07:18:31 +0000 (UTC)
Date: Tue, 26 May 2020 12:48:25 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/3] megasas: avoid NULL pointer dereference
In-Reply-To: <defefce8-72f2-65c2-04cf-918f3697532a@redhat.com>
Message-ID: <nycvar.YSQ.7.77.849.2005261138520.62159@xnncv>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-3-ppandit@redhat.com>
 <defefce8-72f2-65c2-04cf-918f3697532a@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ding Ren <rding@gatech.edu>,
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello,

+-- On Thu, 21 May 2020, Paolo Bonzini wrote --+
| I think the code here was expecting frame_size_p to be 0 if cmd->frame is 
| NULL.  Can you check why this is not the case, or whether it ever was the 
| case?

static MegasasCmd *megasas_enqueue_frame(MegasasState *s, hwaddr frame,
    ...
    int frame_size = MEGASAS_MAX_SGE * sizeof(union mfi_sgl);                   
    hwaddr frame_size_p = frame_size;  <== = 128 * 16 = 2048

so 'frame_size_p' always starts with value '2048'

    ...
    cmd->frame = pci_dma_map(pcid, frame, &frame_size_p, 0);
     -> pci_dma_map
      -> dma_memory_map
       -> address_space_map
          mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
          ...
          if (atomic_xchg(&bounce.in_use, true)) {
              return NULL;    <== NULL is returned from here
          }

Later when address_space_map() returns 'NULL' above, '*plen' is not set to 
zero.

diff --git a/exec.c b/exec.c
index 5162f0d12f..4eea84bf66 100644
--- a/exec.c
+++ b/exec.c
@@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
 
     if (!memory_access_is_direct(mr, is_write)) {
         if (atomic_xchg(&bounce.in_use, true)) {
+            *plen = 0;
             return NULL;
         }

I'll send a revised patch above.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


