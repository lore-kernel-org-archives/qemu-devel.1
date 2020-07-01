Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C6A2082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 20:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C6A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqjAX-0003Fk-Cx
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 16:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulburton89@gmail.com>)
 id 1jqhi2-0006Lx-CG
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:43:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paulburton89@gmail.com>)
 id 1jqhi0-000767-Vy
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:43:50 -0400
Received: by mail-qk1-f196.google.com with SMTP id 145so20720900qke.9
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCFRfQ4VJPaYjOpHOseFrtDXEBwzul7IOaN0Q7ajxiQ=;
 b=J1Wh+9uzj99u9WOo22DrB4SU9Gfp+ybUgHy+sepGSEpHmRSaDwzxxOiXlG3Pi/lszv
 KTDq5FQtYJvs4fqb8xB75A/8mbVJO6BsyxtMnbwvaiVkhnmiNyEgoQZCL0nmUvga4k1J
 6+1po8RGkWPXU01ixdeJwO5+9L6IpWpmjJoKcz6oW1H8ttDs15ePBZnaLzLQ0qsIwXU6
 bGOtHMQwMGefvuGJLmBpoAOOUEbhix0yc4p/6Lyw8Ha6WigOQc650FDyzZrUzQvrk4C/
 ZC1TT0XArr9DCKdgW9W5cvY8r+cs4V/eV13p76T6JDVs498qHduixqXV3ecNnNHayU8v
 JnEw==
X-Gm-Message-State: AOAM530gFSKh6K8WHuvqm8aqxQetSlbGkPTG9qiAA2ZizyhOWGI5V1b2
 wp/xGeRLTrAQ9IW+UYJK0uubGUbq
X-Google-Smtp-Source: ABdhPJybc5cdAjlyTvzlETardZbePDtOxUUACQ6vWK1nvDaX2fKDcOdIqepNT1BOlISAYXM8taRV6g==
X-Received: by 2002:a37:9dc5:: with SMTP id
 g188mr23895459qke.427.1593629026964; 
 Wed, 01 Jul 2020 11:43:46 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com.
 [209.85.219.44])
 by smtp.gmail.com with ESMTPSA id j16sm6082965qtp.92.2020.07.01.11.43.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 11:43:46 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id el4so7390178qvb.13
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:43:46 -0700 (PDT)
X-Received: by 2002:a0c:e847:: with SMTP id l7mr27292248qvo.232.1593629026164; 
 Wed, 01 Jul 2020 11:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
 <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
From: Paul Burton <paulburton@kernel.org>
Date: Wed, 1 Jul 2020 11:43:35 -0700
X-Gmail-Original-Message-ID: <CAG0y8x=hvvOzdvZEAneF8zxFfg8-Q6Yo=hDYFfDOmGBKsb_+ZA@mail.gmail.com>
Message-ID: <CAG0y8x=hvvOzdvZEAneF8zxFfg8-Q6Yo=hDYFfDOmGBKsb_+ZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.222.196;
 envelope-from=paulburton89@gmail.com; helo=mail-qk1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:43:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2020 16:15:40 -0400
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.rikalo@syrmia.com,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On Wed, Jul 1, 2020 at 11:26 AM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> Paul Burton and Aurelien Jarno removed for not being present.
> A polite email was sent to them with question whether they
> intend to actively participate, but there was no response.

It was 2 days ago, not 2 months :)

I'm fine with being removed though - I no longer have access to modern
MIPS CPUs or Boston hardware, and wouldn't currently have time to
spend on them if I did. So as far as removing me goes:

  Acked-by: Paul Burton <paulburton@kernel.org>

> In cases where needed, other persons step in instead.
>
> Huacai Chen and Jiaxun Yang step in as new energy.

All the best with it moving forwards, and thanks to Huacai & Jiaxun
for stepping up!

Paul

