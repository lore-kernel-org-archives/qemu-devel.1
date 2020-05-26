Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48069C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135062073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNpt3Vd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135062073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYrB-0000wt-5n
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdYqE-0000JR-Iw
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:37:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdYqD-0004bc-R1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:37:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id j198so4962169wmj.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lG4RSwwHxWRQs4oOWH2COxBCBjx7/ofjYfYlpVUckuM=;
 b=VNpt3Vd3OB8NeiQwE5z6xFirSCFK0pultFripmIr4D+Xv942UGJuBJKN38dMd/wLwF
 7pd4/CBa2VF6JqFgYw7gr5ZB9WfKUAkAuAHJO+IiFPA2vcsoGt17c/4QwIClnHZBwPxL
 QIDxaYIZAKrwVS7wBcl3H+XclyoCHGVFeXUn5lmL+ME2z0GDXYN9faVloyCMIRR7l6Pw
 /gcK9feSrUA2CmIg4JRkJUXVbd5QlTOOIZp0FgprK1grrcCh6t3PA6YTbTRkbY/aT/MW
 bjXH4TgtVCrw6YXoiNWLlXahb4LqIS/5afRIqBg61K+i1y57HL9upcurfvht/1EUrM5X
 m45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lG4RSwwHxWRQs4oOWH2COxBCBjx7/ofjYfYlpVUckuM=;
 b=KpaV0SZj+e9hiqnLUbHSQCWJyyYhbKS5nWMeC8u/rM/rQTQBPZZ7jO1FSaZUL3gb9f
 3CA90SJehU83u0FWJYDjd8lS4ZAb1IU8b+XWTTaAgcxyaqKFni2VquGowhGuL1UwVgoZ
 kPbn5uQROkWTjmsJ/y/ykv7wfTYLCwVs0fiDkAjJI+Qh0VESO8atCR5VlnIdSiGYZHpP
 YZ2zMEVp7PgmOlGc4d6xMpt+t508JvTtZ0/Hn9Pg2z9XDQ3qIIRLVbCLSiEmpoIeZk+h
 8sKRa0zNVq2x45pFkiVlhwFC8DHyU9N7jv374YPGMOT5wNbbkO7yzi4zbKwfVdfhSV6O
 aScQ==
X-Gm-Message-State: AOAM530iEalUksFz1i3otxvigs9e83rfGdtAoFRuROyQ72prSZANcLCb
 QT76l2ST9tZ49Lx6IG/l6tdLSXz1lS4TJJIZOXs=
X-Google-Smtp-Source: ABdhPJxkdq5QAg2e2QvnAiFUNGxW4G9KtuyuLWnY79OcbKo3x87Mz2eCwdFtbCmyl4BgoCP/OMs4YDB5xj3j0ablk3Q=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr1208836wma.36.1590496675948; 
 Tue, 26 May 2020 05:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-11-f4bug@amsat.org>
 <20200526115353.GN2995787@angien.pipo.sk>
In-Reply-To: <20200526115353.GN2995787@angien.pipo.sk>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 14:37:41 +0200
Message-ID: <CAHiYmc6csbt=fLhFtCMorCgbLd+kbBRoWO+gKdbDG_0x6NxyhA@mail.gmail.com>
Subject: Re: [PATCH 10/14] hw/mips/fuloong2e: Fix typo in Fuloong machine name
To: Peter Krempa <pkrempa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >
> > +mips ``fulong2e`` machine (since 5.1)
> > +'''''''''''''''''''''''''''''''''''''
> > +
> > +This machine has been renamed ``fuloong2e``.
> > +
>
> Libvirt doesn't have any special handling for this machine so this
> shouldn't impact us.
>

Well, Peter,

I was also wondering libvirt listed as a recipient, and I think it
creates unneeded noise in your group, but Philippe uses some his
system for automatic picking of recipients, and libivrt somehow
appears there during that process. Philippe, either correct that
detail in this particular component of your workflow, or change
entirely your system for recipient choice - the current workflow
creates incredible amount of noise, wasting time of many people.

This happened before in case of deprecating an ancient mips machine,
that absolutely  doesn't have anything to do with linvirt.

In some large companies, there where some analysis on how much is the
cost of sending an e-mail to all people in the company, in terms of
wasting time on reading or just seeing such email. The result was:
such single e-mail costs the company $2000 - in wasted time of its
employees.

Aleksanadar

