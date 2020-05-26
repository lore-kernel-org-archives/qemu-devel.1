Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9262BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9C12073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H808BuzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9C12073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWVK-00052A-Kc
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdWUn-0004cR-P6
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:07:41 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:33772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdWUm-0001a6-52
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:07:41 -0400
Received: by mail-oi1-x22b.google.com with SMTP id o24so18229646oic.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=sEM1rKqQbOHjXGp8fm2clVqG69BYFcOADK/vdyBpdqQ=;
 b=H808BuzHdd4h+tQPz+hipNawBwnOEO7Oz0uSQvxk2rOPOjcE68WHfZoYLxbpFkCofi
 Oduu9WYQpgQV7IjR96ZXdhyyk3jyn+Dj2p3arnq/mFurCy4kYi7WAg/psmhjnWfy7VZa
 4P+7lENJaAtnHbPt8lLWUsOJ8RJyW/lmfWC1ZSShkCCqwrbY0mO8yTA7rKObpmqINpiD
 7es3FsxiWZZlqUxEi0guZCrBA4z7aOC5SeNqwa3kOEmfaitTOnvhIxJDPg4bDv78yOhV
 qBjjNHGg3T2zNZcgdRmABQvzqP6baqZqPlMaB9xcWMuJ86X3sTWgERLa6oQCte9BgjF4
 t3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sEM1rKqQbOHjXGp8fm2clVqG69BYFcOADK/vdyBpdqQ=;
 b=WQZ43mYhmjhE7UGKNnEv8H42ywCK7k0vBN9lP3FCw1U/5HW/JFnCPnjvYVG20Gm/zp
 b26YDcSnCcZxxuTgqZapZ31mXNOlWR47SHcEp9a4Ni9bbVtQTZeRyvUzN9g9/KPCCuK7
 enPDUSNGRkIFakJNDnM0UQUbD8Wg5nOWGbK1RI4VSYNJFz4Owbro5gDudj/WZocKwicw
 V6S5cl8Tvef41MjTvbpDRNfCEoDaAPVyDKj+KnEPPaizLblhqXRU0SICWDxErtoWl8it
 +RbnhLI9mfWLb3JaihSzgKE71YgXZcrtDqjunGwUZoJtRMZZ1vw9dstTAASmN+jnHndJ
 Y6Pg==
X-Gm-Message-State: AOAM5306pzFALctKEpfSS8uhYaSXmqCdhOoBzAJiFKQXEGTrLpmQAgMM
 votaVFSPWCDjvpb8p1xu8Mn+kcPlBwsccRuJXM+3UXGp/sw=
X-Google-Smtp-Source: ABdhPJx1wMFGs0lzfqT3SRv8e8evZ0hmw2LoQs+ToWv/EhvgQbDYN/bKpwncrc2u7zi+WPt+yn7gTJ6Y+Tf6wq5GuUM=
X-Received: by 2002:a54:469a:: with SMTP id k26mr8754956oic.163.1590487658534; 
 Tue, 26 May 2020 03:07:38 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2020 11:07:27 +0100
Message-ID: <CAFEAcA_Lr8ySUK_PUNVB+RRQhFhEQL2wFeJtdYAxZhhT1xEFNw@mail.gmail.com>
Subject: 5.1 proposed schedule
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a draft schedule for 5.1:

2019-07-06: softfreeze
2019-07-14: hardfreeze, rc0
2019-07-21: rc1
2019-07-28: rc2
2019-08-04: rc3
2019-08-11: release, or rc4 if we need it
2019-08-18: release if we needed an rc4

Does that work for people? I don't think there's anything we
particularly need to try to shift the schedule to avoid but
we can easily move it back or forwards by a week or so.

thanks
-- PMM

