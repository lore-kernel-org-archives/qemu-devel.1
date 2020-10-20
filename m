Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187E6C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188E72098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjTh0/rX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188E72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwGw-0002uS-8A
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwF5-0001AN-2s
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:18 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUwF2-0006zS-NR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:20:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n18so3358599wrs.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KeOiaW3Szwuf93h9a866OfPlvvAi1Y+2TobGv/t59pw=;
 b=XjTh0/rXrDDsp69Z5kY6djbYduxXSj67AJtEOHkOZke76VSi4+vTW8iImdX+l85zLV
 I2WwFFu4nPaV109jWBXv6mdD4Y/woLxD662BRjZ3IsueLNZCq9M8dUv+lamCv7V1gtTD
 qx16yzGn86GXIVhwdYNcSVCu46WUzCk3SRcIokjJzodjvoP0zFAd5CqiKsSsHGxa7e3f
 +ALpGia6rmRdRF3HP8EkoicQ9xA0BNlmednim2//HdZubdYD1CKjZpukmK7nwcVuABrQ
 tZ0yCE42hscH4H4KKmuVNkyLYP4632t3HCBv3CV45eE8JUGjeL3aW9cf7sC29vgyMtxD
 4fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=KeOiaW3Szwuf93h9a866OfPlvvAi1Y+2TobGv/t59pw=;
 b=Rar29oSetzR2NMB52B2r3DoLWLoJHxfGnOql/k8wL8xkH+6xUHylQHDx3n/lTjhDBJ
 BItX0wqKnc1W98ON+7yQd/95bYlcDJFZfcoraQuKfkPW0aFHxiFw7b8fpwPbJ+OKNYQe
 oinM0dn5HaQwUQFcsKmigy6R3AfCrc6wvQLjBCMq1b6PfpUdKda7VYDJVJgZTeKAD1r9
 b8S/qA1SOu55ASJKRFJYdhcgcRXvDi8Z74XCS/lZo1HgiI8/6srh6CqLb1PWWsgX/Gi/
 ETr1JtHnQomjPA8UA2ir8RlhsodaL5t/poQ/w20qk7/W035IHi6lhKZKwBo7xmAQeWyY
 ERIg==
X-Gm-Message-State: AOAM533epSymYB0ugWK66IrBCrs8czeWIARAUSvWS9ggHD+WZF9c+RiK
 X4TRDFRgpoY5AFnsDN8xwqaAoutvbeI=
X-Google-Smtp-Source: ABdhPJwMMtNbIl0ruoWo+U9K9PEyvSJaxb+CcFdnwPE5K8sl7kH/TgDyWkyZux58XrtGNiEokROleQ==
X-Received: by 2002:adf:818b:: with SMTP id 11mr4808100wra.74.1603218010194;
 Tue, 20 Oct 2020 11:20:10 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t83sm3856096wmt.43.2020.10.20.11.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 11:20:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/clock: Inline and remove
 CLOCK_PERIOD_TO_HZ/CLOCK_PERIOD_TO_NS macro
Date: Tue, 20 Oct 2020 20:20:04 +0200
Message-Id: <20201020182008.2240590-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following discussion and analysis from Peter:=0D
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg05853.html=0D
=0D
Last patch is RFC because I doubt using 128-bit is what we want...=0D
but I'm not sure how to round it neither.=0D
=0D
Future possible cleanup: un-inline these helpers.=0D
=0D
Luc Michel (1):=0D
  hw/core/clock: trace clock values in Hz instead of ns=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  qdev-monitor: Display frequencies scaled to SI unit=0D
  hw/clock: Inline and remove CLOCK_PERIOD_TO_HZ()=0D
  hw/clock: Inline and remove CLOCK_PERIOD_TO_NS()=0D
=0D
 include/hw/clock.h     | 19 +++++++++++++------=0D
 hw/core/clock.c        |  8 +++++---=0D
 softmmu/qdev-monitor.c |  8 +++++---=0D
 hw/core/trace-events   |  4 ++--=0D
 4 files changed, 25 insertions(+), 14 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

