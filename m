Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81620C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578F320823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578F320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8s8-000223-Ic
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo8fc-0005N7-60; Wed, 24 Jun 2020 12:54:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo8fa-0001aW-F9; Wed, 24 Jun 2020 12:54:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id g1so2015486edv.6;
 Wed, 24 Jun 2020 09:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a6S4bFuq2ksSYnhHtpwRXYgyoZWUl1SmVKgAtXplKrg=;
 b=fItONiZaafpOPdAlp3tJzUto5PiC1AIn0jW8KE+Wc2DIkxRiARWFWTGmSmP754fWKn
 /buvRB6lNHaikKwn4FPEHXnli/wHVuVGphSw9XzxsbaUx0Xh1/iJBisvWsfKMamFYcfb
 lrHCJnmSnMIy1WxChWv+yDPUaxF3JxY9J3JXpbf/u9rSOKL1fREdtWNaRZAAwGmXYEWd
 gChsO4DAXjUSILrpfCKLMiJtrbEgTQWPC2ajCdDfkJiorbFRN/7+ApBSaS4LmtbkKmWL
 lII4/kfaVixsdur/gYI/kZDYEmxfx4/UhAx64gLr7K8CUhNytDCWEbIuSEZNAYDhjCOQ
 TG1w==
X-Gm-Message-State: AOAM532ZSvYZY8bVm5d8LVo5GMPq3chj2q4GJMde7U70rHA1/b3NkjQw
 xLBmTjmg6qv3qzAwuqruVNbmSnga0WjzVAvUjnw=
X-Google-Smtp-Source: ABdhPJyIbeH/uMHKa3eVyADG8s9vwe3k01Kdmkx7V4urSTcWwfKcoluL/vtzOuzQy5W3e1s/vTPQiQP981EAvAIyeTs=
X-Received: by 2002:a50:fa8d:: with SMTP id w13mr28138716edr.324.1593017680589; 
 Wed, 24 Jun 2020 09:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-7-f4bug@amsat.org>
 <38918d0a-272f-c05c-6a03-c6ddd8cc592e@kaod.org>
 <a046bcd2-1937-d971-8a1c-23fae0dfc9b1@amsat.org>
In-Reply-To: <a046bcd2-1937-d971-8a1c-23fae0dfc9b1@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jun 2020 18:54:29 +0200
Message-ID: <CAAdtpL4vFQaD_7uUvVAOy34ySXrZCQWnALM9=FOfVZo3750ufg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] hw/arm/aspeed: Describe each PCA9552 device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.68;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 12:54:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Corey Minyard <cminyard@mvista.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi C=C3=A9dric,

On Mon, Jun 22, 2020 at 10:35 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 6/22/20 8:49 AM, C=C3=A9dric Le Goater wrote:
> > On 6/21/20 12:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >> We have 2 distinct PCA9552 devices. Set their description
> >> to distinguish them when looking at the trace events.
> >
> > It's nice and usefull but couldn't we do the same with a QOM object nam=
e ?
>
> qdev inherits QOM and overloads it with the qdev_ API.
> Since we have a qdev object, isn't it better to use the qdev_ API?
>
> I'd keep the QOM API for bare QOM objects.(I find confusing to use
> different APIs).

FYI you can get an idea of the QOM -> qdev -> sysbus -> ... tree here:
https://observablehq.com/@philmd/qemu-aarch64-softmmu-qom-tree

