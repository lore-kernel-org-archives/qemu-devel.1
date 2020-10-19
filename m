Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5AAC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB0F222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNaatsSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB0F222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYJb-00048p-GR
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUYDY-0006DR-Mm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:41:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUYDW-0006uR-9Q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:41:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id e2so185711wme.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+BolaTrCd1wVwrGXLni5DjU/jWn0bUFOsPgEjRRayms=;
 b=fNaatsSpxcgF32gSKQ8Vz7Xa1oUTVq6wNFQJ7+naUj1prs4Z9DTAxNkiDxJZ0+UD81
 FIT8MMlFAms7e2UCn4JAqUJsndLUvUTFzlgWDPCoq8Nko5NgjeN3qciX5CdaBoHcHAve
 VZ6nsIaIZ+6Yi37LyhvocJXOcrWtlS+T+B10ETS6ILYKrA1ZrB+WWURmx6FY/RSyvLb3
 EsizQGGAmmbGpQ1op5yb1HIzK2Z8u8unlScOvIgAjQJxtNlHvZv47blKD+z1R9VhkyDX
 skSiAn+rrOCNVrvyWLgi0yrJVCdXs+Tx059ppmnKUDjK0wtI8CeT5Ogr7f24+CGDkfFY
 Uaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+BolaTrCd1wVwrGXLni5DjU/jWn0bUFOsPgEjRRayms=;
 b=p5eD6BfkK80cq1ibgQUULjvDZMEq1s9eAvcjQhPHMoYMfxFeEYuDnlBGf/kwRhACZA
 t0CxTlp3yEInhiWu4zWp8mWAoAX9hhg2TOsrhzp5SwfeYrYqwozTqyhp6YT/P6kO4Z6Z
 M3Fl5VE0u2Pe3LYGxmwXBpx921Ci6dsTi7U0POE7W57IyeDr/jqlJQI2gz/rRpUxeQyz
 hFkNT6q+qwpl9kS1YYwB0pdn5zfb0vo1J/VNx1d35o9i34ZOKKx6D4bAlAgU3q6xAdFS
 tYNyNhkfk6e/mL9ZJ1URqOgvOz/Ew8DiSvsfHycn3Yov7wlrFT7x6nouNVeRjM1xWScY
 qFTA==
X-Gm-Message-State: AOAM530KS7iwd8riegmJJcpwiSt++iddHtN6BZHHNAS9tdLaRNYBsiIT
 F5jI3tjg5A9Ax5dqMPyN3J1SuJEUdNavp+Vt
X-Google-Smtp-Source: ABdhPJynaB4U80vpmjExXBBLRvGTo8UfdIBgyNdmAT+0jxEjqm8djmdYKEYIiyNZM7zc31rBubpU0A==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr102307wmc.150.1603125660437; 
 Mon, 19 Oct 2020 09:41:00 -0700 (PDT)
Received: from [192.168.2.1] (net.iroazh.eu. [109.190.73.171])
 by smtp.gmail.com with ESMTPSA id u15sm307256wrm.77.2020.10.19.09.40.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2020 09:40:59 -0700 (PDT)
From: "Emmanuel Blot" <eblot.ml@gmail.com>
To: QEMU <qemu-devel@nongnu.org>
Subject: Re: ld: file not found: _PreallocMode_lookup on macOS Catalina
Date: Mon, 19 Oct 2020 18:40:58 +0200
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
In-Reply-To: <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
References: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
 <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=eblot.ml@gmail.com; helo=mail-wm1-x331.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19 Oct 2020, at 17:50, Philippe Mathieu-Daudé wrote:

> Cc'ing Markus/John/Paolo

I never used `git bisect` up to now, so I might be wronb but it seems 
the issue would have been introduced with the following commit:

604f3e4e90c011a6b94fdc1d13700f3ec2375f2a is the first bad commit
commit 604f3e4e90c011a6b94fdc1d13700f3ec2375f2a
Author: Yonggang Luo <luoyonggang@gmail.com>
Date:   Thu Sep 3 01:00:50 2020 +0800

     meson: Convert undefsym.sh to undefsym.py

     Shell scripts are not easily invoked from the build process
     on MSYS, so convert undefsym.sh to a python script.

     Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
     Message-Id: <20200902170054.810-3-luoyonggang@gmail.com>
     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  meson.build         |  2 +-
  scripts/undefsym.py | 49 
+++++++++++++++++++++++++++++++++++++++++++++++++
  scripts/undefsym.sh | 20 --------------------
  3 files changed, 50 insertions(+), 21 deletions(-)
  create mode 100644 scripts/undefsym.py
  delete mode 100755 scripts/undefsym.sh

