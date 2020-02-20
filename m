Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F5CC11D20
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7608520801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icZVYdgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7608520801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4tLt-0000Ul-LB
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 16:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j4tL5-0008Ny-4G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j4tL4-0004K8-3C
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:26:30 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1j4tL3-0004It-Tm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 16:26:30 -0500
Received: by mail-pf1-x444.google.com with SMTP id 185so25101pfv.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XHYjda1qqzD+em9jadsDM4RHxztHgSy9LnYuZd2wKQ0=;
 b=icZVYdgGH2DTqOkimWqVUIwrmF1vqMQyyFIvhXyLLj2vz+AUJdpQAOwiqnQvNTygGw
 85/qInQljfceoHoeSj45OuWlky+9OND5vJZFq63PaNHfMWZB6Yxo+CqSf+wrHoWwnahI
 Omk5gSky5yOQWCfgl44VbbGCKJQWZXsod1axBLvL5IDue1hnlhUozWbVazeCfR1NWeP7
 D0fmmCx4kIUMS13glg3/xN2/yXDI6urc1t9BfV/6kDZWDTo6jd7aBtAFhQkACk4kRoNF
 Vpic6cIzktAOkAGcNB/o6JJunMHscRzEPkdjsxNuqd1gun+ZcYVhL8uE2ftuIzVzHBS9
 0kbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=XHYjda1qqzD+em9jadsDM4RHxztHgSy9LnYuZd2wKQ0=;
 b=ptEKBJfb1hJaC2qBiow8AmYaWNFcXP8am30MzN8pM048uukW3FAEqxs7gvUKq6FURh
 rRrcIaf406V2JBRKOFNWNuweCWFQAwsvHmnqUhacRfmf0cohvXF3RouIvUBe9rtoJ9GK
 ubxqNdkwJ13sPOK3uuQpEz99OTJltIAwhKoA6tpvJI8jP1ebrgk7FNjYC3L3knaGQarP
 E55yWpPhBQHeowbS3OCKWTQUcgdJQXYLPHrgBZOrxGYQXXYTqH6FFW3ZcA2MuRZArOzW
 GxMNo5KRhgqmw7Z8op6qJnYPuyxY8mdN91kE/Uz4xFGT85U8LHHSRtHOOecgM86bWP4D
 sjQQ==
X-Gm-Message-State: APjAAAX1rLjB/r2j6VmZoesdQ3rvdu/gG+uCVqOOfxc8XZDls19GXlI0
 HU9PV+8HaKpqq/tYBUPhhLo=
X-Google-Smtp-Source: APXvYqzK5cNSvH1NY18+KK8Mep3EL6M2Z/OyAWFkwWGRWXIid7AKM6vtbpG/EhmpJgM+dMJ+Yz1g7A==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr34961887pfi.25.1582233988657; 
 Thu, 20 Feb 2020 13:26:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id g72sm545798pfb.11.2020.02.20.13.26.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Feb 2020 13:26:28 -0800 (PST)
Date: Thu, 20 Feb 2020 13:26:27 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] sh4: Fix PCI ISA IO memory subregion
Message-ID: <20200220212627.GB26054@roeck-us.net>
References: <20200218201050.15273-1-linux@roeck-us.net>
 <CAFEAcA8ocGcGHwzdY2ao73WQcfoUbYTy2udUP5w+ZV5NOMeGLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ocGcGHwzdY2ao73WQcfoUbYTy2udUP5w+ZV5NOMeGLA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On Thu, Feb 20, 2020 at 03:06:05PM +0000, Peter Maydell wrote:
> On Tue, 18 Feb 2020 at 20:10, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> I'll put this in via target-arm.next, since we don't really
> have a more active sh4-specific tree to send it via.
> 

Thanks for picking up all my patches, and even more thanks for
your patient reviews and for correcting all my errors.

Guenter

