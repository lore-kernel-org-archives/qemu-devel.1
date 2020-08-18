Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE01206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DT+r1cjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE01206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yIr-0007A4-SL
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k7yIF-0006j2-VR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:52:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k7yIE-0004a4-9H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597744352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ojOJc8TNwb88o3l/kIvXxklyu5s+s7WHnPpORq61s0=;
 b=DT+r1cjRT0hSIqaFfCpfZqndwX3rDdJocqxtdiMCRS1o6tZyzHoIFhnBy5V3EId1+2ZjPA
 rncTzHWw2aSm6bYyKrttXHaTMnod+DjZwjCZP6yBf8hlbJZRL0uA/x5haHqIoYfc1eZ63z
 rg/vOsPMBs8rkFmbmZRGDTBfdj86CYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-CSPzLjDQMW2pQ4q1D2Hjdg-1; Tue, 18 Aug 2020 05:52:31 -0400
X-MC-Unique: CSPzLjDQMW2pQ4q1D2Hjdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59CD01005E63;
 Tue, 18 Aug 2020 09:52:28 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C41B15C1DC;
 Tue, 18 Aug 2020 09:52:04 +0000 (UTC)
Date: Tue, 18 Aug 2020 15:22:01 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 1/9] memory: Initialize MemoryRegionOps for RAM memory
 regions
In-Reply-To: <20200817161853.593247-2-f4bug@amsat.org>
Message-ID: <nycvar.YSQ.7.78.906.2008181445190.306228@xnncv>
References: <20200817161853.593247-1-f4bug@amsat.org>
 <20200817161853.593247-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.78.906.2008181520000.306228@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-709961173-1597743935=:306228"
Received-SPF: none client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-709961173-1597743935=:306228
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <nycvar.YSQ.7.78.906.2008181520001.306228@xnncv>

+-- On Mon, 17 Aug 2020, Philippe Mathieu-Daudé wrote --+
| Fix by initializing the MemoryRegionOps to ram_device_mem_ops, this way the 
| memory accesses are properly dispatched using 
| memory_region_ram_device_read() / memory_region_ram_device_write().
| 
| Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
| Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
| ---
| Since v1: Corrected description (PJP)
| Cc: P J P <ppandit@redhat.com>
| ---
|  softmmu/memory.c | 10 ++++++++++
|  1 file changed, 10 insertions(+)
| 
| diff --git a/softmmu/memory.c b/softmmu/memory.c
| index 651705b7d1..8139da1a58 100644
| --- a/softmmu/memory.c
| +++ b/softmmu/memory.c
| @@ -1517,6 +1517,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
|      Error *err = NULL;
|      memory_region_init(mr, owner, name, size);
|      mr->ram = true;
| +    mr->ops = &ram_device_mem_ops;
| +    mr->opaque = mr;
|      mr->terminates = true;


I wonder if 'mr->ops = &ram_device_mem_ops' could be done in 
memory_region_init() instead?

Otherwise looks okay.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-709961173-1597743935=:306228--


