Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099BFC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8099222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Q3HfUSs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8099222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPCr-00007y-F9
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iDP8y-0006SB-FX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iDP8x-0002dq-Ho
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:28:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iDP8u-0002a9-Hz; Thu, 26 Sep 2019 04:28:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so1073989qkb.0;
 Thu, 26 Sep 2019 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ymrNiC5w603Iw3ATUuk8joiOvUnP3ZGUHJC7aBcSH4A=;
 b=Q3HfUSs79fQsgKOOVnS4X3qnZ6LNxrzs4AXWJnRrerSzmd50VPtwdBFnvpFkUn+XL3
 Cg5aafmN1azVRr1NvMrkcGlXJbK26eQtkQAi+Hn6y3jOFMS1aoQlmnQ7ZkQlNSn97C1M
 vmbZK/iLhgx8/fWXwaRhkS0vaKgxc1UhqMRiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ymrNiC5w603Iw3ATUuk8joiOvUnP3ZGUHJC7aBcSH4A=;
 b=Ut5vsERWTldGD/bKrhi1fWRBYr0V+CfcWIj6DbButOPHle4qY0JccNTrQnHIU4go62
 e/GlFU3MRPgsrtLTL3qHv1aWr/+RvNZev/Q7I+C/GLB30zajxp8emu8uOn015/3IJVGh
 v9U+LCyOqk5Pnc3XjOxUSZ50rrze+Dtum9bwDAI8VgvCgF7m8eR3hJ7Z4K+4sFHihOeW
 /FBMzVoIShTHiTjxbUmYJFFqrgIif9Rvrk+C/oGWIkVRHyYeXhC3uGJCWtxPlO5Uy+th
 /O3+Nhgnr3QWR3mOQyC1AYR6wPCrnEFcPmup0WKFBhuSYq038x1tbbRg8oDM8Qh7zxBM
 DN0A==
X-Gm-Message-State: APjAAAVHvNTz2AjZxq5BPj7Rv+rZpxCvthsKghDBnXGP5JySW24XqTZL
 nQb7eGOtNL/JnGPNJIL4UJRBGoAOHvPUWfBB0l4=
X-Google-Smtp-Source: APXvYqy7MDh5KVt/WyzvxPADbvX+4RsVhiITLgqDAVqXzpCh9hdnMc8UprEvXFPFBiJqRB1KDl8VBVDvoeTmFv6g6wA=
X-Received: by 2002:a37:4a54:: with SMTP id x81mr2068824qka.292.1569486471882; 
 Thu, 26 Sep 2019 01:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190925143248.10000-1-clg@kaod.org>
 <20190925143248.10000-3-clg@kaod.org>
In-Reply-To: <20190925143248.10000-3-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 26 Sep 2019 08:27:40 +0000
Message-ID: <CACPK8Xf=59gpxwEQTkdTuHGuhNePsmw8gDHKw5tD2FBThsp2fw@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] hw/sd/aspeed_sdhci: New device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Eddie James <eajames@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 14:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Eddie James <eajames@linux.ibm.com>
>
> The Aspeed SOCs have two SD/MMC controllers. Add a device that
> encapsulates both of these controllers and models the Aspeed-specific
> registers and behavior.
>
> Tested by reading from mmcblk0 in Linux:
> qemu-system-arm -machine romulus-bmc -nographic \
>  -drive file=3Dflash-romulus,format=3Draw,if=3Dmtd \
>  -device sd-card,drive=3Dsd0 -drive file=3D_tmp/kernel,format=3Draw,if=3D=
sd,id=3Dsd0
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> [clg: - changed the controller MMIO window size to 0x1000
>       - moved the MMIO mapping of the SDHCI slots at the SoC level
>       - merged code to add SD drives on the SD buses at the machine level=
 ]
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

