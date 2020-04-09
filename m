Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A781EC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FD220678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwqDukvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FD220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaWK-0002xa-K9
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMaNP-0003py-EL
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMaNO-0004F0-0m
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMaNN-0004EB-Pb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586451000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FtYZ8zvtdgQms3S7Fq/g6eFvvamlpX9A8dSGP/jEk3w=;
 b=YwqDukvxo+hVeBs2FOzS41wtWusZKnuXL3m9GjfLlbkiJizx2QDgk7nfP0GfjYreT9swNN
 BmI1UNcvWNcOfZd8idBCi1Co3hI23+gKuYSV3t3c9/LIqW0YgzW2eheumJb7crLmbLL/ol
 1mTC8sUovXT6ZFzwehKx4ZagtahR9tc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-Qg6Udpj8NvOnrK0c5LsmOQ-1; Thu, 09 Apr 2020 12:49:58 -0400
X-MC-Unique: Qg6Udpj8NvOnrK0c5LsmOQ-1
Received: by mail-wr1-f72.google.com with SMTP id j22so3623780wrb.4
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d86mx4vYJc69Jq1w0JarA8ZXRIcivQyN3mFEr1ot9MY=;
 b=V4c6z2HwOgHtYm0gJT4IVd/uGds/ja6uj7LT7FTMn02hiyyXLy7E5tVLOTQQto7vib
 myc+SGO/NlESmxBDXB6O6wl3wk4JlFfP0tWPlk5MQCiOgAdbte5M6wQ4cYHuv0JD+fiW
 L+0X0EvBeJkQ1DdWNX+Li8SwZL/KY8ZuAfj6DiQg5EynvAzYmODAnLEWJG4C7M4yk1rf
 ai/QUkcWmKwAo6e6z2v4SiR+nU7gynLRRVtUqJvit9SBA8a/m8mVkMTbTqk54pG5O3Nz
 ZJ3EMNnlURRRtdCQE9PFzB3XmSNb5/sZRsP3iyOjn4IjgHkyURDZrvNXaS9THLnVv8vI
 Y0KA==
X-Gm-Message-State: AGi0PuZOKKDt5LqtvOhYXj6PXd95MqKYj/uKDjz1Z6wqOj5uAMKubK1D
 ZiSF6hw3x2ex0KQygtWfDjChza4XwRPxGl1vHBpdoriRxsbcgfcJ5DQr8ZWiaPxS9TEC+ndkLr6
 nxORLNuMHYzQWRJI=
X-Received: by 2002:a1c:e914:: with SMTP id q20mr736078wmc.105.1586450997261; 
 Thu, 09 Apr 2020 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPIDcPTtqJCRItW/UlsgkLjsv7aDdoT38YIdpWNnkAbZIQfOlbakiYFNQMi3T4UajjMVe+Tw==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr736057wmc.105.1586450996948; 
 Thu, 09 Apr 2020 09:49:56 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id j10sm23263569wru.85.2020.04.09.09.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 09:49:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] gdbstub: Unbreak i386 with gdb remote
Date: Thu,  9 Apr 2020 12:49:52 -0400
Message-Id: <20200409164954.36902-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's silently broken on master during an refactoring.  Let's fix it.

Please feel free to drop patch 1 if it's not rc material, but I guess
we want patch 2...

Thanks,

Peter Xu (2):
  gdbstub: Assert len read from each register
  gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak gdb

 gdbstub.c             | 11 ++++++++---
 target/i386/gdbstub.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

--=20
2.24.1


