Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD07C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A732087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLu60Tkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55z0-0000N4-9D
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i55x9-0007Rf-6T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i55x8-00080n-3J
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i55x7-00080J-Tq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:22:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id g16so4305638otp.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zrVQ4/E6b0Lr7iXKEzS4TcnTZH+wGoeBrsP14wGD13M=;
 b=sLu60Tkc9Ilrt4U/MszyIApJCXPbLm4ota9uiRuyYD6ZPyRL4iuRzqukUEuwwzShVP
 YafbmoDdmdW6z+BsxyCA7TVy6S5X5crW4x/nC4hq0zmVT20Y+X+CKXB4Ikxr8B687X96
 zAXudu4JyuCM7vL9TbzDPceDXRJ3ZpCJlyghG02gZrppfmBwhXpR9oqSxTFtMbywyk28
 tdwhSm90GOdwg/gB71Y1eZxwjlU5v/mfyy6SpdXUcbdqLVATnFo08AamhI5VToOhVfDH
 g16yFkmfLpzLxHqJdBQunR3bYKQ9w1aqIW1PpuRusC6fBL7kfY3Mo6SP9jOMyGvpCZkB
 4gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zrVQ4/E6b0Lr7iXKEzS4TcnTZH+wGoeBrsP14wGD13M=;
 b=YgPwHQwdeNj5/HUbgHHAKEDMNah+qbF7G2Gi5AO4RKF19V76cw+X3bqY9GtB96l7NP
 ktd8Gbl/JXhGZXBHJI7sN7iBI9pEYbFY6971bgPu0nU5i/PPCWNFHOzu9pK4CTGgdbYQ
 Drjugnt5uuIM+NlXUivgw3wbk2JIWRdx+n8STeOrhMoMSqL8/Yo5LBHOAqAmUKZ1uTG5
 M8eqkkq3AjKPMYVwDU7xX40GaK3SIlwY3yqI1coQWGTR93bSZalF5xpQoBHWtnwyvbrW
 dhu/idt7fgzztab1ykATpwSR3NldXQU10QRNj9iyxNbxsjWvCnXlRuh4pJ+ZtbawoDKc
 Njfw==
X-Gm-Message-State: APjAAAU4byQ+fManPdTz3soQrbXPGR+y3CMox1WOFcJX/AbCTsUFz+ca
 k/O4Ye2/co066vAsAcvfrrLPVCCVHyCaJd1WEsJfVA==
X-Google-Smtp-Source: APXvYqzE3XCVcbsvumK7qT+0VTmTGH9aTErub8+uTFqJa2/W5PPfZvKo6Eu/BCcuSbybY/g6knoRZ0aAgVHXvdaaM/I=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr10082305otk.221.1567506141048; 
 Tue, 03 Sep 2019 03:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190828165307.18321-1-alex.bennee@linaro.org>
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 11:22:10 +0100
Message-ID: <CAFEAcA-fKh2n=mvV+Q9quOsQ1H7rwXf0Wr4kR18qdpMy6Uk6ew@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 0/9] arm semih-hosting cleanups and
 other misc cleanups
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

On Wed, 28 Aug 2019 at 18:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Hi Peter,
>
> Here are the ARM semi-hosting cleanup patches and a small selection of
> miscellaneous TCG clean-ups. If your happy taking them all through
> your tree please do otherwise I'll poke Richard. I'm just trying to
> reduce the delta for my next iteration of the plugin series.
>
> The following patches need review
>    04 - target arm remove run time semihosting checks
>    05 - includes remove stale smp max _cpus externs
>
> The first is the result of review comments, moving CONFIG_TCG ifdefs
> around and the second is pretty trivial.
>
> Alex Benn=C3=A9e (7):
>   target/arm: handle M-profile semihosting at translate time
>   target/arm: handle A-profile T32 semihosting at translate time
>   target/arm: handle A-profile A32 semihosting at translate time
>   target/arm: remove run time semihosting checks
>   includes: remove stale [smp|max]_cpus externs
>   accel/stubs: reduce headers from tcg-stub
>   include/exec/cpu-defs.h: fix typo
>
> Emilio G. Cota (2):
>   tcg/README: fix typo s/afterwise/afterwards/
>   atomic_template: fix indentation in GEN_ATOMIC_HELPER

Series, except for patch 8, applied to target-arm.next.

thanks
-- PMM

