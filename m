Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D9C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1B1205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUrDW+2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1B1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNUs-00010u-Jd
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:47:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <divyavipin.hyd@gmail.com>) id 1hGDOa-0003ne-BB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <divyavipin.hyd@gmail.com>) id 1hGDOY-0004Lm-N9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:00:24 -0400
Received: from mail-it1-x129.google.com ([2607:f8b0:4864:20::129]:40492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <divyavipin.hyd@gmail.com>)
	id 1hGDOX-0004Ji-87
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 22:00:22 -0400
Received: by mail-it1-x129.google.com with SMTP id k64so6462784itb.5
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 19:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=dU+6gQS/SF+y8YSD2n1gTaqGgqwioalhz0Ts9rNVuz8=;
	b=rUrDW+2Fxt4WyNqjBz+KmRXLhfrEgvgL/lspre5hPtF6zhCZ73bmNv89Rn7ePfyIP+
	vWYzK6VbgwlANXv2nEgHqGWsCT5zQmZWTXHlN/O8XDF6TEkZ+UUbOomK2hY9VWOVFBQL
	SB3PNjdEinCMnj93Wez/pBDNkoKca2FqbA2+8qX7hTDDQqJ54oTNUYW2O7HZe+OLwVAf
	Pbjlhb70DmOwYWrXGw5drht0YQVAGj5AjGAvlwWOm7yqSqqlUaGAFWnCfnodBgqzdASq
	umQr5W6dHDocIIjh+T+KPTMBS20eCJFRGE6PnQDsjcDGSQ0Iqg03PRqfdlhf5a4HPapj
	HKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=dU+6gQS/SF+y8YSD2n1gTaqGgqwioalhz0Ts9rNVuz8=;
	b=eE+eNwKnOcOZUFQXnn8GXMY2kB6QDEK8m/aJ0c3jpmoiaAHxciUzJ3boCZVWZ9NLXx
	zOPJw+zA6xiWaIBj8FLfdEq3xxFFuNQx2mXpw8Sjgp1JzE0I8hTV2J7TD8YF4D3sZq9E
	j9famdoXK4BphdXqJXife/57ItrKS43K0nu7eeWFv3aAeRM+PrpXzajSaWC/DiNmNPc1
	797SNfUM2DCl0LMk2fxWC04oaKXwV5Kpheg8TQxrTBhQRCWBEAUdYyfzRjAm/v3euOeL
	lWmb7EIuixtW6jMxbJ7yzAjiH01d+xwLL05uaeRRNSaDf2mo4PbKHwuRyekthFhueLQL
	WXvw==
X-Gm-Message-State: APjAAAWZEYBVLdJxP8BXA0pGBQUMdeYWCrOodmIglj1tka53MyQGaDmP
	lh1umkxdfeg4OD/rtudimvxNzqWN6JF42MdCacdgOA==
X-Google-Smtp-Source: APXvYqyvF8VFHsU1qRKSVfpMcg4MoEcEcA0jV4K39MeVVTcVQtiUj7b6sTDlXDhIUuX7HGKMWQoFa5QkQ5VTqiDJKwU=
X-Received: by 2002:a24:3246:: with SMTP id j67mr28017538ita.70.1555380018829; 
	Mon, 15 Apr 2019 19:00:18 -0700 (PDT)
MIME-Version: 1.0
From: Divya Vipin <divyavipin.hyd@gmail.com>
Date: Tue, 16 Apr 2019 07:30:08 +0530
Message-ID:
 <CAG+jzpqx28OHiAqtc-0qBn2_0G4eX7m_=Fdtf=rLTE+aEsZN2Q@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::129
X-Mailman-Approved-At: Tue, 16 Apr 2019 08:45:57 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Programmable BAR registers in PCIe
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416020008.ff3nQLgI4Fj3jRSdU_lYOYDofNRcN_huqC-05OKyTK8@z>

Hi,

Is there any way to reprogram the BAR register sizes in QEMU? The use case
is that the device is agnostic to the size of memory available in the host.
So after enumeration succeeds the first time, if the device is capable of
knowing that there is more memory provided by the host, can we change the
BAR size in QEMU?

Thanks,
Divya
