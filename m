Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E96207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJSE8DOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E96207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibjA-0006W3-P9
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe8-0007bx-77
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibe7-0004Ne-12
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:38:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id r15so2557213wmh.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rEdfwRSO3GyhnFXhhrEW06DMlH84FkvCaHVKL6ZFOos=;
 b=tJSE8DOPg2yirOHecRe22tQjHagO7HeYDvpYpBGE3P1GUFi1odwM3tLMmUumDJrl9/
 4q0cIZFqWSL+HDM8VDaWRYCICYBjkXl0wL/3eBAf09+CarR0BBMZs0kHh4oQOdP6h+E+
 GOQL7jK3lEV9MJlJzoisAznR95Fe/tq7qZAEyglBZ97njt5yvi+t18sZEmUrR2F01cz3
 or7Oh0fXnf/mPyAqCr9eDwjr++hBH5+8HGkBZt14Ftkrhu3zrMAEhyJ4rpiVmBkcDk6T
 NZObz/hll2mhZdDGRQ+3T0uOQz1xuXnNiN9fqJvDDRSyGXDXIgOwkrrD/peIuo//pUdS
 zlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rEdfwRSO3GyhnFXhhrEW06DMlH84FkvCaHVKL6ZFOos=;
 b=RrZWOPpeGziWCxzT6cHHXGsOGj3P0XnwXxm9ShvRmDlpDP5YW1kKOTjAi+eAn8sebQ
 /Q3wym6GppAMNWe+IFM2J7WvzLd4uNf2/2Ig9+odMDMlX3d/cyTJCNguoWrJs91SL8/6
 C8pWzvYuhb5OB0wQaVcFUvYikM7xCTVzjf4SZ+kP/5httr+zjv0nOTnX2PLsG6iFIl8B
 3NiZcs4G6uo1caRBliSVsgUgatRil67TZqCpcGXK/LkoEAoVNAVk/IwNAPsY03Jz4KRg
 MM03cwe7OfKoxXt6CDNU2rcPxsh9MiWwurqMP0h5NR6bpMdTWlS0YbWkgS+cNSEAe17a
 j48Q==
X-Gm-Message-State: AOAM5315lo2GPnP30iQYi4H9GG0GZr0U2lskrEkfUdMj9QotGss+WM8J
 nKGz6XmUQOLiQwuluOJXumIgOt7CXpU=
X-Google-Smtp-Source: ABdhPJzY8CbbUcyFij5CGrcsp7EqAarS1ORGmmh1fAfKvl3HHmaqJ5fvZKabJBn3Zvx8rw/wy7ktXw==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr3328803wmf.100.1591699096435; 
 Tue, 09 Jun 2020 03:38:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v28sm3126530wra.77.2020.06.09.03.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:38:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7507B1FF8F;
 Tue,  9 Jun 2020 11:38:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/17] tests/plugin: correctly honour io_count
Date: Tue,  9 Jun 2020 11:37:55 +0100
Message-Id: <20200609103809.23443-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200605154929.26910-4-alex.bennee@linaro.org>

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 878abf09d19..4725bd851d8 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -28,7 +28,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
     g_string_printf(out, "mem accesses: %" PRIu64 "\n", mem_count);
     if (do_haddr) {
-        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", mem_count);
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
     }
     qemu_plugin_outs(out->str);
 }
-- 
2.20.1


