Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518ECC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6DD20775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 08:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StU08W8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6DD20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jojjL-0007Gz-BD
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 04:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jojim-0006qI-P1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:28:28 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:44169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jojil-0005KD-14
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 04:28:28 -0400
Received: by mail-oi1-x230.google.com with SMTP id k6so3520345oij.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 01:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EnPgKbHZFjYc1hyE9eOcPoQenALALb+bmKMTMoN+M4E=;
 b=StU08W8MppirU5pZZsHt57VN04HtMdYftKcHtRZCAzJbqlToLpD3gVBXbI+IrmQWv/
 QroGImDsLn/kMZwv5zKGa2H7uFgPjURZXK37aP9HiS1OoK7I4wWDhpg9AEDIRzhRr58R
 Ok+n2bMMsyE9yFRAk/ZM9+YZ1jG0b/0UnKbAcaOgt/jqlrzra2jYBiwE+M/wM2VkqQMW
 bWk+JTNesJcHegFsnuiSwZnodmvN10rCyKQeY4No7qnuQYQ6wb8yf990xUn0TsMYaipq
 vQu43cOFsv2Y8eGOpZvwC2xjWu7eGu6mdqkzNn/nOKEHGDwLFo7xHCThjgHAWY6GsYXD
 71Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EnPgKbHZFjYc1hyE9eOcPoQenALALb+bmKMTMoN+M4E=;
 b=AEImXAyo0K1bLUHquIMMJrB7oNntfDZD0kwI/8LOMBISOi0RkEI+gNVu13Ffszu3mz
 9Fum6MqEDH3zHTPDrLKNFpPTm2tE7zGBZ0glW94YYIbzt8r5ZgMFv2lleu0GMJq8dbjK
 8b6AqAEAborYVE6iI+v/Vi7okgQo5+L3jCaXlPwpQk1wW684L/MhzvpJH462r5MXYWwb
 dvEMr0xxoSln82Uop0DqLiRbkrdj/ZhSogB3opoTV1+se5AHCKa2WF35T8AA5BPKHSFw
 YkCCmP8Bl1CUWW3FzNNBjQErpTNBsiA2uprudZHXF9sp6BnC+aCtD7l+2qz2my1DuhtQ
 483A==
X-Gm-Message-State: AOAM53318v/k4AQpjMGAUDV8ImktxTzIzJtZqhfHTBK33Lxbq7huufTi
 YsA0k8C8KMYOg0iS5x9vHl+BQs5Ne2XrY+hWpgCV/Q==
X-Google-Smtp-Source: ABdhPJwF85ZNdKtl8cMMFAM/f+QOzKD334Erv0h0Qmlus0i8S7+yAdJ9DdeRqyQfrEbJ3u6HOBw4g+IFhaQ86gEgQyw=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1447269oib.48.1593160105327; 
 Fri, 26 Jun 2020 01:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200625081133.446-1-jcmvbkbc@gmail.com>
In-Reply-To: <20200625081133.446-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 09:28:14 +0100
Message-ID: <CAFEAcA--JssbY+2-8tBTOaceB8vm0cA8c5w23pc8uP+KBOg5pQ@mail.gmail.com>
Subject: Re: [PULL 0/4] target/xtensa fixes
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 09:11, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of fixes for the target/xtensa.
>
> The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20200625-xtensa
>
> for you to fetch changes up to 8a3a81478dcc592518069125a6ad271fe5511b95:
>
>   target/xtensa: drop gen_io_end call (2020-06-22 03:38:30 -0700)
>
> ----------------------------------------------------------------
> target/xtensa fixes for 5.1:
>
> - fix access to special registers missing in the core configuration;
> - fix simcall opcode behavior for new hardware;
> - drop gen_io_end call from xtensa translator.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

