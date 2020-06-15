Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CA62078A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxTwdYFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CA62078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkre1-0006rv-9Y
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrZe-0001uJ-J8
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:03:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrZb-0001X0-QD
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:03:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id g5so13501298otg.6
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EmnkRH2YoTe3iuP86b7Jm00I5ntFoZNUS9DkL1GSuKA=;
 b=AxTwdYFZE+TWnc7BVinvaFzGuG+pHwUyKam/7MlzT41XH4iuZEVBgynhDHwl7y7uPE
 G7hsRlkG1zaC37htASaOrB96uGAAXhwGW1mNUvce9TWFytES8aFRALg+yyCJgBitSGPl
 Gfb0HYuaF+tUvMgZR07vUtVkKR+QPRHhV/z3wRwpDW7mjG2SNlIW3NGmoLYOZV4VwNQK
 zqXaRHwVXwYDJJwygjkQhaLiwKve57aP/Icese9QkofecizZ9XdaWrX3Zw0fobWvOW2K
 J3FIDmOmvCxpk3sSxaFt20rGH5YfB3a4oSG6CXBl0LHczV0igDYmaWvaZTIxflV6MMDa
 nMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EmnkRH2YoTe3iuP86b7Jm00I5ntFoZNUS9DkL1GSuKA=;
 b=mgz4oUjWn9y69gjbeB8XGEm8rO3nnxGMhWsre7J6Ygz7JRC6+nsbAKJLkAjEGkcJ5c
 +7IzXk7w6MYSKcxBOpj/0ETPKcIi5rJOdpSX7H02zY7t3UsfPsPAJkyh5nUDmlDZCc2n
 rU+rst1/ZT3ob/xrtgVCtvkrZN3oEtStX2AsUqhXD8tciDMMOQ8jgnnTcmS6nplsebeg
 obkME3dlxVI3rdW8VpyQUko8vkku9gPRDvVZ0G+RtlQyXEsi6EgB03xCQzOKIfSy1QkI
 AlLRp61ZtWTwbjbNClRWvx39diOWObsdglS5VxSqv0qt2uHIwpn5+HuTg5jgYqQOuF2Z
 g4Cw==
X-Gm-Message-State: AOAM533VsTTrb3Q5WMhe7Dfu7gjNW/slcb135YWXy8i+ncO/+mknmTHq
 rpPgQ8oVuHDQDTVQ3X22FB87qQLCi0JSgNM/iJf4Dg==
X-Google-Smtp-Source: ABdhPJzjKVT5ex72tRNYX8VKVlUDdXnVV+h31uaPM2PhR+fdGgc7qoMfQZcWKxw3dyoyZLUnm1MJqi8wN/5vMPI8FaI=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr22645151ote.135.1592236976952; 
 Mon, 15 Jun 2020 09:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200612175440.9901-1-f4bug@amsat.org>
 <20200612175440.9901-5-f4bug@amsat.org>
In-Reply-To: <20200612175440.9901-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 17:02:45 +0100
Message-ID: <CAFEAcA-B26YareWgkTanQdGnz+WuyJW6jbHCvdwcGty56zgXpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] hw/arm/microbit: Add a fake LED to use as
 proof-of-concept with Zephyr
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jun 2020 at 18:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> We were using an AVR based Arduino to use this device, but since
> the port is not merged, the microbit is the easiest board to use
> with Zephyr.
> Note the microbit doesn't have a such LED, this is simply a proof
> of concept.

I know this is an RFC patchset, but just for the record, I
don't think we should add things to the board that the
real hardware doesn't have. (The microbit does have a 5x5
LED "display" but I dunno if this would be the best way
to implement that...)

thanks
-- PMM

