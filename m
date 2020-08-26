Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695F02075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zu+aEqfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695F02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxwc-000465-OB
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAxvj-0003MM-Sb
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:05:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:38446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAxvh-0004HE-DF
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:05:43 -0400
Received: by mail-ed1-x535.google.com with SMTP id b2so2214150edw.5
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZScxKFSiyu6tqCFCLZWF+IZV8Vsoh+FFia9FOqpzkiI=;
 b=zu+aEqfvUaW0X7ZORvqKJrk9xhxCL3IOJyL7VBo+RYw+SuWF9OPiXsQLhEsL7k48eY
 b6h8Cj23Sr5eMUalaiILmoHVKKPDKISz1OiPg3VxCFK0iPRG5usMDqGqGPoa1QBaGGTq
 1pGx/XyebJA1y+4ba+Y6At++O3srGeQ+K/E7KeRPn7XUd9vxjvZKRHZJC6+U3nC+G+v6
 OZHp3ACcAv5gKKaoGjqKDmuijjvr4nszWH8ZNv1LkUmztwhSaO9594bW6aVO6C1oaDTI
 4mvH28cWeIL6nFnJQfyqEhwNbUBwMVXGL4md95xyTgYexWCoy7oKTZUxjcfLT7vXsfbP
 qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZScxKFSiyu6tqCFCLZWF+IZV8Vsoh+FFia9FOqpzkiI=;
 b=WyqZZlDH13iIQuTgYW6m4RJySLn1wdNQQ0gY/C86+oqKp83SC1/SXa6rkZge7/sAlk
 Ee8iPuOlR2xIiDdrgjEqfd/2O3BOlgXowVNj6SsMa6yvI7SspHZOnVcv9qFAr080q053
 GRatwje3lQqVIVvq7FIOGM1vWSYuunZ/is6TQ7hHvlK2AFtbKVro4SFsmrzFHKJ9kcCr
 xgfIGFmdeAFFflSJJxLtkczwu3os8hOmeUj6+W2MC/w3BZs5yDstt23U1xGfvEfe3xzO
 63QWgBv6Mu62tPAQsNRSogpaAvoQ07LraHrTwvL4VPu0AKslTIDEU3GsZiXf5Rwe6ExV
 nlnw==
X-Gm-Message-State: AOAM533aAXV+agA1cvaeMSiBtTUK6I4U2GDwb6fz3LbORa7Y0h0iI18g
 EYtNyJ2BmxRMRs0QE0qIow/M0TU9Chz2Jv33CbpfzA==
X-Google-Smtp-Source: ABdhPJzUnZagxkffwgIgEdT3aqKzC1+3wTRBafxiR+me2mMquFaZ5MqWK6XSWwhmeAKDclzG1q5X2i/A2VX3UNYhWFk=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr1783949eds.251.1598457939605; 
 Wed, 26 Aug 2020 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145239.6077-1-kraxel@redhat.com>
In-Reply-To: <20200826145239.6077-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Aug 2020 17:05:28 +0100
Message-ID: <CAFEAcA-SUJJZDVH0vqmwV4aSVeKO=nQ=PQkm7yzGUkov5dkN2A@mail.gmail.com>
Subject: Re: [PULL 00/18] Usb 20200826 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 at 15:57, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit d1a2b51f868d09ca8489ee9aee9c55632ed8fb=
92:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-re=
ques=3D
> t' into staging (2020-08-25 15:01:43 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200826-pull-request
>
> for you to fetch changes up to 0cb60cbaf4831d859134eea39ae99ae23db79d9d:
>
>   usb: fix setup_len init (CVE-2020-14364) (2020-08-26 14:42:00 +0200)
>
> ----------------------------------------------------------------
> usb: usb_packet_map fixes for ehci and xhci.
> usb: u2f key support (GSoC).
> usb: setup_len fix (CVE-2020-14364).
>
>
> C=3DC3=3DA9sar Belley (12):

Something has mangled the UTF-8 in C=C3=A9sar's name here, though
it looks like it's OK in the git commits.

Anyway, format string issue on 32-bit:

../../hw/usb/u2f-passthru.c: In function 'u2f_passthru_recv_from_guest':
../../hw/usb/u2f-passthru.c:348:53: error: format '%lx' expects
argument of type 'long unsigned int', but argument 3 has type
'unsigned int' [-Werror=3Dformat=3D]
         error_report("%s: Bad written size (req 0x%lx, val 0x%lx)",
                                                   ~~^
                                                   %x
../../hw/usb/u2f-passthru.c:348:64: error: format '%lx' expects
argument of type 'long unsigned int', but argument 4 has type 'ssize_t
{aka int}' [-Werror=3Dformat=3D]
         error_report("%s: Bad written size (req 0x%lx, val 0x%lx)",
                                                              ~~^
                                                              %x

thanks
-- PMM

