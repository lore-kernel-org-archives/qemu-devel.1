Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124B4207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0oxuixQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124B4207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop0o-0001oq-9D
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1joozg-0000Da-Q7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:06:16 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:41630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1joozf-0005vf-91
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:06:16 -0400
Received: by mail-lj1-x22b.google.com with SMTP id 9so10462977ljc.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 07:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dNQxdI7/6wNlS8kv5uWIOnaS7/C16hGHOx4Si1URnvg=;
 b=l0oxuixQaWgUKzldKsdAUbIVyrIPm2JKSc3jzZ0fPLmzZw7SjUjXMxVWYgSiTPr7Kh
 ufZrc+VZy8XjNDXydOeUqGMM5f+Bggusv6Hl4R296Upx30IN1VuQr0F2VN674uvpS8mj
 mw+DIEmIb5Sxjb7frfvnYd/8knnYKUUFDVdlTrKtWrc8VD+VcavSxV54+xSmv1N0/AE2
 RUGiZLtbLe7XTjAMLczn7PuDl9NO9T0/+4bKPO9yenwBNpV4wIhao23CC1VZDxwiFwru
 Fwh8v+7D3lktDDZBHkAlN5fqpAYofMVUT7prGSIWnFIK0vjN1J7rNQPX5LLfBgkqNN0P
 RJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dNQxdI7/6wNlS8kv5uWIOnaS7/C16hGHOx4Si1URnvg=;
 b=Z7c72h50D9ffC7Nqb505sN57NXFjuIIdsvVH8nSfEGebNXuSPgReJuv5jwjhp+8Bhm
 DKozU6rpdT2KqiIEfSVxCNvm5o1LzvNNsXdPAdncM9ACyMKcddCnUq27/eWyCM0etVT6
 nb6W15YcIpzwQf8pXJIhQELaAtFK4R4AWW17PB7pRbTTCs3L9Msex88GnBbayvBxRrTk
 MD1KYHBSFw5+RC2tQiB5YWdE4+awQHQlk2b3s6AvSppRcYqi23j6icfUas9Ti70t0zyv
 EU1xXfxldA2jfyBQIFAJeZB6neNh5sQriPMpi9AeHFrX3tWN/vISQHi5+UhnJZwuII3H
 e+xQ==
X-Gm-Message-State: AOAM533+fMzJFH6pduTeTcJwazzA3GubfiVZKC1rU8T051u9uVbzYM2u
 lN61diuaVet0DR+MZ7HrBCuIJKeo9xBtN8YWNKE=
X-Google-Smtp-Source: ABdhPJxBKkVgeKarnIcRkbZmbwlIyq0HtZ1McjPeRoKIlbhXaX9DArgZUxrbhdwJEycTqcpDZdKOuzC/XWy8+rzc7nc=
X-Received: by 2002:a05:651c:1044:: with SMTP id
 x4mr1467292ljm.409.1593180372028; 
 Fri, 26 Jun 2020 07:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVWSvWOQVorXuC4HQbjSN=Tu+TDsc=mr1CUCL1cvJQS9Q@mail.gmail.com>
 <CAHiYmc7TSJZ326892Q9H-MVXZDrpf9ZCL3Y0pUhEiaeOgK1xCQ@mail.gmail.com>
In-Reply-To: <CAHiYmc7TSJZ326892Q9H-MVXZDrpf9ZCL3Y0pUhEiaeOgK1xCQ@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Fri, 26 Jun 2020 16:05:36 +0200
Message-ID: <CALTWKrVjMg+aHgEqZeVbS1dk0mhGv6fWAgUCtu0omEaHMYJ-VA@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#1] Measuring
 Basic Performance Metrics of QEMU
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x22b.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 3:38 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> In introductory section on Callgrind, maybe you could add the general
> form of command line that performs profiling using Callgrind,
> something like this:
>
> valgrind --tool=callgrind [callgrind options] prog [prog options]
>
> Not a big deal, you can do some fine adjustments throughout the project.
>
> Thanks,
> Aleksandar
>

Thanks for the tip, Mr. Aleksandar. I've added it to the report.

Regards,
Ahmed Karaman

