Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F329C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A82220768
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtAeqahI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A82220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjhD-0000Fz-8Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcM-0006Qv-Ub; Tue, 08 Sep 2020 15:49:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcL-0002Xn-06; Tue, 08 Sep 2020 15:49:26 -0400
Received: by mail-pf1-x444.google.com with SMTP id d6so27238pfn.9;
 Tue, 08 Sep 2020 12:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yqpsa73bQrzKkEPT9F/kH2K7vNqI8slBD9edFCTrOo0=;
 b=AtAeqahIaVUAJpCf42i75pB5vhCazSyFJ1qxd/QD5jCVs3AbQWsB99T9KIYqZ6v9nr
 DhuhCoqTNMcItNGyHOYhUen9VEemY5E+20Q+PA3niKFeg03OLtXJtxz8JsFxFE8e5hbQ
 EoVn8Q3UeUYlkLCQazOv3tx3tsUd64znywDmoic1Q0peyJu1Z1hcCDzO6L5xy7cERp3Y
 MbHRTM93gKIDTwrK+QXttFfn0Ml6OSzaJoeRK8t9PEx6IhLBZ1c07TXp+2MPcQBCqZ9i
 31weaSVCOr613ig8oGkLwEHTaQ7bbaLjDQoQ4msv/ZkOKW5i/1wejs6ZbrLFJg+lKRwf
 WeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yqpsa73bQrzKkEPT9F/kH2K7vNqI8slBD9edFCTrOo0=;
 b=UcKhCAdbP0EZWMY9YkMigtQ0cWQNjQMi3mIIPHvGSsLAU9+yxI+QQn22EvgVniELRg
 E5odi13pTJQ3A0Ys3c9xMOgY9Ngu/Gq5HB2j8ptEr7eiwIZt+IcuYSpIV0fM2ZKi7ev0
 O3AnBXKG2QJei3I+NcHm9bBY4IXoOh7fQdGs+FU4psPN3aLYm+G+mTRNa2PcWJbJdozn
 CURsCZM/CeV1a7DTau9k1t8EDftzNN4P+uYBYz2P5pVjuhGPaK5R/fV9v7GazzXBsEll
 JK9K3WIc3ShYoLAy2gQMim+xI4RxBSHhoeAr8P4bfnaYfF+P/looM+Xh4Nq3jtmEAbmq
 jzmA==
X-Gm-Message-State: AOAM530Cq1jETJ/3b3qDlWEWlez3fkgo2PnVWED8LDI9fpCw9JwG3zFy
 qReWH+9G0tcL6G2GzxFeUqWSbdRUwdBTHMzd
X-Google-Smtp-Source: ABdhPJzJAZgO9ILHPeHhANTLXXAoaJCB71EdQqYU0pL8Mv0UX1o/59Z3ZzAqA254z5A9Py1GTocjUg==
X-Received: by 2002:a17:902:8f8a:b029:d0:cc02:8541 with SMTP id
 z10-20020a1709028f8ab02900d0cc028541mr694317plo.32.1599594562940; 
 Tue, 08 Sep 2020 12:49:22 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] meson: disable crypto tests are empty under win32
Date: Wed,  9 Sep 2020 03:48:15 +0800
Message-Id: <20200908194820.702-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Disable following tests on msys2/mingw
      'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                                   tasn1, crypto],
      'test-crypto-tlssession': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
                                 tasn1, crypto],
      'test-io-channel-tls': ['io-channel-helpers.c', 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                              tasn1, io, crypto]}

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/meson.build b/tests/meson.build
index 998e4c48f9..b470a90e3a 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -145,7 +145,8 @@ if have_block
     'test-crypto-block': [io],
   }
   if 'CONFIG_GNUTLS' in config_host and \
-     'CONFIG_TASN1' in config_host
+     'CONFIG_TASN1' in config_host and \
+     'CONFIG_POSIX' in config_host
     tests += {
       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                                    tasn1, crypto],
-- 
2.28.0.windows.1


