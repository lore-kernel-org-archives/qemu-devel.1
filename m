Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F47C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA1222264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Und6fJSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1222264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZycA-0003Lv-KC
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZybL-0001s8-Jd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:52:03 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:45110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZybJ-0007tn-W5
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:52:03 -0500
Received: by mail-io1-xd29.google.com with SMTP id u21so8345306iol.12
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x0MLqSa/yG1P3OVA4XaUY3T2kxf5qkA2kMTvr9yPv4k=;
 b=Und6fJSldMtBerlJOgSJOu9HbKkZJ15H6BsxE9HmLe5zd9udk+FQpAzAuyLKXiV851
 M6es/N8j8Geohhj5+iD5tKhXaBdQh54AOkqGtqSnfbLe45gzmAkrGkGdGyB6mNYtnsYV
 yIFSfLY+iyMTzv52i1szT0dFYbkZ7ifpqUoO30mwirKW096HyYhW4qhhbcEHPrZnT7gi
 ZGXkev7T4t3+MKXTekdnMN1Zyo6PZgqSPrUGXcvVk0ExtKEYPDrvPIBB8RWNWm7AP2RU
 IKteH0qzAjh/5wcKBmH3VDwHjAur+LLNuciFWbyZHkL9Ycp2vCZNWQ080HAztL+I3MhI
 qaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x0MLqSa/yG1P3OVA4XaUY3T2kxf5qkA2kMTvr9yPv4k=;
 b=VPfzVfNDuTu0wlg3Wp/3pLsSTGVFss60/6r03Taf7SsA4eG5ox9Jfb+Vddfn+bE2In
 26TjVDMqET/o6ZzxNL/GLQqaB3ISphuEHvMnwPQYlv9xszefGqOBdjEyqG+JpA6sSD+O
 QEfhBQBIrgJeIh0vxtsF31kxiKD7LA8/g6Kb/Qg3VKRsXchYIdG3uDOwl21UVFZBU19d
 9fUz6KosaDVqEYFlyOfOUiJKcEozZSbnRVUt+2p1qOQdH2tL40GmBiZJJYqR3nbfyF3j
 rRFE3XcvIdTkVH/X6L1SUKIJcxJvZfjYkUnUBlC6DRDzImolWybYLC6DDUkD28insyWO
 IgDQ==
X-Gm-Message-State: AOAM530yYyY+yiHoKj6VgsorE7W9o1VNeJUFRXA7ysV7TxcX5QQby8Pg
 TjeiN1nYPn3wQWexIZ5lLq8KsxWVcw2vhujRSu9wO6b7fxw=
X-Google-Smtp-Source: ABdhPJzFYT9/669jVrml6Pdvz1Je+FMrMFGgXzX40tkUuJ2ztu27XLV3zW4vAmlsPggvFBxcoHHp4IdtWLao0t4GEQU=
X-Received: by 2002:a05:6602:2d4e:: with SMTP id
 d14mr14987437iow.105.1604418721027; 
 Tue, 03 Nov 2020 07:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20200330102945.2388294-1-laurent@vivier.eu>
 <20200330102945.2388294-2-laurent@vivier.eu>
 <CAFEAcA97s+jiZxH+ObdFeFgs7-Wub6XjZvJFmL2s4voRrny38Q@mail.gmail.com>
 <a1fd7792-b7fa-6e86-4a24-b53fb7ecac0f@vivier.eu>
In-Reply-To: <a1fd7792-b7fa-6e86-4a24-b53fb7ecac0f@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Nov 2020 07:40:04 -0800
Message-ID: <CAKmqyKN81bBXtJei7ch3CFLqjsnyiVfZOmYuTEL68a=i7JNPOQ@mail.gmail.com>
Subject: Re: [PULL 1/1] linux-user: Support futex_time64
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 2, 2020 at 11:29 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 02/11/2020 =C3=A0 19:15, Peter Maydell a =C3=A9crit :
> > On Mon, 30 Mar 2020 at 11:31, Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> From: Alistair Francis <alistair.francis@wdc.com>
> >>
> >> Add support for host and target futex_time64. If futex_time64 exists o=
n
> >> the host we try that first before falling back to the standard futex
> >> syscall.
> >
> > Hi; I dunno why Coverity's only just noticed this, but in
> > CID 1432339 it points out:
> >
> >> +#if defined(TARGET_NR_futex_time64)
> >> +static int do_futex_time64(target_ulong uaddr, int op, int val, targe=
t_ulong timeout,
> >> +                           target_ulong uaddr2, int val3)
> >> +{
> >> +    struct timespec ts, *pts;
> >> +    int base_op;
> >> +
> >> +    /* ??? We assume FUTEX_* constants are the same on both host
> >> +       and target.  */
> >> +#ifdef FUTEX_CMD_MASK
> >> +    base_op =3D op & FUTEX_CMD_MASK;
> >> +#else
> >> +    base_op =3D op;
> >> +#endif
> >> +    switch (base_op) {
> >> +    case FUTEX_WAIT:
> >> +    case FUTEX_WAIT_BITSET:
> >> +        if (timeout) {
> >> +            pts =3D &ts;
> >> +            target_to_host_timespec64(pts, timeout);
> >
> > ...that here we call target_to_host_timespec64(), which can
> > fail with -TARGET_EFAULT, but (unlike all the other times we call
> > the function) we aren't checking its return value.
> > Is there missing error handling code here ?
> >
>
> I think the code is like that because this is a cut&paste of function
> do_futex() witl "s/timespec/timespec64/".
>
> And yes I think we should check for the return value.
> I'm going to fix that.

Thanks! Let me know if you want me to do it and I can send a patch instead.

Alistair

>
> Thanks,
> Laurent
>

