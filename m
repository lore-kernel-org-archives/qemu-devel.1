Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6686B206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/AUBLc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6686B206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolI2-0001uF-Na
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolH5-0000eR-OE; Fri, 26 Jun 2020 06:07:59 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolH4-0005tK-5g; Fri, 26 Jun 2020 06:07:59 -0400
Received: by mail-ej1-x641.google.com with SMTP id i14so8790276ejr.9;
 Fri, 26 Jun 2020 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=nsylV5EKN6TiXHALQB7CK9Iue7qUBGaMeqge/7hcRSk=;
 b=r/AUBLc9DyRh1AL2IF5QFToFvf88lre/N3jnUK/BwOTNi3p6JCAjOJeCMFuGSi7uly
 TesksxHFnrJt/25hdK73ChJcZVBCQ2CcRYxjBGaUcFAvztat0yddoKPUx2EyLk2fXmGY
 VBbzMmYWLj6Rs1JFYqRRYGFSP5KjG5KAmaXfoFLDebsXSseIZnNxu5A8lowp2YKe2HPp
 qhwgqpN3yPMqqR8zSrP6i3MdC9mj5VkPBvVEvtgU2EzZ+x29ssL3W5H3Sm3VZLj00HTv
 bsAIWauZ68hgjTxnzEug7RicH3hfPkI0fU1JbGkcZQMNb00QDWbOwvnCCXaZZwhc39AV
 kk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=nsylV5EKN6TiXHALQB7CK9Iue7qUBGaMeqge/7hcRSk=;
 b=VApbsC3XhQqenZuJd+HUT3LthMKrorP/j/KiUaGfcDgTG8YPIgryFlruDoaszZhj7K
 20xPZG35dWlvFEWtDmCpOV3ffI3I8JvWbjgVshox3DTw3qewNaIRJmihFlCGsmSxPaFo
 fvqsjRyV8UUUxthOZ9UqC7h9+rqJni8Elx77+HkisInUPFKmIeE9WzTv9sUWvP3kRgnh
 ovBNRwsM588s/r6jiEhM2Kc04N4l0xIKVsLDnJyTFV26T6J1e59ktTs7Ht3kJ9DdMvSg
 Vtk3k1Fs5FLqQ2YN+vmyvpHA25ov5ih+DZJ5gBQseh7gKbbTNSBJahTb9CoHZgT7P5aJ
 bXLA==
X-Gm-Message-State: AOAM532/TnRpYw9XI8+vHvSo+QUKvtqu3QI4sQ8qxuYhIZ89qJrbrKzA
 ilfk1UC3LD1y2U69qggQDFGMasfxaxpDTvC2Eow2glga
X-Google-Smtp-Source: ABdhPJwtXZ8O1AZQyTyzNohtew132HxDj1kCL8kRYP/inmIveH635mFFCiQ6QS0hWb/4MPGWXLeomCH1OSNwgvU26R8=
X-Received: by 2002:a17:906:a156:: with SMTP id
 bu22mr1830644ejb.322.1593166076322; 
 Fri, 26 Jun 2020 03:07:56 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 11:07:45 +0100
Message-ID: <CA+XhMqyDzenX2BiR7CnvZc-J91wWCX8ra==T_=WCe3xq3-n2hQ@mail.gmail.com>
Subject: [PATCH 1/5] haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 4d0933384d2bfcd0fc8c4c06eed2d07f3f1b7f8b Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 10:35:40 +0000
Subject: [PATCH 1/5] Haiku build fix enabling BSD symbols.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index ba88fd1824..96ba4cf3ce 100755
--- a/configure
+++ b/configure
@@ -901,8 +901,8 @@ SunOS)
 ;;
 Haiku)
   haiku="yes"
-  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
-  LIBS="-lposix_error_mapper -lnetwork $LIBS"
+  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
+  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
 ;;
 Linux)
   audio_drv_list="try-pa oss"
--
2.26.0

