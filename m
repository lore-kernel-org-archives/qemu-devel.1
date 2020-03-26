Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B53C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 10:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70032070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 10:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdFViQJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70032070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQ3B-0005qL-00
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 06:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHQ2W-0005OH-11
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHQ2U-0003oN-L3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:47:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHQ2U-0003nU-3u
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:47:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id e4so5035018oig.9
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=347eUQrPcxbgZRU3Nq1duBCDYFrJHpbNU3mfi6zW42I=;
 b=YdFViQJXSRTl+DT9iP2DgHn2bNIoDaOj+RofIACj00z3WGIYJwGrJtpWjW19ETAXDg
 HpxEf2YrDSkWnnKK4lqz9ivXGVp4KNSwEJVOXwplcpQF1b1yFvEBFBjZI/rodXsIXKPU
 9jEkrJK4ZImsiZufLYwtWVFrfZ05nRN9Frejnh51mJ0oTNqHRsrjP+y7Kzodnz0sYiME
 OP1cDBwqSLJfkdw2BKd/Km6Tk0frWzMZnZ6tw03LLIR9Y/bCLDGm/aJUD9AsKzC712Dj
 Kt8o59Fo8z4pCAK1uvYWF/P2jDjEvhl29iKEXrVua7FtzF8hbpoPD9O768EsqExKZ/TF
 PZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=347eUQrPcxbgZRU3Nq1duBCDYFrJHpbNU3mfi6zW42I=;
 b=IuTg2XgaWDmfnVhcGCrbzFI0F0sn+txUEkiYs0XgcuFNul9wpYnOe8XvfFLctSHFAr
 J5x93cqoGd+OW/mMkpG+fhSogQtwcVMblBfEn+RphjMFdZD3bSTxD9byaXcNhbUL7Mkl
 Sc197ErE0Kf2/RA1KzNrNugje2hP6r/e4LDr8kTNE5Wi6DJ8Ggvwd+nXZArNPav7lVAK
 kda7cIrELOw4AelVZ7c1K1W89FyXtTIquGGhgpdtdu2U5XmmRHUhHhcUjhMKFZOlWi0s
 894DulcErlph2KTYLYhEVgZ321f5C1FZP4cK4y1SfTW3+0E/iaM0WqdjKXmbivvkqqyE
 5VLg==
X-Gm-Message-State: ANhLgQ2P8tF4bB/CMmFgs5C0qcU0IQ7hWgPrXq/4yb9pcxpkM/JrRZJL
 5LAYs1K/E/+vy5oq5C+aqjGNWnRmxNJ24pQAy6igPw==
X-Google-Smtp-Source: ADFU+vuf3LYKUrH3jWrEc+vFrgs2SGy9nTZp+tyVeKhrPPHlzHVEeNY5Fn2crnQ8PFX8ZUNQy+ypGFhUCzE5fgv8wmU=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr274396oij.48.1585219624377; 
 Thu, 26 Mar 2020 03:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200325131632.311034-1-dgilbert@redhat.com>
In-Reply-To: <20200325131632.311034-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 10:46:53 +0000
Message-ID: <CAFEAcA_ZnHkAd7YbvebYcv5vdEh74ETU2-TtZR6NbUbicQ=zxg@mail.gmail.com>
Subject: Re: [PULL 0/9] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 13:17, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 736cf607e40674776d752acc201f565723e86045:
>
>   Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200325b
>
> for you to fetch changes up to 7cd75cbdb8a45d9e2d5912f774d8194cbafdfa97:
>
>   migration: use "" instead of (null) for tls-authz (2020-03-25 12:31:38 +0000)
>
> ----------------------------------------------------------------
> Combo Migration/HMP/virtiofs pull
>
> Small fixes all around.
> Ones that are noticeable:
>   a) Igor's migration compatibility fix affecting older machine types
>      has been seen in the wild
>   b) Philippe's autconverge fix should fix an intermittently
>      failing migration test.
>   c) Mao's makes a small change to the output of 'info
>      migrate_parameters'  for tls-authz.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

