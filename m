Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D3C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE65024A67
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 09:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeDoLn3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE65024A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY60f-0004MV-Ve
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 05:45:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clabbe.montjoie@gmail.com>) id 1hY5zT-0003dt-7u
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clabbe.montjoie@gmail.com>) id 1hY5zR-0003ck-UW
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:44:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <clabbe.montjoie@gmail.com>)
	id 1hY5zR-0003aT-8h
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 05:44:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so10931651wme.4
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=EoTFirwkcUMGV6qEYqMa/Ij3w52n1eYJPvzktcK+OLg=;
	b=HeDoLn3rdeogRQmYnMHPU/ZmC8Zb/kA5VmsXkWoAfW7fOX84gcuM1GskRKYU45Mrst
	JsS4AV6TltPnUNef3NilScWqDZ42WRFYwtz+wwz+yHC/pqx/h7YJGFoAfAbBtoBiKn4o
	x+Yt3eda0kzwZES9kgjq43HnwCGmS1XoDdVJEJgM9EvWfob+IV4ZnYdE80iVA6+WNF4r
	JoDLDwMY2RJyA2FEVnF1NdFFTOxaXfnceQlRToSK8RZF0bom3V7+vynObpNf0Qsl0PCI
	ijUi5i5jgh7aqpxcnuh7o+ht/igy6ir3Yn146yt80wfEdQ7AFeK9esF0vKFx0cb7CHMT
	UjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=EoTFirwkcUMGV6qEYqMa/Ij3w52n1eYJPvzktcK+OLg=;
	b=HIBRI5GuOPgcgYnHsu6jHfWtExsN0yvjc0HSPJ8UmYBfuq4WLJLY5kVHU1AXAslocO
	5Ka1GNoWrvSurSjnJ6ImneX+/GDcvbFVC0A/7N9x7InlLWeSIMV2jeY8McRTVgcBvfTa
	9kPtMGTx9FgRJEmwUoQvRaDxSTUg3Nz4v92wDmNIUZiA6aCvXrsAHNkRhM2bGaXfQUBl
	2Qx2BEHvTJs8X4H+Wp7GHJJU/YZPWzfGavgAIF2zS8w9TGwCa2Ii6uozWvfOJQ7+xRNW
	EwB07DaeQ47jcgCTXQQQu8wUD9RAGE2kRfa9MY9/84ZoI4DOXdNz3XDVQxCiEvREq2gh
	ywmQ==
X-Gm-Message-State: APjAAAWcDuFhPLZTgICGiyLcIbpbAIkFlQbXNOy5JZeiOAqfqDqx626W
	wIkE2QsDiYClgxSyUhcYKSg=
X-Google-Smtp-Source: APXvYqylyF3vA0f1qgs1OvwYGret4IAxdCHBlxIbs8Z8mlOYygcjNNXipPZP4rfcmoux3aXf3Ve5rw==
X-Received: by 2002:a05:600c:2182:: with SMTP id
	e2mr13342957wme.55.1559641456303; 
	Tue, 04 Jun 2019 02:44:16 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
	by smtp.googlemail.com with ESMTPSA id
	k66sm6004001wmb.34.2019.06.04.02.44.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 02:44:15 -0700 (PDT)
Date: Tue, 4 Jun 2019 11:44:13 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Message-ID: <20190604094413.GB15484@Red>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] Running linux on qemu omap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 02:23:23AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, May 20, 2019 at 09:05:33PM +0200, Corentin Labbe wrote:
> > Hello
> > 
> > I am working on adding a maximum set of qemu machine on kernelCI.
> 
> That's cool.
> 
> > For OMAP, five machine exists and I fail to boot any of them.
> 
> Which machines?
> 
> > The maximum I can get with omap1_defconfig is
> > qemu-system-arm -kernel zImage -nographic -machine cheetah -append 'root=/dev/ram0 console=ttyO0'
> > Uncompressing Linux... done, booting the kernel.
> > then nothing more.
> 
> It's known that omap1_defconfig doesn't work well for QEMU or
> "multi-board" usage. Perhaps the kernel size is now just too big?
> I'm using a custom config for every OMAP1 board anyway...
> 
> > Does someone have a working config+version to share ?
> 
> I have used the below config for OMAP1 SX1 board (the only one I got
> working with QEMU). Unfortunately the functionality is quite limited,
> but it still allows to run e.g. GCC bootstrap & testsuite, that is rare
> nowadays for armv4t.
> 
> I'm using the following command line with qemu-system-arm 3.1.0:
> 
>         -M sx1 \
>         -kernel "sx1-zImage" \
>         -nographic \
>         -drive file="sx1-mmc",if=sd,format=raw \
>         -no-reboot
> 
> This should work with v5.1 kernel.
> 
> I'm also interested to run other OMAP kernels under QEMU, e.g. cheetah
> (the real device, Palm TE works OK with the current mainline), and it
> would be interesting to know why QEMU/kernel has regressed...
> 

Thanks, with your config as starting point, I was able to boot both sx1 and cheetah

So I now use the omap1_defconfig and the only trick is to disable CONFIG_CPU_DCACHE_WRITETHROUGH.
I need also to disable CONFIG_FB for cheetah to works.

Regards

