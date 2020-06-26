Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E730C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0C2207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0C2207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorP3-0008Mc-Cy
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorFY-0001Gy-82; Fri, 26 Jun 2020 12:30:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorFV-0003sg-GM; Fri, 26 Jun 2020 12:30:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id e15so7406648edr.2;
 Fri, 26 Jun 2020 09:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0R1ZRoMHvzgmckZtT/a63CObqcUs+AVSroGfXaBAw2s=;
 b=PvmXWPv+f2fN8JwnsZPZjylnQdZeRWFERjri9nwJ9rfAXHBakqmDwa80HoPBFhrlF3
 BauHYsmyHtVcPslnalFULM9rqYA4D6lyhKNLixEe84/hEuOcpVnHK1ASFFMrsd2WDqIW
 +TUPx60oKDGZQbZ81JIQnap6TEsw9QcjTWzYeYTzy4RaouFVD4RLth1JSFB1K60udzAR
 0yKsKJ0k1qJ9X6cI49Qu3EO/cCIncQw4BcjcWtQrLxYYbbgdlaraAxl+VB2eAA/mDI8A
 /rNx41hQ2tH041xA5TIikQDVTONZMz8HLarBhxH33fOsQXEfZapM+cdegrLN3zJ0e/rY
 GORg==
X-Gm-Message-State: AOAM533X8sdrq+RiSd1NuYXWcwwSeNdcordKR0lSPRJrjAn6l9MGbtEN
 /VTgC8hK2RpnjjtR4GfbKF7GNMEJ8O0QSplLjgxA2A==
X-Google-Smtp-Source: ABdhPJwbuP/1MKA8PewILCXv2q9NuKSiSvSP1oJ2GIaB2b8Oaq+P/jHRQK8PN9+Tw+gGDhFelHDVwjFoUKwURNSkQ/Q=
X-Received: by 2002:a50:c8c9:: with SMTP id k9mr4042945edh.157.1593189042788; 
 Fri, 26 Jun 2020 09:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200626162818.25840-1-f4bug@amsat.org>
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 26 Jun 2020 18:30:30 +0200
Message-ID: <CAAdtpL7bKGHdCgi29X-Thf-2yt=hRhCdCXqKeQpy0EVwdAMavw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 12:30:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 6:28 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Patches 5 & 6 fix CVE-2020-13253.
> The rest are (accumulated) cleanups.

Wrong branch... sorry for the noise :/

