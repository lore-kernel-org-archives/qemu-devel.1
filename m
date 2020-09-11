Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BDC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82052208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="sh4wmeK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82052208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGloY-0004zR-Cb
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGlng-0004A4-EO
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:21:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGlne-0007eJ-Uh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:21:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id a65so4954641wme.5
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PAIk1UGdOMhthP6uce/2wt+YllojR8bz7Gg1foCYIss=;
 b=sh4wmeK6Kha4np/3uecDuibMButBi7vqGBSesVb0syHF7UtL9fRvY6K62HUmnVwGXw
 UJtnu45eOKRzpeXaR6jyxAiROTMZnv1PExsQaibopzFoKNUYGpN0Lvk0QcBCa1aB2j1m
 AN6GB2biK6+M4IkOt0UF49t4Bt5hjjwB4APuPpI3Jv1dQxiijvgO0YXrmtiAN6u5t30a
 x3YZhF2J5du80VDM59QYCIhCv7WxW7bpODg0HsguhBAkVv37GSEFzRryZVcPs8Gs5o9c
 p230Uogo6VbIzVnKF67HIIwLp4nX85DqxKrt96fuWxMVn1GMTfHpma3YphR5d6yyR4ig
 s2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PAIk1UGdOMhthP6uce/2wt+YllojR8bz7Gg1foCYIss=;
 b=anup4efuaSt2SApSwIdeVfst4i0pahbmXY4KOe7fYkgmn4SR44NQsZ2TgWYJ/TLXbB
 6aj+XnuhZ7jkx6t8pY1GTiYt1+coQDyvn04OqoImKsobD/5OLqoLhID2h4gJA8ySIr2M
 0rlAX+7H1TmXC0SVz9LjbChXrhO/lH74xV6Rn5ir53ZWJs+YNNgohzGrWNMihPXHx5b7
 en7pZwc638f2HURXNzlXMgau8c77JV5wRO1CojVFcxG9xMyQGdJ7j3SuKQ4lSClNdAKT
 sRL1wgwZaKuI3k3PFWgjEGeTjQR1fGVCwA3Y52WJt2ffbT6gMUYZOL06DvqwkJjLkS76
 TPzw==
X-Gm-Message-State: AOAM531hkFLYmRMNiLNkSCNCJGA5IvnNy9Sd5KaIiSXIlgB+KcI6JNGU
 sMArPtMW2bKN6tLB5dMf/l8sJWLd/Hqs1fd1cOr6Og==
X-Google-Smtp-Source: ABdhPJy9FoJDIZpF+xket2cYV4tMxP+iOa67+miIm0JQ4Mk8wGcdZ9C9KyDjwN8MQ2J1jAUudGYwVGtqhH6RXB7fWuQ=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr2966723wmf.20.1599841281581; 
 Fri, 11 Sep 2020 09:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200905103520.12626-1-ani@anisinha.ca>
 <20200911120548-mutt-send-email-mst@kernel.org>
 <CAARzgwz9XkQQ=9t0bMp4qf=hMa+6Bb9MHtsffKED_aOTwHfvtQ@mail.gmail.com>
In-Reply-To: <CAARzgwz9XkQQ=9t0bMp4qf=hMa+6Bb9MHtsffKED_aOTwHfvtQ@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 11 Sep 2020 21:51:10 +0530
Message-ID: <CAARzgwxHgUkh+gq+BHBLfJ3bPWeiwsC8ZtGr7Trngzs_C7DYdw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] unit tests for change 'do not add hotplug related
 amls for cold plugged bridges'
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I can't repro the breakage. What test command line are you running
with? I am using " make check-qtest-x86_64 V=1"

On Fri, Sep 11, 2020 at 9:41 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Fri, Sep 11, 2020 at 9:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >
> > I am not sure why, but the expected files did not match for me.
> >
> > I dropped these for now:
> >
> > tests/acpi: add a new ACPI table in order to test root pci hotplug on/off
> > tests/acpi: add a new unit test to test hotplug off/on feature on the root pci bus
> > tests/acpi: document addition of table DSDT.roothp for unit testing root pci hotplug on/off
>
> This was already reviewed by Igor.
>
> > tests/acpi: add newly added acpi DSDT table blob for pci bridge hotplug flag
> > tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support' bridge flag
> > tests/acpi: list added acpi table binary file for pci bridge hotplug test
> >
>
> I will double check this one.
>
> > I suspect you have another change in there.
> >
> > Pls check and post a single series with all these tests.
> >
> > --
> > MST
> >

