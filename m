Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABF820738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5DCWZ3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABF820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Yd4-0006Bp-1D
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2YcS-0005fg-Mq
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:27:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2YcQ-00065M-Up
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:27:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so33886189wrw.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bIca3G4w02Pb4vz1h9G48iMfKF6O/OhMhUC0oktLOgY=;
 b=M5DCWZ3a7Q7tmuNNG2Gc376blLVvuTLCXVzpTZzuhxZVWwBf7BFLqZEs4gLKSP7Evy
 g2iMsKqRw46a/denypxwsK+n1vepmN+mODxEBXZv3o3DMwfBSLQpV5rayG8b6jwA8csA
 YwulaOY9icT4OuWNSFjjxMvlslaLQRqcYjn4PDkGqVcrDexTOWCTiJLCQExdEWVTVfEH
 Qiuu7Rzk7b0MJR6y1eu6OdlJQdxExsBRGZTmjrwHHHjhbsn1qOByEGOxwvbAu3cRAkzy
 vKptjj3pYvdYAAf8WxHO5w7HJCrOscLUCHbr6bpXyYRDaJcdIuOJIpET4bdNTQ7Yfxdg
 LtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bIca3G4w02Pb4vz1h9G48iMfKF6O/OhMhUC0oktLOgY=;
 b=kRYSE+g09Y3AIBL4i7is5O7hSDh0YFhMnVWnMFWXN0JlTAjd9glmuANunxBHr/fVvH
 cHGmayoG2S78bOq7tkbuI7jLqSQkKs+2aEQGUOxlJYm0rD8ED/t/RWwNmJkRxf7HKTBU
 swz5Z3kSI/DtbPr+asw5PkUeuuw5NcmFO7JRALfWSRQlEceR/f+GWGpxIyeiPrdC1wvN
 b2i2VOo8YYU7XOFtSftDzUHBMyqOxE8mx4zT2L9fErb+kLMM8IaogbD5ubDrOJ/OA+41
 mJtBN0KzSNiBV+vcNzbNR7+Fm4tLSRyZ0FS2zTJp1KGlKRalxZuy7OeO82bMM7iUUx07
 zupw==
X-Gm-Message-State: AOAM530EQIE8GZUJz0SiEfcVQvh+5BAmGCUTV2l3NPp4uobQaIA2Rr64
 mhf+yLwdrDetPNYEa6WKr54ERQ==
X-Google-Smtp-Source: ABdhPJw7nkRLvdjaY2gE5zT35ialNJHIbTBDOnYOr49EKsqrbbXIQi/9Gq7AOwjWlxIw8BCivLALGg==
X-Received: by 2002:adf:e704:: with SMTP id c4mr16078042wrm.81.1596454020548; 
 Mon, 03 Aug 2020 04:27:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p6sm24252083wmg.0.2020.08.03.04.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 04:26:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7B061FF7E;
 Mon,  3 Aug 2020 12:26:58 +0100 (BST)
References: <20200730193932.3654677-1-yuanzi@google.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lirong Yuan <yuanzi@google.com>
Subject: Re: [PATCH] [PATCH v2] gdbstub: add support to Xfer:auxv:read: packet
In-reply-to: <20200730193932.3654677-1-yuanzi@google.com>
Date: Mon, 03 Aug 2020 12:26:58 +0100
Message-ID: <87bljsnf5p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Lirong Yuan <yuanzi@google.com> writes:

> This allows gdb to access the target=E2=80=99s auxiliary vector,
> which can be helpful for telling system libraries important details
> about the hardware, operating system, and process.
>
> Signed-off-by: Lirong Yuan <yuanzi@google.com>

I cleaned up the test a little:

modified   tests/tcg/multiarch/gdbstub/test-qxfer-auxv-read.py
@@ -22,13 +22,9 @@ def report(cond, msg):
 def run_test():
     "Run through the tests one by one"
=20
-    cond =3D True
-    try:
-      gdb.execute("info auxv")
-    except (gdb.error, AttributeError):
-      cond =3D False
-
-    report(cond, "Display the auxiliary vector of the inferior.")
+    auxv =3D gdb.execute("info auxv", False, True)
+    report(isinstance(auxv, str), "Fetched auxv from inferior")
+    report(auxv.find("sha1"), "Found test binary name in auxv")
=20
 #
 # This runs as the script it sourced (via -x, via run-test.py)


Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e

