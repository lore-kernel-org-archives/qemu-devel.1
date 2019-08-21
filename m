Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591C5C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C51C21655
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C51C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RgU-0003Jp-71
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0ReW-0002Ew-Ge
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0ReV-0004Ox-Ad
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:31:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0ReV-0004OI-58
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:31:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D1DA4E4E6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 14:31:54 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id m26so913929wmc.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 07:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RX3YW5l6ICqZDgwmX2DIJhRo+YlpGnTrL8kuZi8U0Bo=;
 b=c7l+1gm2Ug0Djq3sp9XbRqwIOMjee0Vx39j644OCxrbKbBU5WHtAiV6tVNEORmEyYF
 QDWY+rYeMb0bT17kxQ+J5mU8/DC/wvwjVY56BEMA960BaC2ZCuQkYWvfTRiochAgP21W
 qOJb/OCgPSdSCvkqVF1dFr5g2pGcct59Occh2Kt38acKcLXQJP0ze1u4XpjlodPzCynw
 dyWtm/reiGN8r1DhKY/dwujjfVUXPazNLDdQYkD9vD/Eg7mTrv4N4u0NfoWI5m64Owoa
 dy3BkmqC6V+LbSSgW4t2HHfLLcjXOyKXU1a2mUfZhh4k1wu255crauahY0uTbPOTl+eB
 NN/g==
X-Gm-Message-State: APjAAAU8U3oYOTe8IHRKFLHjTybyf26LD0uIgh941eMuBM/cJ7RypTId
 iWTXsg7ZeIMXstK10g6Xa1IJtx+p/dDDpDCcOtfuS1dcuHN/GEQyimovC96UKADjFs4izzQNSCV
 6+9VT1fjJyHG8tvs=
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr411715wmc.30.1566397913170;
 Wed, 21 Aug 2019 07:31:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwhd25+i/sQXqR9L8E0pnVCFvq1GZLq73tnunw2LQ9KdXB76qkh7hjXeLCbNTPjHmguXEHNlQ==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr411701wmc.30.1566397912975;
 Wed, 21 Aug 2019 07:31:52 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id z9sm272229wmf.21.2019.08.21.07.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 07:31:52 -0700 (PDT)
To: Sandra Loosemore <sandra@codesourcery.com>, qemu-devel@nongnu.org
References: <20190821142151.19995-1-sandra@codesourcery.com>
 <20190821142151.19995-3-sandra@codesourcery.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8c38e143-1674-5b53-ee6f-d31b2e1ca2bb@redhat.com>
Date: Wed, 21 Aug 2019 16:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190821142151.19995-3-sandra@codesourcery.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] target/m68k: Fix bug in semihosted
 exit handling
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 4:21 PM, Sandra Loosemore wrote:
> This patch fixes a bug that caused semihosted exit to always return
> status 0; it was incorrectly using the value of D0 (which
> contains the HOSTED_EXIT request number) instead of D1.
>=20

Fixes: a87295e8df0 and 0e1c9c54afb

> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/m68k/m68k-semi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> index 8e5fbfc..f189c92 100644
> --- a/target/m68k/m68k-semi.c
> +++ b/target/m68k/m68k-semi.c
> @@ -194,8 +194,8 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
>      args =3D env->dregs[1];
>      switch (nr) {
>      case HOSTED_EXIT:
> -        gdb_exit(env, env->dregs[0]);
> -        exit(env->dregs[0]);
> +        gdb_exit(env, env->dregs[1]);
> +        exit(env->dregs[1]);
>      case HOSTED_OPEN:
>          GET_ARG(0);
>          GET_ARG(1);
>=20

