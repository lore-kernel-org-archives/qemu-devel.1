Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A408C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86B52184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFDlrX3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86B52184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoVS7-0006nc-SJ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hoVRx-0006OH-UP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hoVRk-0000RW-N7
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:09:30 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830]:33146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hoVRY-0005b6-TW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 12:09:14 -0400
Received: by mail-qt1-x830.google.com with SMTP id r6so27312403qtt.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h8OAZoEIHAU1ADe79uaXhk7KcXM8lExqdw+R4xOLOzo=;
 b=PFDlrX3x63xpJcBKzvT5DoJnaa5Hftan8id2Ca/BJ6z520ESQ1/hyIhpCgJHqk6rhP
 m3ilTY8AEnD/XpEFzz5OEymQcaIDYF28vBj5IUQKQyl4XjHi2RJwj1vA463J5+YOutIv
 /d6UVVdr7Wzk4wdFtw4ItCDIrlOi/h4i03APKCr//a6sDBALKzdNh3eGgjHzCVM3DUh1
 uvwh4/aGftF4gAXRb2b+dxAdE2AWzWCLjQQgvbEM07JHzYYfk2k6n/XYDmpP4rxugg07
 jOwu7lD2KBGXBkFHwpnhb9MRABE47A4U4l8ya/9ZSWw509J9nZxd2vZ0Pc1qzwIAM6le
 8Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h8OAZoEIHAU1ADe79uaXhk7KcXM8lExqdw+R4xOLOzo=;
 b=bMgC539ImfA26jAyfRwyN19WOeMPAM43P1qLepFWXJF4KlX1dz5V5lAVZEOXbXOUVy
 ghWRYE0nolMkQyRRcsuENxInWZW02yjkpyKwwnSQ6kmcEJ4wHUTqykzmAbSvw/wsXHzK
 ZAd4OW+sUTcpeSOGKrktYiun66kjYlCb8gDzhX6jD92jBvorjLoOvzE8UwhI+9+b05fU
 0+hShTh/b7Rmh2XkZuy8nb1WLV4gVGOnDLSmrkKx9Oqz2zfmI+XyzDCJkLGAIkRM5c0U
 OyPh6CXsgBGb3cEkTJEeoe5wFDWYW238VAJFS/IxNZtTSZw0xo0TQsL8AyRwbpM67ERD
 7Ipg==
X-Gm-Message-State: APjAAAW3EHoczHmSQOKi/XA/ew5l0EqtlZ+yfjL2XdRWfuFcucQbcNXW
 FliHomS7gL8OaGaag+gU0sHSXoGBj6VvmwZ3X/o=
X-Google-Smtp-Source: APXvYqzXBiXEQ0P0LBMdp087ekdiERGI42y5+hRFs6zvLfpB5gRl0dcuXoRxXyxuBUdYvmq016KJYB9+zmlOvAWavA8=
X-Received: by 2002:a05:6214:13a1:: with SMTP id
 h1mr36726126qvz.190.1563552283716; 
 Fri, 19 Jul 2019 09:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-8-mrolnik@gmail.com>
 <d144f0f4-1f48-882e-848d-80aabdbdfeef@redhat.com>
In-Reply-To: <d144f0f4-1f48-882e-848d-80aabdbdfeef@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 19 Jul 2019 19:04:30 +0300
Message-ID: <CAK4993h9ZqDENs6ORuGF8=X=v06FhgcLWdNz8WvrhrKo0MZjcA@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::830
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v27 7/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You're right.
I did not know what next release was going to be. So I did not change it

Sent from my cell phone, please ignore typos

On Fri, Jul 19, 2019, 6:43 PM Eric Blake <eblake@redhat.com> wrote:

> On 7/19/19 3:26 AM, Michael Rolnik wrote:
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
>
> > +++ b/qapi/common.json
> > @@ -183,11 +183,12 @@
> >  #        is true even for "qemu-system-x86_64".
> >  #
> >  # ppcemb: dropped in 3.1
> > +# avr: added in 4.1
>
> Are you trying to get this into 4.1?  rc2 is awfully late to be
> introducing a new target. I suspect this should be 4.2.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
