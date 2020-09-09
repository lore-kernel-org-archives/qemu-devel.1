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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD224C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5995F21973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCCbY9R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5995F21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwri-0000CE-A4
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwhp-0007pH-R9; Wed, 09 Sep 2020 05:47:57 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwho-0007nx-18; Wed, 09 Sep 2020 05:47:57 -0400
Received: by mail-pj1-x1042.google.com with SMTP id o16so1069920pjr.2;
 Wed, 09 Sep 2020 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kj9TtIFHlCghHqJUVATBEyOAMMRb9PuUwVel+thcnto=;
 b=SCCbY9R59kWVgxQ9jIfByocS+w2whmewA9PVz+Pgr+QF8KDPwWDg3gFGS1JwprIsP1
 YaXfcfmG7oJ/aUYxnGM7tapff4qv655+q4vpK8zCuFdw6RQLVHOAizHFCsJv5SpU9gx+
 84h5DAsDwIHdvRekGSstdfp87NYO4tcoj7Ml8vfA4E/nnj0qtPgEPVTeCqBN1+324vhd
 yBQ/wdmbzCYGAc2TklRpeYeTOlHDn6bJS+eSjtmnJWYbsvBw83aGZVlL/UVnMdTogoKa
 vFNL6mcPsc6yzNkMyCxmWqdBKKmVNQZr70/aR/baCSjhk1Krzp39rk1xfLjk4sjanAEn
 NedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kj9TtIFHlCghHqJUVATBEyOAMMRb9PuUwVel+thcnto=;
 b=GWggFwFOXfA/RVfw4ig8K0Dyxa2pV27jP8z9z9GBfdvgD0ggSPUS0CJ1GFO/AHn+p+
 5rBSm/tKIhxi9EyOlMoe6qO1PWBCjE6qHQqo+egtQyDQCOxbCrfAxeyD0gQG0i6LJ0u/
 yr6vJ382SVKbzcC0bXQi/bQGcH+2YDm0d8ZXOu9FgYAdM7gfQETl8xxVvIH/Dg6i/NW8
 O5K5lJrdReCM2CVUjTp51DAzFy9YQCUgVkCOpucd9ajCL6kmdEoXVMQ1bwNS/ajVATeq
 1hCXT5fZfBULqYtqLi/O/UMp8Twpcba2aQjsWP1gcwS4Fl5qraahn2Rh9wIbOLFM7/dD
 8nvQ==
X-Gm-Message-State: AOAM531kGK6dnXfMJW/EddJrZLATS/x5uWFm+QNYQ4BhPrdmRDJs5sVa
 s9agzHnfijkaIgzv/712WPGojxJvRuSpYTXZ
X-Google-Smtp-Source: ABdhPJyMtTLNdBnfaIlGb25lmVZuqM9KNGCEPgAG3bGpRedKYmh6P1/u0Ic1r+fPsDtCBAks3dvpKw==
X-Received: by 2002:a17:90a:aa94:: with SMTP id l20mr94975pjq.95.1599644873798; 
 Wed, 09 Sep 2020 02:47:53 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:47:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/21] tests: Fixes test-io-channel-file by mask only owner
 file state mask bits
Date: Wed,  9 Sep 2020 17:46:15 +0800
Message-Id: <20200909094617.1582-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
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

This is the error on msys2/mingw
Running test test-io-channel-file
**
ERROR:../tests/test-io-channel-file.c:59:test_io_channel_file_helper: assertion failed (TEST_MASK & ~mask == st.st_mode & 0777): (384 == 438)
ERROR test-io-channel-file - Bail out! ERROR:../tests/test-io-channel-file.c:59:test_io_channel_file_helper: assertion failed (TEST_MASK & ~mask == st.st_mode & 0777): (384 == 438)

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-io-channel-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index bac2b07562..75aea6450a 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -56,7 +56,9 @@ static void test_io_channel_file_helper(int flags)
     umask(mask);
     ret = stat(TEST_FILE, &st);
     g_assert_cmpint(ret, >, -1);
-    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0777);
+    /* On Windows the stat() function in the C library checks only
+     the FAT-style READONLY attribute and does not look at the ACL at all. */
+    g_assert_cmpuint(TEST_MASK & ~mask, ==, st.st_mode & 0700);
 
     unlink(TEST_FILE);
     object_unref(OBJECT(src));
-- 
2.28.0.windows.1


