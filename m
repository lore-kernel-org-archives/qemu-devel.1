Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A7C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5D120873
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8PA25aM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5D120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHyV5-0003aR-M8
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iHyTm-0002t3-0G
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iHyTk-0002Jr-Ht
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:01:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iHyTk-0002J7-A1; Tue, 08 Oct 2019 19:01:16 -0400
Received: by mail-pf1-x443.google.com with SMTP id a2so285943pfo.10;
 Tue, 08 Oct 2019 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=FeGnsY+6SlK0zf7+6kb7WpC7UcX+Y2kULIcnAvyrq7s=;
 b=c8PA25aMPcJyEBz/F88IcWC0jTxG6rB6CZsR2ygbvHj3IiifEZDj6kpFaB1H0xpCXC
 KMYwG4nw24PSm2WNwx2RTGtjpl5cN4gGNcKnYin11adeVbAvAwF2vxXD8RSurcgyiGRe
 ovQ3p5B1y44PNeUT7OLxjWit6OQjmy4Z9b4mTegfAN2vtMkIiLk+5VTB1bK32Kavybvm
 GY0RF2Yp57H1qlJ98pFFy73VTWTLhZgmYKjyKmTTFw+6kH10/ir+cVe0RA/7xCcKNHSO
 yNInFltN2F2DRvppRGuRR9AAnr56YpAMjtnHwemz4XrxxNM/7cnv8mpN5HdE0qaRlEtC
 b1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=FeGnsY+6SlK0zf7+6kb7WpC7UcX+Y2kULIcnAvyrq7s=;
 b=bODUCbOpq0QtiePl9MXxBu70ABcdY6tQVu2WjqCndaTx7oTRHvva95yRTszKkxOCvi
 CEqIejsSIZuREaCnp99TrehC0gQquXV5NSoegzYtqkGziXKswjJmJ+fSfVImpaXblXte
 GCvX3rIOuxLQRe1MUGC9hWIfQ/njXX4kRFuuaeDTTvo43CzW0AIPWGn90NEli9H6HXTB
 D/Trc2npeGIazqfmBfBjALfrI2bO193Rp/0QoyMJHkc4X7hthqIyeltnEtA1vfH61pe5
 TKGdE8f6p71R5nGGXDoOqeVDAbPsLzw4LueCm/pP1kwDSQzism7Mys1yiQlbGGNdef0P
 70Wg==
X-Gm-Message-State: APjAAAWXkgqgqdYMyWXzbgzaVADgASnOCJRtcI9i6q9XNmF+I+0dxdY0
 y7tjEcUnktDJfGfl4YzeiA0=
X-Google-Smtp-Source: APXvYqw8ZughLg+/8Y5hq6tg7vmnlif7PQImf0mAt1VEYo4wiR2KxSYk02PyfpIppCuyDMiuF5nDbg==
X-Received: by 2002:a65:4907:: with SMTP id p7mr867507pgs.429.1570575674362;
 Tue, 08 Oct 2019 16:01:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id i1sm168846pfg.2.2019.10.08.16.01.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 08 Oct 2019 16:01:13 -0700 (PDT)
Date: Tue, 8 Oct 2019 16:01:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Message-ID: <20191008230110.GA21879@roeck-us.net>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
 <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
 <20191008214907.GA28137@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008214907.GA28137@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Basse <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 05:49:07PM -0400, Cleber Rosa wrote:
> On Mon, Oct 07, 2019 at 05:28:49PM +0100, Peter Maydell wrote:
> > On Sat, 5 Oct 2019 at 16:47, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> > >
> > > This test boots a Linux kernel on a smdkc210 board and verify
> > > the serial output is working.
> > >
> > > The cpio image used comes from the linux-build-test project:
> > > https://github.com/groeck/linux-build-test
> > 
> > Thanks for putting this test case together, very helpful.
> > 
> > > +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> > > +                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
> > > +                      'arm/rootfs-armv5.cpio.gz')
> > 
> > Do our other acceptance tests download random third-party
> > (ie "not a well-known distro") binaries for the tests ?
> > It seems a bit hazardous for reproducability and trustability
> > reasons...
> > 

FWIW, the root file system was generated with buildroot, with
minor modifications. It should be possible to create a clean
root file system from there.

Guenter

