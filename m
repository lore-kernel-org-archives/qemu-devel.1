Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B24CC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB55D21BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vw+NcrWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB55D21BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNxu-0001Ac-4v
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paul.walmsley@sifive.com>) id 1hvNqh-0007z8-Mb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paul.walmsley@sifive.com>) id 1hvNqf-0002pf-9O
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:27:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paul.walmsley@sifive.com>)
 id 1hvNqf-0002oN-37
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:27:33 -0400
Received: by mail-ot1-x342.google.com with SMTP id r6so105844674oti.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=L96TWPaJYFlpZCiROwFK/mYFAS/viHJGKOgXlgDH/nU=;
 b=Vw+NcrWjAHn2jfsVFLiExSl1jusii1oYjEFgSRw3vwpOoK9fCBD3M8jV6p9+2nMQIu
 a390UkepVDsqeuui6oLdDYKXatxJZFwgcNQr6VSdW6XwcknqAFc+kNzPD3vfIyiGvIyr
 i86kgARFjFTNJOXMV5h43K1dTn0scyOun6tWgO9da5I8/O01Qgx508PVsnH8NRbEF0hb
 YlFws8vGAa0rVf+1XejvQo8HPy2JWGWMJjueSMPtIY1eaTBCq7a5nPW0DtGE8ojAUjED
 wYl60PhjvxTG9xkUK+DjcdAkey/TEdQaIGlRYmPyzYmoYMtv8Hu1XaBt1ftjVZNWq/Rb
 LR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=L96TWPaJYFlpZCiROwFK/mYFAS/viHJGKOgXlgDH/nU=;
 b=jd3icXXkJ2uDR7WvX8QMlZw/rFKjLUB/ryqZP9QZ4bumPj7iYp0d0HXKn7723EIE1q
 908blp7213nkxSY2vor6eCuj4k1DqdO9XReoBLtO7ULpYkLg1olrGAGEUdMnUtFvqB9E
 GepQdV7+ffrEE8vHVmOHdPpjs1jgkGjdjozWAw67yuHVTQWOgozj7EIhItLROXbOeWC4
 dXxS98T7vFxcKxmEcVRVGmft4H84yMbsM9hneBM4xS5RTJVTwZtM6I8deN/VsGGoiX55
 Gbqb0eHU1MfKYEdZzH6lOdY3mI+6n4FGQ7AiqxtjHjfwmqAtYeDk2Wms380VLxsuiS9+
 +XrQ==
X-Gm-Message-State: APjAAAUA71b6ocPwui8PCn3TigHm6O8BBk6j/jnAin9QPw6tOzl6fVBn
 F8IcYCXoptTemWr8sSsO8bGatg==
X-Google-Smtp-Source: APXvYqwOaZHXOluKL+d+v4jUYs4oVh5qXNZ/McfL8yfctWXtVm/fm/kOeuDO1BGacotTjrHEOxW5Vg==
X-Received: by 2002:a6b:917:: with SMTP id t23mr4775074ioi.174.1565191651605; 
 Wed, 07 Aug 2019 08:27:31 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
 by smtp.gmail.com with ESMTPSA id
 j25sm122664152ioj.67.2019.08.07.08.27.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 08:27:30 -0700 (PDT)
Date: Wed, 7 Aug 2019 08:27:30 -0700 (PDT)
From: Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To: Palmer Dabbelt <palmer@sifive.com>
In-Reply-To: <20190807145939.1281-1-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908070804400.13971@viisi.sifive.com>
References: <20190807145939.1281-1-palmer@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
X-Mailman-Approved-At: Wed, 07 Aug 2019 11:32:54 -0400
Subject: Re: [Qemu-devel] [PATCH for 4.1] RISC-V: Ignore the S and U
 extensions when formatting ISA strings
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019, Palmer Dabbelt wrote:

> The ISA strings we're providing from QEMU aren't actually legal RISC-V
> ISA strings, as both the S and U extensions cannot exist as
> single-letter extensions and must instead be multi-letter strings.
> We're still using the ISA strings inside QEMU to track the availiable
> extensions, so this patch just strips out the S and U extensions when
> formatting ISA strings.
> 
> This boots Linux on top of 4.1-rc3, which no longer has the U extension
> in /proc/cpuinfo.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
> This is another late one, but I'd like to target it for 4.1 as we're
> providing illegal ISA strings and I don't want to bake that into a bunch
> of other code.

I'm unfamiliar with the underlying QEMU code beyond the patch posted here, 
but I can review the intention expressed in the patch description.  The 
described intent is aligned with Section 22.6 and Table 22.1 of the RISC-V 
User-Level ISA Specification version 2.2:

  https://github.com/riscv/riscv-isa-manual/blob/master/release/riscv-spec-v2.2.pdf

And on the Linux kernel side we've also recognized that our current 
parsing code is handling "s" and "u" incorrectly and that we'll need to 
fix it:

  https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1908061818360.13971@viisi.sifive.com/


- Paul

