Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0873C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8755521D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DS9sbqit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8755521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvvh-0006cj-Ks
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIvs8-0004eq-S7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:30:57 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:40058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIvs6-00072p-PX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:30:56 -0400
Received: by mail-ej1-x631.google.com with SMTP id z22so3873852ejl.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nUXsad4WgFqoGTV0hZPyGb8kqrVacZi89ucv2tRi5+Q=;
 b=DS9sbqitski+jKZaCeXHemOPwSv5BsFmgbcjn15eybkQKMxb4G7+YnqFFna6jfsrzF
 1JC5Y8tMeb9o6eXuinZnPeQ/HldBscerkXI8aA+V07OVnORcqJWTvh3JzH1IXhHSyQZd
 fTigrR1/6RChcLi++4OWPMNyrAXPfmFGTi3LXb147grT4/nCQjkvyaPJ8BmPhJ/bT0V0
 fprLF6GXcHio6+4AWy3JbW5MVhZwUyzsj5X3sC5xw/g2WLOm15me1O5CBIk/HDqjVAP/
 sB2xUWEN6nygax+8aN0s3hkiQXAegZvEEGp9b5xsB9z36EBea9KyRTea3SEbqw8bUsBL
 RRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nUXsad4WgFqoGTV0hZPyGb8kqrVacZi89ucv2tRi5+Q=;
 b=QSM6WcjP5LR4mpHf+29/m/aGMxaTqasd+Ts/V6rw+Ucj0McDWH4HoW5ppKfax2rA3A
 oUwMDKOocG3h+Fs3WZayqygxWP9qVUpen250wKkU726oO+uu46Kbdg9oEj6nus6KUKQV
 OoTZ7xGfAjDYNwAie43zd5w7MoJL7IMck1Ym/sAy+LWpRfg75qA48VzLI4bbPY2ZyoQF
 fjo5K+/Evn6XOam/O+9HHYBne2KXczP+dksK+RRVjeOOhbY64tM+hE5OhBtiSGIEipHk
 JMKxdpuIUjrHkMQjq9MeHmixpTf7zVZ42O1PSEgJ08/6DN7JIMrmdX8N7h+NKuotQxRA
 DiAA==
X-Gm-Message-State: AOAM530rM6QVg2+FP5JpgKgCcCTOMp9zLobzlsNnSujo7tXJTybNR4F3
 anw5sNM/yG49gLJL15UGUZgHx+FtgY9GNRmKBTi5Tg==
X-Google-Smtp-Source: ABdhPJwQtqXK735N7nCSL2Y1C2v1rIgHSEjbERGkuC4GlFzDg+f94Q7gTzQA+RReeCVQf6hPFQCthlrozhrT+qySm9s=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr30731908ejk.250.1600356652790; 
 Thu, 17 Sep 2020 08:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916114731.102080-1-thuth@redhat.com>
 <CAFEAcA8VyUYJnE3aji6zPQGPD-K+iVGwVNbygYypr+NpSzZBPw@mail.gmail.com>
 <7c21af54-342f-2a29-f700-3b1d3bbd5bc6@redhat.com>
In-Reply-To: <7c21af54-342f-2a29-f700-3b1d3bbd5bc6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 16:30:41 +0100
Message-ID: <CAFEAcA_HZZoec6_gE01+WfGXqd2BXrHo6fFcsitAC=ge1uLFjg@mail.gmail.com>
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 at 16:29, Thomas Huth <thuth@redhat.com> wrote:
> Ok, sounds like I should respin my patch here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04476.html
>
> ... and could you install a newer version of bash via homebrew on your
> system?

I could in theory, but I don't really want to replace the system bash,
because this machine is not solely there to run the QEMU tests.

thanks
-- PMM

