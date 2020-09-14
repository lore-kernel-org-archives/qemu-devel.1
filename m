Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B24C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7714F2078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="M26zNf2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7714F2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnsD-0000EW-EK
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kHnjm-00026Q-9T; Mon, 14 Sep 2020 08:37:38 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kHnjk-000166-4l; Mon, 14 Sep 2020 08:37:37 -0400
Received: by mail-ed1-x542.google.com with SMTP id n13so17352390edo.10;
 Mon, 14 Sep 2020 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wd5IOhNrr2AVWRpBQvmY98Gu56fm8I57I2JuuLZHhOI=;
 b=M26zNf2cXKEbdMaheqi55Ov1TD+a4e8omQYVmA2Rnnnd/1TfF0RhmIGaMo0pFznr8E
 vMZEhDV9uzuZpuEKAXsW/BM78XVuRyx+VZMxc3H1bK+O4lAdurb1S9J08QtxqeH3guyT
 IaatqB98p/EbyseQckKIOrLXw8bii26jEIrdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wd5IOhNrr2AVWRpBQvmY98Gu56fm8I57I2JuuLZHhOI=;
 b=raNU18qVyNKVA/Yjjzp9k78nzzQ6ifO+485B2RHRs3XExvD4vPnoFw1B83HHkLJceW
 T5OWZbtRNiYTvTKFo7ea763wMAZUpEcQQP8p8XrJEwg0vPoRYHvskSPGWIQMw3z+2c+J
 0ldv2eUPx+mUmT0cpHkYkBuj/clb21aYLB8vNEezXI/h2GcVEREYwBLExRTxcx35Fr8P
 dyKhH/dkZtPhFupdwQafEO/Uv5GO96NjeM3zMKV/LCqYRbj6++r2Pnk6x1Gin//WmdFf
 2fdP/QXutujxenjNuj08JRDrnqYxsHyQYnlTXEQpgYPawpHhYNv+M/AM9Fk1hZrkratl
 p+ow==
X-Gm-Message-State: AOAM532XwsEZ8KTiHRWn07rynD5qhrbQ7dBxzPglhVmEi+77xWLp/409
 vWPSLEH8vHJWGtZHVJubq4gycuIexo5Moqhd2yI=
X-Google-Smtp-Source: ABdhPJzDQjHXZgILszz22cPr4LelHan36owlmgLt4jeWGskuIsdFW0ySwsX+ia6ccAxlDo8eiHLSn1Eyt7ISX/TdasA=
X-Received: by 2002:a05:6402:18d:: with SMTP id
 r13mr16343821edv.267.1600087053407; 
 Mon, 14 Sep 2020 05:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200910200715.1920318-1-clg@kaod.org>
In-Reply-To: <20200910200715.1920318-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 14 Sep 2020 12:37:21 +0000
Message-ID: <CACPK8Xfd6c_i7kKqFtEYzgbDw0_6SsVwtNGJ=bG_0pzSh5TP2w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/aspeed: Add machine properties to define the flash
 models
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 20:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Some machines don't have much differences a part from the flash model
> being used. Introduce new machine properties to change them from the
> command line.
>
> Cc: =E9=83=81=E9=9B=B7 <yulei.sh@bytedance.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

A nice feature! Can you add an example command line in the commit message?

We have docs/system/arm/aspeed.rst where we could add the supported
options and some examples of different sized flashes. I know of 16,
32, 64 and 128MB machines out there.

Cheers,

Joel

