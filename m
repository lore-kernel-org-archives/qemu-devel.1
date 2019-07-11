Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62BAC74A3F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A4220844
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9mUXwUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A4220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlNZU-0004WU-VI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 21:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hlNYw-00044d-Ll
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hlNYu-0005qT-PM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:07:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:36255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hlNYt-0005i9-R7
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:07:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id k8so2101089plt.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZrmmJx79hMf1xDaYuntAfmfuZcs9hViDnRwMSxSUGfY=;
 b=t9mUXwUb4AH8rJk9rtJ5j6+Co2bCMBmRi1KJqwCyRmlpv36eghBMoVNF+xkocsw/NU
 alWJQzyAHNPeFlEb70iRlx61g34GieFCTzvX03KPCqT5VDb1epJz/LAeMXFQhY/zhqQF
 fcRs3y3yFbtcQ6m6UxaQ0LdfX0u58revtTpX2QDavIkU0efbgW88yauf+1RPAJAXO6u9
 z7XuaiddfrpyDXT4dng9yXIfZ2cOf2K+D+JvfpoIwJgtdAsaecQPKiEHX8v1amB42472
 DQ9Sd7nswAtbIBtvt2IlVrKNcoExyP81D3rrZH0btgyWw2Cm644vNL4N378SvKYY24fQ
 rcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZrmmJx79hMf1xDaYuntAfmfuZcs9hViDnRwMSxSUGfY=;
 b=DzBGixDJciJde7twJcADQk9hPPzxSnzgyM4xubNXAHvCPA9yJVobDhRt5XZrGaGHGw
 zHB8/2uqwV6ycxOY9IMJNxktUhfW5BcdrriWO7z5RS34wOSrpRh9mSOFZMtXeXZIzHVt
 sV4jro65DinSQ2FznK1Gjh2pCFGxfBco3dasN5awnm8pPao7gbZKxKGdRfkGpON5aII5
 zUrwPaPMrR0GN1EudqZHjTiERu3rn31urK7uPbw3HujUx2ARgMVqlhi6lUrF4Xy9PAHO
 62aErfWagEX5ysuNb+W5AJGO4nMZcqKAb1ZrsfzkwwYAAI1vhpVzda9mUM5CU1L1v8wq
 Sg7w==
X-Gm-Message-State: APjAAAWuxjL7kke1up1ttdDQtMGVzvxAyZXPzfozvsEXcIk/YF0VHM3f
 g17AWzmrfsxDVXcox1J37+KCl1Sc
X-Google-Smtp-Source: APXvYqwX4r0+xncbEZyCrfREyguXClW4UKHdprpBaagJ8YrfnOc6XkkqFCyjRRzMKxhG7V2snNgMPA==
X-Received: by 2002:a17:902:7887:: with SMTP id
 q7mr1369223pll.129.1562807264217; 
 Wed, 10 Jul 2019 18:07:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id e11sm3476883pfm.35.2019.07.10.18.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 18:07:43 -0700 (PDT)
Date: Wed, 10 Jul 2019 18:07:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Message-ID: <20190711010742.GA810@roeck-us.net>
References: <20190710220153.GA10826@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710220153.GA10826@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: Re: [Qemu-devel] Problems building and installing qemu v4.1.0-rc1
 in single step
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 03:01:53PM -0700, Guenter Roeck wrote:
> Hi,
> 
> when trying to run "make -j30 install" from a clean tree on v4.1.0-rc0, I get
> _lots_ of undefined symbol errors.
> 
> If I run "make -j30" followed by "make -j30 install", make succeeds, but then
> I get linker errors such as the following when running "make -j30 install".
> 
> /usr/bin/ld: final link failed: File truncated
> /usr/bin/ld: BFD (GNU Binutils for Ubuntu) 2.26.1 internal error,
> 	aborting at ../../bfd/merge.c:905 in _bfd_merged_section_offset
> 
> Running "make -j30" followed by "make install" succeeds.
> 

Correction: This doesn't always work either. Sometimes I still get a linker
error. If that happens, another round of "make; make install" succeeds.

Guenter

> This looks like "make install" may have bad dependencies. Has anyone else
> experienced this problem ?
> 
> Thanks,
> Guenter

