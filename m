Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3EE20709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xl/C5nms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3EE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1Ft-0005mM-S8
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb1F4-0004ui-2V
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:21:06 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb1F2-0002Or-3i
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:21:05 -0400
Received: by mail-oi1-x244.google.com with SMTP id y85so7286232oie.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8/gZGNNUOMV0cNspyJua+QUzz3j0JQh8jq+6Z4+9XIc=;
 b=xl/C5nmsn8hHP41gZxCIkruWmIRYKYMIGB/O2pJclNNg9Bjms3yD5E94NP3Id5qdco
 GPw/Ynq+Fep0xOXtMn1sLFHVXhzxys4yyoPG/b6kwlJow8Bh6cKofVUI40ByKa7GPtZ+
 Pj4TlLl0GyoBfItBXQoMAPCBva6lUpO7qJPVCb49PEvGZUIgivzZxAq1MzG87JAfJ9rQ
 vzIZgKyyuxBSu5SBr9u2FjMW/yGpop/Fby8yw6HZkcv8JC3hf7FZFNyhwA5TmK4XtPP4
 jFkF3rO48HnEDxGpIN5OwlcFHNZfCvKcOG9NkRIeQ3HfoWZtaDybARA8GEKkSqBBmWIb
 987Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8/gZGNNUOMV0cNspyJua+QUzz3j0JQh8jq+6Z4+9XIc=;
 b=PXPCWSjUMaaAmaFx2I7kIK5CxAp+wzhIUY7JlTAiE1z9YhqFqR3qZNr+sVEWt9p2OH
 pTwKTxVPW83C5m4/eeoXPqORWhboyHZXunbOU0YoMIVi5k3eChpHxEwSWU3+Ewmjqoz+
 nVcXLVsLf7Z+NRzKiiJwCMLDiZcg2jtuB5l/FbLSHeZZtZd7DCNNxGXeWDFWKJUyVUmt
 fWYn0LDAL4Dj3Uo+Ybof/biVzvAY6l9tuGEz0/MKYXogHFU9tKmx//tuzRcyeoi7qe+8
 HvPyW3RieyRdPiZRnwjBQ6XzprfBikrEvRfYYpXN83USRT9WL9FcccT8W2op+gYf590G
 q5yA==
X-Gm-Message-State: AOAM531eM8WW1oy6LOwLetq9gCjsckx47jYRJwjM4S4XLtj2y2nec/3g
 cSddb3bFJev63C1Ny86Km4oku/lmn51SEio7+mRhpA==
X-Google-Smtp-Source: ABdhPJx62nq7PczRR5OTY9N7Lsn/a95RAsGm383b2c1f/a8hDbeSIXlAn2Pv9r6UoqPXa+cO48FDwyBRhljHs04F5Bg=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr2711690oih.48.1589890862477; 
 Tue, 19 May 2020 05:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200504101443.3165-1-roger.pau@citrix.com>
 <20200511134043.GH2116@perard.uk.xensource.com>
 <20200519112806.GF54375@Air-de-Roger>
In-Reply-To: <20200519112806.GF54375@Air-de-Roger>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2020 13:20:51 +0100
Message-ID: <CAFEAcA-RWR_6OQV1EgeYj0WmE89FDKqcywTpgfrMyr8FrELN+Q@mail.gmail.com>
Subject: Re: [PATCH] xen: fix build without pci passthrough
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 12:28, Roger Pau Monn=C3=A9 <roger.pau@citrix.com> w=
rote:
>
> On Mon, May 11, 2020 at 02:40:43PM +0100, Anthony PERARD wrote:
> > On Mon, May 04, 2020 at 12:14:43PM +0200, Roger Pau Monne wrote:
> > > diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> > > index 179775db7b..660dd8a008 100644
> > > --- a/hw/xen/xen_pt.h
> > > +++ b/hw/xen/xen_pt.h
> > > @@ -1,6 +1,7 @@
> > >  #ifndef XEN_PT_H
> > >  #define XEN_PT_H
> > >
> > > +#include "qemu/osdep.h"
> >
> > Why do you need osdep?
>
> For CONFIG_XEN_PCI_PASSTHROUGH IIRC.

All .c files should always include osdep as the first include
in the file, and .h files should never include osdep (we note
this in CODING_STYLE.rst).

If you added this #include to fix a compile issue that would
suggest that there's a .c file somewhere that's missing the
mandatory osdep include. I did a quick eyeball of all the files
that include xen_pt.h, though, and none of them are missing the
osdep include. So I think you should be able to simply drop the
osdep include here. If that produces an error, let us know what
fails and we can work out what's gone wrong.

thanks
-- PMM

