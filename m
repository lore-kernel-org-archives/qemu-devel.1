Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B12C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBEF20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9KAnf00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBEF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnT7t-0007TE-Dd
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 16:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jnT6M-00062K-T3; Mon, 22 Jun 2020 16:31:35 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jnT6L-0001x1-Be; Mon, 22 Jun 2020 16:31:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id v13so14288198otp.4;
 Mon, 22 Jun 2020 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=ULNJdP/LxY7hBn2xJoed3jrUlm4v/XHqomeLIfjzmI8=;
 b=D9KAnf00Eo18+1V2xCq8Vf8ajMvyKsEVuJo3BAb/GXyiWVYy39F82VuI7lCl43iSw2
 kT/auQtBmosgu+C7AIZ7xlCeSCDZH4PAHDPrl1rSYhV2FVnZOWvCOC0YYdBW1a9+53Ft
 tsDsEowA0Sim0DHYYqtRpCX/UjUKqGUxCVzfnKpyvmRBJI5P8wXwagxOAA9dMgBBBLx+
 N7RZdsz+mnHS9r58eyoyzysAqF0kLecMXCPNFzZtgwBvgZ0GPrJS6Wa/vKpX94HEPiul
 8QsIwNqTihYrecGNTKnNhO29n5JDMdI5pGEJF93AJ0nrAr+d8dxYhnUZe+5u8vyUmhpR
 fWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=ULNJdP/LxY7hBn2xJoed3jrUlm4v/XHqomeLIfjzmI8=;
 b=iUn0LiMu8F6y86eoz+zkDKM4mwx/7YIpN1Jc2xHclwA6fkvs5wUSD2thrqBUuEphJS
 RoeTH84ZvkbpoollG4r8zk/kv9xnrsPussOtGXB9R7rQRX0O2fNQYDOxwZ3MFQebJNzM
 m213009h+yFwu2lq3qKX9HVJCXdleEm8jACuq9aQdoKEJ8iZjb+w64YcFMs4mFG8q3C3
 Fq1VsTYhLis9LQOKanFNBcJinnmXvWkVp6QdqJn525ap3wpFY6o7AzkJLwDEe7B5/0ic
 0R762Pk2T+6zATT6E54L4vcnzLABqrxmMyYbi2b0LxUCxj1lyQDqe+NtyXRN/MC94YJQ
 UiKQ==
X-Gm-Message-State: AOAM533FB1AXZE1czRl6Wdb/9icCfQvQ34y16zgDXnJKriWnDeUhl6qu
 IsTEnyXSOZaPk8qbEb2Jwp0=
X-Google-Smtp-Source: ABdhPJxK837d3uXpvD8a94YdxJYAvEbBDlnM2R6TfPIKh1x//M+TOsNf4tkgxBy5ON0Np2GeamMKiA==
X-Received: by 2002:a9d:6052:: with SMTP id v18mr16085636otj.65.1592857891455; 
 Mon, 22 Jun 2020 13:31:31 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c129sm3477423oif.53.2020.06.22.13.31.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Jun 2020 13:31:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Finn Thain <fthain@telegraphics.com.au>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <alpine.LNX.2.22.394.2006201332390.9@nippy.intranet>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
 <alpine.LNX.2.22.394.2006201012590.23@nippy.intranet>
 <alpine.LNX.2.22.394.2006201332390.9@nippy.intranet>
Message-ID: <159285788272.15440.3321202874853204008@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/78] Patch Round-up for stable 4.2.1,
 freeze on 2020-06-22
Date: Mon, 22 Jun 2020 15:31:22 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Finn Thain (2020-06-19 22:39:41)
> On Sat, 20 Jun 2020, Finn Thain wrote:
> =

> > =

> > Thanks for picking these fixes. When the maintainer originally merged t=
his =

> > series of patches, the first patch got slightly damaged. This was remed=
ied =

> > in a subsequent patch[1]. That is, mainline commit a0cf4297d6 ("dp8393x=
: =

> > Mask EOL bit from descriptor addresses, take 2"). Would you also pick t=
hat =

> > commit for v4.2.1 please?
> > =

> > [1]
> > https://lore.kernel.org/qemu-devel/23179263-a8fb-57cc-e98a-bfe9a2ee9037=
@vivier.eu/
> > =

> =

> While we're on the subject of cherry-picking fixes for fixes, you may als=
o =

> want to consider c264e5d2f9f5d73977eac8e5d084f727b3d07ea9. I didn't find =

> any fixes for fixes for fixes. That search probably needs to be =

> automated...

Thanks for the catch/suggestion. I've added a script to the process to help
find follow-up fixes, but it still needs to be run manually. Some sort of g=
it
integration would probably be a good next step.

