Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0FEC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A77206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXkRc6Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A77206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT8zJ-0004RR-BX
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT8xH-0003ge-9r
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:30:28 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:35145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kT8xE-0004sb-Td
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:30:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id p5so5297861ejj.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KLa6waaFMAt3yZmnyaIB2bKqan7xbz8NYq4Wce5QT8k=;
 b=zXkRc6Qmi/HnUsxZ4ZaPFpM+8bUPAu+OF0ODjlPIAuAjpXTA3g3DKgw/Poocj3G+rp
 QyiUQYubApXeXh0Vo9hyZNzz/fAjutTub9OPogUAu+M9e9Jh5s0OlWdP0yxDFDh5dBn9
 AHf6e4Sf4YaaLk4Pp4DMGcCSBElBpFmHXmu+IUEMAoLoE8Tq/iEwPzYpE3yl9YsXZ0ez
 hLJMPBki4qdGYW11uuUl/rhIFRxQRx9o7W00luc7568UBQ/CEy05lWzNKjbNGHgsRnj8
 aIrXS4t+9AES0HZRNNHD+DZLy2wceOzF2TMBBWqz2TIyslzBfGIPN9Cv3BIMnkkPMqKb
 md9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KLa6waaFMAt3yZmnyaIB2bKqan7xbz8NYq4Wce5QT8k=;
 b=U/7ZHcqv6fUm3S+ySLKb6q2z5ohYSIacV3NnjExURqkcL+K7O+6z7SDejOGHCYsiF+
 jqvCt6DVdbi9zQeg1B+8hXCY3yVA0UJqWSEFKa/F9s0pYCYt2sBs9Re9+49pbz8XuaY/
 +Kc4Gr+mYu4bPBSDttqMCHxHDLk7hOJN0Jh0SWr4ZWZOnTYRoPNG0JOllBNW3Y0YIPR0
 IXaVnwSGngankjid6DnOEnY92bU0IndxIzdlcFAz3dP3eb7HKQoGCObxiHD+cBpsdgYZ
 BF0uqtf08XW7hRKWyxxRo71hfri9SI7qtw8JY+/rgpR0zFPFTYG22nIEXxe6vZm99mJk
 BEtw==
X-Gm-Message-State: AOAM530S2v6aEfHfg2OAp41Oi41/rAcAxLv1J/vz2Ej6GChRy5wE63yC
 fHCSHNKVeRBnS14RgTdjJwM0RJ3pE9QVxLF47SowSg==
X-Google-Smtp-Source: ABdhPJy+8rZyXGJm5Y4DFkJbarxwu/vabG9fgWXloNSMl/+Aj9WKJ6bFlKu8EsAIXOM0mH3oJalpLoPoPABi58C1mIY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr5973318ejk.382.1602790223097; 
 Thu, 15 Oct 2020 12:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201014143415.240472-1-ehabkost@redhat.com>
In-Reply-To: <20201014143415.240472-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2020 20:30:11 +0100
Message-ID: <CAFEAcA_ybt2U-j6byUXJhKaAxBkRv-rjqKugmhWij2qBJdGerg@mail.gmail.com>
Subject: Re: [PULL 00/10] machine + QOM queue, 2020-10-14
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Oct 2020 at 15:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 96292515c07e3a99f5a29540ed2f257b1ff75111:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2-pull-request' into staging (2020-10-13 14:06:22 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to d9753cca6b0db724bc6d15e60cfad1705f800b96:
>
>   can-host-socketcan: Fix crash when 'if' option is not set (2020-10-13 15:56:30 -0400)
>
> ----------------------------------------------------------------
> machine + QOM queue, 2020-10-14
>
> * Register some properties as class properties (Eduardo Habkost)
> * authz-list-file: Fix crash when filename is not set (Eduardo Habkost)
> * can-host-socketcan: Fix crash when 'if' option is not set (Eduardo Habkost)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

