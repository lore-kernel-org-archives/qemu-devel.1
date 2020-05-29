Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66479C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCA72077D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 16:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyrC0IA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCA72077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jei2q-0000sp-Dt
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 12:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jehzt-0006ej-GG
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:36:41 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:39731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jehzs-0004l2-PM
 for qemu-devel@nongnu.org; Fri, 29 May 2020 12:36:41 -0400
Received: by mail-ot1-x333.google.com with SMTP id g5so1885244otg.6
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zXn7AXifg48JVqsK9vmLot62NN8E79cUAHW8G7tpJww=;
 b=HyrC0IA6nn1hI4HTbT7QugqwR/28LKc2Oy3eU1lM2KTLvq09G+60fVX49jH6D0V5PE
 +xqc1GD07svWmUwRVK5FmGR7EeYw5lvs5WchmhZLRJ8RbLgyZ5O/CA/qyLSmSRyMoYtV
 mxige4UJMHFX3ascDV5fVPwszVpViGOzd+KR6vrBoBzc1hi1GG9ALA+VPdsh7jLbqkGJ
 Xrz6xsKyHsj8E+kABOxK4RIA4nMiUpDW5x/Gc9huMDMhC4ko2IQSgNNynHAywiXPTcqH
 hRmGsVtBncbXv5RaMvpuCVfuuLzYR0snrW3TjYQz9Iob0kJh8Ex0GKOvOvdHwx+iu3wa
 dtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zXn7AXifg48JVqsK9vmLot62NN8E79cUAHW8G7tpJww=;
 b=dlXRd2lifoKCJdFtG5jmbxlZ72jZOOGmRQJgC87wmUGvN5klqj+EfCMHL9hv3+Kjq+
 6pjg1t0tMQzT0RSBWyJFFKJfRLYHk9DXc2ikdiAQ2rrcTIRDOh16I7r5WOz0bDNxMUrL
 OLcwPJE9AuHcsfoc5rcb+3/4T9W/+97d+xESd3pyWUOwTABeEv+G7t5u4YuIx+TEghpG
 2HZwxpt8r55MiIPSBcplrPIIS6wclDuw4BL9+n2pOqMpVlMGcfbQyGzd6frMQQe9bFsT
 iZRMEh17XoFW00k3qRudzVqxxaqoACp0CuqHeB9lcwv6aqWSbYvQuvrCAhC/nGBcK+iM
 l2aQ==
X-Gm-Message-State: AOAM531JGnw1N/zdEBMyiPlqNsH9WxjyNTf8dR44QL+438zoX3PNvrNj
 dtYjPpzFwExMek6gaSMdmDS1tFN1QJxtS+IcCygsqA==
X-Google-Smtp-Source: ABdhPJzCXE6d89Lv/EblkPHDF/Q7fNSN5waE7yYG2fRYjPBk+w8vatqex7gK9Kh824fmgKGM2Smu5gwfUY4M4n0z/0k=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr6676198otb.91.1590770194679; 
 Fri, 29 May 2020 09:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200528123609.27362-1-kraxel@redhat.com>
 <CAFEAcA98OyyyC6gs34e3U03=dXz8GkDn5qf38UaO_XBB679V+g@mail.gmail.com>
 <bf43132b-71c2-d411-7cf3-e9a00066ccdc@amsat.org>
In-Reply-To: <bf43132b-71c2-d411-7cf3-e9a00066ccdc@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 17:36:23 +0100
Message-ID: <CAFEAcA_Su+2O6nm0hRfj1BqwQzSsLva+ft_f=1O47-o6U8NxBA@mail.gmail.com>
Subject: Re: [PULL 00/21] Vga 20200528 patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 at 17:15, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 5/29/20 12:29 PM, Peter Maydell wrote:
> > Could somebody send a followup patch to fix the indentation
> > error checkpatch notices, please?
>
> If this is part of your scripts, this is a nice feature :)

No, I just noticed the patchew email.

> >
> > 5/21 Checking commit 97f369f2479d (hw/display/cirrus_vga: Use
> > qemu_log_mask(ERROR) instead of debug printf)
> > ERROR: suspect code indent for conditional statements (16, 12)
> > #34: FILE: hw/display/cirrus_vga.c:1038:
> >                 if (s->cirrus_blt_pixelwidth > 2) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
>
> I explained on the patches:
>
>   False positive.

The code is
            if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
                if (s->cirrus_blt_pixelwidth > 2) {
            qemu_log_mask(LOG_GUEST_ERROR,
                          "cirrus: src transparent without colorexpand "
                          "must be 8bpp or 16bpp\n");
                    goto bitblt_ignore;
                }

checkpatch seems correct; the qemu_log_mask line is misindented,
and looking at the commit this is a misindent introduced in
commit 2b55f4d3504a9f34 "hw/display/cirrus_vga: Use
qemu_log_mask(ERROR) instead of debug printf". The old
fprintf() line was using indent of tab+tab+4 spaces, but
the new qemu_log_mask line is indented by 12 spaces, not 20.
(Tabs are always 8 spaces equivalent.)

Some days I wonder whether we should just do a bulk detabify
of the QEMU sources.

thanks
-- PMM

