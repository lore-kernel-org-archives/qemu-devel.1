Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5870C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7519020639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9YILFG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7519020639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9lE-0000i4-Oo
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kA9ka-0000Ep-27
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:30:52 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:46563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kA9kY-0002DH-Cv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:30:51 -0400
Received: by mail-lj1-x233.google.com with SMTP id h19so8994650ljg.13
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=caqhb2C65aUW67atjNi6UlHxXKVVBs0vDcFMl3D1IT4=;
 b=c9YILFG/DtvbJPbEKwYJ/IRe07cvH+xnRjUWALag/BY8/VZE2huyMra7xdCAELJZ8y
 8swB89bYoAH7EK85A3J0TZ8aFoqscudwX36TsXvJwgkBak4n/m5A4tWPKABfdpkcVKG6
 kPkfJJX8o35MpmlaUFLO9CTVSHZUoZ7Sz9VzbiM9kbeZGPptKMIvA+plnR4fOBLPqyBI
 EC3CVP9UNujfmTL9hIoifnX7DaOw0B/AtX0a/vj/v4XGwRtNy8bbqZdMaGCaHyGdwc6v
 r8Sr1r+iHgOWUhEsEwrpmYpxx1KthM2qr2NLHwVru3twkeJc9iLWY6tyqtuR3LCdOHFr
 Sudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=caqhb2C65aUW67atjNi6UlHxXKVVBs0vDcFMl3D1IT4=;
 b=GTIUn33MjLLxUo4pyIoCJsJvfGuF4xsdD+hAl/YJWCOiX9qzXdBkMqGbRrzo7SLjrc
 Us1aAZyej3NIQiOj2+MCfQQ/98SBkqRfCya4VnmeYHzl+iD74Qf79z60lhl3T2NH17RN
 otKuOlATEeg3uwQHur2+g8PB7+fMkvD1WVfVtHyA+VILbjiZdZQRhXhnbPbJT9ZXvVxX
 s4gKe2BhkaX8ElxyQC/hWG5LF6p68jogZV285C523z6k0ZYCxBsV9IdtMvWYMSW7fkYA
 Zd90c1P/S1x3HZJtPoiZE/AgO6RtLNho+a/kWRUjlpjw4kzFmFWkTJ8XOISDHq76QFwz
 D9Ng==
X-Gm-Message-State: AOAM531ffZxzL3uRkN56gPQZ4zt15NoHfoCwBBjuZBhzSMbBfuqRfHqI
 Vz5MCzMch95cBTaJS0TSt9snk3BH50HyvXjat8lpJ/jCnZBuew==
X-Google-Smtp-Source: ABdhPJxbKu2g9tuSSt7Qcb3oe8uLgd5opbou4oUFWLkh0uI2swVMnzlsHNIbyW0FNNPGXD1ikx6cJATXrOU2M0CMa28=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr2162435ljk.119.1598265048303; 
 Mon, 24 Aug 2020 03:30:48 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 24 Aug 2020 12:30:00 +0200
Message-ID: <CALTWKrUjCNQDqTPFGXF7rUsQvqem0VuL8Ufa4JB8y+S-vk1ySA@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#9] Measuring QEMU
 Performance in System Mode
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com,
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x233.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greetings,

The final report of the TCG Continuous Benchmarking series introduces
basic performance measurements for QEMU system mode emulation.
The latest version of Debian 15.0 is used for testing and comparing
the emulation performance on five targets (aarch64, arm, mips, mipsel,
and x86_64).

The boot-up time and the number of executed instructions are compared
for the emulation of the targets. The report also introduces a new
topN_system script for finding the most executed QEMU functions in the
emulation.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Measuring-QEMU-Performance-in-System-Mode/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
Report 2 - Dissecting QEMU Into Three Main Parts:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
Report 4 - Listing QEMU Helpers and Function Callees:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
Report 5 - Finding Commits Affecting QEMU Performance:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html
Report 6 - Performance Comparison of Two QEMU Builds:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg07389.html
Report 7 - Measuring QEMU Emulation Efficiency:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00098.html
Report 8 - QEMU Nightly Performance Tests:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03409.html

Best regards,
Ahmed Karaman

