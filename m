Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5ADC20739
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZl2UXLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5ADC20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlbtc-00029M-RT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jlbsV-0000eo-G9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:29:35 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1jlbsT-0004Iv-Lx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:29:35 -0400
Received: by mail-io1-xd44.google.com with SMTP id c8so3745186iob.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CexC07ltkrX3A0BwKEEKgs+L6C97sd8PTyNtwWr2dko=;
 b=kZl2UXLZPrAKBphX80J1SSWcxzSFnC/DO0yIzwIUtftwmfxdFA8Dd4rncdugzP8o0p
 xp519zZs2cDa/NpqGten+nsy7jWa8BeNUYRO1Lzg4AmfJvvdlPeAqYHqMfSGeEPpQy2F
 pY55t3HuFoYIsmoL0TojexoGY1OzpkOy1Bu06ArJbaW5xC/c7JF9QvHC6QF69PjhlYCA
 i1MHjOhrI38UT8RZQImDwoRKUelH1wrAg8Du9ydP7Pufuvd6LnaJL90ntcApgoidPmkt
 1vfY0tm0zs0NQhbFpCd7jOpfM+1bOj/GsSNcxSB957FfYwFzlkZY09gP+I1+3pj+l5yI
 fPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CexC07ltkrX3A0BwKEEKgs+L6C97sd8PTyNtwWr2dko=;
 b=Tnde5TywrZgYG+ZBVauk2NmqWyLWkjWh2GkZWbs+mKQHKuE0uKnLJA2ripqp5CEYpW
 T9pNa1tzG5OxqKO8OZ9KEUx4zigqLdLzawnt3I+OBTt6sjnU3UOLRl3EQYrMwYQ24s84
 jbwS9JOObODa3vEJFqai6dXIwXVE2cBABXx249EA/YnfAnoEm+d/NNMqTkUHOzO50YBs
 eqqsm74UQoIn4My+mkR+I2vMKF6Aysh73MdVTlwszP4QVoU0qA3w3YkfDmvNMX7/B2w1
 OZ+oBRru3GvUa1P92JFZTYBkwzVMNnEvFzafNsfyEgHHHA7bYpvPvYasDYCbsls43PGF
 cozQ==
X-Gm-Message-State: AOAM530cxykikLaZkmhUeO5/+HKOY7jYDmE6h+6rjwnAbVLcExlhr2L3
 l4Cv5eCdQs00c+4cnOaO7j/KcECxd46A7G+OFWg=
X-Google-Smtp-Source: ABdhPJzb6993ajBnm+38sfp5HN9Em+A2p9JXd52X1WhDXsKfl+gP02G7Gm4oFTjM1iY5g6l8de1a6PZhQUafF2R0ktA=
X-Received: by 2002:a02:9f84:: with SMTP id a4mr392516jam.0.1592414972166;
 Wed, 17 Jun 2020 10:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200617082402.242631-1-jasper.lowell@bt.com>
In-Reply-To: <20200617082402.242631-1-jasper.lowell@bt.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 17 Jun 2020 19:29:20 +0200
Message-ID: <CACXAS8AD1sp0GcP8VM70v2DTUY5UC7Suqc93vBNOMDARW874Xg@mail.gmail.com>
Subject: Re: [PATCH 0/8] ESCC2
To: Jasper Lowell <jasper.lowell@bt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=atar4qemu@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: tony.nguyen@bt.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 10:24 AM Jasper Lowell <jasper.lowell@bt.com> wrote:
>
> I've been working on improving Solaris 10 emulation for the SPARC64
> Sun4u architecture with the goal of a working shell. Currently, Solaris
> 10 boots with a number of errors before displaying the prompt of an
> otherwise unresponsive installer shell. It's been mentioned that this
> problem may not be isolated to Solaris 10 but may affect derivatives of
> OpenSolaris including illumos.
>
> From what I can tell, Solaris 10 never attempts to use the 16550A UART
> for the serial console. The kernel will probe registers to identify the
> device but will not use it for receiving or transmitting. The kernel
> only prints to the console using the prom interface that OpenBIOS
> provides. It's difficult to ascertain what the problem is because there
> is no visibility into the kernel. The 16550A UART on the Ultra 5
> (Darwin), the machine that QEMU Sun4u is modelled against, is used for
> the keyboard/mouse (SuperIO) and is not traditionally used for the
> serial tty. Instead, the SAB 82532 ESCC2 is used to provide ttya and
> ttyb on this system. This patch exists to increment QEMU Sun4u towards
> being hardware faithful.

