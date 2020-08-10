Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2A42063A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4uyx0li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2A42063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k549x-0001HA-FI
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k548z-0000Er-Nf
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:31:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k548w-0000yG-In
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597051857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3qrpDHJd/i7kPERSFdxE/hISeCGA9IC7CFeT1H8w5WA=;
 b=J4uyx0liLKK4zGLYnpWm6Ae+GgppPyCmNnH4qVBIVjy2k4yTAp9zZEYnhPlOf5Dcrc2hfl
 t9tYTArY72vksliwm/HPq1/q4yF02Iivz2+cqAXNRQ++pzgDph4/H7QhW42gE9SFVuWIhC
 HExi1ysYegDc1cvQonqH+WOyeXj0FBA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-PxYJtW0WOQSQFe7PlBFuHw-1; Mon, 10 Aug 2020 05:30:54 -0400
X-MC-Unique: PxYJtW0WOQSQFe7PlBFuHw-1
Received: by mail-wr1-f72.google.com with SMTP id w1so3996782wro.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3qrpDHJd/i7kPERSFdxE/hISeCGA9IC7CFeT1H8w5WA=;
 b=PSgXHHVImhryz5F2gu1FbONnAy7/NxAmIkmz52gtHwSlWqLDNS3SdN/5z/uk9KYhto
 QD697tFfvGZfLMjLJBm+k/cQd2z8MztzeQXCOzTYWLmRY0WK8/TQ1EtucpST0E2kibu1
 IIWeI/pVKt52VK0LhsaNo8DeVw4mu+JCHwDCE0Hkq36I1TUNnZDb8+OfxnWHlW8pKmDc
 RUSBLVNVtyYiCoIbMXF+jk6vU8tgIi6Cifh5ZeGDCfIvgRFFgKLYNDEsqGbS1RtGRp6x
 Id5Q+/ogsKkE9LmrEa8blJhUajX+5LY69NCkXsO3XuI1spUR1KW+2kE2dwHnn3qn+89L
 ARQQ==
X-Gm-Message-State: AOAM532R1P8XZA3LCJZHPL6b+r/47nwAZIS/AsAPJuvPxCp+GM2X9Hfn
 QJSHmi4KG0s5GeCXaKmN7q6e/WARigjpNiPYvwutP5AEBhJBM3FHMyel2VbqB9DOx2RaN5hbJRN
 tH8VkhXbluDT1eJY=
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr23493652wmg.109.1597051852882; 
 Mon, 10 Aug 2020 02:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiqzi/irBZAvtqIFv6VKGMrdPBjEP/i7hw4kT/xKGGYdvH6oXus+NRQFYEQRDxJN976L2k+g==
X-Received: by 2002:a05:600c:2055:: with SMTP id
 p21mr23493620wmg.109.1597051852652; 
 Mon, 10 Aug 2020 02:30:52 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p8sm21430797wrq.9.2020.08.10.02.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 02:30:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] acceptance: update asset urls for the Bionic aarch64
 installer
Date: Mon, 10 Aug 2020 11:30:48 +0200
Message-Id: <20200810093050.28744-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2 of Paolo's patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg728610.html

Do not update the binaries (and their hash), update the path to
the current tested binaries.

Supersedes: <20200809223741.56570-1-pbonzini@redhat.com>

Philippe Mathieu-Daudé (2):
  tests/acceptance/boot_linux: Extract common URL from xlnx-versal test
  tests/acceptance/boot_linux: Use stable URL for xlnx-versal test

 tests/acceptance/boot_linux_console.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.21.3


