Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4033C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA85420863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 02:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="caWR01mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdQ4X-00088q-Vg
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 22:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ3l-0007M2-QD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hdQ3k-0002wd-RD
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 22:10:49 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:45441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hdQ3h-0002t8-0N; Tue, 18 Jun 2019 22:10:45 -0400
Received: by mail-qt1-x841.google.com with SMTP id j19so18011815qtr.12;
 Tue, 18 Jun 2019 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6f/vDN8UzYXYAWICSwz3/kaEZ9vcmij1v7RkJ/hDmCQ=;
 b=caWR01mHysbKltd9C0umCIG1FEVVP6tAJkmyMX3RqXHn3lR7EOtLMsgz5SJ8FAtrci
 bgF6qaDElmZSYatbzDuCLlsnU4UVFpfCBlWX3Xt0k1WjF69yF8N0NWWjjMHoFLTWfIij
 K4EQjpIpQGvDsUjNa/A23MOaLFcbxj+hR3X4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6f/vDN8UzYXYAWICSwz3/kaEZ9vcmij1v7RkJ/hDmCQ=;
 b=U3TiPDEg9snhX0jZIhavd2rYJDk6XeQpdhfKdsF2vFR5pyJoPkM3QsBiXUvR3AKNtZ
 f2VcJZd32sDA321vME8Vi5D9vgLY0wQUdFqo34Zh8YOU5dlfpi3nshXC/zM2wswDOc83
 4A6vfnq3TryzErymyiDneIxKXPo9xWgRm6jUnuRZvxr2lWAHQu+KU8BYeGobgYvNuMzp
 30WlvYphLSrtMoYf/hXR9q2F2+hFYrPOKLaeWsDpgxSmrKQ1UwxsMQ8WMUT/J25Q5ooN
 KCuzyL1JURI9aRpHtxRrF/8Aeyvc1NZy3lzyWTsWWymNzeJujaM+6meXsFtvz4e8VNBu
 O/dg==
X-Gm-Message-State: APjAAAX4d0cCc8l9xv+wzxTpiql8gdzcjIiFOkL35tVTnG6PYbIFJ+Nc
 iNAY1qvWvncvjYDvwLft0ZSkXKts8bK1JF0mO0+1LOJ3
X-Google-Smtp-Source: APXvYqx3qwtn93D4sSCm3KIag9VYoaNbhtiEanLZLUMGTUe7VTdYf119zfpK/09crxYpddO2GRKzVom06gIleDMLTRw=
X-Received: by 2002:ac8:2d69:: with SMTP id o38mr89557454qta.169.1560910243508; 
 Tue, 18 Jun 2019 19:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-6-clg@kaod.org>
In-Reply-To: <20190618165311.27066-6-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Jun 2019 02:10:32 +0000
Message-ID: <CACPK8Xcwsf2gshvJxJUtBrPrYsqaa_w7XqC5bmb8wAJRbBhHgA@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2 05/21] aspeed: introduce a configurable
 number of CPU per machine
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 16:54, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The current models of the Aspeed SoCs only have one CPU but future
> ones will support SMP. Introduce a new num_cpus field at the SoC class
> level to define the number of available CPUs per SoC and also
> introduce a 'num-cpus' property to activate the CPUs configured for
> the machine.
>
> The max_cpus limit of the machine should depend on the SoC definition
> but, unfortunately, these values are not available when the machine
> class is initialized. This is the reason why we add a check on
> num_cpus in the AspeedSoC realize handler.
>
> SMP support will be activated when models for such SoCs are implemented.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

