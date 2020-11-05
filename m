Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252ACC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 01:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0AD20719
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 01:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkmJ0ylo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0AD20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaUX9-0004pi-1t
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 20:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kaUWI-0004Oc-2R
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 20:56:58 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kaUWF-0004Ih-4a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 20:56:57 -0500
Received: by mail-lj1-x242.google.com with SMTP id y16so571222ljk.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kJ+H3u59usMaBdqYMyKqe9IstrloInZQB28l4DF2x4k=;
 b=tkmJ0ylod3GZA2WtFG3y8vuhI2jFA2pV6Rh/G2BensCGx8Iu0wBz5uiZQB7BT70+dQ
 2TW5O374nKiLn8hB/kmrL/ox/RSO/3oTZZz3WRV8GuKaw+g6oi+HrR2+QxjQcgPX/BpF
 FGBuC47wiac1eNj4ABFB2KIo7p4zlYICxQ+jVZGwUGgE9F9VLqARbIW1zTMgz2Re1Ux9
 pLxMrizhgFgCC+qOO2TS7vxcWVd5LjpFAR5/XgYyf7vy3eo8lZQtufxSIXrgDk/amKAt
 Qn5C52lBUIaPiy4Q7WwAajEvWF85n+5SK7N+CPSMg4DQiWxnMCONVG2DflDDKkp8bR+M
 kagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kJ+H3u59usMaBdqYMyKqe9IstrloInZQB28l4DF2x4k=;
 b=dkUf7yT6ti6+nOmMyLXL2IVjZB0pN1dJf/4NdSLGAesFg2F1NMnT8bCpTuC09vt7q5
 SMkIB279iAfOn6MjbZILq/H4Pyn/wUxPTfFYLxQwRJMIoOacJPkRYCWRdbZlSwLCsPZ1
 dIq9IOd4WGJEJLclKihC4ro+OrPv13b713Bdmk+JOSAz9ah3+2qAuUVX2m0zBT2mxDur
 Wi9QBT2F+v0gAAvvEILtBsTrDwlzZ5GkKFYz0NbUhNvDAkreJliHLYM9K1eX9iMo8HBP
 fWSezLh8UbASgi89+tMmk/hTv/6FWoypBV2pj1aVe8oldPnXL4j22hJYDRLYN0ZdJaQn
 vEbw==
X-Gm-Message-State: AOAM531ZUQZ0Y4VcPRtsIeoRhgz/1MvsXe0SehA9MTJIcUbPkPTZCh1x
 XJjvk/uSXrLmFZFWHtgjYOefJDjxn0FQv1wJC8w=
X-Google-Smtp-Source: ABdhPJzl5rkG7SrXu6UcdzkO8gSaVEV19miO3zLCBVmljeIOkDkfFI8LzP5ajmnatGhcp0xYRBb0x3Q6N6BVRTCZYUs=
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr23810ljo.34.1604541412133; 
 Wed, 04 Nov 2020 17:56:52 -0800 (PST)
MIME-Version: 1.0
References: <5FA12391.8090400@huawei.com>
 <a4915556-bc78-a8c4-c887-f53ed14251b6@amsat.org>
 <02FD0B38-19BC-442F-9DAB-1B56BB8115B0@flygoat.com>
 <1c3e1462-fdbf-5e2e-6664-28e3ea44b609@amsat.org>
 <CABDp7VrEa7hD0hXu-T4iAyVF2vvn_WRg8LiAHrd6wTor7Qt5wQ@mail.gmail.com>
In-Reply-To: <CABDp7VrEa7hD0hXu-T4iAyVF2vvn_WRg8LiAHrd6wTor7Qt5wQ@mail.gmail.com>
From: chen huacai <zltjiangshi@gmail.com>
Date: Thu, 5 Nov 2020 09:56:40 +0800
Message-ID: <CABDp7VoBTbcftKhvk4ch_2sxGEh4Fnw1dQdzMsFsDHUkEUn0uQ@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhengchuan@huawei.com, zhang.zhanghailiang@huawei.com,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 AlexChen <alex.chen@huawei.com>, Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Nov 4, 2020 at 12:17 PM chen huacai <zltjiangshi@gmail.com> wrote:
>
> Hi, Philippe and Jiaxun,
>
> On Wed, Nov 4, 2020 at 1:17 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >
> > On 11/3/20 4:40 PM, Jiaxun Yang wrote:
> > > =E4=BA=8E 2020=E5=B9=B411=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=888:28:27, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> =E5=86=99=E5=
=88=B0:
> > >> On 11/3/20 10:32 AM, AlexChen wrote:
> > >>> According to the loongson spec
> > >>> (http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_u=
ser_1.pdf)
> > >>> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x))=
, we know
> > >>> that the ISR size of per CORE is 8, so here we need to divide
> > >>> (addr - R_PERCORE_ISR(0)) by 8, not 4.
> > >>>
> > >>> Reported-by: Euler Robot <euler.robot@huawei.com>
> > >>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> > >>> ---
> > >>>  hw/intc/loongson_liointc.c | 4 ++--
> > >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> For a model added in 2020, its code style is a bit
> > >> disappointing (leading to that kind of hidden bugs).
> > >> I'm even surprised it passed the review process.
> > >>
> > >> Thanks for the fix.
> > >>
> > >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > >
> > > It was my proof of concept code.
> >
> > Don't worry Jiaxun, this comment is not to you, but to
> > the QEMU community as a whole. We should have asked
> > improvements during review, and explain what could be
> > improve, what is not the best style but acceptable,
> > and what is good.
> >
> > > Any suggestions on enhancement?
> > > I'll have some free time afterwards so probably can do something.
> >
> > It is a bit awkward to not comment on a patch (diff).
> > Comment I'd have made:
> >
> > - Add definition for 0x8 magic value in R_PERCORE_ISR()
> > - Replace R_PERCORE_ISR() macro my function
> > - Replace dead D() code by trace events
> > - Use a simple 32-bit implementation (pic_ops.impl.min/max =3D 4)
> >   to let the generic memory code deal with the 8-bit accesses
> >   to mapper[].
I have reworked, but I haven't take the last suggestion (Use a simple
32-bit implementation). Because the mapper[] are naturely accessed in
8-bit, if use 32-bit implementation, the data type of mapper[] should
also be changed, which looks very strange.

Huacai
> >
> > If you have time, today what would be more useful is to have
> > tests for the Loongson-3 board.
> As you suggested, LOONGSON_LIOINTC will be used in loongson3_virt.c
> and it is defined in a .c file now, so this is a chance for me to
> rework liointc.
>
> Huacai
> >
> > You can see some examples with the Malta board in the repository:
> >
> > $ git-grep malta tests/acceptance/
> >
> > Regards,
> >
> > Phil.
> >
>
>
> --
> Huacai Chen



--=20
Huacai Chen

