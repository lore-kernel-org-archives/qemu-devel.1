Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14ABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3D720659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRu99f69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3D720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDLY-0002XB-T0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhDKy-00027z-5X
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:28:48 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhDKx-0001sY-8h
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:28:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id g7so6649358oti.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PvG0YV99rdo55K5ZavYzF2d4JEo2ZL5Z9QrItIHGMGI=;
 b=aRu99f69hDBEz71B2x/DKCjTFwjaSNEMxMEYvI/scPqXoDyXY+Rof9KXirlz7CFwIt
 HChYCHOzNMeLLl568YagsdmhlqOqRTv2nQTpfG6qvgMRzPuoPVkY8KDT/Z01k2DDcfZf
 iJkORuzHqGo0E4gmLS8EW2Eu49Cjku/YwaPDTmqlIAlAL4O5/46rS7F/B3RWjEXQM+HL
 ACoXJ4F/Swtufzx/Ls0HBetYhVue71BD+djaFn65XdnN1dI26D9m2CNGWzhKgiId7MhK
 xV96NH0yoAtlEeDKdw6zd6g1yw+QxNQLvE9UYtuGU27q0p58wHAz0tCnudpXG+sC1cMq
 3ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PvG0YV99rdo55K5ZavYzF2d4JEo2ZL5Z9QrItIHGMGI=;
 b=HS2v+Q8+E3XnOXWXiGZc2jKoQxtooNkvH34Q+X1+U2kbCxJsvQeRGKPovBbmCKgDue
 UhBC36doyi57j2/6M8bkCSZaGz2aMDv17T6t2O+p/sLPILOQmqglm+bHlp16wl5ush73
 XXnx+LsjtxyxnPeh3EIZbvFFskO/6N/bjLAONJMQuaQrUjEN7cm2QOzzJbesww72zZNF
 w24mTbXw9a9gLfTQkGME8SVxRTlI6LzQj0pkO4X4p0QaIR5WSS66T5fWgVZMNUpdAtZ1
 Mqs6ZOfF1AUdU+hGD65H3w7InmFyl+m2GRkFunBgCTZEdI/nawq9BGPm8KYdXw9NYYJX
 BNJg==
X-Gm-Message-State: AOAM5303uLxSrk0LK03o8rRxb3bBzXKEW0wAiknrYeQugekckKNyEFCV
 X/V6HD4bfpkjU1n84go7lZ5TSffZmqXECL7yLAW5GA==
X-Google-Smtp-Source: ABdhPJwk2y/BVaGby0S5oao0WYqCfPBZJVm3upQBADvAdKSjAUS8p6sGBie5n7Hg3UKoO7p68xhEvh420570+5rq5Sg=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr7692083otb.91.1591367325821; 
 Fri, 05 Jun 2020 07:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200520235349.21215-1-pauldzim@gmail.com>
In-Reply-To: <20200520235349.21215-1-pauldzim@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 15:28:34 +0100
Message-ID: <CAFEAcA-4DuvX2jqFbMvXyqpeytj95gUn7pVnhH1b_622GgAMog@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 00:54, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> This verion fixes a few things pointed out by Peter, and one by
> Felippe.
>
> This patch series adds emulation for the dwc-hsotg USB controller,
> which is used on the Raspberry Pi 3 and earlier, as well as a number
> of other development boards. The main benefit for Raspberry Pi is that
> this enables networking on these boards, since the network adapter is
> attached via USB.

Applied to target-arm.next, thanks.

(Gerd, I'm assuming from the fact you put a previous version
of this series into a usb pullreq that you're happy with the
"usb: add short-packet handling to usb-storage driver" patch
even though you didn't provide a reviewed-by for it.)

thanks
-- PMM

