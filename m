Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C64C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819AA207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxt/VXbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819AA207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwpx-00057I-E6
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhM-0007GN-74; Wed, 09 Sep 2020 05:47:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhH-0007jr-Mt; Wed, 09 Sep 2020 05:47:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id s65so621320pgb.0;
 Wed, 09 Sep 2020 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xBOHLIgzzS+cZLXuoOhLEV5Djuhr7s8VvLqqjTlGHNI=;
 b=jxt/VXbKXcB+OjQ8v70XeIXG4aTVqQYrSDG3sZW+CYjblVC/Es9a2PSay0tDBlt1FE
 byKua9WlGu0y3UfltY2syZZk1zI1GdFilgmF5WePl9QUHARfxOmXpuJWA4SlhWYZxLNF
 xdyxkoUpSDFG4ebw3s4SpLZ1+2iQ3nj8wvrDdmCzs6YwmCYvcfbAI9IgDT8+hadnveSt
 BpGRbNMkOaDTO8G69Qk8jkSQpLnJY8gWqr6zugSwLN9NwJWUShfpBYpZYezRuNmvAYAe
 ku8gQ3hWu+xi09jc5tcd14/iOJGKlfawYJUkV4sfp4o+tPEATAZr+7k0uKLyweRmgzB7
 qeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xBOHLIgzzS+cZLXuoOhLEV5Djuhr7s8VvLqqjTlGHNI=;
 b=Ore9D/31/++1tfdQot9/hFSCfv12AiIaexe4qZdFeENJg/I+GZvw/rzIxCN0f2EuZv
 iBVhc7d81bR9gRWHoOe95iDY+dC5OavPFb864k9TWZiRvjEfw9oPmLbOUaOzJNKvxIDr
 4LBc3ZVcu4Zsv9+WQ6ipMeSLIPfPOR3SKctMgpTVpr4Chqf7OMOVENDaBPx/o0JceBaC
 hg1ihAKoX9WNSa/9Up6C/H2GfOD54tiA1U1hdh8IwU3uZMTmeJ3wUZ9eGgk4O0i61/eh
 4xwVAYEh8tFYfyOk/ZS8TN70vAUE0p61d+sl/GXNu2U/hyasS4HrLzuS7P0Uaw2bw4t1
 +Wfg==
X-Gm-Message-State: AOAM533jDv+GCxt0AtPwoE3T737Zyu9LWo4Y3Y8wZ0OtZE8qtD+Zuje/
 OkTuMMFCuOUOWTapxoa411DI+TKGyYH2arhf
X-Google-Smtp-Source: ABdhPJx0An2o17UGp72a+1OQ9mCUVSV/KLSwc5LpdLJfM5hFi/7vsVHpWr9CTHjduc+70VF6EN+3pg==
X-Received: by 2002:a62:5212:: with SMTP id g18mr124535pfb.8.1599644840472;
 Wed, 09 Sep 2020 02:47:20 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/21] meson: disable crypto tests are empty under win32
Date: Wed,  9 Sep 2020 17:46:07 +0800
Message-Id: <20200909094617.1582-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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
These tests are failure with:
ERROR test-crypto-tlscredsx509 - missing test plan
ERROR test-crypto-tlssession - missing test plan
ERROR test-io-channel-tls - missing test plan

Because on win32 those test case are all disabled.

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


