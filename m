Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D07DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D8220722
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jtau3XcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D8220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ddQ-0001aN-F7
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2dcb-0000uy-Dv
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:47:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2dcZ-0007zi-P4
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 12:47:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id 93so18235767otx.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Usm/6h7N16x/wxM5TKQj5tj8P/i4BtTOOcp5csWYt4E=;
 b=Jtau3XcM89LL3xC7TEe3GAnS7qK4+9cw0OpAxEnX7eHGqhKSVKHxv0ZFe1n4UocDiA
 mW0JPWncTOEo2yO35nkxh4aFn+zGw2+aA4W/ReCP+h2fpz95V0mGkSoe9+AGG6RNt4ch
 Jwreu92lFF2+ySGmCXMOAecee4CVLUmQkNR1yDr1NqMMb3Fg6XX4+bmy2fH+dTx1wY+v
 TzPBygU05qkqPaKHH/lHj1kz20jXTapGgQ0iNov7HTY+sv7HLw7LbiCaMPlXdU4dPNK+
 ZloEswYISPKAZjCx7GJJBFVR6+KTg8gK9eNt3s8ELOQq+2DbPNembJz0OX6ZR/Lit81t
 zS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Usm/6h7N16x/wxM5TKQj5tj8P/i4BtTOOcp5csWYt4E=;
 b=QkrXmZQWRQJZQ56qHXYnnbm22IVEZ1JzypT0dqSFRC+cVtt/np5B7nN5AlSgWavUT1
 nXeFQPicbimtUMIAl7xy+N0XifDUeX1Uh6gdTwmK7MUZcV8na9R0lyl+glrMCRjViiOG
 cPxIaIAavV/6Q0Uyq+Ty/CHTMPNQcxUccjoOfQ/Wq3d8VRl5pEoHzUmWE/9llHojQVAO
 +ylxs3ECxeTsRG9YezOR+LGtMtvoV6YXnnYxD8BS9YSoc4E9DlvgimSfHemVP7NGQ/Vv
 pp79JGDSPljtaEeMK9vqcbASpAQFAJmZ94PRApfGLbmSeM3jJg5rHQwA6dC6gVcLTjg7
 KZIg==
X-Gm-Message-State: AOAM531Y4bAsC6XvrHz4dqO8ZK7siQVDCaSnzk4awUrDQ9F7aaLtsD68
 d+K2sWCla2PycQ1R0LB775VsO8Wghhr4tJPx509KMw==
X-Google-Smtp-Source: ABdhPJwL8bSuuMVu8QUpkQn41wKe+w9UJyQ8uUsj7OLcjzkDx+JlDczU0zS8LbPssRy+Hp1/anGlBwmjDitZlITg0E4=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr14280078otb.91.1596473250307; 
 Mon, 03 Aug 2020 09:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200728100925.10454-1-philmd@redhat.com>
 <20200803163515.GD2866@perard.uk.xensource.com>
In-Reply-To: <20200803163515.GD2866@perard.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 17:47:19 +0100
Message-ID: <CAFEAcA9a-7uXwS2TcCH7nNGb0QAPaBu5sA=Ncox4c+6yMxe61Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Aug 2020 at 17:35, Anthony PERARD <anthony.perard@citrix.com> wro=
te:
>
> On Tue, Jul 28, 2020 at 12:09:25PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > CONFIG_XEN is generated by configure and stored in "config-target.h",
> > which is (obviously) only include for target-specific objects.
> > This is a problem for target-agnostic objects as CONFIG_XEN is never
> > defined and xen_enabled() is always inlined as 'false'.
> >
> > Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
> > when we don't know to force the call of the non-inlined function,
> > returning the xen_allowed boolean.
> >
> > Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/=
")
> > Reported-by: Paul Durrant <pdurrant@amazon.com>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Note that rc3 is tomorrow so if you want this in 5.1 it would
be a good idea to send a pullreq with it today...

thanks
-- PMM

