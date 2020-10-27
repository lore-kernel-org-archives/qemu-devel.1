Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8472070E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8472070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKTn-00084Y-FX
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 04:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKTD-0007Ws-AK; Tue, 27 Oct 2020 04:36:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKTB-000428-Td; Tue, 27 Oct 2020 04:36:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id j7so471892oie.12;
 Tue, 27 Oct 2020 01:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CaL96iEgCuok2/I+7KQGOcMe4bmDpTV/ZVKiDt+5+PM=;
 b=dRcKinstehXXmAGa4wnPq9Q6NcMVigxvWn+XcuANm2GvTII1Rcb5B5EEd1i2bcsdkK
 KMhXf2Sbthc+fz92Z76ek2Pe7jtVZQV907/1AEhzdU10wweEZLeDAFIAwyDLimFI1ekz
 yAY8l3lvg5FSylxka3Pu9UCaq5umEjGNjkPqJN+AgtLnjyrlFLw7gpiDWeUfaj0WfJnw
 lUUu9gUzU3l8L0hSaYwQ/COOrSRMVGHrob6+Wl1w5AZ59x4czEK7xqMs2b8ZIeIQmTrX
 vp7eUt6z+FzRXk7orvRLLvboBZ3oFflbwCXjY7W/NEwu6xgQCLmgAsyhobZMM1Rn4ZPW
 FOtw==
X-Gm-Message-State: AOAM531S7zsbPRD7mblSZ6xt+kXEiac8gMy3RlEPKcSrV1izniywWs4k
 HnzQmEU/L6BqBb+kpu+SwTGHM4X7HoYtYXCW8PsL2YWE
X-Google-Smtp-Source: ABdhPJzNh8YmxoxYMOX6yXKeFYFQ/Uv92vr4+Gz8RIWKaVwgVWzpMCWvTY7GReiVTJHvyCpB1adESsiHaipgIfx6gB4=
X-Received: by 2002:aca:5047:: with SMTP id e68mr637643oib.175.1603787800479; 
 Tue, 27 Oct 2020 01:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201017180731.1165871-1-f4bug@amsat.org>
 <f87cc670-a1c4-62ea-c4f2-5706a9af1a18@amsat.org>
In-Reply-To: <f87cc670-a1c4-62ea-c4f2-5706a9af1a18@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 27 Oct 2020 09:36:28 +0100
Message-ID: <CAAdtpL41q8e4B1RN-0TdnjEkwoOGcsWnNQ82H6gaBAN8r=mPzA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/intc/bcm283x: Trivial tracing cleanup
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.196;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-oi1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 04:36:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Luc Michel <luc@lmichel.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 6:07 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> ping?

Oops wrong series, these patches are already merged, sorry.

>
> On 10/17/20 8:07 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Add trace event for IRQ from CPU/GPU,
> > use definitions for IRQ numbers.
> >
> > Philippe Mathieu-Daud=C3=A9 (2):
> >    hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
> >    hw/intc/bcm2836_control: Use IRQ definitions instead of magic number=
s

