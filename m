Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C8EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB6020658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6nn4pcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB6020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjfn-0005Le-Td
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcI-0006Dl-B2; Tue, 08 Sep 2020 15:49:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:36204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjcG-0002XV-J9; Tue, 08 Sep 2020 15:49:22 -0400
Received: by mail-pf1-x42c.google.com with SMTP id d9so51269pfd.3;
 Tue, 08 Sep 2020 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=INK+kK1nWbJF7y+rXihzR5UqDDo3HdyPVAq4bdijot0=;
 b=V6nn4pcnL30ehqXQzPe1KBoBzzKm6eGqBUxesciQmyC8zX6UVJ44msCrAKEx5e9t7y
 TD/1Rn3SsreOBSOGOfSaf8R5aWQmVKRIxPU5wp5YqhmwDHdXcn6jvHoqFiA7V1HzaNDy
 Pt4uiiMKCSDlgMHFJyRldDrDpZqHYtGnKN8O8Kf+LyWl6YOhfviFAsGu4kx1rFfASE85
 5Qu7Rv358uzVCQsVLY4HFZP7hSD/maA5uefNBXLgVw7c8y2pWtv8bXeGaZcxmsD0fJ61
 8DFcgBSUsowLRPKyb5HPthfn/Vf35yHK8MgtXqiKcgfkpRsmoZSnVD5gcIQ8o/mPgg4I
 R09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=INK+kK1nWbJF7y+rXihzR5UqDDo3HdyPVAq4bdijot0=;
 b=PyKK73La6RYyDt+im6zNQyd0m9FiEjUxKoo81OcLhNB9LbCJjRV/scNM8YrPzipe2i
 ET83dAfTJpihtSyc4Tpny8pk9b4O6qcpyNj2sg1ms7ocGa5GCCJT9C8kqgXZhHPFrBiO
 eMOHviogHwoaq6R+TdCsWx2TvbKXnfvBvntqZPI/AkFzqGANAcRTxbKJGlV7YqPeLfFL
 tvyRI0nZ3tMPfST8PwCOFnPk3buDK00WZo6I//YxnNq5TpJYCHWvroGTcuYOJvyLnyb3
 rLqUl91votqnUbixcNze0ficoZs9HIznPg3pCabpj0QzOwE46IgWWxhrzA28b+C8Oo2+
 UOrA==
X-Gm-Message-State: AOAM530IRVRzkpjRL9gp3UwWgQWGHxhuvUX7tXbw9QNbWmPmsvW7vqvi
 eIb3a5OEpttcV77sMJpUZ8jyn6JRe1BwkR/f
X-Google-Smtp-Source: ABdhPJwUDRreLw/8rTSc/YKm5sOooQFPCdwHcxyxDNOBrOsWzOnRPWsqBHwJQc3mDrR6hf931EywWw==
X-Received: by 2002:a63:4405:: with SMTP id r5mr270755pga.382.1599594558554;
 Tue, 08 Sep 2020 12:49:18 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] meson: Use -b to ignore CR vs. CR-LF issues on Windows
Date: Wed,  9 Sep 2020 03:48:14 +0800
Message-Id: <20200908194820.702-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42c.google.com
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

On windows, a difference in line endings causes testsuite failures
complaining that every single line in files such as
'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b to diff.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qapi-schema/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..f1449298b0 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


