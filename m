Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8628DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5121820775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtzDlhkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5121820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2cxW-0000fw-FE
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2cvJ-0005Zw-28
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:02:50 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:32823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2cvH-0002N8-5Z
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:02:48 -0400
Received: by mail-oi1-x234.google.com with SMTP id 25so10099123oir.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X9B/6xqhFTCTL9HuiHF939l+s5+ZSJAOaIwfW6pEmu4=;
 b=wtzDlhkR4XX0aKtm/2OAd4g9GuOH1xeDdqWqJbX/k8IrC3b2/MmUfnkLwWO+hx3dOE
 i4Slo9Ycg+6kxgZF7uLbjKeocz5q1OzAlHZb/hRvKMNcHugFxpC/+3zEvFnEnDvw12FQ
 wMKTfjjFJI0DsTmRI04mWRsRV/wCjQaNhhNfIlvApvBDH9lUDZ0+S07Asvhxq7ftyl7j
 Bt8bENbmOk16cAPHASDQVbbv4C4Yiqox5cyA8Lh/66pt3sUkoT75M1mofFOuXLvrXXTg
 45L7IjYnsoAWpjo81/tLa3TVHq+BBkSru7BKpdFZ8s4y34vlCBD2TwNLrrxN3JxyxOh3
 aLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X9B/6xqhFTCTL9HuiHF939l+s5+ZSJAOaIwfW6pEmu4=;
 b=qq4Ikhfhv6zOQm879VNuPfrCzwQ9Da+TE8emlHM2dMILacmg5nNRr9f6P36Q6zjdR+
 P3j76mlTnC/ct3gP4AZkAu5RHURP4ZoO2c/FiVWMluQlizkZgZRf9Jw0hiGWLxjCvyUI
 p/dpo1bMOYL1oYz+da2HsBRQChkZO4xJE3ia4iWjfv9tTOzfqJjMz26e3lhhmeGgJZWz
 tAfMbJ4tTdh1/8d3wsaB5Vsq2d05eQKLjbLYqapK8/dq9YdgEKioetXBTH/fiv8DMX2n
 kzEtRW7zr58kB6LW8lcdR1+7I1y8JHKdZXX8NCaYUWvad79HFkTeYtbXwyzfKNIUR4AK
 6a1g==
X-Gm-Message-State: AOAM5339pmCUtALrj9270+4e6FsA8qdgrvk3qPpseOtEa1hDGM927wsS
 y1k1WYy2b4L119zkf8e6oBvXh4NxPN84ruljYfV0jw==
X-Google-Smtp-Source: ABdhPJyZ1nv9CZjyD6P7FzBh12kvAQj1jrw7QNJqCGGKR4cUJ4f6Dx/M4diBwLJI39zj8w/FR237K6tqRfsF7iB1NHE=
X-Received: by 2002:aca:48d8:: with SMTP id v207mr34864oia.48.1596470565453;
 Mon, 03 Aug 2020 09:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200803141147.88923-1-eblake@redhat.com>
In-Reply-To: <20200803141147.88923-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 17:02:33 +0100
Message-ID: <CAFEAcA8LxUXZBF96JrY2Q110tSLujtAJsbmpmBQr1D-qGa_wNA@mail.gmail.com>
Subject: Re: [PULL 0/2] bitmaps patches for -rc3, 2020-08-03
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Aug 2020 at 15:13, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 6c5dfc9ccb643a0d50fdec9f10806b14960571d1:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-08-03' into staging (2020-08-03 12:21:57 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-08-03
>
> for you to fetch changes up to edadc99a2ee90daeaaf4fba21d623ec8efe7c8e6:
>
>   iotests/169: Test source cont with backing bmap (2020-08-03 08:59:37 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-08-03
>
> - fix bitmap migration involving read-only bitmap from backing chain
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

