Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C2DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D4C2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKO+Nfpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D4C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dI7-0004OJ-Np
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k7dGg-0003RT-Uj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:25:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k7dGe-0007I3-6W
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597663530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QEvuyFe13HuwqkWS1TP9fyuya5uvD7HRC2/7vHLEUg=;
 b=DKO+NfpvqW8MHnP8819cnhA5zfDXgDwFeWrzUBsuB7DhTWagsukv8Ku5hNQNx2wxG66Hrl
 IpkswOWn8sI58/kOQAv0P+HSNKo/bkiU4fp0fTL63/wu7spmmHMdlcvG7bSqgA6x/D0U7O
 8ZGImIqMdQp7pyLYswToW5iWCac0CEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-x12_ipWfPZ2PcI0a34pfqA-1; Mon, 17 Aug 2020 07:25:28 -0400
X-MC-Unique: x12_ipWfPZ2PcI0a34pfqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693AF1007465;
 Mon, 17 Aug 2020 11:25:27 +0000 (UTC)
Received: from kaapi (unknown [10.74.8.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C33B5D9E2;
 Mon, 17 Aug 2020 11:25:20 +0000 (UTC)
Date: Mon, 17 Aug 2020 16:55:17 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] memory: Initialize MemoryRegionOps for RAM memory regions
In-Reply-To: <8e562b3d-ead5-b277-4791-66baecdebacb@amsat.org>
Message-ID: <nycvar.YSQ.7.78.906.2008171643040.306228@xnncv>
References: <20200816182602.352-1-f4bug@amsat.org>
 <8e562b3d-ead5-b277-4791-66baecdebacb@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1145623414-1597663526=:306228"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1145623414-1597663526=:306228
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Mon, 17 Aug 2020, Philippe Mathieu-Daudé wrote --+
| On 8/16/20 8:26 PM, Philippe Mathieu-Daudé wrote:
| > There is an issue when using memory_region_dispatch_read() or
| > memory_region_dispatch_write() on RAM memory regions.
| > 
| > RAM memory regions are initialized as:
| > 
| >   memory_region_init_ram()
| >   -> memory_region_init_ram_nomigrate()
| >      -> memory_region_init_ram_shared_nomigrate()
| >         -> memory_region_init()
| >            -> object_initialize(TYPE_MEMORY_REGION)
| >               -> memory_region_initfn()
| >                  -> mr->ops = &unassigned_mem_ops;
| > 
| > Later when accessing the alias, the memory_region_dispatch_read()
| > flow is:
| > 
| >   memory_region_dispatch_read()
| >   -> memory_region_dispatch_read1()
| >      -> if (mr->ops->read) { ... }
| >                    ^^^^^^
| >                    NULL deref as unassigned_mem_ops.read is NULL.
| > 
| >   memory_region_dispatch_write()
| >   -> if (mr->ops->write) { ... }
| >                 ^^^^^^^
| >                 NULL deref as unassigned_mem_ops.read is NULL.

* This check should pass/fail as normal I think. NULL dereference would happen 
  on invoking mr->ops->read/write() call.

* When mr->ops->read/write==NULL, the dispatch_read/write function would go to 
  the else section to call read/write_with_attrs()

    const MemoryRegionOps unassigned_mem_ops = {                                    
      .valid.accepts = unassigned_mem_accepts,                                    
      .endianness = DEVICE_NATIVE_ENDIAN,                                         
    };

  Maybe we define read/write_with_attrs in 'unassigned_mem_ops' above?


| > Fix by initializing the MemoryRegionOps to ram_device_mem_ops,
| > this way the memory accesses are properly dispatched using
| > memory_region_ram_device_read() / memory_region_ram_device_write().
| > 
| > Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")

Yes, this should be fine too.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1145623414-1597663526=:306228--


