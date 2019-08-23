Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E376DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9183233A0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 10:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnWwQKTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9183233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i16S9-00049Z-NN
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i16RB-00030a-50
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i16R8-0005yO-M0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:04:52 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i16R8-0005xp-20
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 06:04:50 -0400
Received: by mail-oi1-x242.google.com with SMTP id k22so6585348oiw.11
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Ld2g1ANzaJ3BU0IMsM805CAgEjfWCCaeApEnc2U2yRY=;
 b=fnWwQKTkMVaFR7tZ2IycSSQ63AFBTpEeOpZuLud/eGqv8u8Z+tFP2TlrkicnQV/6Pt
 CwzSGw0gaOaBDp8/xuxocq9ydi8XUik7n37cFvKfnHi2Kz6ux0wa4LGWrJ975PXxND7q
 2i9NGh68RFKUDod99F9dQnTQipE+xuvtzcQJ0mQPBtvoTPLocuNjJWDBhwZuVHM9Up0O
 OYvdOpID/XVwRgoDLK06hUPeDZAml+3r0Z8R0VwS5gmtowT/Vz5JKRAfvRhWweUh1Liu
 WHondQy/sh5Wqzh62bk3XaU1d4usAxXjX0ykw5E5U4dpfNr+pidr3eSxpTU7+nnk5l0T
 WKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Ld2g1ANzaJ3BU0IMsM805CAgEjfWCCaeApEnc2U2yRY=;
 b=CkzipxZjc3JXLmueVs0JS0hAjSKU17HLz5x4Rf6wCUpoeJ6ZTk2AWAQJVNV4f74X7o
 CY84SU8GX84pDN+wI8yxiMz4Q+uXfIsyE/rgk6ftwLqo9XSS7BOLMVLejwK2ELK4/Lsk
 1jGrY/Hn/1cWKoQuvp3djPgrfUvg6pNTqjPRG24IHAz+mJo0V6uIREI/YGCQ/JFJxCDp
 lJNHc/Eg/cbnE4osTIBCOcXdAbnHG2pDIb892NbgXiWw5UVtek/aIaqgEhRtFhsXUqh7
 ykOYQJq/vn5kv0tgZZZiaG8JQhKa9X+0yP0Ij/3sdThMVGEmpNyX0qE+JWfAyth1HSSy
 4+Tg==
X-Gm-Message-State: APjAAAX3e6/u9QW6uxMzp8zT0F8WFMSqR7mxns9CY37UuyFQe2ATwp5U
 fXZq2Kc7KRXptycCxPNsqm9q/kyKD6tEVEhtJmg=
X-Google-Smtp-Source: APXvYqwacFkbrJ1ELLwHKSmHIM9htYqLLP23nk6vr0naMPPj6tFZBkuJohANfsOj+JDyYkSmg8MH8l9bcTibm8fV4Jk=
X-Received: by 2002:a05:6808:198:: with SMTP id
 w24mr2503658oic.53.1566554689288; 
 Fri, 23 Aug 2019 03:04:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 03:04:48
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 03:04:48
 -0700 (PDT)
In-Reply-To: <20190822231443.172099-1-scw@google.com>
References: <20190822231443.172099-1-scw@google.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 23 Aug 2019 12:04:48 +0200
Message-ID: <CAL1e-=jKTWdSn37CNZFMz2=KGrxWC+2UGur2GrPhG6ErMjx8WQ@mail.gmail.com>
To: Shu-Chun Weng <scw@google.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/2] Adding some setsockopt() options
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019. 01.15, "Shu-Chun Weng via Qemu-devel" <qemu-devel@nongnu.org>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Shu-Chun Weng (2):
>   linux-user: add missing UDP and IPv6 setsockopt options
>   linux-user: time stamping options for setsockopt()
>
>  linux-user/generic/sockbits.h |  4 ++++
>  linux-user/mips/sockbits.h    |  4 ++++
>  linux-user/syscall.c          | 16 +++++++++++++---
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> --

Very good! Great news! This may solve some package building problems for
Debian (using chroot).

May I suggest to you collecting all your outstanding linux user patches
into a single series? That way the reviews would be easier and also the
risk of forgetting some patch would be smaller.

=E8=AC=9D=E8=AC=9D !

Aleksandar

> 2.23.0.187.g17f5b7556c-goog
>
>
