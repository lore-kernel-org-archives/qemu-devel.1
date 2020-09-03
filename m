Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D8C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0735F20897
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="FR6j6G71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0735F20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmSm-0004qu-U5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmRs-0003u1-F4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:26:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmRp-0008Df-QE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:26:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id z9so2347865wmk.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bOTfnPyoFHsrOjVkIJC/x4Ybq8TIQNkA+LjG95QroQ4=;
 b=FR6j6G71lZFCfVcvFdavjjWL15Qxx7UBiDwMJ7N9CTakeIQ/ADJ3Prwhxi05sQKNSm
 ieO98cLIjBJCt+QJ71lO8qn/PdLDSPo1b9CDnE4lVB1We2ojFFtSX59Kf0LxTGWkuCel
 hVQQXBWP1AsQq/OPGtBF8wiy9N5HcPhp5AYuVXqFu1o25ZFJbce8c0HtQPqqb5x4Z9TH
 AUtrJmOeHnWLas0d5GonjyatLPQqwVlw1c7x2ofz4tWlVN8R+qzgQF04ORsovO7lB1hT
 +dluHHGM+6m0xfWb+enWI+Kwa7L01yHvMfskd7ecQjF25ILKkfxaC+ENhSD1h83wNyw0
 q2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bOTfnPyoFHsrOjVkIJC/x4Ybq8TIQNkA+LjG95QroQ4=;
 b=cPz3uFSX7NJEN7NfzJsOntJsWqkAG82k33Jfh1Z/kcruV+c0aHWFEZX931nRvF+9pa
 012J4gqpOsqGAdaVyxnzjYD6PrQoWseIdYSSZhXhyd+8PdEYfj8qroIewTRd3yVaz8VK
 uIvntvx4P0zsonL/0YQsWQb2xsigqgFCiHMXX7r9ABrItXzFx0e5E9HD2kt1W6/htxBe
 avQcnw2W8c4YbPUJFx6LrvZHsv1frxIW+dA1eN9DQF0E35CNuZymOiFGeLf0U+vYNu5H
 LvjsDVpYzTEleYs3tpV327ArOyFIuWn6M77ucM0Z2df3PUMTvIBUtqBGM9CnfeyV0HUF
 BNOA==
X-Gm-Message-State: AOAM531qFgD1GYz4RZXIRQJNT0EHP5wxKpBH2Hvbdiba9i1QOrYDTDnT
 5YuiH/wstIG+u/t0BRGYh3oE5wOaWU9AU65Q6XK2MQ==
X-Google-Smtp-Source: ABdhPJxM0qNzo7YoAHzwOc7n4ZDpOaeHX3JMesRtj2gEZJFhZ+/FHRrKi0TPZGi9ieWdcOBS1Jzhh6jo3t7Qz6wpTo0=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr1857869wmg.137.1599128788039; 
 Thu, 03 Sep 2020 03:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200829081233.10120-1-ani@anisinha.ca>
 <20200903060332-mutt-send-email-mst@kernel.org>
 <CAARzgwwFRUOoq7GOttzJVT8+67+7uNugC529SB8DX242p8A_QQ@mail.gmail.com>
 <20200903061515-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200903061515-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 3 Sep 2020 15:56:15 +0530
Message-ID: <CAARzgwzz+FQhXGzPMYbCtc1H4ff8726KgNVFR-xOzTRvdSH5Zw@mail.gmail.com>
Subject: Re: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x341.google.com
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

On Thu, Sep 3, 2020 at 3:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 03, 2020 at 03:41:13PM +0530, Ani Sinha wrote:
> > On Sep 3, 2020, 15:35 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote=
:
> >
> >     On Sat, Aug 29, 2020 at 01:42:33PM +0530, Ani Sinha wrote:
> >
> >         When ACPI hotplug for the root bus is disabled, the bsel proper=
ty for
> >         that
> >
> >         bus is not set. Please see the following commit:
> >
> >
> >
> >         3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI =
hotplug
> >         on the root bus").
> >
> >
> >
> >         As a result, when acpi_pcihp_find_hotplug_bus() is called
> >
> >         with bsel set to 0, it may return the root bus. This would be w=
rong
> >         since the
> >
> >         root bus is not hotpluggable. In general, this can potentially =
happen
> >         to other
> >
> >         buses as well.
> >
> >         In this patch, we fix the issue in this function by checking if=
 the bus
> >         returned
> >
> >         by the function is actually hotpluggable. If not, we simply ret=
urn
> >         NULL. This
> >
> >         avoids the scenario where we are actually returning a non-hotpl=
uggable
> >         bus.
> >
> >
> >
> >         Signed-off-by: Ani Sinha <ani@anisinha.ca>
> >
> >
> >
> >     What exactly are the consequences though?
> >
> >
> > The root bus might get ejected by the user when it should not if the us=
er does
> > the following:
> >
> > outl 0xae10 0
> > outl 0xae08 your_slot
> >
> > Please see Julia=E2=80=99s comment:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html
>
> OK so patch looks good, but please add all this in the commit log.

Done. V2 sent.

