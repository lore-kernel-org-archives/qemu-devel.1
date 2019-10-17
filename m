Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A0ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C19121925
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhS+osuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C19121925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8TC-0005sH-3D
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7kb-0006qq-B5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7kZ-00039C-Vv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:31:40 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL7kY-00038A-4Y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:31:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id k10so213546oij.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xHyu7q76oXBH+bqG3LCms0OKv75afsZTrsNgh3msjhE=;
 b=dhS+osuFNug2fmWCW6jQP7VmUJHYvQC8DfJjDL2+K0+k/KdNOWvjWXiTKugPSJP2tv
 1vR6zG9YO3Ht2Bk4Hk8SxdwOBaFHK+XBPGSeOUKROpGfBbMQap6Cm0OUZW/aK6ZaR9zL
 IVtBqcYeZz1XdsvumhffPTcl6UXZ383JJvVZWMvomN3uKF4vJMXi45+z/o5uxCZ1AHe3
 OgJPZ79+4IKFpuGuor9I5rscYUa4kitagrmUIi6Y+JuPX6fEl9EY9BioOp4vxZBITdgh
 rkRuv71hai32f3Eaxdr1fwkmP0jViPZCir+MgmqXakV++XW5cjv2ATdcDTDrZ3RjUwW7
 4+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xHyu7q76oXBH+bqG3LCms0OKv75afsZTrsNgh3msjhE=;
 b=EzNClfsnNd8VoyxK/jGuA5OQvSbfHOrFVwdz5q61M3uEtLhZRAO4e8KYDVuB2Qaj/J
 gfxJZhBdY0PN40ifN6Fn+o1qj/DRHNLWcETIJQwEKwEF96Axlz4J4pCTpTNQWlm6lRZI
 iGCY0UZtQ/DH7P5xCnFJQRg92Oo7VBbWEg/Dk22l1WbNO1eYux7VhhHoZ6lPExIBH5Dr
 jBCGbZ76h8pygy/Ggk+uxXyGdfuPP9lzNGohq0K9JPF8oYwlcv3SGfZR4SM1ex8U20MN
 1m/mkLF8dVgWHE6ReXnGFR4Htq7lF5WOTlVhTJxeKzLweauqwKuS6hS53jZvwauYPztM
 RxJw==
X-Gm-Message-State: APjAAAVPHb5RQK37rF7TS3enVdfYciw86VL0ZRuf+GVLhKWvH1V1Byu4
 MUsZ79QNtwHp7eNqQsZZya/ADtMR+Hcy/R3fenJp3lgOScw=
X-Google-Smtp-Source: APXvYqypckVWw88iyrCbdespuXPi9MJxWZlQrsYv92WPiuxTjvJNGVw0DlWGs3+B3D6mci76yLFoVjnUU3JHAsbqZY8=
X-Received: by 2002:aca:49c2:: with SMTP id w185mr3793559oia.163.1571326297144; 
 Thu, 17 Oct 2019 08:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132351.4762-1-peter.maydell@linaro.org>
 <20191017132351.4762-3-peter.maydell@linaro.org>
 <2210f783-1159-1263-dfff-3bd84111e2f5@redhat.com>
 <CAFEAcA_jYjN=pQ719kbrRGXF2f8uDg_uj1r_dO0320qqB1Nppg@mail.gmail.com>
 <f1ada0bb-4d8c-69cc-df00-3f69c3891718@redhat.com>
In-Reply-To: <f1ada0bb-4d8c-69cc-df00-3f69c3891718@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 16:31:25 +0100
Message-ID: <CAFEAcA91ixLzO9+Y29ezvPWeqQ9aYHm8cxestn1yLKNLo8=OLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 16:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 10/17/19 5:00 PM, Peter Maydell wrote:
> > ...because the commit should come after we have finished
> > updating the timer state (t->run in this case), because
> > the trigger callback slavio_timer_irq() otherwise sees
> > inconsistent half-updated state if commit() calls it.
>
> Oh, slavio_timer_irq() calls slavio_timer_get_out() which accesses the
> ptimer... OK I missed that.
>
> Whew we need to be extra cautious with this API...

Yes. If the callback function is a trivial "just update
the interrupt register bit and set an irq line" one, like
about half the ptimer users, then it doesn't matter too
much where the commit call goes, but for those users who
do more complicated work in the timer callback it gets
a little trickier (and I didn't realise this wrinkle until
about halfway through doing the API conversion work).
It doesn't much matter where the begin call goes (an odd
asymmetry), but the commit call is effectively a "voluntarily
yield control to the callback function" and so its placement
can be important.

> If possible I'd rather see the patch removing the NULL check previous to
> this one, anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks; I'll add the NULL-check cleanup in v2. Coverity will
probably complain otherwise.

thanks
-- PMM

