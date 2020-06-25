Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145DCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77C020773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVccJGnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77C020773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joNM3-0001sc-2S
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joNLL-0001Qo-Ey
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:34:47 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:42895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joNLJ-0006Ts-DV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 04:34:47 -0400
Received: by mail-oi1-x22a.google.com with SMTP id s21so4253036oic.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IglRg8lXsd79+r5shjZYwTBveptkPLVkCrw5Wy8tYcs=;
 b=fVccJGnwDr7z4QvSohrpIBf3fhbrYOCDpoxPraoEvktiqoUEvHOO8pni5CCulFU1Zi
 Tawf3FTiM7NHeK9TvOCbyLXa44uv9La6GtoRpD5ZWHyQr5gHqbSALq/zkHiyBOqCCTkw
 HNFxINVX/GAPVqt2zE5t4ZfqRmD1PXK5uh69M5Y8kIKSb21R5gsXj7MF2ylpKxXfx3/V
 eq9nTTxL8HOiuAqFKg7a2/vo6AWenVrADSiBCNImgEawvIKlFYRVqZX6Y76sbGw3rF5K
 JaKmyEtABiwf5L4J2kMhHXeLOCxbqKD7YFqOIzIlnNrOUqx2siXgb/vyMQFoTRtwUV0i
 0KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IglRg8lXsd79+r5shjZYwTBveptkPLVkCrw5Wy8tYcs=;
 b=oRGgq+hKg+ONqE6fsNdybEJ9b1PjmmXH8ArqlDNjwGrTTjtSWiCUT+/JD/cZqmw3U+
 5JvVrwpGab1vDZrUAl7+xUiUl9ZjJdedC5O/DOnb6v+exjCyjRNitE0VMr9NSP7F5kJb
 sddIpaNGOiIjw9InflQfRyPcHW/xD0PWcPpV4RqMHXk20CkMiRJWkuIqBcft1hGc4pbn
 eE1bKyTL/0F0C03doHJvhYs0EUWU6dORqN/daqFn05CRTeZMn/B9hHoMvIlE++1BqmXc
 LKyo/lOyeyHfjXnCsjxZpENg4OZZFbic4wFoo7epWdUqItwPDkMev9HHz4hlNrlN7Cq9
 pdyg==
X-Gm-Message-State: AOAM530UuKMZIsFdUYFUZwEXkxvAbesTvu+vqaCOhw1IQD6NhZvgD3gT
 aSFfkh0b1l2R6vh+/afClvmerlk/H9/h1aYE7leRZv9Ci4A=
X-Google-Smtp-Source: ABdhPJw4NgQczUtwkoNERzcfrN8R3JwKAXqTqRn94EE8RCoEEJBcJJzW0sXSIXyo1OPUxSbg5FbwwoLQf+mk6LSb3zU=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1220027oib.48.1593074084006; 
 Thu, 25 Jun 2020 01:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200623114114.1375104-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 09:34:32 +0100
Message-ID: <CAFEAcA-GijDVQkbY7G1JkXToKHkYuzUWyii5KQM9r+yEPTi6RA@mail.gmail.com>
Subject: Re: [PULL v1 00/12] Merge tpm 2020/06/23 v1
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22a.google.com
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

On Tue, 23 Jun 2020 at 12:41, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This PR cleans up header includes in TPM code and moves some backend components
> into backends/tpm.
>
> The following changes since commit 292ef18a38270e1cb8e9a3dc06bca589068f293d:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2020-06-18 16:52:10 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-06-23-1
>
> for you to fetch changes up to ca64b08638e259c313a3e7c3da106116b59be8e9:
>
>   tpm: Move backend code under the 'backends/' directory (2020-06-19 07:25:55 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2020/06/23 v1


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

