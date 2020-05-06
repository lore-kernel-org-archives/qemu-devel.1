Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7084CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD19206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="afMAA+H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD19206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWItc-0000pN-6Z
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo0-00067V-Ot
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIny-0008Je-T8
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id x4so2315433wmj.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZTJh34FGQCI152lwyVv0YTBLMCIdfCpxo+sU4MbJ6bM=;
 b=afMAA+H5YqNdc1Geqt97zuQ8Z32W7FIZw3TsHhdzmdUlfPcV1SqAAzpVIDD1ooWzKR
 e/xGNV9IbZHN8soRR1jkuvLYCnuMYqZ0Fkkhwe+4mb/s63VK98RK6rbApOdbJYjQphEb
 GgYsTpopVlL4lg38UgNwnJoAWeGiGVzrZzMF2gl/JQjCRIJAbbFWfumGHuv4UyLHYu10
 8RARMZeFOvjpkYgbtwC9tqnKVa0ShrAOEz4H7p9O2gbGaXTbuah/mnoOl55SJZs09GX9
 wO4HAo5sOCebogDZrWfJN0vtrppoDo/zbKYWFQfS2ktueV8w7aq4rDtGG2pKyIJuiBvy
 6BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZTJh34FGQCI152lwyVv0YTBLMCIdfCpxo+sU4MbJ6bM=;
 b=bApCGUIhUV1YRsqgmuqN6cDHxRiUEbHCI4B/enNGK6nk5snvdZCP3vayDPLCY6pmOw
 52gn0XZo+yE9jdiqSj1NPpVD4L83o2LcvNEfIjl2q00Q1SXSfzIb9KGRw3Azk6QQsFb7
 YXXnl/s4lYI2RpzD3p07U8l2+a07j3+Yx2pNjqXqbwmzvseGKL2lQdTjd69dyJ1VMFwl
 eTzg0Kgb+T/8ccCHAi9JYux/Hr9ILT0mhv+o6GAL4gA1SnSa+2sSC61JdWfcSwzHUSfV
 NljtF9wKSL8df6MwKzKfgLpQApHssHBnnjOUESeBmQ+ooWvLEPV6u+4xY5+zmD3BCdXO
 RIzQ==
X-Gm-Message-State: AGi0PuYPL6wPniYvqkXnWpWJW6h9lcEGBjmJiSNKwMd7ofNVZxwti4Lc
 IBjjoMlp1XMuQcH3PPZcdfYHvA==
X-Google-Smtp-Source: APiQypIcvNrbXeglYI0QTBJmkNzXle/skaCkV82T09XN2dy0/NyZ4cVCJNeeNN7yc7fEs5MZ1gLWEg==
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr4616891wmd.16.1588766736163; 
 Wed, 06 May 2020 05:05:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l16sm2390029wrp.91.2020.05.06.05.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C0821FF90;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/14] .cirrus.yml: bootstrap pkg unconditionally
Date: Wed,  6 May 2020 13:05:19 +0100
Message-Id: <20200506120529.18974-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Li-Wen Hsu <lwhsu@lwhsu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li-Wen Hsu <lwhsu@lwhsu.org>

This ensures compatibility with pkg repo so a change in upstream
doesn't break setup. See:

  https://lists.freebsd.org/pipermail/freebsd-cloud/2020-April/000234.html

Message-Id: <CAKBkRUzicxphjjkkxdgzB3cDSv=AszD5V4X499jT2BjiAaazGw@mail.gmail.com>
Signed-off-by: Li-Wen Hsu <lwhsu@lwhsu.org>
[AJB: applied from Li-Wen's github, applied sob, tweaked commit message]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index f06f5af2b93..de0727cb097 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -6,7 +6,7 @@ freebsd_12_task:
     image_family: freebsd-12-1
     cpu: 8
     memory: 8G
-  install_script: pkg install -y
+  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
     bash bison curl cyrus-sasl git glib gmake gnutls gsed
     nettle perl5 pixman pkgconf png usbredir
   script:
-- 
2.20.1


