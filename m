Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7BC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE29247BD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IObwVdNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE29247BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKx6-0008Mi-2F
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKvr-0007Ma-Lr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:05:39 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:42660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSKvp-0006JP-MN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:05:39 -0400
Received: by mail-qk1-x732.google.com with SMTP id i22so4619562qkn.9
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZUGu1UjR8L476LNL7fXxphmCIcS0ofD66g+kHXKobM4=;
 b=IObwVdNCG2HviBddPIHXaO7fBXgVd4IMV54T1c2dgm1mPpyez8saUJlRLHH0D6x6cc
 YxLX4GLFKpnuALRKE5kWohB56qyTKO78DlSbiO7OkXjlOP2zazIfIk411MKZrXJkC/7G
 9gm5WgxpovwnivU3B7/YrmdIPzcf5pOUBWNBpHiIvFw/kwmbIqriV++tLM20h75LZKW9
 tQ7lw8VMQfgoUvmIulj/27zu2xX4I6yZGAAR8j3PHcc88Tfq86jJ/PFcabnrl5YaJMLk
 K9um05Vg9uaGQUm+PBThNycqv6wH1rGvgeVwYnxXq8iOsqjOWnPh2pPNA7YyWwb4Wt0+
 MtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZUGu1UjR8L476LNL7fXxphmCIcS0ofD66g+kHXKobM4=;
 b=RYXqG2Bztw49oKtuxEeeq91PYeMUIEoykRcPpFqfBCCQnw6JX0iZwplvTBVmtp0jAe
 J6j1Z8+24JRsJNBQOqw0DKznmtLIhIZG6peCFVXMEYZVqbAX0NxVv9QIockYCGfPrCL3
 I21jdCTu7jiQjVjEHEZB/zk6zWha3RPFkQ9vofyDfe7K0LgN6z9B0iknN566KQTO/zUH
 JE5Hk+EoMgdmojgNUGPRy3rlDkhg9JeqDq5t4iWtJpBh5RHUiYp6NIenb4JYkyzW/s3w
 8sHlmQEH7YANLh7EL6kdz0yiywmfeRnzwwFCXbq8SAdEmEyR9INJbRYf2+XR2iWmFl7i
 DjVA==
X-Gm-Message-State: AOAM532C5lnRbGL7NmIie0eNXngYyj2GCjpipA5fq/vNo+2HfiCi9h2h
 F2YSvwkIvKKhwu6Oh0hWJKqwkkg9udc=
X-Google-Smtp-Source: ABdhPJxOTxmkqh+AoB4DBTpV5Pol3D0nwJYAhdUYd7RDexCSOKqQbKr0DammqDLpjyQZagRGN1nPOg==
X-Received: by 2002:ae9:ef56:: with SMTP id d83mr98199qkg.83.1602597935940;
 Tue, 13 Oct 2020 07:05:35 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:2df1:3321:942a:fbce])
 by smtp.gmail.com with ESMTPSA id z26sm13793609qki.40.2020.10.13.07.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 07:05:35 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Add Xen CpusAccel
Date: Tue, 13 Oct 2020 10:05:08 -0400
Message-Id: <20201013140511.5681-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=jandryuk@gmail.com; helo=mail-qk1-x732.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Jason Andryuk <jandryuk@gmail.com>, Paul Durrant <paul@xen.org>,
 Claudio Fontana <cfontana@suse.de>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen was left behind when CpusAccel became mandatory and fails the assert
in qemu_init_vcpu().  It relied on the same dummy cpu threads as qtest.
Move the qtest cpu functions to a common location and reuse them for
Xen.

v2:
  New patch "accel: Remove _WIN32 ifdef from qtest-cpus.c"
  Use accel/dummy-cpus.c for filename
  Put prototype in include/sysemu/cpus.h

Jason Andryuk (3):
  accel: Remove _WIN32 ifdef from qtest-cpus.c
  accel: move qtest CpusAccel functions to a common location
  accel: Add xen CpusAccel using dummy-cpus

 accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 27 ++++------------------
 accel/meson.build                          |  8 +++++++
 accel/qtest/meson.build                    |  1 -
 accel/qtest/qtest-cpus.h                   | 17 --------------
 accel/qtest/qtest.c                        |  5 +++-
 accel/xen/xen-all.c                        |  8 +++++++
 include/sysemu/cpus.h                      |  3 +++
 7 files changed, 27 insertions(+), 42 deletions(-)
 rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (71%)
 delete mode 100644 accel/qtest/qtest-cpus.h

-- 
2.25.1


