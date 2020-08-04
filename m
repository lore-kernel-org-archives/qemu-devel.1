Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE93FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27262075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkYUO/0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27262075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sdl-0008Qk-RB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2scq-0006kt-Ua
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:48 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:36094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2scp-0003Sz-DB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:48 -0400
Received: by mail-ej1-x630.google.com with SMTP id kq25so28580249ejb.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0PARhiXdVodHPM5A1bHNqTp2LZsrKFa7JpVk6IXSowc=;
 b=rkYUO/0aYMVnIiVeT1MKxlCRB1VZKqtwhy94kxl+zQlf1JZ2pD9Py02Pwa/x2Y73l1
 6JlZ5Onm27haH1HQv6PkIbQj3rNaPbEgRA0GSUw46l+0CIJ+cdxABAmk+b5Kosb7Bxup
 eqMQr8RmCgJTJsXLrmsEjx1cNLqd8V4lxslnoovMeHRlmNniRjd9nHTIMnC8FxsQGe6X
 S6K8CNN0kefE5Y/USpB7TZInpU7NR4YuyZE/ChnNIp3zqmB4SVbIU8Rsx2BNCxmiGzCG
 7R4+2kVBhvtTOb5ATPtMqXnxA5oS5Ez/N1GFRJaj1TLxDBaXyRvUO/T9dYm3lnbRc5w3
 fc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0PARhiXdVodHPM5A1bHNqTp2LZsrKFa7JpVk6IXSowc=;
 b=iRORgOEIDhUrcar3gzufDkORoP7Hs4GpXWyrP1BmJWTykE8hqwJCbfEC7FI0Q1gZjq
 sXlCiZ7Y6RnoCxiH9SMlDSo7NHv/seKuQpyO051OeUjmwKaTiK5NJBq/Vdue9jg0eluI
 DSCQYK0g/4Hoom/TzZ9xuGPb+pqjFXho4Np/bos5KnDVEMxIXD2XSFrlfVww3XIn7DtI
 xnIj7jeSiUTjiaaQlyDFFXFUF5qqK4kqvR/6iM742GLm/LJJdQ85SeY8nypJ0n8HqoWB
 sN2iH/66MoaO2Y0NYETERJTje/Gingovwc1fBe3MOzSFLtYXdVE7y3SOSyQrvkytCiUC
 7Myg==
X-Gm-Message-State: AOAM532tjkcW8bT1IFcMHUesWmLE3I0Co8rn0Zm0csb15K4s3Rn9ZRaC
 gYx5s67AXkIug7+QSviUSOX1Rlk7
X-Google-Smtp-Source: ABdhPJxUQP8OQo+yTfHKiSpVFzDcTThmzfdEUd+DX8FVX8B+xgsoAg+MUAcxERuZBXc3aqwQUy4fZw==
X-Received: by 2002:a17:906:401b:: with SMTP id
 v27mr10015465ejj.300.1596530925387; 
 Tue, 04 Aug 2020 01:48:45 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id q11sm1299641edn.12.2020.08.04.01.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 01:48:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] .github/workflows: Add GitHub action for Windows WHPX
 build
Date: Tue,  4 Aug 2020 10:48:40 +0200
Message-Id: <20200804084843.31075-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reposting Stefan's patch in case we want to merge it in
(I 'd rather not, adding them as GitLab jobs instead):
- add MAINTAINERS entry
- improve speed by parallelizing jobs

Philippe Mathieu-Daudé (2):
  MAINTAINERS: Add entry for GitHub 'Actions' config files
  .github/workflows: Use matrix strategy to parallelize builds

Stefan Weil (1):
  .github/workflows: Add GitHub action for Windows build

 .github/workflows/build.sh                | 112 ++++++++++++++++++++++
 .github/workflows/pkg-config-crosswrapper |  37 +++++++
 .github/workflows/win.yml                 |  25 +++++
 MAINTAINERS                               |   6 ++
 4 files changed, 180 insertions(+)
 create mode 100755 .github/workflows/build.sh
 create mode 100755 .github/workflows/pkg-config-crosswrapper
 create mode 100644 .github/workflows/win.yml

-- 
2.21.3


