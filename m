Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADABC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FED220674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEJM3giQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FED220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uPR-0001uE-A7
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 19:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOA-0000Go-W6; Thu, 20 Aug 2020 19:54:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uO9-0006zu-4W; Thu, 20 Aug 2020 19:54:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id 88so353592wrh.3;
 Thu, 20 Aug 2020 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TEH+j2h3vIXryMOrTbzALiNvvNqlgjAkd7z0U3Nc24c=;
 b=iEJM3giQVNF4r4KfTvIHQ0hS9+K3Xm0hnvTuwcJWgkAJlwaoMLhkkBg1j0Ts6xPGAe
 5JFzbwjk0xTeQCrBkpk/bU8ALoAjNUm2Yvw/nffqQiaNY7CYisiP0cxTsVXtWTBjooBG
 mx/1550rwhXDwV3712JhzIZg+/Kvr8EWtqlVoDq2T/F3j4R/f6b5jWbVrAC5gEJu7Iq8
 /i/n/+OrPYqAr10OWAm7G9UDi9++jyDSZ2osuJ31FkQcv5qBWoYBYtzeWHBE5e6yz5V0
 oU6En/Kf9rkvbde4/uioflRKxB3Kvx/wTM2Y+GJ8ojEJcYq5rrAJ7dhGO5NBB7cTw7kP
 6uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TEH+j2h3vIXryMOrTbzALiNvvNqlgjAkd7z0U3Nc24c=;
 b=NMpSOeY8GkS7tuyflAfLsm0e8eoJzvAz6Z7kyxTNDFrRTOsKVgSKIH25pwm4eZ/4dE
 DudCP283r59043pDf0T10SZDrOKMMN7KUjE/MWG8WbLWxXCM63Pu0LA0AoP1lI6cin1W
 nL+/7/CY/6ohgQBrXHhyF+Yvt+g+DwdFkcSe5BnLf8ZHmaLQBt4ux9J4mqvGhpQTqK8m
 KopFS/XKNEEEoD28HQcnqmqXFmtRRGV13i8GnyFol2QNWdAOZk6St/Wj0oGaCzsiKEej
 BFVoCypaD89V+pz189aDRu3X0F8G6K1gWJKmy+Spmv0j6pTtIVI8RXWQOfrV63e+PXl/
 CYZA==
X-Gm-Message-State: AOAM533l/T/gTy/XnP7avxTnSVELNaNY8h8xSrBRewqKTY2I514eXRdD
 y9wdGQm7yS/MDi6KUQYAVeDp8LDsttcEd+4I
X-Google-Smtp-Source: ABdhPJyYJmzpv7wfiwpRDG9A6wV0np3UvaiSuF8zXKnUmKljfyx1/EdHsH7WTlNa2v3X+UYp003UWQ==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr138844wrf.309.1597967670882; 
 Thu, 20 Aug 2020 16:54:30 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id o128sm556506wmo.39.2020.08.20.16.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:54:30 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] iotest.FilePath fixes and cleanups
Date: Fri, 21 Aug 2020 02:54:22 +0300
Message-Id: <20200820235427.374645-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix some issues introduced when iotests.FilePaths was added and merge it ba=
ck=0D
into FilePath keeping the option to create multiple file names.=0D
=0D
Changes since v1:=0D
- Remove unwanted submodule change [Eric]=0D
- Add Fixes: tag=0D
=0D
v1 was here:=0D
https://lists.nongnu.org/archive/html/qemu-block/2020-08/msg00773.html=0D
=0D
Nir Soffer (5):=0D
  qemu-iotests: Fix FilePaths cleanup=0D
  qemu-iotests: Fix FilePaths docstring=0D
  qemu-iotests: Support varargs syntax in FilePaths=0D
  qemu-iotests: Merge FilePaths and FilePath=0D
  qemu-iotests: Simplify FilePath __init__=0D
=0D
 tests/qemu-iotests/194        |  4 +--=0D
 tests/qemu-iotests/208        |  2 +-=0D
 tests/qemu-iotests/222        |  2 +-=0D
 tests/qemu-iotests/257        | 10 +++----=0D
 tests/qemu-iotests/iotests.py | 50 +++++++++++++++++------------------=0D
 5 files changed, 33 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

