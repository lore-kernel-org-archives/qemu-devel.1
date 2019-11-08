Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE13C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5662021882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMIaImtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5662021882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6KJ-0008St-Af
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT6BU-0007iK-28
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT6BS-0001Vr-TK
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:28:23 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT6BS-0001Vb-NL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:28:22 -0500
Received: by mail-oi1-x242.google.com with SMTP id j7so5567833oib.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 07:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lp11khKQaPh+6YHpEsxMg/MHNXsCrT4eT+O+6aCFVGs=;
 b=rMIaImtNNNn23rX7Ii/0yuKzn5Z55YCqSxDMB3+bt871XCGy4dGArABNKwYgI6zraX
 9gIbwFIi+595P5n3pCZPdMQatAEKAmv4ZNe6emrS8p1mal9BtSBfaXhHPA9feM/Cd780
 t++g8QxeBgRx/nGGRXLvMJuOyjVDDN4qgd0DLstUKrs02ZV9HYzapN8MuMLfZBCRrTee
 rxWFyOiOdRf3J4QyAyoioCkeUjUHLnJ9y+R1C1nvxVuYZl/h3t9aFMa2bmL70IbsDR4+
 r+BZqRvdmZg2RlhY6kk/BAjVVMmFjNN7uhwUqBgQ0svmyW5HVTwu5ueTJwqKT2Iet6hq
 l0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lp11khKQaPh+6YHpEsxMg/MHNXsCrT4eT+O+6aCFVGs=;
 b=hD82fQW45/ijMBvueQecLL/M8COn3Ov0l5d6nAuhETFKPlO1Y7BWOs1EzyJE68nG+j
 x5V/tN2OkUjSH+w9QwJ8hhJMiKCHC9INPDeIuZmrfcMKBwvIFZ87iQweBbqxDG2YMXkQ
 Pv9m2OrA2swyLYWnpI3/SS+0M83pGHq3mGECdKHOLVkygk67Y+uHA/53eBN1IJOXyWjU
 4KXi0X6ygraIguOSHdr7JDcdE7AR8EOwZ12+ydlcOwD0SvnQD1/YTAdc7dtA/dvMKRIA
 ce5XTnaXyEy9axPpA929s83jZs2xp7JziP9/c5ncOfwuTsr/SQ6+xTuN7JSbCregyXSq
 ZKsQ==
X-Gm-Message-State: APjAAAVtb00whYDrv+GuUUjt/GnI2smQk59XaSdJNkzdLlZttsqwZ6dY
 afyslSB4Jt5ZXBTkywRkP3s07wB8dcRbh4ItHxc2Yw==
X-Google-Smtp-Source: APXvYqzqMYQfldKdiKe3TkeiRTG3tBB8DWOSr+m8V5qrIs5d2CqIcUYyLZg4/brCCZ/OCVFFjwO94ZOFza06NBBD1w8=
X-Received: by 2002:aca:451:: with SMTP id 78mr10302671oie.170.1573226901895; 
 Fri, 08 Nov 2019 07:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <efef625a-8162-5454-128f-489d636563a1@greensocs.com>
 <aae84bfb-e735-0aac-124c-9abbdea882ff@greensocs.com>
In-Reply-To: <aae84bfb-e735-0aac-124c-9abbdea882ff@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 15:28:09 +0000
Message-ID: <CAFEAcA9QW1JTg72YiGDxuEi5Dip99KUxuHAqDnVma1=A_qqbQQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Multi-phase reset mechanism
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 15:26, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
>
> On 10/29/19 4:53 PM, Damien Hedde wrote:
> > Hi,
> >
> > Does anyone has comment about the interface / patch 3 ?
> > Should I try to split it ?
>
> ping

Hi; this patchset is still in my to-review queue, but we've
just gone into softfreeze for 4.2 so I'm a bit short on time
to look at anything that's not for this release.

I do definitely want to get this patchset in early in the
5.0 release cycle though.

thanks
-- PMM

