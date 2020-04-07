Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D3C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 21:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6841A2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Abpe3g/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6841A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLvWN-0002vr-Ds
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 17:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLvVk-0002WM-D3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 17:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLvVi-00056Q-Tu
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 17:11:56 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:33688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLvVi-00055P-I9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 17:11:54 -0400
Received: by mail-ot1-x330.google.com with SMTP id 22so4730401otf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZF78cAxWWyzqoXTU57AUohvpqTrNrT5K78HteKJY98g=;
 b=Abpe3g/XjHufKxAYzAHWMa2yguPVjhOXtPxlarHEZwrc4Ceihfvccx2aYmQCbktruP
 32YSqkqrLSCBy6t7um29EcfPP654DmlBoW6B0zFTAfcy0C+P6mHIL0OBDbykPwe/0bO9
 PEOyesXhHpMO36MaOSp99yE3Nu8d1fkFRxV50RmUL8S0Ve++VCylWKGQESECLF//E5dE
 JCLht8f16xE3mgOqfCgR+h4Icg1W/GsNlbkQGlmTism8/1q85iwjLf/Nk9kjbWhDbqoR
 mkYPUlkUNXGhajvbmJE+meWbMxx/xmumuMuSAKA1pvThyVBRp2+6jgdlnKBjMrh2BGiw
 X3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZF78cAxWWyzqoXTU57AUohvpqTrNrT5K78HteKJY98g=;
 b=r5ab97iABYqAN3thjqDKOhHkqSPZKC2m7iCB69UilQ+X5m/eW9o9+oo3yG1RSO4zIv
 zJWWhwvvESRfAmH73PgZfDaPbFfr3jglcuaIJMiYWYJRHkLER6rfFzAKhRMYDY9syb3p
 rI2BIx8oT6IZredq5w+5619+gF9o6u4XyCsEXvyEtckhIoJkoODvPJjXDAqHgTonzVOa
 k0xw0u40J7HRbTtB96sngR5sLhR6d3RWn02ALtHDAuEUSjtx/nA4UQNQLZVs/WxWHsqc
 XwBYYxQlVe1zuIAmoVF9prbQWqS8jj8N1D1MWH53GuLjTj7XEIJFJUdCBXlFpgTvttJa
 MnvA==
X-Gm-Message-State: AGi0Pua/vpB1l8o97l4d5yedYhieXXQvJe7u8zRBjIKPABnOfyXvDN/2
 DQDr/N8UTekrU9seYYpMnHzaI5I1s7oA8M5rMM+ZJw==
X-Google-Smtp-Source: APiQypK8p6e6oM4bpyu/uq9uLFkMMODhc7LrF7Sg8rUqfqaF21YfXZCCzSxtcqu/buWJ1G7TPmlNVgUf2sPmml9fEKo=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr3289337otq.91.1586293913150; 
 Tue, 07 Apr 2020 14:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200407152237.1468704-1-anthony.perard@citrix.com>
In-Reply-To: <20200407152237.1468704-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 22:11:42 +0100
Message-ID: <CAFEAcA_q7hN90Y4FgnmzJvvc=pmyb-Fi-zCHz-Z7phu1KOsW=w@mail.gmail.com>
Subject: Re: [PULL 0/3] xen queue for 5.0
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 16:22, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 8f0d25c464a1989d606f7b988d07b1147dfcde33:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-fixes-20200407' into staging (2020-04-07 15:10:11 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20200407
>
> for you to fetch changes up to 758af9cfabfb000eb00e42b9738e655b18fdd812:
>
>   MAINTAINERS: Add xen-usb.c to Xen section (2020-04-07 16:13:26 +0100)
>
> ----------------------------------------------------------------
> Xen queue for QEMU 5.0
>
> - Fix for xen-block.
> - A fix for a Coverity false positive in xen-usb.
> - Update MAINTAINERS to add xen-usb.c to Xen section.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

