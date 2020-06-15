Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129BBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B42206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc/XdSSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B42206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpCc-00025o-4i
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpBu-0001ZW-Ds
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:30:22 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpBs-0004ab-Ox
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:30:22 -0400
Received: by mail-oi1-x244.google.com with SMTP id k4so15884358oik.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=srFUniT9R2/nwhsmcBefJuaMLsx7y8DQU1XICBlvm4M=;
 b=fc/XdSSHt9UD089S+WLDtb+fT1DzwXljqLwri8X2rURsAf51iTAgo/vE6SnaIPFxin
 52vR+t4OZHIB6w99A4x7LrrlVivWtWq2ysSANwvG6QlodTHwfYHm6OHJ5eiWmGfoZQfD
 ajww6ENjnuPTOOH4Ag6yj0dbI0la76roPvH+82JHJqiTJiB9tU5SMx76HxK7IM3c6nBm
 lIDgithkY+aTBxP1fGVyxTZpeiZzGEDnUNwQKhmMbrm22XUgM32IFDrf1S5gVtF49y5R
 aqCQGY6x77nX670xpY/0BrTX0xUd4O4WpCuyxIfzHiB6XJxR1zJlmvBT5ro5NztJl5J0
 DWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=srFUniT9R2/nwhsmcBefJuaMLsx7y8DQU1XICBlvm4M=;
 b=apewyEUBL6UBryuvQsQ29hXwgCTvTZBzDkqvyjRDsXIIgMGgZxdhCY+HcLFk5RvdlW
 18doyY1Yc7A9dhpI3LFzU7a17s2oHtuGHp52M7Sue56cehzVU+CU2Xs6lD3k99GAjBUv
 E0UZKQVLszjOL4hADVMOFKlyGKqeiYm1R84DIs9X3uRJx5Epqqvf6mbhMCopJKOpHKwG
 8R/C3Hajqq+q6bBEhsd8z/XWHXlbBaaptcs/zr4a01ftCKKsYwwFy/X/+zYAaH3+MVJ0
 7ukBkRsVdekELn9Cq9iUPeLOKg0wLT362w4SfKXU43t1Fzdngvf3J1bo8yLWAUXRWh4o
 0Pnw==
X-Gm-Message-State: AOAM533UexPELq0p1Ji5PscM6WvU96JuRVbc5GNBJ5O6MBh5dgXoBQZa
 wjDK+ROcTCxYoV7tIyd7AEeZSXAxnLMixNI2XQpKbg==
X-Google-Smtp-Source: ABdhPJzOWq86Jg/TNbmrYmkZS7WxqZjR2lU8jHWcC7fmCYU2GOMbpwaVbubiQL0SxHDypkmjeSSbNK7aSh0OsAEQZAk=
X-Received: by 2002:aca:568c:: with SMTP id k134mr8227307oib.48.1592227819099; 
 Mon, 15 Jun 2020 06:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-3-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 14:30:08 +0100
Message-ID: <CAFEAcA_mD6G+-OoA-2NWVXRD-qrOHWa56pvWi_SVBf5EZQf6oQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] hw/sd/sdcard: Update coding style to make
 checkpatch.pl happy
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:24, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> To make the next commit easier to review, clean this code first.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/sd/sd.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

