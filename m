Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:45:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CBF2080F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOMBfOH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CBF2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZhiG-0000kZ-He
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iZhgP-0007xY-VV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:43:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iZhgO-00016c-KQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:43:37 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:32841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iZhgO-00016D-Du
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:43:36 -0500
Received: by mail-ot1-x334.google.com with SMTP id q23so11317645otn.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZsLhqKnJTsUVbbhKGMVhPYU1UuLtqj3KpJXwzPoqsg=;
 b=LOMBfOH5qDt9HnRP5D4Dp/mWoAXBECnNIzqFkTE4o0LXKxJyuB8xG4/eSu3m+DOJnA
 NO1JEuO/pZ4dBIwG6VYweVHMYDqh9hNn07llxC8CZZp/QGZZfOkc95G4pUxZDX+3QX8M
 CGTU+mxpLqT2IVkwlzKbVIedITkopXvykPgwqGp+ctXn6t8c29Ps/EHne2+PNWy1bYXH
 hz9k8t70VIhKjCLWCYcHP3pLzBFYS6f1xdcQ8Xkog5bSiOyGufCJrMpCfa9TYxMKA8LY
 numYWj0JHtpCyjoUHvKqQNqF3OlUYCuB8IN56owdbPjPWmmTZIsx97i6ZnoTjz21fckt
 JfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZsLhqKnJTsUVbbhKGMVhPYU1UuLtqj3KpJXwzPoqsg=;
 b=I3l66cMSj8nlbIL8nf72aVktf8IKvybLEp0qv5y7Gil/jk2oCQSjaPivbgd3zyV0QG
 Q05DAlm9u2CldOczHqplxy+KAUOo2gFbIGE/JJdZahfPV5ccJsqNBLyfsKFwijOozKtD
 6Hg+gksjl+oE6yqe4RUMUWueCqxAIElPfWli7mAju5YUi/QKLm+ByfMLSIvkVCDPLzFY
 Uu3dz29lkJZoUcMKGtWov/VvMmpjBZFV7AWjVfFe5HBSw74jkmv8jCEaZS/4Ps674BjL
 ZtSgrFFNIjlbZt9Blxedm+kfq/MuHucgugubRp4c8eGkA0VCwd+7ni7GNlmplwP4JGdp
 syDQ==
X-Gm-Message-State: APjAAAUymYxVIwp+Lf0qapUEXNkA/gbPD4hBlYbPIxJ67avqyhpxZaLX
 PvBSrqbhaPSiU6GPXkf7VxLkeXG/EgWTT5YJmRSugg==
X-Google-Smtp-Source: APXvYqwwAnxY6XPr2KFDfcNSCiVQkI8PNczfQaUFL5P2osUGjazXWoN5FnUgM/RnouGgnGQSWazMHDDV8qd1RQUAj3c=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr767281otk.91.1574801015426;
 Tue, 26 Nov 2019 12:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20191126085936.1689-1-pbonzini@redhat.com>
In-Reply-To: <20191126085936.1689-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2019 20:43:24 +0000
Message-ID: <CAFEAcA_RYF+sReq=yta0m4cY-N-qfBLmM62QUzXWE3dds8Djcw@mail.gmail.com>
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Tue, 26 Nov 2019 at 09:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-11-25 15:47:44 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to e37aa8b0e410e83b4e150e38e83e385169ba09a7:
>
>   hvf: more accurately match SDM when setting CR0 and PDPTE registers (2019-11-26 09:58:37 +0100)
>
> ----------------------------------------------------------------
> * VMX feature fix (myself)
> * HVF fixes (Cameron)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

