Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330BECA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4075420862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6oBmB4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4075420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ5qR-0005Uq-GJ
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ5ok-0004YJ-6k
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ5oi-0005qT-WD
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:28:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQ5oi-0005nC-PO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:28:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id u13so4667840ote.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JUr1MhaKBfprl8mgnkJE+WevQD2GJ6OZqM2LNp9GDN0=;
 b=e6oBmB4CYp0f06kX5j4RUhMmog82VrPUew96IuG93K79SAsZy7UdkrOoI6v+xvdsGt
 6bGPNRnzbpaI64mOUpuuGQWSUL5XkKo8oSo951n1uO3Fu2c8lWioWH+HI0fwxDUq51fD
 vdqtAG6tu9r5y5M5c+mfostxz/oOqeP//j4ec0xa6iVkgj8W+S+7FNNTlOnBnzrYBgNe
 TUgos1v2CGHehKDV0kVO07ixRWm2z+8BYWs8bIg1j0fLD2hnT8GKSBglqSA+fKpr35+K
 mYFCki3esXnWmeBhgu5h6g32fo7Is+6sKVB6gdydAaxYpMZSKoXTrDxGKHH8a1n/k8sv
 JDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JUr1MhaKBfprl8mgnkJE+WevQD2GJ6OZqM2LNp9GDN0=;
 b=eG0F3FA9DAQ4dZZX3/0Zk96SNLiuKOZ/vQWGPSohjNaR2gbyKv1gyuyUc7j6UHpcFJ
 WE3IhcbxaTCY6/vgTstUs8MiZgQ67ZuYiCW84aioBxVpp+E6uGtFPKy2X8qR1MbNKl0l
 nFlbT19iNFJcq+fZdZpYXNdp+qTZD0JxbG0+Z/Re6ZUpC0KtQYZWgSrqUpW/kW7OoQZk
 4yfbnGHzawOMBvcOKzs+Bf3wtPkmZUYpUQtHx7z3BHRAfCae24KTKw3pXWid+nD1X1PH
 Axp0725p9PtiMQ582tnlDVFGIIiuA1Doc6aPeulKhiwwcVJHYWr/5j2uMhu4p8P4QBM7
 yL/w==
X-Gm-Message-State: APjAAAWokt5riyWZjCOBdRaxIk7VChC4TYlsW1C4SL9xEyH4fyPfLbY8
 bF66NGohFdka43qJhESrN0k0byjJzZv2FTLrla9dNg==
X-Google-Smtp-Source: APXvYqx++qgGPqohmPknh+UPLDG3CDRiD6zA94ag0Ke7YncSviNGkJiJTRXzpNaR9m3Yqz4Aoi1vpjcwfgPr5MsCeUw=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr3315804oto.221.1572510507598; 
 Thu, 31 Oct 2019 01:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 08:28:16 +0000
Message-ID: <CAFEAcA885U=w_vY7TaY=ULq+PBGeNAy6AfuyK0repuGiAdgCyQ@mail.gmail.com>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Oct 2019 at 16:34, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> We have to set the default model of all machine classes, not just for the
> active one. Otherwise, "query-machines" will indicate the wrong CPU model
> ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".
>
> s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model for
> all machine classes".  This patch applies a similar fix for the pseries-*
> machine types on ppc64.

> Libvirt probes all machines via "-machine none,accel=kvm:tcg" and will
> currently see the wrong CPU model under KVM.

Isn't this a bug in libvirt ? The default CPU for one machine type
tells you nothing at all about the default machine for another CPU
type. Libvirt needs to ask about the default CPU for the machine
it's actually interested in, which is not likely to be "none".

thanks
-- PMM

