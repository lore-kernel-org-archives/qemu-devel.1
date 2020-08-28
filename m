Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56830C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1921720838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsBA9fHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1921720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnhs-0002fu-56
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh2-0001cK-Oz; Fri, 28 Aug 2020 19:22:00 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh1-0006JG-4t; Fri, 28 Aug 2020 19:22:00 -0400
Received: by mail-ej1-x642.google.com with SMTP id d26so1267441ejr.1;
 Fri, 28 Aug 2020 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aAsYTNWSCWRXVEcWjShTIqNNma8HoiTz3K1aeOYl0LU=;
 b=JsBA9fHN87R4CJbqSR/sCkhq89VnonGVEhaA0XyybxqapB6k6ujt0y/8Oi6Y183hLA
 dIonOhAFz3fQLUKCTQFi19sd+P5r5GB6S43ClsYXU5bILaV7XrO/RuiyEeArfQrEmFoy
 X2KHqgfXSbUexDIw6snC95W0KDxjLU47sypZlr79M011717V+MYyIR259C/CDMyRcRMu
 4+mnjqMb35wgTfef/NlKUohnqpkpR+3VbCjiJGdYyYLtZzL1lwjvnZUhfctwKvZcXmGi
 je3L+KqDVHXuZiZtKni5IS1MrrxdBbdF/qpQ71eSsxWDICteCOoNav0i4yZ+2sE2bSFS
 Dqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aAsYTNWSCWRXVEcWjShTIqNNma8HoiTz3K1aeOYl0LU=;
 b=Ia7ZMxwQ08/z98fWoDvkauTmgPqMn5A+xGcwVMapYbYNVZ9DfUHCydyC4n0zIjlAtP
 3uXxV43NWjPB6a43ihLvRSGD4uc9NyIAlFKEWLaj2AGvPSgJlG8HRjyY16DSn/kShlDk
 TbS+IvbwmpSSEqtBgL/1t7MiEeePt1O4xy6OeRVDla4rGSNnnr4dbsIZygp7OKdEVZKl
 rGnLXpgi3C/kZ3Eya7hEVIL7o++Kd1af/TTLXrpHEcjJg3mPVcdLCVvqnEaNsq+i23/J
 caLHf6It2qM7Pwnsn2wvuUEntFU1WjshZ3M0h70V2wLL546vqPbgYkQGRVAEDdbY3fEl
 ocBw==
X-Gm-Message-State: AOAM532Mq+OO3qecpsE5DCA9rSLdOE7ZRZvkEygjUx/QJcdSy84WDsh2
 iaCMnu1IKEVpbvnt2tfQrOesIgvukU8n5A==
X-Google-Smtp-Source: ABdhPJwengIBcAZgALHNXc4RfijziCN6X3lAVMUclhDZmJ+PFGkuF8dEYnztuCcdAinttUSzWg3Xow==
X-Received: by 2002:a17:906:d8b1:: with SMTP id
 qc17mr1074151ejb.362.1598656916593; 
 Fri, 28 Aug 2020 16:21:56 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id j21sm523436eja.109.2020.08.28.16.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 16:21:54 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] iotest.FilePath fixes and cleanups
Date: Sat, 29 Aug 2020 02:21:47 +0300
Message-Id: <20200828232152.205833-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=nirsof@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Changes since v2:=0D
- Improve dosting to show how sockets should be created [Max]=0D
=0D
v2 was here:=0D
https://lists.nongnu.org/archive/html/qemu-block/2020-08/msg00780.html=0D
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
 tests/qemu-iotests/iotests.py | 53 ++++++++++++++++++-----------------=0D
 5 files changed, 36 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

