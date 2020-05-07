Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF12C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 336DA2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4MxiRwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336DA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcAq-0001Bf-53
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWcAC-0000j6-Qd
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:45:52 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:32846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWcAA-00022b-SW
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:45:52 -0400
Received: by mail-oo1-xc44.google.com with SMTP id b17so1162994ooa.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c1Mb6OZpWMyTtJ9/wbtgbyEX3acbcVdZ3HzvoUHi0a4=;
 b=O4MxiRwHuibTZyb5EiGEdZ2YUbDGysiiPNHqrz60bziKcRtD3UhfyTKtgMSSjEl1f/
 KW45+iHkeBUa6T1oPhpA/tgrjc9fL9HXLj0UInRTuTwi4TjJRytmREPfjU+Gpf7/GEn1
 f0dw6+7Bz29IW/iUmYr4OQdWpmdtX5nO9KUtu6b1A1lIhrjqLssCX/80S7Zv41WmB/aC
 TTtcAr7lj+e7t3hOSRTZ6xg0zxULrkBqgk1KgV//3Dc0P/0UalpTzW3RKV3tXdx08/gr
 5yLi2cPjEVFYHuRCy961hkbIMF/0yXKP1+ozvCV2algqP1bezs8l8fJtQatRH0QaJuM0
 pIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c1Mb6OZpWMyTtJ9/wbtgbyEX3acbcVdZ3HzvoUHi0a4=;
 b=LzOLaXlAkwBdt9ZLdkTqxwE5UpXEFY51ZMUjMUFzALeHsfVkxq0PkeFaYMaW/F9rmA
 kQkI+YVmBp27mK4Hp/8HAkKnKegM/KLvn9zkdiw2RJQfKVzzeEaLtkhjQVQD6Pv2m7kX
 znw2PV/MhHwv5rfcfKcNTlqgjb45B564pEd/EXISz3CUJE+DInNdvcM85T7cX+wKZgJM
 FtL1trElDr2c6sE/X4xYV3EslKBIQLvmroklvGbYESAUU/WYYax4SjVznfHWVKsqC4ZE
 AQ6o3h4nkilkQ7ke55T8QdENojQuhqaFaNJqFWjdR3yGNN9AKx8UssiwkoX5wMKpC3Mq
 zWIw==
X-Gm-Message-State: AGi0PuZ8Mi8KmR0CU2xjOib5JN4bzddh2CryDMammam8LBCfHYXpn6b8
 OhOHmFo6hbYT2kw0ImnZSNWOlHDL4YgWE2EdRDLEoQ==
X-Google-Smtp-Source: APiQypLxDZvfn5ZE77gSC+cZY9JPmCH4zmiJn6owSnCinju+3BQSKZCADFHB4cxCyCbjtju0UAJWs085NNQq6MARsr4=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr10627769oog.69.1588841148877; 
 Thu, 07 May 2020 01:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200506142746.369563-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200506142746.369563-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2020 09:45:37 +0100
Message-ID: <CAFEAcA-cLrMRSZhTdrq4Q2PDa0X2HihLw1-xPzJewwe9d8n16A@mail.gmail.com>
Subject: Re: [PULL v1 0/3] Merge tpm 2020/05/06 v1
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Wed, 6 May 2020 at 15:27, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> Hello!
>   This PR provides PPI changes for TPM support on ARM and compat
>   machines for QEMU 5.1
>
> Regards,
>    Stefan
>
> The following changes since commit ea1329bb3a8d5cd25b70e3dbf73e7ded4d5ad756:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-05-05' into staging (2020-05-05 16:46:37 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-05-06-1
>
> for you to fetch changes up to 541aaa1df80df465c7dc934dc8cf57c0e3dfd6c3:
>
>   hw: add compat machines for 5.1 (2020-05-06 10:12:16 -0400)
>
> ----------------------------------------------------------------
> Cornelia Huck (1):
>       hw: add compat machines for 5.1
>
> Eric Auger (2):
>       tpm: tpm-tis-device: set PPI to false by default
>       hw/arm/virt: Remove the compat forcing tpm-tis-device PPI to off
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

