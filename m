Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB8C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67F024695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YplGmz8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67F024695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eFc-0007KT-Rw
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e88-0001YE-2V
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e86-0001Xn-5c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e84-0001XG-CS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ci83psJipRLmMM102aFH9DJiTrhuqoBAGmTaxPcC9V0=;
 b=YplGmz8kQImkHexFY+P3QjXD2FqsvrQ5RMzgi3DJR7hCDdpSBnQb5ThFdaqCreBVNmbl/U
 3xe4V1F28BKZCN+bfbJD7ytcWgAEAuHiUZqZ7irArvUnW3CbDmyxs6K/Lw9bUxaWG6Ux+J
 HroJ4YRIKTCfHHt7YHW2CkUb8Gnbdyo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-49eLOWIyPhmUMHfZQUghcg-1; Fri, 28 Feb 2020 06:48:25 -0500
X-MC-Unique: 49eLOWIyPhmUMHfZQUghcg-1
Received: by mail-wr1-f72.google.com with SMTP id p11so1223219wrn.10
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WbQgs/ipNL+I36ywVUaG4Y7AH+d71TJ/LBgfF4qcL6Y=;
 b=f2WuNHt1tNumJFbXSN3+L6cWe2Ug599cvdXqiDZCiZPzGxh+4Jxl6ij2iJCNBn7JTr
 c4KJwzAObtPzoKWPGiadhPoS96DrFP8F2Vv61bpWPPMFbhpe731vhyS/7xkLA+1KtMVh
 0am46W/5FAPACv4JvZDka+pZssReJbTjUPbci2wwytKWlTMSz0oOGn4nnX5q2xaUCp/m
 0eLjc9nh3dSDsRa5r1BRW9GVC9YRfWOOsl5fKKxfA/fn6o9NKuZ6eqA/VBvbZD5ldHGw
 IyoABQ1iIQ1fct0HNC9bEjzX+2FnC/fNPXSQ2H1CycW7VtKf87lz0D3wRTB1F5aLFe5b
 CKcw==
X-Gm-Message-State: APjAAAXJWbv0+3Bo0EPYE2V9sGk87wBoepv9fbT7Rm1ck8lDDc03ZUB+
 LL6j33rhZlIRIm8dU25nbamQKFnRNe4uCcx6dGSHcqcrQWQL652SM+dtZZFLhWhIFLNoS6jIvNj
 t+qQKUe8Twc4GTVM=
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr4227978wma.184.1582890503681; 
 Fri, 28 Feb 2020 03:48:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQABjkSoRhQ7mYf4Fp+XHNAFXX1MGC0FklN6t+jzS2XcS2Mg7+aoV7AAxB6mPPvyteIIs53w==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr4227957wma.184.1582890503469; 
 Fri, 28 Feb 2020 03:48:23 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id a7sm1736226wmj.12.2020.02.28.03.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/18] hw/pci-host/q35: Include "qemu/range.h"
Date: Fri, 28 Feb 2020 12:46:43 +0100
Message-Id: <20200228114649.12818-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MCHPCIState structure uses the Range type which is declared in
"qemu/range.h". Include it.

This fixes (when modifying unrelated headers):

  In file included from hw/pci-host/q35.c:32:
  include/hw/pci-host/q35.h:57:11: error: field has incomplete type 'Range'=
 (aka 'struct Range')
      Range pci_hole;
            ^
  include/qemu/typedefs.h:116:16: note: forward declaration of 'struct Rang=
e'
  typedef struct Range Range;
                 ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/pci-host/q35.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 976fbae599..47086c645e 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -33,6 +33,7 @@
 #include "hw/pci-host/pam.h"
 #include "hw/i386/intel_iommu.h"
 #include "qemu/units.h"
+#include "qemu/range.h"
=20
 #define TYPE_Q35_HOST_DEVICE "q35-pcihost"
 #define Q35_HOST_DEVICE(obj) \
--=20
2.21.1


