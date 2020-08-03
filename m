Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5878CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2913720722
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcC9swZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2913720722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ddj-0002DI-FG
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k2dd0-00019x-Pk; Mon, 03 Aug 2020 12:47:58 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:44975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k2dcz-000817-7S; Mon, 03 Aug 2020 12:47:58 -0400
Received: by mail-lf1-x144.google.com with SMTP id x24so3499817lfe.11;
 Mon, 03 Aug 2020 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3fXnroyHhh2ZypZpfGGO1PqM+ePmoBxOOOVQb81ZRiY=;
 b=dcC9swZj8gcPxwofo5tJRqnNuqX9AYxSkseMSxDALCa8JW7eaxaN4pIe1GFLSd6fvf
 /kTlMS0lzxwPNtGJbsuKNA+KtwiefRI6900T4VU/M8fOrsDha5Wni8Ul34ZUdOHF6PPJ
 TyG6UuMk/+vKwcYW9vQeyH44rj6SMruAoK89IThKgipd+8j9gcTwZH+6YFgpvRvHhUJ6
 4vdU962WT2wnpaS4davFY+gVlvq4o0+mtJpfjARN/U8o/zNHkA65l2f/VfX3ehkvNkfg
 7ewHREf2UmzK3yXk3NQqEaPomGnmJT8UM7Y4EkVTEFCjzEY5nnVcJwnLWxGO1raMqFlr
 mcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3fXnroyHhh2ZypZpfGGO1PqM+ePmoBxOOOVQb81ZRiY=;
 b=RRJ135uZor2Bn/P5HQh3S6ckyF4lnE3GVm5rXPHpw3zzn2ICoQ1pVBwcbPQGLO+9Jj
 iJRGwjS99Cwnr0QDA+nJdSiSsjpQJk9aTtNbhmMzizJWTDUZiZsEDZbc3A2UvAsZflMZ
 yRL95/6rjeUwNwH9pQeZc9PaTkJntib/dedK960mqSrzNaDaCmgM/P8g5A8DOv6FJyXr
 2iOrLGuIb5e2+SbOeV9iJwpi+oXEJ4zjrMrSpocGLjnceO/Z1YF3zuTMOoEXWl9O+P+L
 2LPpGWRdBo8R1+hsakuRUJKgPt9MDoQgjINrw2IN8yKo02pI64f443/Je1H67/C+pUaz
 4OIw==
X-Gm-Message-State: AOAM530WhF+zCzPK7b+0Pl3y2zoinggc0ZAQG1EQ+YaxVpMSXMYuEHPw
 NiG6zk3GqnMXTnJIkISGs8jIpJ6z
X-Google-Smtp-Source: ABdhPJy0IMty4AaQ4/qlJt6L+meF+5mlfCuDmxL9V8D8jR1K8vHh3RS4OuIoLt+85cQzCHl++9P4Xg==
X-Received: by 2002:a19:7710:: with SMTP id s16mr8957767lfc.162.1596473271168; 
 Mon, 03 Aug 2020 09:47:51 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 16sm4396867lju.100.2020.08.03.09.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 09:47:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] docs/system/arm: Document the Xilinx Versal Virt board
Date: Mon,  3 Aug 2020 18:47:48 +0200
Message-Id: <20200803164749.301971-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

This adds some basic documentation for the Xilinx Versal Virt board,
including a few command-line examples on how to run ARM Trusterd Firmware,
U-boot, Xen and Linux.

If this looks OK I'll send similar basic documentation for the ZynqMP and
Zynq.

Best regards,
Edgar

Edgar E. Iglesias (1):
  docs/system/arm: Document the Xilinx Versal Virt board

 docs/system/arm/xlnx-versal-virt.rst | 176 +++++++++++++++++++++++++++
 docs/system/target-arm.rst           |   1 +
 MAINTAINERS                          |   3 +-
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/arm/xlnx-versal-virt.rst

-- 
2.25.1


