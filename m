Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A6D20772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDco+x/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A6D20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju2nq-0005g4-UB
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 19:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1ju2mg-0004Ol-Hu; Fri, 10 Jul 2020 19:50:26 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1ju2me-00035G-TD; Fri, 10 Jul 2020 19:50:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id w17so6184383oie.6;
 Fri, 10 Jul 2020 16:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=EZEzUt7O1ol2Sg+jnXkibkoEj5o4nuVGVLftXtZDboc=;
 b=XDco+x/hfNHB0P2uWyPJGW/c9o6tXTvig9zHCsCFnCA9dnlDYEAhxKlU1LHhhKxpfR
 GTU59cwQwccu+OCIau0C38LE7gcGMBNZyOF+lvLh9UrVd7M/cqOi8WUVhGNRa0wNim+g
 d4xUji7jh4M9HmW2hWerRQTZWhc+VnSeKFZPFFcJ90FbYJ1woIz3WJTveAtuQBopWma8
 NfaQWRtt2L0UN6KvcbgiuKP301jilRKrAWyUOTHFcApVmwSQya/ZgRwpl49yINR1RlFz
 1Hqzzc6PNpM8SGg5pDr90CxDdj2LUv/xcE4sskWqR8hGryp0XdFjJdYIuNdTMXs/MCgk
 gmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=EZEzUt7O1ol2Sg+jnXkibkoEj5o4nuVGVLftXtZDboc=;
 b=qdPKiWUJWbiCN53YAAsyCavmP1bO8yWjH+NzYl1jO9vd8T/G8XThK/gvG9qrIxySuB
 JQkO0tuoSzPV2QoHu5IiFLnVUU/UWpulDYfH9/eIobjqsisGSgjBwBZeZQABHVo2GOLX
 /5lhsAyp3jy/6MwLbyT26PUIhC9z4aijs37VKWf3hmxLH/ef8CGId0WXoeinvdrpYrey
 kntnJag0eWLb04sJQfW7LNJqouu4MVPuLN4joAU5Zhe6+mJYufATU1lpt8oCBOD//AZB
 1epIIEPn8EBVzURApzF0K/QPc9ZkLaGeQLv16sfu6C9OJeRXxl14S3QvMKJrOlsElr6Q
 EZGQ==
X-Gm-Message-State: AOAM533WpGjnE67xm3dMcN8LvAKFKFEgNkXn+WM1CyNqHxVoDDA+q2CV
 WgRD2ykEipSJ6pLSV/OoCA==
X-Google-Smtp-Source: ABdhPJxYMedu1mn08E0MIXU481bYMrmAIMIfN/dxQjxCNSvwsWCWGVQVBYJXLVVns/BRnK3i9uTNRg==
X-Received: by 2002:a54:4595:: with SMTP id z21mr6027517oib.157.1594425022256; 
 Fri, 10 Jul 2020 16:50:22 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id 95sm1367866ott.6.2020.07.10.16.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 16:50:20 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5810:6df8:8a6e:345])
 by serve.minyard.net (Postfix) with ESMTPSA id DBBE9180714;
 Fri, 10 Jul 2020 23:50:19 +0000 (UTC)
Date: Fri, 10 Jul 2020 18:50:18 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 0/5] hw/i2c: Rename method names for consistency and
 add documentation
Message-ID: <20200710235018.GC3235@minyard.net>
References: <20200705224154.16917-1-f4bug@amsat.org>
 <c287bb80-7057-b5f9-5263-84b7a12790bb@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c287bb80-7057-b5f9-5263-84b7a12790bb@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 11:53:13AM +0200, Philippe Mathieu-Daudé wrote:
> Corey, this series is now fully reviewed :)

Ok, I've pulled this in and added the extra reviews that came in.  I'll
work on getting it out Monday.

Thanks,

-corey

> 
> On 7/6/20 12:41 AM, Philippe Mathieu-Daudé wrote:
> > In commit d88c42ff2c we added 2 methods: i2c_try_create_slave()
> > and i2c_realize_and_unref().
> > Markus noted their name could be improved for consistency [1],
> > and Peter reported the lack of documentation [2]. Fix that now.
> > 
> > Since v1:
> > - Addressed Markus review comments
> > - Added Markus/Corey R-b tags
> > 
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07060.html
> > [2] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08997.html
> > 
> > $ git backport-diff -u -v1
> > Key:
> > [----] : patches are identical
> > [####] : number of functional differences between upstream/downstream patch
> > [down] : patch is downstream-only
> > The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> > 
> > 001/5:[----] [--] 'hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()'
> > 002/5:[0006] [FC] 'hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()'
> > 003/5:[0004] [FC] 'hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unref()'
> > 004/5:[0006] [FC] 'hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()'
> > 005/5:[0012] [FC] 'hw/i2c: Document the I2C qdev helpers'
> 

