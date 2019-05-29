Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDDC28CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51453239C8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMR21/AI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51453239C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzRF-0000X7-Fj
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:20:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVzQP-0000Ao-MN
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVzQO-0000qg-Hq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:19:29 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:41967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hVzQO-0000pg-6E
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:19:28 -0400
Received: by mail-ot1-x335.google.com with SMTP id l25so2167513otp.8
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=no+30y3AssIZl36aiBayhMqNMYAO7PModrCfojkCUog=;
	b=GMR21/AIT8CtE49idUHvgl8Mwn7Isw6RrZbx71fR/o4NMFKyILoL+tTAi7SPrrzF7y
	nK43J4FxBaKTSMqFJh3/gb8OK1ari5r3Vfl7TMcgRlKTDxVkK3JJJyr54GESpRguRj8x
	7Wg3vrPgwxmEub/E70wiKjCn7ZhdWeljkAFr8fFWXrxAcFwrzghAwFht90tfVgvRczN9
	LWXcD21LkbtP2ZStM7/uywR7YZ1ZyfnhLZ0pSw4etqE4+cmDt72sZRMhRH0/hHgDTZgb
	EfXkgZBtxp0xgQtbgWQR8CYrIzedSCNcsDBp2NtzVw45o7RnKML4Oe54uVCXDkx5S0bG
	P6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=no+30y3AssIZl36aiBayhMqNMYAO7PModrCfojkCUog=;
	b=S6bWN24Qk7f/E2j1Fu0hSQJWwH5PRCceZJPi/QUAFOzspW2XZ2BB/vbGTvGQycruU7
	6vOw4i9AYD+dX/V9LicF0mAb4h4vWFGZIH2dNBFZGDnvgj4BWBGD3R8AdADZbqq3hqAz
	92ex6ei+jyNZzpk3LSLj/C+06wrX3zB+pHNDhHzajMFazO82W16PTnhq7HBabrhjTgX2
	J6BlZgelgvrRAHi3w5YfGskZt5mLJ53pRyQGOTxWZ53F4ojl9q9TTIC0+KgB8PNMa1t1
	KLgx2jphAhSjTeD1r4puEFMthSnVPg+jSy0zkQmLMHX9oMga/+XuX+Sd+ZKc0o8NCmvq
	hvEA==
X-Gm-Message-State: APjAAAWlErzywB6lAw5rKNJJ8me9WddXTzYBbEgIO4b/HUuwKpT96Wir
	BbAtIgPaTBoRbIsqokv1Rthk/QJn6Y3u/ZCXr7w=
X-Google-Smtp-Source: APXvYqzvLvYMVMh7GiZAh+4yxXq/i7YM4wNZWf79q9gdaTku7RQF0cTqtmvMC0rIOE/LNSW/aRitQhExv4lv9wPKT18=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr48709218otl.341.1559139566994; 
	Wed, 29 May 2019 07:19:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 29 May 2019 07:19:25
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Wed, 29 May 2019 07:19:25
	-0700 (PDT)
In-Reply-To: <2b3a7c62-81d1-0d91-e7d5-03c9fcd4a012@redhat.com>
References: <BN6PR2201MB1251C914F948CFB53757492DC61F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<2b3a7c62-81d1-0d91-e7d5-03c9fcd4a012@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 May 2019 16:19:25 +0200
Message-ID: <CAL1e-=ix3BeKM3ct25imB1AWXvN620Cpud0apWrOga1cAn7OMQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::335
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Malta-related files in MAINTAINERS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 29, 2019 3:45 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> Hi Aleksandar,
>
> On 5/29/19 10:22 AM, Aleksandar Markovic wrote:
> > Hello, Philippe.
> >
> > Currently, we have these two files in Malta MAINTAINERS section:
> > F: hw/mips/mips_malta.c
> > F: tests/acceptance/linux_ssh_mips_malta.py
> >
> > Do we need to add more files, or other Malta-related files naturally
belong to some other sections, or are shared by many boards?
>
> Not related to your question:
>
> The Malta model is an old one in QEMU, as such it uses the condensed
> format where all the Malta specific devices are self-contained in the
> same file. This organization has Pro/Cons.
>
> New MIPS boards where added and instead of reuse components, they were
> duplicated few times, so now it is harder to maintain.
>
> Back to your question:
>
> All the South Bridge and 'below' devices are shared with the x86 PC
> machine, except:
>
> - FDC37M81X Super I/O: maintained by 'PC Chipset'
> - PIIX4 South Bridge: maintained by 'PC' but this might change
>   as Michael S. Tsirkin is mostly interested in the PIIX3.
>   I have a WIP painful series related to PIIX cleanup.
>
> The North Bridge differs and is Malta specific, so you can add it in
> this section:
>
> - hw/mips/gt64xxx_pci.c
>
> I'll sort the PIIX some day ;)
>

I honestly appreciate your detailed response.

Aleksandar

> Regards,
>
> Phil.
>
