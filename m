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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7772C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCFB2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZozQ3uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCFB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG556-000239-8h
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG53m-0000NO-Ax; Wed, 09 Sep 2020 14:43:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:34687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG53k-0007oR-Qx; Wed, 09 Sep 2020 14:43:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id v196so3070542pfc.1;
 Wed, 09 Sep 2020 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VE49ZNwXmJO0oiZLGn66FYFMfa5GjTxPVHs0mRhL2ZU=;
 b=eZozQ3uq8l8PQp0TiptQYeoJoDOLixwzFMLfKGy1YoSpn4sjSimEilxMqzPZk5cLCc
 oZ/AevTMx3JUhbjLTXXJEdwwmIAEZ9aIa54gGeZw36RTPkbRc9GhTcR9Hy64xcjcwx5v
 6uLLDKS25zfAuTQxw31TXYRNyWm1IMzZm9aTFH5aQ1dAomj55XVO+JVWnq7Ui603Q/Gm
 ngloVGMOs7M1yXIQRRtBOEIm3pzkDmE0E7vSTqn049l0q0uDZlpSUFI4+73BguIakuUZ
 Llrysz0rFnfmimgZUAoKaFoDes9giV4yLX4DDpHjNCOIU1vo+7CTEBNP696buc8MlWCZ
 jdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VE49ZNwXmJO0oiZLGn66FYFMfa5GjTxPVHs0mRhL2ZU=;
 b=VySR6K6xOxa//fInb56z4wrgZKXAiu9Rm9p1pu0m06D8H88xDkZ6ds8vTpHNebIWyD
 BdaGwo1r/GqTqqYapH8/SArLlakEe0fSPMssKkNLwku963c2neo78y9aCyQF8qRFrGtT
 mcmAGG8nVwkAkEh8r53kdffiXk4TN5qRGvPWVDW/OYETKsrASzMIs7h8aN85lnCpwVkg
 Fp3ze+alC9hcbvu3kBrhudEJB6DpJ/LvdlmQpzLNRkyJYt/s1ABJhP5IMqcGycOqI/J0
 aMVb8WvPVajFQpyTD1+B6yGhKYPH15sw/B59gJ8Xsj1j+aCktca3nIMCklJeXDdrl183
 4rgg==
X-Gm-Message-State: AOAM532rmi9glzoRZVy4oJDxASG/BiAioVZjwY/n3ao8ar6R/SpFkxdP
 CFuYeFEHLrJWnwkB5N24Wa88+aBf807eyZkp
X-Google-Smtp-Source: ABdhPJzQhYdhaWE0AuhnSSYJ4PrEu8rrJy/l1EwX9Rr1oh7wpqJBE4Efc93R4P6pAGpFLEXVinc4XQ==
X-Received: by 2002:a17:902:a40e:: with SMTP id
 p14mr2031587plq.4.1599676983844; 
 Wed, 09 Sep 2020 11:43:03 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 63sm3521673pfw.42.2020.09.09.11.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 11:43:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 25/25] meson: guard the minimal meson version to 0.55.1
Date: Thu, 10 Sep 2020 02:42:37 +0800
Message-Id: <20200909184237.765-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909184237.765-1-luoyonggang@gmail.com>
References: <20200909184237.765-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42b.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So we can removal usage of unstable-keyval

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 0b1741557d..af34a85bec 100644
--- a/meson.build
+++ b/meson.build
@@ -1,14 +1,11 @@
-project('qemu', ['c'], meson_version: '>=0.55.0',
+project('qemu', ['c'], meson_version: '>=0.55.1',
         default_options: ['warning_level=1', 'c_std=gnu99', 'cpp_std=gnu++11',
                           'b_colorout=auto'],
         version: run_command('head', meson.source_root() / 'VERSION').stdout().strip())
 
 not_found = dependency('', required: false)
-if meson.version().version_compare('>=0.56.0')
-  keyval = import('keyval')
-else
-  keyval = import('unstable-keyval')
-endif
+keyval = import('keyval')
+
 ss = import('sourceset')
 
 sh = find_program('sh')
-- 
2.28.0.windows.1


