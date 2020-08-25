Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF4CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA502072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAkxpcJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA502072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAa61-0007kA-Gl
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1kAa54-0006tC-E3; Tue, 25 Aug 2020 10:37:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <erik.lucas.smit@gmail.com>)
 id 1kAa52-00068I-E7; Tue, 25 Aug 2020 10:37:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id f42so5444863otf.13;
 Tue, 25 Aug 2020 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lw6Pxd03BF3GKZkDED5dFIfpW7t361Uyoul6qaBpfak=;
 b=YAkxpcJ0GhsIJthpiprBM+4q7ZjFcPvP8FucY4JHQzPrJeHbhvSOjBAt9a0wahnJeP
 fKMyTVW1Snb1olfHRV3f5HHhRy96uQodmd/xibWvSxKaiPuA/gJpQOAv5+08oFWRvfS2
 QcFAFpluQU2lyw0YnsTVgjeqBp+PvdpoLctpQZDV9oAxcA0lVDTlDaaa2yBSI+QYop9Z
 u8UXNDEbhz0FHZhfe/LZV7Bd7TrP+553j3cyMWdVl5LAZOSxeOEnwjuzOJ11MwgwZK4j
 gFgLnkwN7WT3XYf69WM5SETVywoil4l8w8b2kH0CwtnEIKw/zKtQOhOXAGuiPqcWO+sG
 0K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lw6Pxd03BF3GKZkDED5dFIfpW7t361Uyoul6qaBpfak=;
 b=DdTHU7/AQKhJzECRhWQqXxjoK0h2+W4nMR6fFCMtoMictgPzbDOf++GIFBLvQ7AOBZ
 NLkCvSwTwYW60bOIjyo0/L04qbWiYIPZafH6nz2NUDRDHa2yPnMGXjd2TpN8qexvrPcj
 yc27XkGPTk/qA6e/YwQnevJCi1IAky12sSnX+z8Afq2U1qxNTj3bR3IyVrewHkiH0DqZ
 sMAkrgddxikc2oQAM+GtwoVEgbEYJ/Ubb091Fp5Ir8AgxpLbWUiQM9YmFmbzWHPxRIEf
 jOTxiI1h75N1hqslrkRAXs7RDDh78ZbVGCxoqtAfxfV56kJmNQsTPYrn4cJYnGeNxHr0
 y7Gg==
X-Gm-Message-State: AOAM530BMmNv2k4Tsop33qdLcP1r48GPGyUTaEA3rRQpQFDPBNbvztZe
 47FgUTSEjWE2UBTNMOX7lYz/yRE9sRXrJgNXBMU=
X-Google-Smtp-Source: ABdhPJwSTjSRUAeQ6lQYqQ+el7dPn3154clgpMWMBQz+RjZoG3f8VLzPOmC9NLFPDOvTO2/sNavmvHPypkbefU/ZCe4=
X-Received: by 2002:a05:6830:2143:: with SMTP id
 r3mr7349255otd.78.1598366262520; 
 Tue, 25 Aug 2020 07:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200819100956.2216690-1-clg@kaod.org>
 <20200819100956.2216690-6-clg@kaod.org>
 <CAFEAcA_GwY5qqLFYcttobLRnt_b=HoMNHMXEZrDHyRZJ4mjGug@mail.gmail.com>
In-Reply-To: <CAFEAcA_GwY5qqLFYcttobLRnt_b=HoMNHMXEZrDHyRZJ4mjGug@mail.gmail.com>
From: Erik Smit <erik.lucas.smit@gmail.com>
Date: Tue, 25 Aug 2020 16:37:31 +0200
Message-ID: <CA+MHfou4eE3wYCMv4ojLSnnUeffKy73V6FhpaBC551bsfkqa+A@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] hw/arm/aspeed: Add board model for Supermicro
 X11 BMC
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004c719e05adb4a5e9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=erik.lucas.smit@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004c719e05adb4a5e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020, 4:33 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 19 Aug 2020 at 11:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > From: erik-smit <erik.lucas.smit@gmail.com>
> >
> > The BMC Firmware can be downloaded from :
> >
> >   https://www.supermicro.com/en/products/motherboard/X11SSL-F
> >
> > Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
>
> Should the name in the From and Signed-off-by: here be
> "Erik Smit" rather than "erik-smit" ?
>

I don't know if it matters. I'm fine with either.

--=20
Erik Smit

>

--0000000000004c719e05adb4a5e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Aug 25, 2020, 4:33 PM Peter Maydell &lt;<a hre=
f=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On Wed, 19 Aug 2020 at 11:10, C=
=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_blank" =
rel=3D"noreferrer">clg@kaod.org</a>&gt; wrote:<br>
&gt;<br>
&gt; From: erik-smit &lt;<a href=3D"mailto:erik.lucas.smit@gmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">erik.lucas.smit@gmail.com</a>&gt;<br>
&gt;<br>
&gt; The BMC Firmware can be downloaded from :<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://www.supermicro.com/en/products/motherbo=
ard/X11SSL-F" rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.s=
upermicro.com/en/products/motherboard/X11SSL-F</a><br>
&gt;<br>
&gt; Signed-off-by: erik-smit &lt;<a href=3D"mailto:erik.lucas.smit@gmail.c=
om" target=3D"_blank" rel=3D"noreferrer">erik.lucas.smit@gmail.com</a>&gt;<=
br>
<br>
Should the name in the From and Signed-off-by: here be<br>
&quot;Erik Smit&quot; rather than &quot;erik-smit&quot; ?<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t know i=
f it matters. I&#39;m fine with either.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">--=C2=A0</div><div dir=3D"auto">Erik Smit</div><div dir=3D"=
auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000004c719e05adb4a5e9--

