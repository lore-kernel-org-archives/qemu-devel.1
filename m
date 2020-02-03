Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5671D20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtggjQyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5671D20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYXY-0004EZ-Ij
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyYWr-0003lj-27
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyYWq-0005oM-2o
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:00:28 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyYWp-0005nR-Uw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:00:28 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so14138244oif.10
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uhsw1BYBpFGbuKUHVCaxTP7nhysB0Kx8XsRggqHx0GY=;
 b=AtggjQyjSXq6nvAFc60fPF+bpBoy+5vPCXl/NN7XyFLo1Qwp84IGPTEUeW6lzzABB7
 fQW2g5ncfkoosJXv8n7kOgwEW2FyAGeKI2wYhF9Htoi5dkyBk2USewH7qI2JCQY5OD9W
 7hg6aqK3N99e3wwK+p0ZnyIYUBrcGawi8pCNsRz0dZ/oHWYO4pb+kaP3xmwxCd8xsS1F
 K6sBpF+pL1PEshYJe5LXlnOrnfeGJk5DwauR9ylULU+b7IurQ1FdHFB4W74xhons/fyO
 H0p2svCTTgusEkygeAbKS46vSpWbxDRLiypUjWq8qHxJ15tQQGXOWNUVEglIWDr5knlV
 LmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uhsw1BYBpFGbuKUHVCaxTP7nhysB0Kx8XsRggqHx0GY=;
 b=Hs24C0hsS36M4P4evy73SiPW67Sbv/6qTn61OtqLem+N1RSv4PF45rgKRVo8e49Lvh
 91QH/C8VvpVS8iNutjhrPo8Lwj4wsP+pjVoWhDwD3JD4/FWzjyGKWhggBgR3EwPDZwHX
 NeQmx9x3MkYP2mE3IHKjhcoLe3md/omoW5+I1DMUVLRUfls4OZW/Sh2zk5/pJ8YXYlEM
 G+rSbigLyxQCk3R72tLt0QyU4HZOUG25IaT0FzPC1BIOfHZaTLcfpXwa2mQbuyli/Dda
 G7//RiA8+vSKUjA/ADhzTWCnstTjqBSLxYiAva2AgXrtXSFyxpvC+Wij40AB7wlrxBC/
 AbMQ==
X-Gm-Message-State: APjAAAVVx2d+3WeL0HmNonPJFmCJ5xsSH6KVFa4oY+GfrbSFUfwKAZtw
 EQEKtqON79GU4ybtrWx0e07QS+q+ADPDr+UY3Bjd1Q==
X-Google-Smtp-Source: APXvYqzfExVUgUe0XwgjRV199aL6qM9cV/bUYKwl/Otfc/f37Bsk/SAXJnEo4/KIwT1Oj9wuKKITzoyqF+PHqQ9z7do=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr14149909oid.98.1580724027145; 
 Mon, 03 Feb 2020 02:00:27 -0800 (PST)
MIME-Version: 1.0
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 10:00:16 +0000
Message-ID: <CAFEAcA_8-0wqQX8KEK_zFRufoaEQkaeaXu4DLx08KazxTZ5fxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2 Feb 2020 at 19:39, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.=
hu@gmail.com> wrote:
>
> This adds proper support for float samples in mixeng by adding a new
> audio format for it.
>
> Limitations: only native endianness is supported.

Could you explain a bit more what this limitation means, please?
In general QEMU behaviour shouldn't depend on the endianness
of the host, ie we should byteswap where necessary.

thanks
-- PMM

