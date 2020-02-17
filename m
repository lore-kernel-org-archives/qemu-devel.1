Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1036C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B86720702
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjUrSAHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B86720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dau-0003ht-Lc
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3da9-0002cQ-7H
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3da8-0000yU-87
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:24:53 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3da8-0000y0-36
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:24:52 -0500
Received: by mail-ot1-x341.google.com with SMTP id i6so15578308otr.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RMzYn/RKf0PSTpkNpMCiA6qbaK1zSkfbqyqrqgmljZc=;
 b=wjUrSAHmVZJkvMebx6bTjcECp3rj11XnCUy1OlNt1IMrtBvEvit5uFjxWKEwE2BH1B
 pb0pxFTFlosofy+22pm/vDWAZWZchXjc0D6fzCUELcuT4ubBtyZOLRCSgZ/6FPaOwH4A
 pWH+7pW/QN0pmTExaSJUOOjNMHgooVYGDUAp2GalICI9acq//dfFQdOOW0mAZwp5/OYE
 zPCIofjjVu7L45qwo/WCCdNsOSd/uXg6EMwxqYlJwxW3rktPpwl0nxaz5+OeO9XetB+9
 Kci/ZYNnf6IaWBCmoIR78CryPFoN+MIvFArVoCCROKoM3DfUsw2ijdFZYq8LRBd2ugpt
 6EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RMzYn/RKf0PSTpkNpMCiA6qbaK1zSkfbqyqrqgmljZc=;
 b=f3S6dRtd+f2vlsPA334QSYW+8tvqF6bbuQ0WLG6UjpILZZPOntxX+pj2s5ENF7JqqA
 zcA4b+oINrgulcbxwoThCFULIxp/LWwP8RbYDmaI4DXTYRQkskbH7mgYoLh26Iy75kI8
 RtchOtYsDSFLxw9DcOs2HxZF+lupR67Pm/BX2EJ2uI6ayN2c8JG065zRyCGdTObukbBN
 gnvlCAjM7ANdnVwWfuyrg2ToEXq0WxdCjeU+N3lDnTw+HsWg1/WEolY92vjxlipQ19aj
 ebX6UxsOMDucT5BMeVXqyxuD4msTmulPin/WDeSMppDWsd5iMgFTvQivnI9lzIyd7WPi
 HD9Q==
X-Gm-Message-State: APjAAAV/mI0bqf4Com95R63QLiUscw+GzofzRZDhiUgGm3T90g4b6eSW
 pgXMzn0sDOo7Pof+uryNsMT3zWOJF40XDENcXWsZrvFS
X-Google-Smtp-Source: APXvYqykaqSgZqTe8nw6dWV3B/l0rig+dSbc3dNPt7eIOuctoftVjt5nubCkt2lGfNrlShqQ5sp/FI98l0nIkvM6MM4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr11117605otq.221.1581935091103; 
 Mon, 17 Feb 2020 02:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20200121013302.43839-1-joel@jms.id.au>
 <6ac783d8-84c0-2200-9c7b-964f8dc56da9@kaod.org>
In-Reply-To: <6ac783d8-84c0-2200-9c7b-964f8dc56da9@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 10:24:40 +0000
Message-ID: <CAFEAcA_3VGA67HhrTpyeEpq=va7RqLh=sSxZ_KvAjYCWQxUxCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] aspeed/scu: Implement chip id register
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 09:29, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 1/21/20 2:33 AM, Joel Stanley wrote:
> > This implements the chip id register in the SCU for the ast2500 and
> > ast2600. The first patch is a cleanup to separate out ast2400 and
> > ast2500 functionality.
> >
> > Joel Stanley (2):
> >   aspeed/scu: Create separate write callbacks
> >   aspeed/scu: Implement chip ID register
> >
> >  hw/misc/aspeed_scu.c | 93 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 70 insertions(+), 23 deletions(-)
> >
>
> Hello Peter,
>
> I see you have merged patches more recent than this series. Do you
> plan to take them later on ? They apply correctly on mainline.

Sorry, these didn't get onto my to-review queue for some reason;
I've just put them into target-arm.next.

thanks
-- PMM

