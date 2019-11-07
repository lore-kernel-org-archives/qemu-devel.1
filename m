Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D857C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC14B2166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saqnnNhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC14B2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSk2k-00047O-4e
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSk22-0003g6-HW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSk21-0004IA-Fc
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:49:10 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:39604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSk21-0004Hv-Bo
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:49:09 -0500
Received: by mail-qt1-x844.google.com with SMTP id t8so2870944qtc.6
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oc9io1Tl+gFZlmOfwh8oIoECu8AFwovcAehA+mL4JG8=;
 b=saqnnNhs46Y5xElpP25GKU298zmHqet1zya24RITXJeKqt6mkZXkHk1/kdPbcWr7ZP
 dQiTgHsOs5nD+/C67IB9i4510AQbXII8yQIDK60jKDNuiHLtwBeqstI+noxgfQeyUoWZ
 rMehIxbU6SD47pVCqFZDxvjfsQ/GLlSnHDJ9Lq/a6CFO+mZ9F9tfn+9CyQaEFSKi+i0p
 iiPmOeR9+EPAeAh06nZRozwQgb2L0t+cx9xwMKDAyR4lAYGWejWwdIpjR4ZidMDSKQSA
 XB8lyL6I4Dy6jR3+FCApc2ie2Y9tMk0/5MN00vKQCQ108YQIpedhU9FXX0sKsAJoHSVm
 A9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oc9io1Tl+gFZlmOfwh8oIoECu8AFwovcAehA+mL4JG8=;
 b=GHZ3tjc6O0yYzC4pLkEMCh8hGUcn+mbf92PA/gSEJjXtQo1CrG0nMjJVJ+8cXY+I5D
 t1Fwz8PLSNEpG+XIAAGds1fSKcyxn1fxxN3hxTwrnabjJ8KD6gG8NLwWShXo+x9QTQ8m
 o8j2N0vc3fHc0Jaq2OFmu6Nj1dbxwUKZbSujfm1H6GNiyaJqmD9/Vy/Twsoz3HsNsz0v
 kbH/4g3OfsnH4tRhWUmUryPZ/ArUmDToNczBcXKIKSnqWNdJuCCnTPUXi6nTEMbhA7E+
 WG2D5tcWd/KzUFw/S1zx5b1Bvnoyz6fPKpfrY29MokI2FpDg4HD//WgdY/ztu5H4k0dy
 dr+w==
X-Gm-Message-State: APjAAAXFJ5kJMNY0Pd04UcbRRaBZvdSXUfYIV8ObMXVqBVpTN8nLkA30
 Q9mbuEu8Ge9r+zJ2m95OCgT2SSg/8GekcsCIl2A=
X-Google-Smtp-Source: APXvYqz3LtHk2A/5wJjI7S5A/ezRgA8UzWhv/olUK2arsdZ4wltkdJfVDCdk3QhnILgpuzCFjVably9W8UyNN+MX8Ts=
X-Received: by 2002:ac8:7685:: with SMTP id g5mr4158804qtr.213.1573141748642; 
 Thu, 07 Nov 2019 07:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20191107091136.359965-1-stefanha@redhat.com>
 <1233611027.10012683.1573119684999.JavaMail.zimbra@redhat.com>
In-Reply-To: <1233611027.10012683.1573119684999.JavaMail.zimbra@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Nov 2019 16:48:57 +0100
Message-ID: <CAJSP0QVMCyYND7GrhUUCF_c9XOd=2ODRdV_s_K=afJ96XMz=pA@mail.gmail.com>
Subject: Re: [qemu-web PATCH] Add device fuzzing blog post
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Manuel Egele <megele@bu.edu>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander Oleinik <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 7, 2019 at 10:43 AM Thomas Huth <thuth@redhat.com> wrote:
>
> ----- Original Message -----
> > From: "Stefan Hajnoczi" <stefanha@redhat.com>
> > Sent: Thursday, November 7, 2019 10:11:36 AM
> >
> > This blog post covers the device fuzzing GSoC project that Alexander
> > Olenik did in 2019.
> [...]
> > +This article was contributed by Stefan Hajnoczi and Alexander Oleinik.
>
> You could also use the "author:" field in the header for this.
>
> > diff --git a/screenshots/fuzzing-intro.png b/screenshots/fuzzing-intro.png
> > new file mode 100644
> > index 0000000..e130027
> > Binary files /dev/null and b/screenshots/fuzzing-intro.png differ
> > diff --git a/screenshots/fuzzing.png b/screenshots/fuzzing.png
> > new file mode 100644
> > index 0000000..2f15ecb
> > Binary files /dev/null and b/screenshots/fuzzing.png differ
>
> Seems like the images are missing ... can you please attach them?

The commit is available with .png files here:
https://github.com/stefanha/qemu-web/commit/49efe1b254460a92c6348e1981caf3e1320782f8

I moved the authorship information into the author: field.

Thanks,
Stefan

