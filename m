Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C42221F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LlXX/3pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C42221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYdh-0000qw-0O
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQYcj-0000Nm-IM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:18:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:35311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQYcg-0007Ca-M2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:18:33 -0400
Received: by mail-ej1-x62b.google.com with SMTP id u21so8958946eja.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kyXnZdpbu3eWTEqfIsEjQch+IMoifHA2saYDwvwAyVs=;
 b=LlXX/3pYY5X3g2rhRcEvojB/E4oKMMETJ7lyYkX7yhSB8XFdV7E6w0QF/vWdHSG1zh
 zWnK83BC1ybRks8SvJn6M7NBmhL7Rmj+ps4c1XSFOn5tQCPjBAFI/op6BDu1iNNjVp0w
 1VqT4tEKtd2c9HxtNpu9KWHJDa7ptb93HRiwTjVk58WaDHFSFHmIpwN3MQpffTQKSNJT
 spngmjHdYcNPUhRpic0SedcPjBOFeeAr+zucg5b05gZV3/t7Kp0jB/QX3EX54rHF4DWA
 0Ixm+SOcP2vdgQwS6sBXyvQabyoeIElxYRqHqIMbIXVG0YqHN/3CPzDe+aRFcSp+cHcd
 8qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kyXnZdpbu3eWTEqfIsEjQch+IMoifHA2saYDwvwAyVs=;
 b=siTjq/qUwPeVXAV6IKKgk0efW5cX/tLUF361kMiOtmgksRAoZwwtucXY8USeGq8M9L
 GFosbRzcuPb99xJ+WhX80WGNEQ6WkvGYka7pM5akXl9AgLutGs5MTNwFOxKLz90hdi93
 wGjyyMeZJyFuCms6fD12fjcusCslpEW1NAS/I8uFTiThRoGXmlMSTONS9R67ePviIcb9
 NsAY0Wo9CuYWba6xIuLC+Q9nARWRJzBC2XdzBNU5ieU76SQnw7lg7hawej/nDHS8ce3C
 kZEeO7k9dGBPxfmuDS+Wc35xmt6XVya8bvzb0tSjfDyi+lVJAIK5bfa/VRM752RXPt0W
 P9DA==
X-Gm-Message-State: AOAM530x5U/V0Xv2zVI/WtpOFp+CkpiaRmcrbOrkuqNkbUhrDde7FSmi
 3YgsY94XFMsjwJzSVL8R9t2Glw4Gx9KOXHl6+Qr/MQ==
X-Google-Smtp-Source: ABdhPJwMHHq3eUUY3sPlEyeQfnYVqVfbqtLTI2kaalz9GK3vICsZyR/YF5IUZl/nNNyxoivwDENUAcGhZqoq6M/OlSw=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr9605015ejk.250.1602173905467; 
 Thu, 08 Oct 2020 09:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201007155600.337316-1-dgilbert@redhat.com>
In-Reply-To: <20201007155600.337316-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 17:18:14 +0100
Message-ID: <CAFEAcA9fjk5gpuV5Pq46DS8gux0gkY1fkhn=GU6W=B9jdAKBdg@mail.gmail.com>
Subject: Re: [PULL 00/10] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 zhengchuan@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Oct 2020 at 17:06, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit f2687fdb7571a444b5af3509574b659d35ddd601:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-10-06 15:04:10 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20201007b
>
> for you to fetch changes up to 1df31b8aca2aa4f83d5827d74700eeb6d711bbdf:
>
>   migration/dirtyrate: present dirty rate only when querying the rate has completed (2020-10-07 16:49:26 +0100)
>
> ----------------------------------------------------------------
> Migration and virtiofs pull 2020-07-10
>
> Migration:
>   Dirtyrate measurement API cleanup
>   Postcopy recovery fixes
>
> Virtiofsd:
>   Missing qemu_init_exec_dir call
>   Support for setting the group on socket creation
>   Stop a gcc warning
>   Avoid tempdir in sandboxing

Compile failure, windows crossbuilds:

../../migration/migration.c: In function 'page_request_addr_cmp':
../../migration/migration.c:148:23: error: cast from pointer to
integer of different size [-Werror=pointer-to-int-cast]
     unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
                       ^
../../migration/migration.c:148:47: error: cast from pointer to
integer of different size [-Werror=pointer-to-int-cast]
     unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
                                               ^

thanks
-- PMM

