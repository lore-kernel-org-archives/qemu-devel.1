Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90920C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B03C206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJTw4agB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B03C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBqx-0002Tu-MH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhBqO-0001sa-Hc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:53:08 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:39528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhBqN-0005hn-C9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:53:07 -0400
Received: by mail-ot1-x32f.google.com with SMTP id g5so7486516otg.6
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mzkkXgp0w+zEtvpnuZQDyX64IpaaA/GxxdlEJ4IxYAk=;
 b=gJTw4agBz/WtXjXg2bTH46IGOgrNs8ru8kFG2Kyp37McdYmqyObppRDZMrRR0uua4p
 fJLctDbU3XuNw3RTldIDGYs5+NJ7+jgyGQCXbeJyA5xvhuW7mVMrcZRPO12RDyCEp1kA
 gLWoLDaY9wkldyr//BUMRkA7YaOfnYR91wFADfEMk6h/zbsEePiOPMfxs4Opyclo3xew
 7N7KGKdpVCykVcYesLcxte2mKKScoNmiTU/dAcm/TrEVH2AKhZry958yNpzEyaGLrzVj
 LxM9JQXQtXdC1PL91A0qEQavSZYefUQnKaj+Zs4bh1OgplgXoOA+ubT1iFV15hJL3UZo
 DKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mzkkXgp0w+zEtvpnuZQDyX64IpaaA/GxxdlEJ4IxYAk=;
 b=e3MaTlAGbM5pnN0MJHLvEvPc089FL0ZNwB42eN8ABYQe7zx9KWwesYU9Lk3glSl+RF
 FbZCaghQzxUfb6xy39S/jWYWcE7gxnqTuCJYbOsEr1H8cVuueuf4WbuXmjSglK2OaJOH
 wETLxzgwZA7rrLAqhvUus1WZp5+3OyWt90tmPdwrCq7aXqX7un4J3+NRlqRSj17MM2W2
 sXSHYYWeXHe6CZYqngZWctV6ZwqcP48fEetjcwDNgUaOy9I6wQRXcXdMVW76dH6/IN0q
 Fhvhqss8Ch7LU08wwhjIqTD3RSlM99q5ALYc/OTbrKA5H7aRan2MxXxmCN7NRsyCEtVV
 lLaw==
X-Gm-Message-State: AOAM531GH2Gk+YpBmbc8e0v2NFkU4O74voR5KCetF3A9EowezJP0mWwU
 Hv0Bmd6XTdORiWvyo95I+P+rxUAGTWHoykhun9SEhQ==
X-Google-Smtp-Source: ABdhPJysnEzHhNO8mpZ6gphZx7teSY4xifSHgRLtZ5Fv47G0mc367BhJnKCipRkUVMOONFPPGemnbcw/xRO/ilTDdBk=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr7701017ote.135.1591361586206; 
 Fri, 05 Jun 2020 05:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200605094750.149957-1-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 13:52:55 +0100
Message-ID: <CAFEAcA8M+KxGbWeHK5n6wtwBLFtXL7dVBBBa9En0zn+O-rmNwQ@mail.gmail.com>
Subject: Re: [PULL 00/11] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 10:48, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 66234fee9c2d37bfbc523aa8d0ae5300a14cc10e:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-202=
> 00603' into staging (2020-06-04 11:38:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 7d2410cea154bf915fb30179ebda3b17ac36e70e:
>
>   block: Factor out bdrv_run_co() (2020-06-05 09:54:48 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

