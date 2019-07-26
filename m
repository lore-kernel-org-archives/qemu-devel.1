Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7899C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D5621850
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATiAObBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D5621850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2n7-0003d3-Rm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 12:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hr2mx-0003F5-NK
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hr2mw-00029F-3Q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:09:47 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hr2mu-00025t-73
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:09:45 -0400
Received: by mail-oi1-x234.google.com with SMTP id t76so40643619oih.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=nplS7ViPiO4rm/Ef6coRm+eWEUhzNKA5/MiwNSEjwao=;
 b=ATiAObBWgW961qVk4koSTbAR4vBgiH6/cJlNa75fkY5B5gDScTTCbYSkL0R7iVPyKW
 +xn20Rvs9yHOoW5LzDkMIQfxNGLbopdE43bJp22/n1Mn8SuPYQuv704EBLHE5iovNQlJ
 ahHspjU43RgQPS3rqbd6OvwGWtQo4om9IoCNuTcnVZd8fAM6gzIt51cDTUkEn/jy4wRW
 szsTYyz/duOu6tBdXd/rOUFLqq7ylm1ml8yITaqQZbKcI1ij4r7wukJQYypVtuKsT1lr
 mbP4f6sD1XBtozZLbgsXhOoxzpTZgP99rSjAXWHIhV1mJ0SVjk15mVhCgnhyGY2bhuLF
 rN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=nplS7ViPiO4rm/Ef6coRm+eWEUhzNKA5/MiwNSEjwao=;
 b=lK8zJr6tf8b9fjLkdHZyF19z+YLRl0bDk+1YAalFizVE7PsjGtDrfGJjPX36oRen90
 QPzeiGQdkIqhwKsE8Fr0r39dJ61Qpxfx3+W0dlJzvI9E5PWn5c+m/4r1w5CahnTsic2Q
 /naDfedgN8fhFQaAcDDHXAw9v/anG7awaHi3VERiGshmtGLfQcev2kKaww2VlqK4rq6Z
 YaM0yCLRQdjKZxe5c2lsiLqZ3wiA1ZESsJO9ATd9yjo3CREUBFIbBvpNnZWW5wD+ZxY7
 GfoaSgHO2Dy9XL7WQEStVepkkdMUUIFmjCcT4Dcs2nK3hJsrpf9f4LwPXXqIIFKn951a
 xCWQ==
X-Gm-Message-State: APjAAAW0RfkP6a+L8UM94AeWu9UH9PceDDlx61P0yVqa+aTuPOcH3G0b
 5Wfi+jeKzovJApmUdB07yJHhwyauXahMLOKnfTtupgNGzDw=
X-Google-Smtp-Source: APXvYqyR3NkBxEfY24Mlo8J99+k9zk/aRnXsFIzZXdHStv54irB3VZDKdT2+GYhMpyLAqclosxjIrxKonld+FzwVHU0=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr27384677oic.170.1564157382627; 
 Fri, 26 Jul 2019 09:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190726151952.1932-1-peter.maydell@linaro.org>
In-Reply-To: <20190726151952.1932-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 17:09:31 +0100
Message-ID: <CAFEAcA-RhQNiXhFNCNQC3DGQmLAAHH1g43Ba6mPzPbPDf8O69w@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 0/5] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 16:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Handful of bug fixes to sneak in before rc3.
>
> thanks
> -- PMM
>
> The following changes since commit c985266ea5b50e46e07b3568c1346e10064205c9:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190726' into staging (2019-07-26 13:52:06 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190726
>
> for you to fetch changes up to 67505c114e6acc26f3a1a2b74833c61b6a34ff95:
>
>   hw/arm/boot: Further improve initrd positioning code (2019-07-26 16:17:56 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix broken migration on pl330 device
>  * Fix broken migration on stellaris-input device
>  * Add type checks to vmstate varry macros to avoid this class of bugs
>  * hw/arm/boot: Fix some remaining cases where we would put the
>    initrd on top of the kernel image
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

