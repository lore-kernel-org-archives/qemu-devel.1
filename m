Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F4C4CECE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EB2206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZyixREP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EB2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClK9-0001ua-SB
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jClJG-0001CY-KS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jClJF-00024Q-Cs
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:29:10 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jClJF-00021n-6h
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:29:09 -0400
Received: by mail-ot1-x341.google.com with SMTP id j14so10302938otq.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d7ExToA7ukFgaIlGlPhMKk8Km2pb+rGkei+b6krgOkM=;
 b=qZyixREPridVpxFGXnekwCA1wEFxdbXDOObBp0di8XzaYvCdGNL1TKjKpcauMuGtdi
 TFVGwmBfZ4TLQ1N/p+d78CmNwWHwNb2T9D4bsdela98KXb+LhxXqHkGh/Pi8LcEKXMPf
 d7ZWFOYszeQ1QvD4B72cFWTFU6w9QBksOP2aSR30XtrAF1p83zdlgn5aRbrFIaB20b9/
 4RPPoHxpbaHxTGGog4aHeal6/E00BAWkPsboGZC2TQagU7Ah4G8AZnOb932Np83O2fsp
 7xwMZ+3jAjfk63pSyREGGPcxgTKZOjJKxZQliFSfxLc0pzfznvdMW2MftDWzyPJDBVD8
 uUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d7ExToA7ukFgaIlGlPhMKk8Km2pb+rGkei+b6krgOkM=;
 b=pxAxe3d3aK+00elGfUgl+UXPSnpzhkGbAOV0tWN8WVpcWZtLM0gBl4NYQsOV/c5Nfn
 lCsNFcS6np82d4DOdo4wdn4QV2OommnWJZzOvHI5C7uK1vg/6guRj9t5eiDz1fcKJFoX
 9uM9XcOhGUHUa3S6dTB40OVO5iaVW7/s0OId104ECmIDIp8rsERcgKzy8hTTVvWNFrLH
 LwsGUZt8V2kLJ/AeoxqGPKMV2xCOhnIwFOySvMrzAPgEJSeE19dJ4i/fjogT/T+pzFEH
 sk17+SLzuNVrii74w84pW3mlA2blxatTW9PuWm37NCLz/ctV5pRnHmSDzIGBGU80LwSg
 xJ7A==
X-Gm-Message-State: ANhLgQ3ZKCWfJAp8LpBxiDNv4xh1woxvND2ucCPScb5lrOe8qxuKnpnb
 FIddneAbTmzzsH06IbZ/13Fiv3e1gVcSLzsw/zmcfw==
X-Google-Smtp-Source: ADFU+vsd8TxBx6Lk8dbWCxWoA5LHQvluGxwglrALxjwp73ZAAqWySSOdVoRlh6Tq5Vq8mHVM+PGMNB2fdOJt8ZCXbhc=
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr10680836ott.97.1584109748226; 
 Fri, 13 Mar 2020 07:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200313123242.13236-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200313123242.13236-1-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 14:28:57 +0000
Message-ID: <CAFEAcA9kM_=52JT=XyhjDLA3CUSpeKwCB2nhLRrjY+MaBLw1yg@mail.gmail.com>
Subject: Re: [PATCH v4] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
To: Chen Qun <kuhn.chenqun@huawei.com>
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 12:33, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> The current code causes clang static code analyzer generate warning:
> hw/net/imx_fec.c:858:9: warning: Value stored to 'value' is never read
>         value =3D value & 0x0000000f;
>         ^       ~~~~~~~~~~~~~~~~~~
> hw/net/imx_fec.c:864:9: warning: Value stored to 'value' is never read
>         value =3D value & 0x000000fd;
>         ^       ~~~~~~~~~~~~~~~~~~
>
> According to the definition of the function, the two =E2=80=9Cvalue=E2=80=
=9D assignments
>  should be written to registers.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>


Applied to target-arm.next; thanks for working through the code
review process.

-- PMM

