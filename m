Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D061C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE8320658
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqkyEv7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE8320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pP7-0008WB-Ab
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9pNB-0005jg-LQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9pNA-0000JH-OD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9pNA-0000J9-KU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583410384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biiTpzltwU1sZnuHfx0nIZ3HPWdcfFfqBiK+XWGwsSg=;
 b=FqkyEv7fh6XQmLIwAFyNpxdNdxH9Hm19oUU6KjxPXpmBe84cMekOvZB2ZfAuWP58V4R9Yw
 Bnz7gUY+dfVdmJ+YBywfcFgfFffqxLmrkrZb0B325mRlVS9bL0Ql5iYA8SXiFhDKM2pVy2
 QY4yr/6lzOBI2qP8hn1whwsZgpXIhIo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-fNCr9ntDNy-PdqQoOPCwLQ-1; Thu, 05 Mar 2020 07:13:02 -0500
X-MC-Unique: fNCr9ntDNy-PdqQoOPCwLQ-1
Received: by mail-wm1-f71.google.com with SMTP id b23so2009628wmj.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/S7pAhQdbWIOFjZggLKf3SMhfw5UacO71zzf9J+ONfw=;
 b=LCNPGzBn952UrIiqEQM1gncPyy3bpBC6Vvo/bWte47FQoYdEb6+YEVe1WJEIWzEm6s
 o/7yWRTH2qOm+E49+pdB+Wl89Ob5NlKV35p0GhrsO60Jc5qkZI/95RHdkPM8bHrxm/3M
 H2hmVgGf7WeVNR8BizRPYuVy2gut5ztUZ4sQIcXjFSAPWW8CWQ6VgrNrdiROuKrjG/gP
 Z1Nnjg0z5JVbNTf1L6DkFXW865ZCE4o6ccIRjDYf6t4+krCsNDISCzr2KM3IlnkyG90y
 wl63vDTnByKLuJHRIVf2QyUqI2wbO2qrpz7VWnmBGx57sQakGWxVLgl8SE6TYaXSHvjX
 NsWQ==
X-Gm-Message-State: ANhLgQ3vdorlK2jAfmrWujx+1tzFVS/6cbV684D/w9DRWy/er1GRf8Ob
 ZHJFLp5wMg0v8ZfCiAEDsZot3ezRkSlrXvZ2N1q7n+VHJ4iYuV+5j/OqWSuJuQApmCj80C93v54
 v66F/K0EETWuOnvY=
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr9674718wmj.175.1583410381262; 
 Thu, 05 Mar 2020 04:13:01 -0800 (PST)
X-Google-Smtp-Source: ADFU+vth+6calAOVZz2Cyvlkq7snsT+nQmo+Q0iFdPDQwSWqAa0yB2+ceW1MpbH3tGHogbQFXs4Hxw==
X-Received: by 2002:a7b:cc69:: with SMTP id n9mr9674693wmj.175.1583410381056; 
 Thu, 05 Mar 2020 04:13:01 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q1sm2518037wrx.19.2020.03.05.04.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:13:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
Date: Thu,  5 Mar 2020 13:12:47 +0100
Message-Id: <20200305121253.19078-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305121253.19078-1-philmd@redhat.com>
References: <20200305121253.19078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This header use the srp_* structures declared in "hw/scsi/srp.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/viosrp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
index d8e365db1e..25676c2383 100644
--- a/hw/scsi/viosrp.h
+++ b/hw/scsi/viosrp.h
@@ -34,6 +34,8 @@
 #ifndef PPC_VIOSRP_H
 #define PPC_VIOSRP_H
=20
+#include "hw/scsi/srp.h"
+
 #define SRP_VERSION "16.a"
 #define SRP_MAX_IU_LEN    256
 #define SRP_MAX_LOC_LEN 32
--=20
2.21.1


