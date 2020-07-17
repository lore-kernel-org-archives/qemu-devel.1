Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B20320717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8jw9v5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B20320717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPaJ-0006ip-Gs
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jwPYq-0005dm-Cw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:33:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jwPYo-0003n7-Er
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:33:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id h1so6723729otq.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=BtEBcDSCTyIVVshJqWrjd1jDtZUMp0leo6UVzK4ejwk=;
 b=c8jw9v5EIVSxuh1ci2T7xWjLOqXEcoV+guPkSiGm8EYrZelT24d5WIklmhjhI4fYc0
 F3NyECh1dIMsbDrHijRAr02e8hgkIy2ujmSjZ4Ry5NE3CQujpJ9edaO+bSESfbFvnojY
 28WHLRUGZrQ34GCz4eLaYaMLh6lfw9aOTqqNiiucU06waI/2TAnjjCIUTwoQTx+Ool/k
 fM83L0LU1o3lhG9tsU1UJr803Qg5x1XRUM0X31JD78BdUXq3D54PIVCZNWgqTrCVyFgH
 LMfKckOeMAHUgx3MT5XzVfCOxlXmT1kLiZeAqt+ilSaVjD6Noqkh8Hvy3LzfDUZ8S8nf
 V1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=BtEBcDSCTyIVVshJqWrjd1jDtZUMp0leo6UVzK4ejwk=;
 b=c0ajRPwM9UrazREQr17UPTA87s60PYWCsj2Gv+Z4ceiNDDzmtH35pa4MxequnWDVkb
 UZJxquXW8CZGe7X5AoxiDebej2di4V92N1VP/kvkqhq+jYn6HJLnHn/mPsNNpnGTEB1S
 LfTRi5lOGJxs15hL8SOWChgFcaSdDs4Wgdelvr40JZFqVwvfr1j2QL5/lUICuTKHh+sp
 a7Hpi1q9jp8yqbSEgzv3qxyNTIj7uPj9NRpUl8cVBIXjSGu+4GJ8WgGK59vf3siSgVau
 jxxjBUa4VKxS3aOQxqnQwGJRxVEwn9eribEOuIn9j1JFNsEMUWM0rly4M4Qqez9sHGni
 H5kg==
X-Gm-Message-State: AOAM533cKffNPSYE7a8ddizzaPZ2H00TSF1B/Lsy/u/igTgrJw3dWLyA
 84YER35AHmbQezfBYLk6Zw==
X-Google-Smtp-Source: ABdhPJx453cd787CdlaxKEKro1GSdiCoJ4I66zo0qM+GvBk7D+FXjCihh0yQ+ecc5MtIuWsneHX94A==
X-Received: by 2002:a9d:4002:: with SMTP id m2mr8629680ote.129.1594989232868; 
 Fri, 17 Jul 2020 05:33:52 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id n7sm1980869ooo.38.2020.07.17.05.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 05:33:51 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:899b:e727:2fc3:fa54])
 by serve.minyard.net (Postfix) with ESMTPSA id 7C971180050;
 Fri, 17 Jul 2020 12:33:50 +0000 (UTC)
Date: Fri, 17 Jul 2020 07:33:49 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [GIT PULL] I2C updates
Message-ID: <20200717123349.GN3235@minyard.net>
References: <20200716174900.GL3235@minyard.net>
 <CAFEAcA-UWJBpM_-G2RAe9B-WcPzBaKGZTas1njehQ7gcjsMpew@mail.gmail.com>
 <20200716222601.GM3235@minyard.net>
 <CAFEAcA_5M8MD+2s_r1jjcgDY0LX69iZRkUP1kbUQTQYEuSN1Nw@mail.gmail.com>
 <c60beae4-2de2-3355-08bc-ee442cd6b091@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c60beae4-2de2-3355-08bc-ee442cd6b091@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 17, 2020 at 01:30:35PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/17/20 12:50 PM, Peter Maydell wrote:
> > On Thu, 16 Jul 2020 at 23:26, Corey Minyard <minyard@acm.org> wrote:
> >>
> >> On Thu, Jul 16, 2020 at 09:45:41PM +0100, Peter Maydell wrote:
> >>> Hi; this failed to build on x86-64 Linux (incremental build):
> >>
> >> Hmm, I did test this, and I just rebuilt, then rebased on the end of
> >> master and rebuilt, without issue.
> >>
> >> It looks like the smbus code is not being included, but I don't see how
> >> that can be.
> > 
> > I was wrong about which config failed, sorry. Incremental builds
> > are fine, but the build that does "make -C builddir clean" first
> > fails.
> > 
> > It looks like the problem is that in the created config-devices.mak
> > files, CONFIG_SMBUS_EEPROM is set, but CONFIG_SMBUS is not.
> > So presumably the problem is in the change
> > "hw/i2c/Kconfig: Add an entry for the SMBus", or it is a more
> > general issue with changes to Kconfig files not correctly
> > resulting in rebuilds of config-devices.mak.
> 
> To Corey, this is likely the later (buildsys), see:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05475.html

Thanks, I was planning to try to figure this out this morning, but 
Peter beat me to it.

Thanks Peter.

-corey

