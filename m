Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A459C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B422073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvmXTp5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B422073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIUF-0000Xc-GE
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEITE-0007xI-Bg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEITD-0002KL-FN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEITD-0002GW-CM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584475546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nv6FBg5W5B5yOIVhWzKnpAMqoyE6jK+xNDViDJMSFc=;
 b=LvmXTp5jUXVKgvMyaiqkY8NXRyfTEFPQz5hwza+lig8ZTmsYlfcfEf/Fywbvmwy0iHSLAk
 sy6kdEzhc9WJUJKsrjtlyWu6nB+Mdzbqv+eC6nqylzACuNpt5OMlpXBqDx1aE4XSTxSNQ4
 l9EwRuVAj3MA4kNOoM9oDjdCZL2V6/s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Kr9J0atpPI2ImEHwlkUodw-1; Tue, 17 Mar 2020 16:05:45 -0400
X-MC-Unique: Kr9J0atpPI2ImEHwlkUodw-1
Received: by mail-wm1-f69.google.com with SMTP id n25so198685wmi.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 13:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yc6xlZcS14vgNEWwWvNOlbkHPATF7ysIeX8hSziaJVI=;
 b=uNQx8mo79cvdEGkAoheOO7FUiMZo8yHlk9OFaChTOUVJJo7wAC4PISIRXw44GLpu3E
 SezZq7n7AXhT+TnHX61PGBm++GqnqURpVkkz+DbimptDXYT7EbfCDXB19pgKT+BqwYew
 LyUqlAwM1Sob2dEKkd6CDXbab6IfJ9cC8LxNq+EaazFbMYRyicslt0l/wfbSJSYfdAXe
 H1NSaYIVQAfrZqla6myfndanQp7Kgr0bC4Yo8O9u+5ucgPRF9pJsmKS5T0HQdPdyk4LK
 5hXUIdJVzYfWMdQXlJ8LKtSYf7HZUVf6IS+FPC8tlTPIH7l0WLngoUV7FklPRCaHRQrD
 iCzA==
X-Gm-Message-State: ANhLgQ2OmxOKPcLPYOS0tYfs/aEML9njumxosH738Y0zuF6dFQU71BYS
 u0dmd0V29/kE0pzNLtxRIANXgSHJRubQW437i/FaucVCExIm8a5Rkh4BV1Yd31THyXRvXf29cau
 vM/lwg9/zgEZDUok=
X-Received: by 2002:a1c:b154:: with SMTP id a81mr677231wmf.175.1584475544020; 
 Tue, 17 Mar 2020 13:05:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvQrtR5kIJzlF2CwDx5+bls+Si9Ue6eNdudj/V6+Mdo/UOTlCXD9eXduD1RQz7J5KG2p2NQiQ==
X-Received: by 2002:a1c:b154:: with SMTP id a81mr677193wmf.175.1584475543642; 
 Tue, 17 Mar 2020 13:05:43 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id w19sm602795wmc.22.2020.03.17.13.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 13:05:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] travis-ci: Add a KVM-only s390x job
Date: Tue, 17 Mar 2020 21:05:37 +0100
Message-Id: <20200317200541.6246-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a Travis job to build a KVM-only QEMU on s390x.

This series also contains few fixes for Travis/s390x.

Philippe Mathieu-Daud=C3=A9 (4):
  tests/test-util-filemonitor: Fix Travis-CI $ARCH env variable name
  tests/test-util-sockets: Skip test on non-x86 Travis containers
  tests/migration: Disable autoconverge test on Travis-CI s390x
  .travis.yml: Add a KVM-only s390x job

 tests/qtest/migration-test.c  | 10 +++++++++
 tests/test-util-filemonitor.c |  2 +-
 tests/test-util-sockets.c     |  7 ++++++
 .travis.yml                   | 42 +++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

--=20
2.21.1


