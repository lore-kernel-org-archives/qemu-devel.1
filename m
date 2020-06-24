Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBCFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC5F2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdrfkXT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC5F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3ZF-0007Ya-L4
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jo3YV-0006VD-Fy
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jo3YU-000723-2g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id l10so1895273wrr.10
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+hStw+jEhDLKTIZ2D6nzautxOHmyAupBUTrBEM2cdlk=;
 b=GdrfkXT6HaTMdFb2hBKS5rxzDZRP/t63X6AT11g1RpgTVpbEtgCCgjMYPfp49MrHOs
 2TjKPyPnwvWN3sGcQ/ESlhDulVrex/A7QoSvEaE+Cx81ZHb0nX8O5PqJ4Eo/FFf11pTh
 lMC42XM8wXjSSxa6wx3x6XA0VIGWlqmMF1f3vlV8IIT4XEetS5UnIVlAhqYBI1behiSZ
 Idzf1R7Zfd881lXKaNvVhkniDRknn7vpnoLQuBLoOE3zIOuBQXDcwBZkqpQ2xHu6qGYv
 O9oLHrYPGzXYKgdIp2MELx3dys1p1wb+RLy0xqVE8NOHnUzrsX2LsT3z+CkrsiWT6lOr
 mS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+hStw+jEhDLKTIZ2D6nzautxOHmyAupBUTrBEM2cdlk=;
 b=OAOTO6QxT+duMGE7WygEP76b/7v2LzbqL414pfziFh/UfyA2EHoidhrteMzXTUz9tD
 86BHAc4gEsE7xnzu0YZ64L5BQd7CeOYEUyYIgVlekLiiPqkH5juo6SH/omlB5bghssiR
 M9FS/r1sNi4nSQzLue1ediWNJNkOTdP1MGTBAsdlradsmG5edyGaIH+k9O10kqSjyq1U
 FPziqcyY6zwZeT/bMf+q+iFvBzXN9n4l1Vn+R7VEztLS7bNcJVGnbP2h7W21+Z/xM0Q9
 3+OiVDhzXUW02xoVWgIkVWuk04xsAHEDwxTSRKKZebJvrsLB8T4S/qrOBlVbq0hlvJem
 drmA==
X-Gm-Message-State: AOAM530aPW5o1bdI+T2WsuM4pz2cNEmLqFH4MVrXnudJeQ5HKne5tDxY
 3N+0OUM14GPDjJA/EewxQr8GCvlqj6SM3qdl0ao=
X-Google-Smtp-Source: ABdhPJynQftHgCOqf0tldT1HpYmo3RHmU00MR147N98BlIC16v5zgQ5eRNqMJvokZouB+UbyzbyQeC7W16wr3dFYg7g=
X-Received: by 2002:adf:f885:: with SMTP id u5mr30140252wrp.402.1592998020150; 
 Wed, 24 Jun 2020 04:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-4-git-send-email-chenhc@lemote.com>
 <CAHiYmc7FVCu6WTyFfUdz84iBYaL9QtrQ+Mv_nFU6KzzCWbnz=Q@mail.gmail.com>
In-Reply-To: <CAHiYmc7FVCu6WTyFfUdz84iBYaL9QtrQ+Mv_nFU6KzzCWbnz=Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 24 Jun 2020 13:26:47 +0200
Message-ID: <CAHiYmc75wGPk=rQDTw9PfFGSsEzhgTXzTKTQC0GjiHWX-kH7aw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 3/4] hw/mips: Add Loongson-3 machine support
 (with KVM)
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> What exactly is missing in tcg support? Would it work if Loongson EXT is supported in QEMU?
>

Huacai, hi.

I couldn't find the answer to this question in v6.

Could you please clarify this aspect?

Thank you,
Aleksandar

