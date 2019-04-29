Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F10CC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEA72063F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9SkNCEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEA72063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59577 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8cU-00076N-92
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:55:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8bU-0006YG-Ky
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8bS-0006UW-PJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:54:04 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8bR-0006TK-1A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:54:01 -0400
Received: by mail-oi1-x243.google.com with SMTP id n187so8695704oih.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=PNjaz5jmGqscrk5EWGZMQ4X+yWZT9bb9jB43XJMl6i4=;
	b=N9SkNCEXnJyG3qIRNwg52YwUMfr8FENlIX4wsjmzWMm2mJ2veacFrSB5J1zDv/cbeD
	YvXOPRkBjG/AA9Mt/Yk9ftgDIt+LrDf4aIoqYSkFFg9Izm8hFzzAgGBClIflq16M5g4o
	HPsPVOq4JofISRHa3+QNXlU0sMv0nJXBVd2aE31WluSNjpuyVPtAU5ImW1o28lsqVvAw
	NX1Axb1d+EDbTCEVbCV2r0KLDsPaspQV0QP+QkkczN6a1eA8vvWRZ4BxqHiYVNPn2slC
	zLGmZU6bxgMCAI+Go0brbMMffsC4VMIVR/54T7ksYpdTOucXuSEHlVcP6/3NVn10ksOw
	37vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=PNjaz5jmGqscrk5EWGZMQ4X+yWZT9bb9jB43XJMl6i4=;
	b=YNwtYvZ1MfWwVhRUySJ+PkBA5cubIm0oedrjNXO++IOxO4RuZGItNfc966p4RJlynC
	IKhsVz292QRnj63CyYdsBzLVjoKjUwEOT9ClxTv1h4zLkGgP+9L1DD8cU5Y3Njhn1DKy
	5QcGQ3jdwCh5PVyXQMSeQH9IqgTyFvc3Zo0Vow0ijlIXqPWWnEVX15py6eZtEEui/Obv
	jhXVt+ZhL9vKZYjMciolLbGUIkzbw3XJ30bvdFIB2bULIJRmAxACvTINI0Dxqgd4O/ES
	9bUvBmYTpaLx2hbNpMr99RSVTgBVw2NYb5qdfKIlIqGzASIx5yynGDt2g5G28oSyzjkO
	NYbg==
X-Gm-Message-State: APjAAAV/y0gHPLcpyhMf0ekN0kOWrkQ9jpXOHi1/BfCEN9SBZSDtxGAm
	8i78YQmwNhS57Hv2fqkXXpionXqWOGXSnRjykLp/7w==
X-Google-Smtp-Source: APXvYqyeOJGxLqPcEFJrIQwqCWOA2dd91fahYLyG9nU9Z7WIz9MvWEp+hfQx1zf9DxouGP7YczSCD/B8K2WIm0a6JzY=
X-Received: by 2002:aca:4c88:: with SMTP id
	z130mr16675548oia.170.1556553238956; 
	Mon, 29 Apr 2019 08:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-17-thuth@redhat.com>
	<98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
	<b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
In-Reply-To: <b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:53:48 +0100
Message-ID:
 <CAFEAcA8xWTwbU6RSBbQkF2j5OfozEq9g3Pq83KyYG_J1CqGM-A@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
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
Cc: Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Yang Zhong <yang.zhong@intel.com>, Rob Herring <robh@kernel.org>,
	Qemu-block <qemu-block@nongnu.org>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429155348.FPBF9-4ZQZel6PJjVoYVFCYmuRMVdX5EtqbX8S7aelg@z>

On Mon, 29 Apr 2019 at 16:34, Thomas Huth <thuth@redhat.com> wrote:
>
> On 25/04/2019 17.53, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Thomas,
> >
> > On 4/18/19 8:00 PM, Thomas Huth wrote:
> >> Dependencies have been determined by looking at hw/arm/virt.c
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  default-configs/arm-softmmu.mak | 11 +----------
> >>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
> >>  hw/arm/Makefile.objs            |  3 ++-
> >>  3 files changed, 22 insertions(+), 11 deletions(-)

> > Without -nodefaults I get:
> > qemu-system-aarch64: Unsupported NIC model: virtio-net-pci
> > This is expected.
>
> Yes, it should still work with "-nic none" or "-nodefaults".

Er, if you need either -nic none or -nodefaults after this
patch then this would be a change in behaviour, which seems
wrong to me.

thanks
-- PMM

