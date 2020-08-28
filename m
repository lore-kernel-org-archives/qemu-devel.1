Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A707C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxJTy6Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A707C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbfP-0001hG-V5
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbeb-0001Fx-FY
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:30:41 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d]:43541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1kBbeV-0004OD-Li
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:30:41 -0400
Received: by mail-lj1-x22d.google.com with SMTP id v12so712823ljc.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=UrlZ0vEsYah2VPiQnDqKrncKb05OTZCpuAqIFRXTQSc=;
 b=kxJTy6GnkNGOFH0W6ZBR3ozKIbNKZlNZzd/eY49vZ+w2gfqgfOIS5PhtTS1dX4kdyL
 wSWXtReck6WJE1I4pjmN1/u2n4c+SSnnAsjVhRzLkv0r2A0P0qe7+CRWkLwkxQ8hSZ1I
 PUwl+CFDjECR3zgPV8ZMojHvsFJDmQF5E/E0AOvq9zFyQ8B+5Qg6AOJ+ZdGTriIrurPt
 kLae+ul7sMGm05Sb84BR2yxJmDbTjyVNEVMJqv0bPt/BwF3r7FnXrNLOtCms9M5QRmjl
 AxPqVOrSNya2U6TCMagPHJPsF3dBNyL3SCqwAzD/a+Hqx4QxAkeRyET+QBho7q+0MNUt
 nuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UrlZ0vEsYah2VPiQnDqKrncKb05OTZCpuAqIFRXTQSc=;
 b=qYABb88Ipt3l1QxhH2OPKJtZ1fpWDh4ChXKpWjTW8+vMoe3AY1F/g69M2sSLOeVut6
 0KDFV1N1lQ+ewR97gcwULAeZCVdGHHS2Bd6jF9ml+7HVEawIvtnwtyNYZduK/q+l2Ici
 GOw3lPR1kNV2UfnDMGoJcDCE7zrYON/9nFmfFfNpctMCquZqWantiF7D/8nld4xs08oK
 JYnC1uGQcrSeLcHPGJlGfSHFJRXqT0DVHdqXKbFZHTtTFK6Wf8WczL5CurkVU/G0+5v7
 RspY0IYn7BkGWOQezHgmPRLXaGd3+8oeDpNERZFxZIX7FNT4WD0gxiz0IDx63lcx/8Sf
 W7AA==
X-Gm-Message-State: AOAM530dbeZ/2Tddvg15vwbJSRFHB6aEipgX5jCAf91xmYdfuuRVOVPN
 F6bblGiRvrKuzgIbIcYu2XEE+EEFvB/DAkfhiZdZuLpS/TNsiQ==
X-Google-Smtp-Source: ABdhPJxi6h7SYvILl0352m/8XNy5kvNm6h60Ud0vcwa4Ih3LlgIZERSMMjZsIo0ldHEG6o/7nXTccHc2MxazVyNZc1M=
X-Received: by 2002:a2e:908a:: with SMTP id l10mr525727ljg.409.1598610632919; 
 Fri, 28 Aug 2020 03:30:32 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Fri, 28 Aug 2020 12:30:00 +0200
Message-ID: <CALTWKrUL_x7VQCsUVxLnMwH9=snQGd57sreWjRAe7RsBa8oS0w@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#10] Measuring QEMU
 Performance in System Mode - Part Two
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com,
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x22d.google.com
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

In part two of the final TCG Continuous Benchmarking report, the same
procedures introduced in part one are used for inspecting the
performance of QEMU system mode emulation. The only difference is
instead of emulating the same OS for all targets, different images
where selected from the Qemu-devel thread below and the official QEMU
documentation.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg604682.html

For each of the five targets used in this report (arm, hppa, m68k,
mipsel, and sh4), the source of the used emulation instructions is
mentioned. This is followed by a snippet for fetching the required
files and starting the system emulation.

The results of running the time command are then displayed for
measuring the boot-up time until the login screen is reached where the
emulation is stopped. The top 25 executed QEMU functions are also
measured using the topN_system.py script introduced in part one of the
report.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Measuring-QEMU-Performance-in-System-Mode-Part-Two/

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
Report 9 - Measuring QEMU Performance in System Mode:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05705.html

Best regards,
Ahmed Karaman

