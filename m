Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E3C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F261921775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxDr7guD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F261921775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0CRJ-0006PJ-6s
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 17:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j0CQh-0005LZ-5n
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j0CQf-0006jm-Tu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:48:55 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j0CQf-0006jX-OO; Fri, 07 Feb 2020 17:48:53 -0500
Received: by mail-pg1-x542.google.com with SMTP id z7so515428pgk.7;
 Fri, 07 Feb 2020 14:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c0YrgqcAFKn9jO4Ubw0Jyq4UDMhCZkruc5f4J/Wv9R4=;
 b=oxDr7guDw62QGBtTfhwD1c1uLrlekKSf4UgwfRRtx0ajBWsCTD7Vhf3UJRIadCIIOh
 nL1eJaAmDWPHapVZjJCTH44n+mXmcHKsRxvA90/zIW1bDsDxQD3Mc1uYnzUdRzCudDOZ
 EVuo3r+NSi/n6lSLdM9ef2N4KxsUqrlO9EBNj9jzpblwCgovdQ51ly5Kg4h+xUZ87cNu
 pQDrin7LLrpwSmAvVVk89a0YBBt0D7II/JdkhdmGuY+D6cMnP66z+oRff8QKi4lzzpFR
 5nTJU7D+WnMY07FxLMRUfpGiVvhKjaqFdi2YzZJxRqKS6M51m2eJHA2Rn2cz3zhxORt4
 7o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=c0YrgqcAFKn9jO4Ubw0Jyq4UDMhCZkruc5f4J/Wv9R4=;
 b=sgDjAG7DH9xAwtfKJAaDmTg/P6B5Tib/dnSswyueTy/2nkV0irjR5GxZcCqxvNMc6h
 z/B6zZ8FsAU6q+IlK2r/vRXnSgqRp0D+78PygexOV/mlxbrniKSO3c1mWdadanYzQ64P
 BEcCyoVbRlry+bErXiemq6Z3trcqn3boMU3dobnI99C4ggjYE+UlTdWI3rUBppgYjfTW
 khP6zsIa0PR6Q4CT65sUBkrwhdgm96/AE3bugkrq3C0sS15ZJLEtBnngo8b9G6tDqIZl
 Sq5fYSgKb+59nAkpBoBvwi+xi7PNpXQXvKVH1vYMQWFFC86BuZ1xtOeeb599C+KJUb7P
 TMzg==
X-Gm-Message-State: APjAAAXloh+ZLQGnuUFQvShxI+ccIZia6B9MOw/vlSqINDwH0B8BYqm1
 hAyWu6cGR+X23+YrB1d58HSWMDcc
X-Google-Smtp-Source: APXvYqy6vcmHi4mi1vp58nuU9ZFyG6SpM2exRkFs2S/icMkgQ01C51MRnnpFtZO9K0GVXPLOmBKpHg==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr1135579pfq.138.1581115732421; 
 Fri, 07 Feb 2020 14:48:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id h10sm3987029pfo.181.2020.02.07.14.48.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Feb 2020 14:48:51 -0800 (PST)
Date: Fri, 7 Feb 2020 14:48:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
Message-ID: <20200207224850.GA10890@roeck-us.net>
References: <20200207174548.9087-1-linux@roeck-us.net>
 <158111304888.591.9861885311267533100@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158111304888.591.9861885311267533100@a1bbccc8075a>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 02:04:09PM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200207174548.9087-1-linux@roeck-us.net/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
I forgot to mention that the patch depends on the similar
patch for ast2400/ast2500. Sorry for that. Not sure though how
to tell that to the test build system.

Guenter

