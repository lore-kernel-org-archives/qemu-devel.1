Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DF0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34052084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/X0Ajyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34052084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3C9-0005gv-RS
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AK-0003q8-Fd; Thu, 02 Jul 2020 13:38:28 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:36613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AI-00078d-K8; Thu, 02 Jul 2020 13:38:28 -0400
Received: by mail-ej1-x62b.google.com with SMTP id dr13so30741788ejc.3;
 Thu, 02 Jul 2020 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yYAqTFaG3IJZ4oYAHm8QxvnWNnh/bKJUXtdm8vNz9n8=;
 b=l/X0AjygPlODGRcgFVDHU7gQEpN9iYtLRLD+3t/Di77Ug4QFmuUV1J9egsAKLxLKnw
 QTdCYAcdMxXIc7lQ5SApkLUrPvtFBK19ifl3LH3R615HwhEmbwSI7LsmZ/b1b1FKcwjs
 QlAx5BTTUj5C0licE01E2TIMeaEaPG3mGI04KMQz/I5yltgtQrq5wNId1p8RA60/lkcv
 6jF+lzcWfvSUkB/GLpjPnQjfzvRbsRjMDb3QG4J3S25X9YfQiGkWJ98AwadO9SSLPgpv
 426Q4cnHvBjif9/f8nsD6gpnMB3Hzo2Klmse4sgRBaLgTVyVRiltCzdhwvD6Rr6J5zZ2
 pphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yYAqTFaG3IJZ4oYAHm8QxvnWNnh/bKJUXtdm8vNz9n8=;
 b=LiZOvc0VjtNVU3So3RAuFmjpCcBAyzEMycWU3suZ/5zqb4uEEts5vlhrOnKsrewrrj
 5ktXaSCKrbSNUlpTsNk5Ad6As+X6WigucHzUEHP9cEYW5pXf/dxfRXH85o3d+f8ttqBl
 bmbxkkZ+QRPg1VjjH9RcHZHtPF7ORoX2ssEyq7qdVTEcsqnswdGfUALzqb5JwD3/RWUn
 wgVZMUohTXhnvIrX4sIgEPpyxiZhf5HhI1Xttty9hNPjr7J/L3sYBOLb34ZhkB6zcV1Q
 9kpqEMkf5+Wfb6MC5aX+TTdA0hiS2iKdfrI6hkor+KP347ZINMCtW7VzV3KMcVD8AgnY
 Ecyw==
X-Gm-Message-State: AOAM530ggtNXmn5uSd6aOAWG5JVQiHqRCroogos/ZtEER7W61nm/t4YW
 TbQwcCe5vcCMHLK9D9Xj9DEp/G2IfAs=
X-Google-Smtp-Source: ABdhPJzNHHHznny+xzU/+lQjf2m/xdh2IA7cyxpzqQKEIZPQ1QuV2gKMpMa3Eu0FKXUS/8jQCuZTOA==
X-Received: by 2002:a17:906:2b9b:: with SMTP id
 m27mr17376773ejg.19.1593711503804; 
 Thu, 02 Jul 2020 10:38:23 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/19] .mailmap: Display Andreas Faerber name with diaeresis
Date: Thu,  2 Jul 2020 19:38:02 +0200
Message-Id: <20200702173818.14651-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?F=C3=A4rber?= <andreas.faerber@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Andreas Färber name in the following commits:

  $ git log --format=fuller --author='Andreas Faerber <andreas.faerber@web.de>' --oneline
  165ceac095 qemu-timer: Move include for __FreeBSD_version to header
  5d7ff5bbde TCG: Mac OS X support for ppc64 target
  ea5ad306ba Suppress optionrom build on Solaris x86

Cc: Färber <andreas.faerber@web.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b1e4cd97ad..a539ae8222 100644
--- a/.mailmap
+++ b/.mailmap
@@ -64,6 +64,7 @@ Aaron Lindsay <aaron@os.amperecomputing.com>
 Alexey Gerasimenko <x1917x@gmail.com>
 Alex Ivanov <void@aleksoft.net>
 Andreas Färber <afaerber@suse.de>
+Andreas Färber <andreas.faerber@web.de>
 Bandan Das <bsd@redhat.com>
 Benjamin MARSILI <mlspirat42@gmail.com>
 Benoît Canet <benoit.canet@gmail.com>
-- 
2.21.3


