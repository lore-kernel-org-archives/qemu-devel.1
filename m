Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E93C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541312074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4V21mF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541312074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7Wj-0006KR-K5
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl7Ve-0004v4-TD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:03:58 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:43925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl7Vc-000390-PF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:03:58 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id i4so1195586ooj.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NpDEM3EukKZ9HEBElaByMWE5MOsvcBH36NUWOrybWeo=;
 b=T4V21mF+W3zgF+RB1kWbqilJBrcI6X4TpfJ1J/334evImNhb9nWpIU+jAZYL0ftM9S
 SCNGbXiCtEMT5Kr1fLjUQk7ZBAc7cTB1UCj2GpH9+Y/qH/NH2IV6bRElr6gYPic9gOOf
 +eYPfQrG/IpSwLXfOlpufzrRnkzESoPze2n8YmFvb43CsX51ondUKUoTGYaHpalTXru2
 RAyZQC5z3k4XCxXYkkj8yBH6eAdSfD8nYtgZeCHjUCE9dk9eC04KLzYtWNmOnykpnGTl
 XH8+39rkPjz5ppmSF9UHQK5SvdeAZhCAyYsHaKmvfjfu1w9zpUTm2EVobzDzSooJTNQS
 Hjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NpDEM3EukKZ9HEBElaByMWE5MOsvcBH36NUWOrybWeo=;
 b=H2O6VqmG0Rmwf5Mp83yYVhz4+Wv1aCWXdutER5U22taqxK6pXVAqbcsSZoqboW6++w
 YY/oo3QwMakNb+untPn9wWTduEXseM+iU3stBiSKeES2CRr2IoIcKZ+1KcOD8euuLN74
 fPMNxYL/w3xJwgiVfBs5gK/FMRiImafrqXyvG5NZImIfdV+sJKV8souzQXpLdWkcYHN8
 ki+zJwLkWIsrz684AHvEq2RersDdBUFYL5LSMF4chX8dO33NOE9l+56K/izD036n2Kz+
 x1BQSyi53PuarPAe8CaIp4TnmfYk1nrZu8D+i4O0zYOmYkZ9PWHgePHifuuuOb96bYN7
 2kXA==
X-Gm-Message-State: AOAM5307GRmAkoSJRZefCnimZWt+TUcTzSoPVq+4vVH9UbJfuTClkowj
 d/NLhpKrx1S+PUlwjE6M7sHiQM/0FAQpSdfpoBfnFA==
X-Google-Smtp-Source: ABdhPJz3UPyNUVF30Ks+3Ng3ZZ3t4YyfKLdSe0C9znJOPlEpUjJBxgtgRMNlYwN+XiZ9s35/xiXxrAzOdgvygLs4SeU=
X-Received: by 2002:a4a:221a:: with SMTP id f26mr1490417ooa.69.1592298235082; 
 Tue, 16 Jun 2020 02:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200615103633.300208-1-berrange@redhat.com>
In-Reply-To: <20200615103633.300208-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 10:03:44 +0100
Message-ID: <CAFEAcA9WXvK=ybfCneXLgg4H=muQ=Q=TBgpFa_+H3zttF49AsA@mail.gmail.com>
Subject: Re: [PULL v2 0/5] Qcrypto next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2f.google.com
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

On Mon, 15 Jun 2020 at 11:39, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424=
fb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
tagi=3D
> ng (2020-06-12 23:06:22 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to d6cca8e111696fbbd7c233dc53f9c80b6a43359d:
>
>   crypto: Remove use of GCRYPT_VERSION macro. (2020-06-15 11:33:51 +0100)
>
> ----------------------------------------------------------------
> Misc crypto subsystem fixes
>
> * Improve error message for large files when creating LUKS volumes
> * Expand crypto hash benchmark coverage
> * Misc code refactoring with no functional change
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

