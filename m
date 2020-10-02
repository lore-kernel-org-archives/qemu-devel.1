Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2404AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DD220719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nyb1+bpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DD220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPaa-00085f-K5
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOPWe-00053l-0Z
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:11:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:33115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOPWb-0007LK-EZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:11:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id g4so2632091edk.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nIgPFPa+NeOnBwJGmiObRUt8avPJ5iejTmVAlh9ZCGE=;
 b=Nyb1+bpgPWA/52n9r0EnYBBQCaLpvZBGwHNk7JLoYpVmIcVcu1VSEiV/OV6tuWhkvq
 cWsyUVKHlQmfp/fs90JDjcbAwbNYV1CzBpz7orZ/RdUA6DNK2q+aJ2I/zH4XLhBiJMg9
 9NYsB7N1/gibHZRkhX2RWIyV5ANBpAE+QuWewE7xf1e3DRbuEfC0GcpVEmMuU9b1kCsx
 AXiRm+Ff4AJXPqXHlGzHvfOAOXD10P0r4DGW0fJJTtADnoyljCg4ok++B13K5P6EUgND
 vsAz9u25+8V515bFytENK2ACwN+WoqGcf82O4G2ga06rYQgWBzMbhz7dxJGYcPSZmnW2
 0Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nIgPFPa+NeOnBwJGmiObRUt8avPJ5iejTmVAlh9ZCGE=;
 b=hqDnVZpQ+q1feknGrjcnLmPNFSFcpriRQ3qKke8dRiOJELn2Di32cDV2pe+jjqbTcJ
 91FXxblj15kFTwCpO8nofS8Uaj5EUZg/4DsXpVe4zGJSLxOgtx2VO1R+YHjezELmNbTx
 Mz+ZSlfEeeNUJLwDHk/994LjVEoMT0ScrUA0nIaBgBzKGqd4tdLh6jQWNjYwGT/nASRi
 sv/6SnLnf6xpcDAq4pr2aER4uqfE8TGPkmCnRwtcfQFJc2GmisY4wojsS4kwwCVsnzU5
 GukMlH/80oXBRaLGXilODbIBfmA3wRnbFWpIlfQoh7Qoj+QP9QtUh8NuOuEdk+w6rwFU
 w4NQ==
X-Gm-Message-State: AOAM530tPwH+9hIgtvvpfBYe78q9ZWTCmWUPNA6Sktv9Y2lXOGjgyBwj
 nZGhE9KNCrAw0elHO6YGwetcXxlewIig5r8sGr7snA==
X-Google-Smtp-Source: ABdhPJwiG4CLYRwAC9rcHbPPSRsS6X5GFfQmhAiCRVxi9c/Ti5E6fRrVDMHTDUxA+Bi4k2ToqT2JS2rRttPsGboUeWA=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr3656018edw.251.1601662280153; 
 Fri, 02 Oct 2020 11:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201002144345.253865-1-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 19:11:09 +0100
Message-ID: <CAFEAcA8nvy9u+07LRfOdNAKbXpFmxtv7Su7s3j2xXXoev1V5ag@mail.gmail.com>
Subject: Re: [PULL 00/37] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 15:44, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 0d2a4545bf7e763984d3ee3e802617544cb7fc7a:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-python-021020-1' into staging (2020-10-02 13:39:20 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c508c73dca636cc0fc7413d1e4a43fcfe4a5698c:
>
>   qcow2: Use L1E_SIZE in qcow2_write_l1_entry() (2020-10-02 15:46:40 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Add block export infrastructure
> - iotests improvements
> - Document the throttle block filter
> - Misc code cleanups


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

