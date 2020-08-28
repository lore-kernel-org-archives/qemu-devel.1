Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A33AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2D4206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xWUGPR9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2D4206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbGL-0003x6-Ip
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBbFp-0003T4-DM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:05:05 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:38023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBbFn-0000sx-Fk
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:05:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id b2so631827edw.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3GJWD3iPL2x3i/hERpQgKOrnhnFhnBoNKrE+VDjBtXQ=;
 b=xWUGPR9rPFaCbu1CZSctDAhndMoggfsUkW/f9Lt95dPejv089gSgjz67FZTtGQaqv3
 wuwpOsOWqDs5q2JD/I3sz0HD0I5nNP1bB4P5A+jqK+7ypNw96nfw6sv01J4/4Rk9TqEi
 t8VAau6KYzBSZ8yN1hQ+Qqka7bG5gaZ31sL7kOmYAzAdipHHbZHcrYniR15rLIS3Alls
 Ab9tlyx+YYLM4suK3/L+1D8me6wTDXCjlaOKeebHq2LRx4x3Q7hMgoqfux3Ty9l8LGuN
 rrgllmPZ9Q75JYxpkf+2C06jLWCzaEBwp/IfcXO4kUyXMs6JV3RuDk/5gbjN89SG9nWz
 fXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3GJWD3iPL2x3i/hERpQgKOrnhnFhnBoNKrE+VDjBtXQ=;
 b=VZ4Bwx4BBY82nir7ZSdnon+jmWoSMiNM7whxKuhti8oJJT4XDBqW7XcmhI8Xc6M2mT
 6531ue0VgMlddMoLfXx8ejHJrInhmvkSrJJsn1yhQnsao1wBTBqSmHAX5ne/SfnCxoVT
 b6DAgUVCAqeBEoRRakSM87af/C+Q8fJeJ9CKgJ6Mvu7f/l0NOJsftq7PD9uIl0ijQahg
 uVcL/LUTpOcZs9yNcjRhNrH1Lc+NmLUgAbGnV+OHeKD1W6miziqgOoD164HayBVsE7og
 9hZacgMadz5QyMOH3DxvPvcTeOj/XBY2kzsnDT0TQ+vofNjVtVZTAD4LQEVA29CdUS9p
 5rRg==
X-Gm-Message-State: AOAM533ZUk7JHzJSILrBf1BqGny4q6gPh3ihTU7WzVfbXVeLoILfzd6Z
 kdOcyMfbzotx+92TDUHJ2Mmlbh3sImLwdS5HFrywEQ==
X-Google-Smtp-Source: ABdhPJxsC00zpqJK6PbV9bRFbl1pkkxSyWW43YPro6FRP6wLdZHBmX01/WpMWTkaBzz8RQOWMdYeHmHj3sRZmEyBVh8=
X-Received: by 2002:aa7:ca14:: with SMTP id y20mr1098898eds.100.1598609101934; 
 Fri, 28 Aug 2020 03:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200827165956.12925-1-pbonzini@redhat.com>
In-Reply-To: <20200827165956.12925-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 11:04:50 +0100
Message-ID: <CAFEAcA_RJkhobMO8jKCxO3=1zwG+Terz+fGM117dXCuakd_hrw@mail.gmail.com>
Subject: Re: [PULL 00/17] Meson fixes for 2020-08-27
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 27 Aug 2020 at 18:02, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d1a2b51f868d09ca8489ee9aee9c55632ed8fb92:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-request' into staging (2020-08-25 15:01:43 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 666ab710f83c29966cca3a5d3ac2776c2b5f1afa
>
>   ninjatool: Fixes E$$: in generated Makefile.ninja (2020-08-27 08:31:54 +0200)
>
> Since I am officially on vacation I don't have access to the full set
> of tests I run, but it passes both gitlab CI and the docker-mingw build.
> It does not include the submodule update for Meson 0.55.1.
>
> ----------------------------------------------------------------
> meson fixes:
> * fix PIE default for Windows
> * tweak conditions for requiring SDL2 and pixman
> * move NSIS building to Meson
> * fix creation of systemtap files
> * add --ninja option for Windows builds
> * other fixes for stupid bugs and for Windows paths


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

