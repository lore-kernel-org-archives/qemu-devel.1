Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2932074B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAlU0unf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2932074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg5Eo-0006kF-Ij
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 07:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg5ED-0006Jg-MB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:37:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jg5EC-00053v-Sw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 07:37:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so3081311wru.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ceQh7KDuSbqfQzt8ZZjn6/6jQP1zHqPfpK2+Po808Os=;
 b=CAlU0unfq+/CxdT8MnAnQlcQpTDleS31L/yFpLn9mzlhJgRqDASXBOBPtMZqVPab89
 7ZVFu+WPfWziTRLntYfS8D+jjtS4fnZAOViT45amYKGas0nooEp9aYUm1IodaBECdb34
 cK1opBwGtd7NT+gaAv4a2mle4haio7zt3Jk2hQjeg2+AJ5Z9O9CIz70enzeZy/Mi2TzL
 b2Iautb/12Swhd6lFwnpp5WuNgAs+WjoFlzRzptnCQizWxfScytIV6N5UrtBa4/qhaJR
 p6UJzL2u/1pEyYx1mOpHhA3Lyc4JmBS5lMyAnRf9Vbh0Oypfk9mjW7tjG+WClp5Dldk3
 IFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ceQh7KDuSbqfQzt8ZZjn6/6jQP1zHqPfpK2+Po808Os=;
 b=T9GzTyZsAgTzKa5gAOJLPO3FRMxjI6JvYydNj+DsYcpoDRiEZeshd+17a+Fpr6yR+M
 WO6Kzs0Ti7IsCMLsf7J2VNsIF+v1zRhs/H3jJCz2EJ59nPoVo0RWTFiuTdNDoYroiho0
 evxE+oNj1/KlNqjdq+6ApY1RY+3P6CsUgRKPa4c2ljTHcTDHemu+kbJMyQzLO7xDMHiI
 dlC80/T1JOIp73Ia1+CyI/56/vxgBMzGSSiKIb6mTZb1qNy7YP6FY/0FQ7yQiqvehRBh
 PFq/CyPZ7AIe76zjhWpQSIhTfApWOgONUlIqWqbG4DLCA7PyoZvO5YM316A+DS80V7XN
 iX0A==
X-Gm-Message-State: AOAM532baKLuvDUG+0ap3eQd1Uk3pTnD6pXtVdBwVURnOtdg8/40K5Bb
 sK8/xIYu/bDyHEYIxMEHYf6s9j6r
X-Google-Smtp-Source: ABdhPJy2DlwYfsHNj1jf718PBA1GxO7+zcdpRWVqJgnLwM0aXfGzFJlSat0rgFt7CiVIw746wcNHXw==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr25659060wro.414.1591097824709; 
 Tue, 02 Jun 2020 04:37:04 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z12sm3822247wrg.9.2020.06.02.04.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 04:37:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: Temporarily disable the aarch64 job
Date: Tue,  2 Jun 2020 13:37:02 +0200
Message-Id: <20200602113702.28549-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Travis-CI Aarch64 runners are currently broken, the build fails
because the filesystem quota is full [1]:

    AR      libqemuutil.a
  nm: qemu-sockets.o: Bad value
    LINK    qemu-ga
  qga/main.o: In function `main':
  /home/travis/build/qemu/qemu/qga/main.c:1494: undefined reference to `socket_local_address'
  qga/channel-posix.o: In function `ga_channel_open':
  /home/travis/build/qemu/qemu/qga/channel-posix.c:210: undefined reference to `socket_parse'
  /home/travis/build/qemu/qemu/qga/channel-posix.c:193: undefined reference to `unix_listen'
  /home/travis/build/qemu/qemu/qga/channel-posix.c:218: undefined reference to `socket_listen'
  collect2: error: ld returned 1 exit status
  Makefile:686: recipe for target 'qemu-ga' failed
  make: *** [qemu-ga] Error 1

Per [2], LXD container have 'approx 18GB' of storage, but our runner show:

  $ df -h
  Filesystem                                                                                         Size  Used Avail Use% Mounted on
  /var/snap/lxd/common/lxd/storage-pools/instances/containers/travis-job-qemu-qemu-693775643/rootfs  895G   38G  854G   5% /

As we suppose a filesystem quota makes our build fail,
disable the aarch64 job as a temporary kludge.

[1] https://travis-ci.org/github/qemu/qemu/jobs/693775643
[2] https://docs.travis-ci.com/user/reference/overview/#virtualisation-environment-vs-operating-system

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 564be50a3c..3569ee99b3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -399,6 +399,7 @@ jobs:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
     - name: "[aarch64] GCC check-tcg"
+      if: false # Temporarily disabled due to problem in aarch64 runner.
       arch: arm64
       dist: xenial
       addons:
-- 
2.21.3


