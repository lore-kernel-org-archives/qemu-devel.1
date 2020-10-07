Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D0CC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC709215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDg//Fv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC709215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBbD-0000zn-RO
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQBZ7-0008RU-Hd
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:41:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQBZ5-0006Ie-RJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:41:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id k18so2890854wmj.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZwWXOc1WQi0R6Xij4D+eAVJiX+N+czC83z1CU3YB6Iw=;
 b=JDg//Fv9ih5jFUo8J9P/ytBfWJLY15zaR8NbiynFDPIbONM2xT+1t6G4PfknWMUN8x
 nuCJvENfdEFfeU+j3cv20EMhIjlXMWd1ofH5EKISaxfhG4XldtR/z7/x9M7VaE5EPcE5
 Z0bkV31qjr5PZCdW+SUzm3jBi23b7E3YUUsPTS2LgRlV4SroDWY42t+/IuBrHUHazM2I
 p5SVciG1qAf4JBFa6LvXO9GXWn4QSTUHWGDPIWjIxEJPb9bjaw1LO3JyJ9/ju8qlmtbf
 ASbl4gRnNPpRZ34r0ZMFJDcAqrleS66zOZNrZXp7bI0M8XQeJ3Y5cTY1wqIvDT/A9Kqs
 rFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZwWXOc1WQi0R6Xij4D+eAVJiX+N+czC83z1CU3YB6Iw=;
 b=T2ab+Icn7RvWPoCnTkWsmWXvirE7JxOTVHmk7fxTYLhjamNLlrCGBl+f3E1pBkxgTj
 MDeHOUKagjNtFhteoRr8MEys2hGz/cY3tV8jnYsIhVdiH2MwnbAIk9H/Ztc+B0UCLuI4
 1gTKRsZilbrhHJ5U1yf9Wc1Dki2HJT627m4jAF66uQDg9e1DI3LzNKpPCJtRfxPvP+A8
 SeLtNV5QYidi+fUlp4ucqdPLGMoRJ7N15lR0UMoyeqvMmb/cxSNH6ylaQTFnwBfQjLQs
 L4EMcye8z8aaLgf7OgiwlmLgG2MB5cznss7KOg5bAJTlh+NHpn56oU7c5N6J4i6pLnVz
 spnA==
X-Gm-Message-State: AOAM533D22XR51WkY2DZ6UDnWts6loxL0RjC1zpI1aQz+ytkAkywBvbe
 NQfBzKkdYX4Iuud13T4ue/s=
X-Google-Smtp-Source: ABdhPJyeDC+TTPSdUm8qk/ezSX8fskAygm2LthrBInBRqZdHWEYaSfKGK3XknnAF0gy5SNUxsfFLeg==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr3061489wmf.121.1602085274244; 
 Wed, 07 Oct 2020 08:41:14 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a17sm3363731wra.29.2020.10.07.08.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 08:41:13 -0700 (PDT)
Subject: Re: [PATCH] Changes to support booting NetBSD/alpha
To: Jason Thorpe <thorpej@me.com>
References: <20201007032417.26044-1-thorpej@me.com>
 <f4d04e98-bd81-aba4-a8e7-5e818b13260c@amsat.org>
 <406720D0-D88E-4CBA-9789-11D0D2EA93F5@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <257e9ff0-5361-c5b9-22c2-1d8cfb250567@amsat.org>
Date: Wed, 7 Oct 2020 17:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <406720D0-D88E-4CBA-9789-11D0D2EA93F5@me.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 5:13 PM, Jason Thorpe wrote:
> 
>> On Oct 6, 2020, at 9:42 PM, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Hi Jason,
>>
>> Well, this is not the correct way to do that, so this patch
>> is unlikely to be accepted. We don't want Frankenstein models.
>>
>> What is it you miss from the i82378? Why not implement the cy82c693ub?
>>
>> The code you want to modify is in hw/alpha/dp264.c, see clipper_init().
> 
> The Clipper emulation *already* implements a Frankenstein model, a combination of hardware that DEC never shipped.  While some Tsunami-based systems did use the Cypress bridge, none of them, to my knowledge, had the CMD646 IDE controller.  The only system I'm aware of that shipped with a CMD646 IDE controller was the early version of the Miata (EV56 + Pyxis-based Digital Personal Workstation), and that system had the Intel i82378 PCI-ISA bridge.
> 
> The are a lot of differences in the Cypress PCI-ISA bridge, but most importantly, it has a different interrupt controller (the ELCR registers are programmed differently), and it has a different built-in IDE controller.  As far as I can tell, Qemu does not currently have emulation for the Cypress interrupt controller nor the Cypress IDE controller.
> 
> All Alpha systems that had a PCI-ISA bridge[*] shipped with, as far as I'm aware, one of 3 possible chips:
> 
> - Intel i82378 SIO
> - Cypress 82C693
> - Acer Labs M1533
> 
> ...and the emulation provided by the existing Clipper model implements the Intel flavor (including the interrupt controller).  I just want software that expects one of those 3 chips to be there to work.  The existing emulation seems to assume that system software will just go out and probe the peripherals in the ISA space, but some operating systems (NetBSD in particular) support Alpha systems that have PCI without any ISA/LPC bus at all, and thus only go looking for ISA peripherals if a PCI-ISA bridge is present.  That is what my change here is intended to do, without changing any of the rest of the hardware configuration.

Can you provide the information to reproduce your problem
with a NetBSD image please?

> 
> 
> [*] ...ignoring the weirdo early models that had PCI + EISA + oddly-wired-up junk I/O chips.  Also, I don't have any direct experience with post-Titan models, so I'm not sure what they have...
> 
> -- thorpej
> 
> 

