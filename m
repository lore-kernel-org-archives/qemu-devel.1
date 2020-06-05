Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE532075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="XMWEhuhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE532075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9u1-0007fq-Fr
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1jh9tR-0007Ez-53
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:48:09 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d]:46643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1jh9tP-0002sl-3s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:48:08 -0400
Received: by mail-io1-xd2d.google.com with SMTP id j8so9724326iog.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9+vqBaiHLseC0o8afzLevdr9E593kvR5e3ZXbdnI9YI=;
 b=XMWEhuhDhgmTjJroADqNCPnlm+oFFG55eJ7wV87Ntdbb0J5ax6Qox/gZIF+friUklW
 NYEevc790Z+qsaEuy2K7XYLRq+C3f9vPB/6xP4W0WE03ntkaxUEe/+XICsA9UrRhxM3x
 rW/p9Hfevay/5zO1rB7Eh5x2/Fri51QCxCBG22WjmhYrJiooqs/lUVaWpx9IRMf10DfE
 17oQEK/UbMx/PyYQOwnXiAqWgw5yoJZW7DzPhetI8/t5+IaxFKjJa8KUKD5/yFC+Nb9B
 vKfIPX+eEjK65JNFgzjQnq0LDpeCngNVSS7ITYkado30XtM+kDMsQsbFbaTs54PUxwgZ
 75fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9+vqBaiHLseC0o8afzLevdr9E593kvR5e3ZXbdnI9YI=;
 b=FXI9GyUpGHdrWRusmvPXVyeyyB0jfOyvyrOFMJe8LRlr92bn3GHs67huW79nchWtpb
 U+EuB5lWgrSWfKExHJeSJzEVkY35QtUc8jnBzUXUk52vXOkRMgCJG2qgnv+ewBcN42si
 OoOMMm5sjcf86sn41GcDRCAcwjpkqLAyfcizjpYS6/X2i7CWuERbbWELIUKDYpAo1bH7
 W5to7cuWYm32xf4eJ17mOpEJTdhtT7pxqV3bBLNv/zRcshuVkX+DYHuwQ+SmhCQO5TKb
 t+Ynw5ptpKfdNHSDLOqT26RMJSTzgoIpWpPFRMLsqWPq6E5X4j8uY/e6TmBhQkjiScUf
 kmOA==
X-Gm-Message-State: AOAM532RlmGm0H5rlz3CDm9X3qapGkXlcniPaDuWCS0Alcr/iiqFvngp
 EV/WmJkDF/PT7OrH73uCeQqxL0lpdu+42XNGNPh2+A==
X-Google-Smtp-Source: ABdhPJzIE9cQeuDg/MOTB67O8AYH8l2g+3znNr675zrnPcnYTcnQP9I++sbXJDN3Ei/hGU11rOrzaycYd2D4qr2EqX8=
X-Received: by 2002:a05:6602:2c45:: with SMTP id
 x5mr7569755iov.80.1591354085440; 
 Fri, 05 Jun 2020 03:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <CALQG_Wh7eMt9U3gWkZZGDq0RFvWfuSVoiNBRNnPS_cDVfUc30w@mail.gmail.com>
 <CAFEAcA_1+rDcjD7Lyk9ESSkPAKmJwF=0ZdwkgQYUDp8Gtn6jHA@mail.gmail.com>
 <CALQG_WgP=ZebEMrXh_EpQJXqJPi48i6nwZU_yWq7VqhV_=eTVQ@mail.gmail.com>
 <CAFEAcA_iW_0jTk=9hCh+UatyhY_HFgzmZeSxqqyUCH19Vv1jCA@mail.gmail.com>
In-Reply-To: <CAFEAcA_iW_0jTk=9hCh+UatyhY_HFgzmZeSxqqyUCH19Vv1jCA@mail.gmail.com>
From: Fabien Chouteau <chouteau@adacore.com>
Date: Fri, 5 Jun 2020 12:47:54 +0200
Message-ID: <CALQG_WipfD4YMCccBnrT3GaFZ7wkvDtSHPg0Tg73-y5w+rbpsw@mail.gmail.com>
Subject: Re: gdbstub.c CPU clusters not handled for ThreadInfo packets
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=chouteau@adacore.com; helo=mail-io1-xd2d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 2, 2020 at 7:26 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> When there's multiple clusters, by default gdb will show you all the CPUs in the first
> cluster. Would the behaviour be better if the other cluster in
> this machine was the first (default) one?

For our use case yes it would be better. I will look to see if this is
doable with a small patch on our fork.

> Hmm. That's the behavior for 'target remote' but 'target extended-remote'
> ought to support multiple inferiors. What gdb version is this?

Force of habit, I made a fool of myself and used only 'target remote'.
Sorry for the noise here.

Thanks for your help,

