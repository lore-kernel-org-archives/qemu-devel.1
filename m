Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF43BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7202720890
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnj2SYvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7202720890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwCLB-0004MD-OV
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 18:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jwCKO-0003vg-Ng
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 18:26:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jwCKN-0000CL-0M
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 18:26:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id a21so5469927otq.8
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=snzjKBedmc/TZNMCZNMBmclQuV08O5eQSornc+dVz/E=;
 b=Hnj2SYvkj0aM5557tGcUJ0j6+yPHtkE3obNj5Zo4AoKQOaxfqeg8SuhBTdhjDUxbrv
 c4RGIMGeW58kPxvOtrrQFhHgqR9CcPuVCIHWspKol14Qvt2vZFqqc4ggTV4/HD4pwlSg
 0L4sadcVs6BCvlj35ZDVF5DYcLgnvjA0PfnI+UjqoA1PClci2CuSlY76RtVLgo7xRRKn
 UrkaS/S6OXsQnMoCpAOfPKTQmcF/trZ/TxWL3slnveFcut2XhRxlZqqzX8IzjMNnUOaP
 CqGJdNVQvsJlUS+3nMmIJ8Glk8cEPJ0sw6UpOG4Dh3Dm1uh18lYYyf32z4KNy81iS/bg
 00ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=snzjKBedmc/TZNMCZNMBmclQuV08O5eQSornc+dVz/E=;
 b=QvlPlqBtF7ceAYEO9JdKCd7Cu30YSZNjTDvNLtRgp11v4aayboTX6ENW2Uf0O90vnz
 D+u94LvlbQmzgtVz156CyUNXZSwaaLuRT5peZUgWvXM6uLfDqqIeG0094eNXkMxZODIK
 p3PWEXi203PCOPPIZgq9AJywJ9PYIWZq+yBJZdupE6vDYUgTW5H1IiAdCcqTLBBYtRqw
 1zhRKS3ztJ+OXAGlJOtF1o1XFAY9Ahqvm0tmS3f5Gii15s8SwnRQMHZdHugOsVDm8Rcb
 HqiSKnTJiqD5+PS8jeRdYhsnRpNP+lwQZOkV0YWbV9FGf9o6njHXmVRJ1T2yvbQvBOy2
 x7nQ==
X-Gm-Message-State: AOAM531ECLUl+o2btReWUvLCwLTICDOyVDj8jFLeEVP4tuDuSEzChcex
 zaCjaSyoZRxmqHx+5OCU8g==
X-Google-Smtp-Source: ABdhPJyv3DOXSbUP5PoXX0929A8hGYIGwzW2dekidkyeAxGc9AyMOJRGwzhVG7kDQUC5AMNh7KDzDg==
X-Received: by 2002:a05:6830:1e55:: with SMTP id
 e21mr6741695otj.318.1594938365509; 
 Thu, 16 Jul 2020 15:26:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id o23sm1470297otl.0.2020.07.16.15.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 15:26:04 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:ac62:d225:13b5:8855])
 by serve.minyard.net (Postfix) with ESMTPSA id F18D21800CC;
 Thu, 16 Jul 2020 22:26:02 +0000 (UTC)
Date: Thu, 16 Jul 2020 17:26:01 -0500
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [GIT PULL] I2C updates
Message-ID: <20200716222601.GM3235@minyard.net>
References: <20200716174900.GL3235@minyard.net>
 <CAFEAcA-UWJBpM_-G2RAe9B-WcPzBaKGZTas1njehQ7gcjsMpew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-UWJBpM_-G2RAe9B-WcPzBaKGZTas1njehQ7gcjsMpew@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 09:45:41PM +0100, Peter Maydell wrote:
> On Thu, 16 Jul 2020 at 18:49, Corey Minyard <minyard@acm.org> wrote:
> >
> > The following changes since commit 45db94cc90c286a9965a285ba19450f448760a09:
> >
> >   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200707' into staging (2020-07-10 16:43:40 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/cminyard/qemu.git tags/for-qemu-i2c-5
> >
> > for you to fetch changes up to 73d5f22ecbb76dfc785876779d47787084ff0f42:
> >
> >   hw/i2c: Document the I2C qdev helpers (2020-07-16 12:30:54 -0500)
> >
> > ----------------------------------------------------------------
> > Minor changes to:
> >
> > Add an SMBus config entry
> >
> > Cleanup/simplify/document some I2C interfaces
> >
> > ----------------------------------------------------------------
> > Philippe Mathieu-Daudé (6):
> >       hw/i2c/Kconfig: Add an entry for the SMBus
> >       hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
> >       hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
> >       hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unref()
> >       hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()
> >       hw/i2c: Document the I2C qdev helpers
> 
> Hi; this failed to build on x86-64 Linux (incremental build):

Hmm, I did test this, and I just rebuilt, then rebased on the end of
master and rebuilt, without issue.

It looks like the smbus code is not being included, but I don't see how
that can be.

-corey

> 
>   LINK    i386-softmmu/qemu-system-i386
> ../hw/i2c/smbus_eeprom.o: In function `smbus_eeprom_vmstate_needed':
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/smbus_eeprom.c:94:
> undefined reference to `smbus_vmstate_needed'
> ../hw/i2c/smbus_eeprom.o:(.data.rel+0x50): undefined reference to
> `vmstate_smbus_device'
> ../hw/i2c/pm_smbus.o: In function `smb_transaction':
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:93: undefined
> reference to `smbus_quick_command'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:97: undefined
> reference to `smbus_receive_byte'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:100: undefined
> reference to `smbus_send_byte'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:105: undefined
> reference to `smbus_read_byte'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:108: undefined
> reference to `smbus_write_byte'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:114: undefined
> reference to `smbus_read_word'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:117: undefined
> reference to `smbus_write_word'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:149: undefined
> reference to `smbus_read_block'
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:174: undefined
> reference to `smbus_write_block'
> ../hw/i2c/pm_smbus.o: In function `smb_ioport_writeb':
> /home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:290: undefined
> reference to `smbus_write_block'
> ../hw/ipmi/smbus_ipmi.o:(.data.rel+0x50): undefined reference to
> `vmstate_smbus_device'
> collect2: error: ld returned 1 exit status
> 
> (similarly for other qemu-system-* binary links)
> 
> thanks
> -- PMM

