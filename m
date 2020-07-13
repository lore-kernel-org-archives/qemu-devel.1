Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7940C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A95520758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJjSaNUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A95520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwCi-0007Ic-O4
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1juw7k-0000CZ-Gz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:52 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:42075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1juw7i-0003xE-HX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:52 -0400
Received: by mail-lj1-x232.google.com with SMTP id h22so17028753lji.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=GariDzhBz8PEV35gIgjvw3gtx/O6mGsCSHkRgoLonyE=;
 b=CJjSaNUKmsiorUMpqvjTu3aIoZOKtOOakDf9hX977Fe/y9ZcV2Gq4llnHiuxlW9X+2
 i+YUknCxDWA3egi5+a37V7H3Owqxt3lIIYuQ6joGjdo6XwiRV68vh4j5VBiXUOzpKhaF
 CtZFWNIGn+NtFev01W7MF5K+Ozrl8PSyNEgaZwIMms/Uj5MJLsemz1ZQNPpgmz3JtirS
 uwWqmexoC+7fMIntA/e924CdtuIS2NpgAGI+ak+DYRM3r+W6mL+NztryZIhpDVz49NFL
 4OKgZz209OOV9b8Lonr0tWdQXBR103Sh4qoxUwJSln1bKgZ4XrVScFhS2E9gQ2fWiw/w
 5hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=GariDzhBz8PEV35gIgjvw3gtx/O6mGsCSHkRgoLonyE=;
 b=nRmj3RoEACgtJgxEet49zVnWqjriA9WmwbhJeOlhIRM8gNbN/YbruxSTM6/I7nFsel
 CXNakoJjygbjK6TYXmuonQzRU17hZaqBN9Oae8EZWOcvlKQkzug6VcWKZEoL59/Q4C11
 jOCeT7VhdH1ecwXzY1iIDWKwZ+d4ZIuE+U4WZ4RXzEHuj6tcheORnYaTXHF9R+7+fAFt
 2w46HuwaBZpXkldqie9WjvQZczNfbZkpZPrZlwSaKKkXUgh6nrNPeQeILPw3gOtMSkcs
 qD0CDYUDIpgs+dNuiUjoOOn/iHbG9YU7wps8wPkAslP2HTyPOw7IUuRJVYjfkzx78gW/
 v8Gg==
X-Gm-Message-State: AOAM533ynBzrrO8ytyKTuQ2E7VwdlEe+MbWkRJQk34CoHGzQ1cAaC97c
 BUniJMdFR+qMt7BjRqJc8BRaV3FVRkwExLiJGKfU8UMsnmg=
X-Google-Smtp-Source: ABdhPJyK+BDgDzeWeUzou7g+N5QDjGp/azKdtav23D/zaeudPVyHmz96ev8SB96Pz0nQMP8B7+rimS7arrCiTq5ckKQ=
X-Received: by 2002:a05:651c:14d:: with SMTP id
 c13mr12727477ljd.409.1594637747664; 
 Mon, 13 Jul 2020 03:55:47 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 13 Jul 2020 12:55:00 +0200
Message-ID: <CALTWKrXdN6D+_BE_mCTTdWGf3SwyrB1hA9oo1kJqrCzVfRnH7A@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#4] Listing QEMU
 Helpers and Function Callees
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x232.google.com
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

The fourth report of the TCG Continuous Benchmarking series builds
upon the previous report by presenting two new Python scripts that
facilitate the process of displaying the executed QEMU helpers and
function callees without the need of setting up KCachegrind.

The ppc performance degradation is then re-analyzed using the new
scripts. The report also introduces the analysis of three other
targets, hppa and sh4, explaining why they were not affected the same
way as ppc, and mips, explaining why it showed an increase in
performance.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Listing-QEMU-Helpers-and-Function-Callees/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
Report 2 - Dissecting QEMU Into Three Main Parts:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html

Best regards,
Ahmed Karaman

