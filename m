Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD0CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A21B2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkcK/27y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A21B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooas-0003X4-2i
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iooPg-0007no-TU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iooPe-00025V-PQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:56:48 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iooPe-000257-Jy
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:56:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so76264558oty.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uHNVe45bPawaFpgDDd0YwUYB1ddE9UBM+oSkjbA/SMg=;
 b=LkcK/27y65VU4stAT9nfUfM3xQ0OkTPo+zUFulBnmBVqnzO59r+Ol0I+xhfbXN2q5N
 QMuHfUAopGliwDPAXXdPF1tdkXhgCIKUEm34lNz31kdhncFZ3qnc+MvzmvfXNv5g7uzU
 uCq17qI+rZTsGauGvLMBwsgo6k5H8p377CGfUzc9H0VPU+II6E2C9hB5P3wymFQCCSYp
 y4WyjPYiD2LVC2VZusNSUvJq97viOLH6lEDRxEt3AiJ/elXMesJLZ6Foz4+RlMz42KUr
 FZxt0xf978TqMeDqQ/AA+KI8k43j++d3IwCAIO+0pxlUte4uQLU2zgTOa+d+5Pb/GZAE
 uJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uHNVe45bPawaFpgDDd0YwUYB1ddE9UBM+oSkjbA/SMg=;
 b=FsMtrVr2C3n91/DQCHW2dck8cBx+sLLRK2V7dDmE/z5onPOpkKqGao41PI2dn8dzYO
 ih9Km570VCK1+3TE476a8KKPgxhdX8vGTP6bqjHA468b3RGJW8BXiED62c7vPx66+EFJ
 NBOHM3EMqDpDE3Guw6p/Jc0dJsjHh2asSBYvAi6mWvdyEJTmDwn+DrcKnYjYc3SPE97e
 pBjk9un96iHOmyOpryzjzzsStG6y7ZOPcNU04aaAnYXdoXlHckdMr8h8myxTq4JHFz/K
 nXSnm1ABf6TlBhG7+xAFm5RuSfxUuWhAONBgcxU984Ett5Z0V+FnKnDI2F6WoFAsF1/D
 MoUg==
X-Gm-Message-State: APjAAAXfzX+Y/Q5UKrENnjB61T1HozqMFEDVRSvx2usxGDPOFE7XKPcg
 w7vUmTOnH5EkzC0J88M6f6ZhjsaxettC4Qyl0Hfduw==
X-Google-Smtp-Source: APXvYqx+2ER+NcHPoqe+taz0/tnrRgly7NxQ3fIjXmqbd5x4m5fhtSMfyQKje7YNsCaRciMcRFKzKAE1S2JPY3cDnDs=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr113452893otq.135.1578401805747; 
 Tue, 07 Jan 2020 04:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-22-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-22-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 12:56:34 +0000
Message-ID: <CAFEAcA-VanHHknV7BWOmfs5ZuN1=OVW5fdHstFALQ80zY-ODCg@mail.gmail.com>
Subject: Re: [PATCH v5 21/37] sm501: make SerialMM a child,
 export chardev property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Fri, 20 Dec 2019 at 13:49, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Embed the SerialMM sybus device, and re-export its "chardev" property.
> That way, we can get rid of PROP_PTR "chr-state" and better track
> devices relationship.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/sm501.c | 29 +++++++++++++++++++++--------
>  hw/sh4/r2d.c       |  2 +-
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