Nice, thanks for sharing!

> The SAB 82532 ESCC2 is complex because of the jungle of features that it
> provides. Linux and OpenBSD only use a small subset of features
> restricted to the ASYNC serial mode. The ASYNC serial mode is
> relatively simple to implement in isolation. I have made progress on a
> patch series that supports all serial modes, along with transitioning
> between them, but I have decided against submitting it. The serial
> controller appears to multiplex bit positions in registers across serial
> modes while preserving the bits themselves. This means that some 8-bit
> registers need to keep track of more than 8-bits of data and that the
> interpretation of the value the register holds depends on the selected
> serial mode. It's not ideal having a copy of each register for each
> serial mode because some bits are shared across some of the register
> modes. An added difficulty is that the manual doesn't document this
> behaviour well and its unclear what exactly happens when there is a
> transition in the selected serial mode. I've avoided depending on
> registers being uint8_t and have made use of macros so that the backend
> implementation of each register can be changed at a later date when
> supporting other serial modes. If I have the opportunity to test real
> hardware, or it becomes clear that HDLC/SDLC/BISYNC support is needed,
> I'll look at upstreaming the other changes that I have.
>
> I have written a bare-bones patch for OpenBIOS that adds this device to
> the device tree. With that applied, Solaris identifies and attaches the
> device successfully but does not interact with it further - similar to
> the 16550A UART. I did notice, however, that Solaris 10 entered an
> interrupt routine for this device when the network card was being
> configured. I couldn't manage to provoke this behaviour for the 16550A
> so this might be some small success. I strongly suspect that the
> interrupt is a spurious interrupt caused by misconfiguration of the
> devices in the firmware but I have not investigated this further.
>
> Solaris 10, judging from the OpenSolaris source code, determines
> stdin/stdout for the console by examining the stdin/stdout properties
> under /chosen in the device tree. Naturally, this is done with the prom
> interface. From what I can tell, to set these properties to the ESCC2
> node it's necessary to change stdin/stdout for OpenBIOS completely. This
> requires a device driver. I have made some progress on an OpenBIOS
> device driver for the ESCC2 but it's taking longer than expected to
> completely replace the 16550A and it's unlikely that I will have this
> finished soon. It's possible that Solaris 10 emulation for this platform
> will improve once that work is finished but it's unclear.

Actually we may consider adding another sparc64 machine: "ultra5", and
maybe deprecate "sun4u" machine once OpenBIOS supports escc2. (But
maybe keep it as it's as long as it's used by NetBSD regression tests)

> This is my first patch series for QEMU so it's possible that I've made
> mistakes in the contribution process - sorry in advance.

Congratulations on the first patch!  It's a very good start.

> Jasper Lowell (8):
>   hw/char/escc2: Add device
>   hw/char/escc2: Handle interrupt generation
>   hw/char/escc2: Add character device backend
>   hw/char/escc2: Add clock generation
>   hw/char/escc2: Add Receiver Reset (RRES) command
>   hw/char/escc2: Add RFRD command
>   hw/char/escc2: Add Transmit Frame (XF) command
>   hw/char/escc2: Add XRES command
>
>  hw/char/Kconfig         |    8 +
>  hw/char/Makefile.objs   |    1 +
>  hw/char/escc2.c         | 1135 +++++++++++++++++++++++++++++++++++++++
>  hw/char/trace-events    |    6 +
>  include/hw/char/escc2.h |   17 +
>  5 files changed, 1167 insertions(+)
>  create mode 100644 hw/char/escc2.c
>  create mode 100644 include/hw/char/escc2.h
>
> --
> 2.26.2
>


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

