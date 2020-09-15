Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25313C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AC920756
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+Yi41MS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AC920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIATe-0008Rh-OK
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIANq-0001QV-79
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:48:30 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIANo-00045a-7y
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:48:29 -0400
Received: by mail-ej1-x642.google.com with SMTP id e23so4880389eja.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VKfWIAJMCrqN13rMR9SQ7Jx0m6rOpjBjAXOPQ7M9HEg=;
 b=T+Yi41MSdfUBVHPbp7HFhmtKfCEhMfHdu1rfvEUGfoRklzGeKjf73UVQxrdhIRbzLk
 WcV1i4ewJ2x3g0qCk8576MbsTdPPQcx02puYaUbrUhX4sciq7zycPfBsdA7FJJ2zSWCw
 oikVUDIJ32UwoMoCm57a8/fzwY6NpXmdbVvYvkGBSCTooMDCo/zm8s5QMoc7VJZHXB5y
 BsZJLRdwW1ZNkDOcfhsZ88i2YE1pH9DsWDqPHSGgi8tG1ie/26L449GkO8nRVsX1pDdl
 o8oj5nl8mh+RJuVRUkJLM1Y2JfrhXm6MKHvh4uvmpJXfIU4/uneSbxTBTJBi4Byff8Es
 YRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VKfWIAJMCrqN13rMR9SQ7Jx0m6rOpjBjAXOPQ7M9HEg=;
 b=D9Ghr7hRujVt4BaekzTcLstTq2WGAFacoPf6NqMM1wuXAWfJ/rRmXm1IArh+sw+2yQ
 eXf/PxwmMSevJa1xxGLqdmbMZS76ifkg/8sayf3X7hWUYGggmrGDq5ajwpfGdmqIBkli
 N8I52WAKndkLzPYAmVOOehLKZwCUk+sW45d5R1Nax6fjszJABuliucDiTj766UR6C445
 niICV9fx4So80AYM78JJyqBhTtUy+K9ka+3SCqJLn8timzuLJhomubt1BuHttZQ3eyfO
 KMFEXsoaVK2A+ASzNR2C0UuQZ54j3jb0Q30C2PMH3DVEH4G09oocnS+fys7cM5Y8Fai3
 zhMQ==
X-Gm-Message-State: AOAM530zT204YVdLcJzEBvVxjctcDT+vkUZcinVcAD3catY8vgWLWxzi
 2gRv5U+EgWMSfnNApAs2liddAMz9Q8pbG9KW79TPRg==
X-Google-Smtp-Source: ABdhPJw4EM87P/Z63yVhZRnRmo4UFR4EmiWpGPOlo/ECkrvEXl3gl7m/POYGRnWvTsm6UAj+QDVnVqzXDCQGvnJOUpY=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr19003898ejb.382.1600174104979; 
 Tue, 15 Sep 2020 05:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200915110155.15362-1-otubo@redhat.com>
In-Reply-To: <20200915110155.15362-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2020 13:48:13 +0100
Message-ID: <CAFEAcA8J+8hMSQE36wYc6QMdtdMg-_ZSYbNKca1UQ9u2epWCQg@mail.gmail.com>
Subject: Re: [PULL 0/1] seccomp branch queue
To: Eduardo Otubo <otubo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 at 12:02, Eduardo Otubo <otubo@redhat.com> wrote:
>
> The following changes since commit 2d2c73d0e3d504a61f868e46e6abd5643f3809=
1b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00914-1' into staging (2020-09-14 16:03:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/otubo/qemu.git tags/pull-seccomp-20200915
>
> for you to fetch changes up to e474e3aacf4276eb0781d11c45e2fab996f9dc56:
>
>   seccomp: fix killing of whole process instead of thread (2020-09-15 12:=
56:26 +0200)
>
> ----------------------------------------------------------------
> pull-seccomp-20200915
>
> ----------------------------------------------------------------
> Daniel P. Berrang=C3=A9 (1):
>       seccomp: fix killing of whole process instead of thread
>
>  qemu-seccomp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Strictly speaking patches you send in a pullreq should have your
signed-off-by, but I figured in this case the acked-by was
close enough and it's only one patch.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

