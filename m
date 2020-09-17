Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE1B21734
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4/mD2iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE1B21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuHc-0005Zl-Nr
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIuFI-0003Tl-Vr
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:46:44 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:35798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIuFF-0007Gy-5M
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:46:44 -0400
Received: by mail-ej1-x62a.google.com with SMTP id u21so3413722eja.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=itoa0EkVs41InPj3NrKvKjQjcU5s/DwzeOQKeQw5UkY=;
 b=a4/mD2iGgBMy9Z2sqkXZo+XZQnZN+KwqsnYW8s0wy3+n0vy+sjrYMAK27Oe12s/A4K
 1WucZO5/CFihquK8h1SAB9Va2MzVAeQoYq4nqsZ43pRXjE0/RIpg/xogui6rBEXH+vey
 E9bySCYcSRT+No6IbDzaFxSePchC+gTGr1N0kVQV4lOU/aSbQYtbLDQg+XI/k3rjMcA1
 p9da2WIK6nB5PYjeE9Jf181Fln1mgkeyfNzReQr5lKk9UMAjoiaTl5cYqKJWOdM9mL7V
 dbqgI0+ozOlCwpExTqTeR8eBpFNVqYUKUZQZul01iMgefqQEAuh+OKioYnX9swk8aLH7
 u2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=itoa0EkVs41InPj3NrKvKjQjcU5s/DwzeOQKeQw5UkY=;
 b=kF4AvyVfeTDwIfGFLFLLekni8vEF+E893+PRiA9kDiZ98QJr/1xryl+45DzdGBELwI
 GzBiFx4O02YRA0L6eQyUXAyVfE6COJSa2xoFYtJdVUTKdeQPAcuvwK/zdqfez9lJJDGW
 WTw3ACx0+GM+nwrvQABrT+bI4vAZLgNAj1Au+j/hDPW0lsbYWTiU02W33ew+fwO+AAD8
 7rOGcXQUb23RvSGajzJiSpYqvQpUVQufsygKnhp9e6phS4GX9YcJ5hmqyaPxabReMf4L
 GcuYmQkt8qMc8GpVq6IxLpNizl5S5X5EBvyH3M6jeHrLkHv3o7GyzSIJdqLRoiujDnJi
 Lq3w==
X-Gm-Message-State: AOAM533xraLpFW58XBpmCBK772yo6oZFwqQQ0lZdqfjQ5B1zRdEzYeku
 xvnOsWz9JWP7RUcxyhENcXgirU84wOTs3NGVW4b+Kg==
X-Google-Smtp-Source: ABdhPJzz44RBDxEPfq2Iy1f9m4RaF01Pr6U7gFpxQM+mwD4fWtG8e/qjVFScL640h+N9R+5fyi1hWu2XPPH59Hzrylo=
X-Received: by 2002:a17:906:552:: with SMTP id
 k18mr18466899eja.482.1600350399239; 
 Thu, 17 Sep 2020 06:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200916114731.102080-1-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 14:46:28 +0100
Message-ID: <CAFEAcA-sN1+wsZ9sN6PckR=_74Ncj1y=AVZ9QHj5WpxxsJvQ8A@mail.gmail.com>
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15 14:25:05 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-16
>
> for you to fetch changes up to 114daec31d64600e5a070abcdb8de2cf74d01e94:
>
>   cirrus: Building freebsd in a single shot (2020-09-16 12:15:07 +0200)
>
> ----------------------------------------------------------------
> * Fix "readlink -f" problem in iotests on macOS (to fix the Cirrus-CI tests)
> * Some minor qtest improvements
> * Fix the unit tests to work on MSYS2, too
> * Enable building and testing on MSYS2 in the Cirrus-CI
> * Build FreeBSD with one task again in the Cirrus-CI
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

