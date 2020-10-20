Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC797C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DE221741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ze+dZL+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DE221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpXg-0006Xw-Sq
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpS0-0007ga-IT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:05:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:39843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUpRy-0006xL-HD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:05:08 -0400
Received: by mail-ed1-x535.google.com with SMTP id t21so1370246eds.6
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=19qn0BCYWTM0zx/HwCCABK7hV/xe9G+1LyV7NGMXlQU=;
 b=Ze+dZL+aSJSyQyvOV24FW+TcTcJ4hKvSue+XKEjS9cR6zBBkjaBZBMt6awYUppzhh5
 fBRuBN+wv0IAOGiWtN0DY5Wd8Rkz+MTmgzFKKJkCK9SIQ/qxrHGU0N7rk+Byd455zA7Y
 vSZsQF+h604Fd4CdXBq0MkiAGHaoh3oRxlWn+5F4Ll0r8Dt56mU9Er4VVYIk3bGRXvbo
 w9JVrJK5qpgy+Bxtskb/Xcz/m/pzygG2tuvy2SoUvLVHpK03hobVVT0eC6HhNQh0az+P
 nYxhwtk0cVd8+xGoZ9Pl/UvyfWWbMEQ490J94y9lvnaTbcueAssKX6mCjAiJnmn7yGyM
 NYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=19qn0BCYWTM0zx/HwCCABK7hV/xe9G+1LyV7NGMXlQU=;
 b=uLNrzZnW3dYd7Sz8joeV6ThPi+WVnNb8YprG8y7qoIpOWADFrmPR1QV8B9nTKTZNHj
 lIz5YcjWoWJGbj8K77idlC+e6ccFNStbpnyOXOXTB8Gqt1Gpb1ztofrnYNYikUHR5XMs
 EEr3wqu6WEc1S//j3vF3RFUFp22J/cysFVPv+nbYVgNhcztQ3kRh3c5PujvY/d+Purjx
 Jr3CNRXaHKyNUIbkp2JpVLogJ04JueitzMsXZXyvj1WXd0RDX0/D5m8divXcCriGcsmP
 Pvz8MZ8gv69esvB8D1rJwz0x4VO5egvDWOGt90hl+cLNoaMwz7hMcw2MRf3pTJexLEkw
 2qEQ==
X-Gm-Message-State: AOAM531VHY1HnsC7qZMWDXztBhc1LiXgBUVUvg03OIly+nGfn1FoUGR7
 xNzLs4bL5/GDNnMo5SYIP09GF9xeCQx20sk4vG+FlQ==
X-Google-Smtp-Source: ABdhPJyxgQ1NUIDElmJPF32wlaL+q6lIGOZ6SS+mmUFF3b6UdtFwUNurBr+pczB3pHND2ZDQUpmCeZsgP0D2mo4LuYg=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr2232319edb.100.1603191904687; 
 Tue, 20 Oct 2020 04:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201020100239.272748-1-anthony.perard@citrix.com>
In-Reply-To: <20201020100239.272748-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 12:04:53 +0100
Message-ID: <CAFEAcA-_w_tve3MfUnPLMJyerox_f8JQAu2SsvCV29O=ZKY9Gg@mail.gmail.com>
Subject: Re: [PULL 0/4] xen queue 2020-10-20
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 20 Oct 2020 at 11:02, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit d76f4f97eb2772bf85fe286097183d0c7db19ae8:
>
>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20201019' into staging (2020-10-19 14:39:27 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20201020
>
> for you to fetch changes up to 8959e0a63a3a681a31ff8397d9345a88e6d905bf:
>
>   hw/xen: Set suppress-vmdesc for Xen machines (2020-10-19 16:33:28 +0100)
>
> ----------------------------------------------------------------
> Xen queue
>
> * cleanup patches.
> * improve xen backend setup performance when other xen guests are
>   running/booting.
> * improve xen guest migration when running in a stubdomain.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

