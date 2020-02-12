Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B100AC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7522173E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 23:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJFGQmue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7522173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j218s-0002Cm-IV
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 18:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j218G-0001h4-Aw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j218F-0006c2-5D
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 18:09:24 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j218E-0006bV-SF; Wed, 12 Feb 2020 18:09:23 -0500
Received: by mail-pl1-x641.google.com with SMTP id b22so1516784pls.12;
 Wed, 12 Feb 2020 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=AiE1r6YOeFPfRVFFJZLH7Z0csnvt9YqTi2HaF0JL6js=;
 b=CJFGQmuevf3yr30vlaR0aQ/52O4caXfDQI+fQGqQJPI+Dc4lbZX37qf7bMhYybU/ru
 2cw3N4JEPC+Br+B3rnqQPnHsBlY0H+8sSKapsqEyixB5GSxkCTKiAzRtehIcThV45Vo/
 hxOKnkAUe/8M6p7CQ+dk/cAR2VX95KeaOu9BnFfU2fZgWis6JA8eH/6bqsAwpDl42pkt
 cI/b2uWcvYI+WaMwAylE/G6xpS6PHBnelaw/ulL5PLHgbQRuRuFQ/V1EbjIyj4/8LVtF
 1qNJcBA74w5zBViiEmwVlnqu+X/noEYApZHoA5pK5hQJINdpHffO5NWqR3wkp84UmtqQ
 MkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=AiE1r6YOeFPfRVFFJZLH7Z0csnvt9YqTi2HaF0JL6js=;
 b=fsvjJEed+OGQmc6tqO7caOyxlvg8APtdoGtM+AgfVAUEmHNQYuGnvovkbNcBkrPTFg
 12ibuKw5ppjX6VWUxtyxOdaG1A/sbt1qPkrL0XfRHf6O60PFpYe4npIGM0djGVmEDaN3
 3bZk5mFiV2L6jZWSbhiX14cYoYSX0lSfJWkNY6eAANdb/uzQC/7azmuImKhEucINr97N
 4J+1vMsx86K5NQ4CTUjalDvzrFZwo4rmdfpOxfxyM09YRgxx9vCR0FGNLe76Xgoddkrk
 NH5fCWcZbD0H0orbfCXHBMU5iwQRD8WFL8j1AhjHrj79vbB0zV4MpSp/FA9+fg3lkmFX
 /1KA==
X-Gm-Message-State: APjAAAUPXV73ukhNTJW58aNgT3BkB/cQywYuLnmewvyE/Z8c6IX8GyM8
 nG6Wrdck6pU3DRkQjbotHyC7Z1EZ
X-Google-Smtp-Source: APXvYqxEVNcZoiljy8GCplgfmGm6u4ZfuwVC+IL2CuGr1nhDoc67yM3TmFXBy5kFHC85FgpFXC/3OA==
X-Received: by 2002:a17:90a:c390:: with SMTP id
 h16mr1599787pjt.131.1581548961314; 
 Wed, 12 Feb 2020 15:09:21 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d3sm283679pjx.10.2020.02.12.15.09.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Feb 2020 15:09:20 -0800 (PST)
Date: Wed, 12 Feb 2020 15:09:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Question about (and problem with) pflash data access
Message-ID: <20200212230918.GA27242@roeck-us.net>
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 10:39:30PM +0100, Philippe Mathieu-Daudé wrote:
> Cc'ing Jean-Christophe and Peter.
> 
> On 2/12/20 7:46 PM, Guenter Roeck wrote:
> > Hi,
> > 
> > I have been playing with pflash recently. For the most part it works,
> > but I do have an odd problem when trying to instantiate pflash on sx1.
> > 
> > My data file looks as follows.
> > 
> > 0000000 0001 0000 aaaa aaaa 5555 5555 0000 0000
> > 0000020 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0002000 0002 0000 aaaa aaaa 5555 5555 0000 0000
> > 0002020 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0004000 0003 0000 aaaa aaaa 5555 5555 0000 0000
> > 0004020 0000 0000 0000 0000 0000 0000 0000 0000
> > ...
> > 
> > In the sx1 machine, this becomes:
> > 
> > 0000000 6001 0000 aaaa aaaa 5555 5555 0000 0000
> > 0000020 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0002000 6002 0000 aaaa aaaa 5555 5555 0000 0000
> > 0002020 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0004000 6003 0000 aaaa aaaa 5555 5555 0000 0000
> > 0004020 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > ...
> > 
> > pflash is instantiated with "-drive file=flash.32M.test,format=raw,if=pflash".
> > 
> > I don't have much success with pflash tracing - data accesses don't
> > show up there.
> > 
> > I did find a number of problems with the sx1 emulation, but I have no clue
> > what is going on with pflash. As far as I can see pflash works fine on
> > other machines. Can someone give me a hint what to look out for ?
> 
> This is specific to the SX1, introduced in commit 997641a84ff:
> 
>  64 static uint64_t static_read(void *opaque, hwaddr offset,
>  65                             unsigned size)
>  66 {
>  67     uint32_t *val = (uint32_t *) opaque;
>  68     uint32_t mask = (4 / size) - 1;
>  69
>  70     return *val >> ((offset & mask) << 3);
>  71 }
> 
> Only guessing, this looks like some hw parity, and I imagine you need to
> write the parity bits in your flash.32M file before starting QEMU, then it
> would appear "normal" within the guest.
> 
I thought this might be related, but that is not the case. I added log
messages, and even ran the code in gdb. static_read() and static_write()
are not executed.

Also,

    memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
                          "sx1.cs0", OMAP_CS0_SIZE - flash_size);
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^
    memory_region_add_subregion(address_space,
                                OMAP_CS0_BASE + flash_size, &cs[0]);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^

suggests that the code is only executed for memory accesses _after_
the actual flash. The memory tree is:

memory-region: system
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000001ffffff (prio 0, romd): omap_sx1.flash0-1
    0000000000000000-0000000001ffffff (prio 0, rom): omap_sx1.flash0-0
    0000000002000000-0000000003ffffff (prio 0, i/o): sx1.cs0

I thought that the dual memory assignment (omap_sx1.flash0-1 and
omap_sx1.flash0-0) might play a role, but removing that didn't make
a difference either (not that I have any idea what it is supposed
to be used for).

Thanks,
Guenter

