Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2490FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF937205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubCe1pER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF937205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jal4z-0002cq-2B
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jal4I-0001i5-8i
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:04:54 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31]:34590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jal4H-0002ZQ-4S
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:04:53 -0400
Received: by mail-oo1-xc31.google.com with SMTP id s139so2290049oos.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R7rJdqi+lpeDF5cDwPxgi2/om4RFbIn37QJspD6jnNE=;
 b=ubCe1pERX5dWDL0ahYilz1rxU5dOlyK+7KC77qJ+Xyvpa5eBGl3vb5yMQBjYX3HeLJ
 9TqyDPZv9xjUBOAyj06oMjewC4xmPtCAqWiNBVz88a24dVFsFfgvFf18/XwP98YL5dvL
 xTWbCrQpMg3FT61kEcrzOGRRyN8zi6wNH54S3FB6w6EJW3VcmqBcscukA30NRc40UOPx
 iK6w28jEOCzFTyTcdSX5kFWXVQC5qxPrC0U8ZoB4hFFz0k59sgnCRorvGPJ6Be/94gVW
 yUUM81MH2lOdodatwq5nUfA+rrYEp1GmgJ+lboln1uHPp4EncAWxtgzCT1z5RbA4mmeT
 UGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R7rJdqi+lpeDF5cDwPxgi2/om4RFbIn37QJspD6jnNE=;
 b=d9UjxQON2NY5qi7vyVuAFa8JDntyfs0wmss5qUVCbde1ZbiKn1EZOvez7pw05zzHRE
 81J7RDQ+um1y7fd0E0WRda5fsiGijyn9tbKIfwLE74M1Acde9GwFnDgiIgi7YHvVNALo
 nCHHNWxSU0lBH2O+Dxnxcjv9xso703YoALTQ94a6UReOD+rPxltWuYpaFp0+Oe2Nih11
 a96DdX9F+NhSqM0oVMp1VOU3U3K58tBcovlSU4s1LcsFf+NHrag8hsZXkM4nCYPINFTg
 rkAmsooY0KyMoRkz946EFT67lw8r5mc/JH8vEITYl1NC/AOoOirB+MexVMK/edw4hvHn
 O5mg==
X-Gm-Message-State: AOAM530sX5iUe99LfBe37/erPbmWItIxnftAct+13dYs7r2qd7mUHpmt
 nQrzjFmUAMkcMx3hCA0OZaiUNBtc+NTqf+NzTwTqHQ==
X-Google-Smtp-Source: ABdhPJwjZBDQwWtOT5BUuLe6pA9byNalm0eX7tAAXuqn9W+h811E5RKFK9p/hOunsQWtgiQUjzh5SBLeRZ3DVi/NSuE=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr14014107oog.69.1589828691943; 
 Mon, 18 May 2020 12:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200518151255.10785-1-kraxel@redhat.com>
In-Reply-To: <20200518151255.10785-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 20:04:40 +0100
Message-ID: <CAFEAcA8dDuroKd2C8V7Mk=pGih_hVORuFFzPMB5A7q1Dbwg66A@mail.gmail.com>
Subject: Re: [PULL 0/8] Vga 20200518 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc31.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 16:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit debe78ce14bf8f8940c2bdf3ef387505e9e035a9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20200515' into staging (2020-05-15 19:51:16 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200518-pull-request
>
> for you to fetch changes up to 3fcf15df0073a76d37e2816597771d4c9763e413:
>
>   ramfb: fix size calculation (2020-05-18 15:43:51 +0200)
>
> ----------------------------------------------------------------
> vga: ati-vga bugfix, ramfb cleanups and fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

