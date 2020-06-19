Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C542EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943CD2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3j21Miw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943CD2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmLje-0002Tj-Rf
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 14:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1jmLir-00022E-EB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 14:26:41 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:45051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1jmLip-0000sV-RY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 14:26:41 -0400
Received: by mail-oi1-x234.google.com with SMTP id x202so9267307oix.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8zTOfm6OM2OKNl5JKSUZouLS5MDMTIJbMaOmlzypkBU=;
 b=a3j21MiwmsU66gcYGKOqsnGrRJHZqduHdfMUVKw0ecLETBqVT7qQ5WLHooMSeEtOqR
 6ciF9EYMu0ntrZxStDmJC3aeT6IhJ0mVaAOEnmmeb2Abvx/WAtyFkMqZC1YMdfeKixf8
 yaZTqK2pq4HdozPjXiQadG4sCAqvEki1AhVi0ng60tMGtGn7WDN8SAsOQ8QBF3cQLTXf
 yc1ml12k/yrzaqZlKd27BKZsk8zmgpzKYH41DHQRipawOXKfFLjzYrCzBOL0u+G/5PJv
 aq27WSyMoIPK0iDDkMbULgNTUbqoEM/pZ+dQ/Twx9wVS0XDJ7lPJ4ZGz7Xx+CIws6bD9
 bDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8zTOfm6OM2OKNl5JKSUZouLS5MDMTIJbMaOmlzypkBU=;
 b=ZYcuHuprv7fGBFpGNAT5BSwsyTW5OH8ld5KglbLbPpAvf5CTAqMRfCAOepvsnq1Edo
 q5ds63Bkr1rr+eRuWl6ceZ6SgvavjhEOWyw7Z+41BxRSHAPRrM9tKewQC96mMt4X2Qup
 weOEMrbe1ZIEIDlHWOBoiIRuksPLkMjwz82RiS7yxwInOn37s3n8YUSp/mEQoeElKbUc
 Oe+JlWqII3iCN55Znw9NzoWDuixuFHmDcVLImJcOiK9At0GxekEpytkbVk70YvWiP8GV
 L2jj0AqKjbY7aJkxEAPvvWqxcQuo6InEcv3fuHxzgTObvrS44911s/bvdp85+BNljNkp
 026w==
X-Gm-Message-State: AOAM531Hh8Fdu+pcmi/WWg22NJh53915t7Ozto8lZyaZC4Rdcar8OlkS
 q/AJDe1qgH85sOae2zBMTRv9H9JXS/LkPRjGoGM=
X-Google-Smtp-Source: ABdhPJwJrD7YkZEfJAnT/34aTMqrMJE3YVbB0ZaBND48VKoWrtC4P+8g8pp6z4V4AwL39mnprbQ/COuCV2PSWG7EiPA=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr3804185oib.122.1592591198478; 
 Fri, 19 Jun 2020 11:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uyW33vsUTNMPpKN=S-obPWf+EZwS3TiznJgq4Av7R-3tg@mail.gmail.com>
 <CAFEAcA8LULxscffJvbDOTNyeSpZ0vkJoxgMWN1e5VDQ-ym6uYw@mail.gmail.com>
In-Reply-To: <CAFEAcA8LULxscffJvbDOTNyeSpZ0vkJoxgMWN1e5VDQ-ym6uYw@mail.gmail.com>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Fri, 19 Jun 2020 23:56:26 +0530
Message-ID: <CAM2a4uy_TSumwp_LEUtewKyVPiiEVsxO9xd+-d+YkxPO1Exptw@mail.gmail.com>
Subject: Re: Usage of pci bus
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=mindentropy@gmail.com; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 2:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 18 Jun 2020 at 20:36, Gautam Bhat <mindentropy@gmail.com> wrote:
> > I am confused with the usage of PCI bus for connecting different
> > peripherals. If I want to emulate an ARM board which doesn't have a
> > PCI controller how can I emulate it to be as close to the real board
> > as possible? Is there an ARM interconnect or something where I can
> > connect the peripheral controllers and the peripherals to these
> > controllers?
>
> I'm not sure what you're asking here. If the board you want
> to emulate doesn't have a PCI controller, then just don't
> implement a model of a PCI controller. You won't be able
> to use any PCI devices, but that's fine, because the real
> hardware you're modelling doesn't have PCI devices.
> Most of the devices you emulate are going to be the simple
> straightforward type which have some MMIO-mapped registers
> and an interrupt line. In QEMU we call those "sysbus" devices;
> there are lots of examples in the tree.
>
> thanks
> -- PMM

Basically I want to model ARM structure as below:

ARM Core <-- APB---> I2C Controller <------> I2C device.

Is the APB emulated?

From the code I see sysbus calls are done inside the emulated I2C
controller which would call the emulated I2C send, recv and event. Is
my understanding correct? Is there a sysbus instead of APB?

-Gautam.

