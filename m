Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC506C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FCF206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ef6TE1MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FCF206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCoux-0004BS-LW
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1kCot0-0002Ip-J0
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:50:34 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130]:45285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1kCosy-0008W6-0o
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:50:34 -0400
Received: by mail-il1-x130.google.com with SMTP id q6so1685718ild.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7MUXZC+mXIJp+jIPw0KzkHr23yG7+1R5ua9TjhMwqb0=;
 b=Ef6TE1MJVsCbjcmxnR2UgtfbYZw8ib6XFNlplAuJ/iioz+KJrV3p9C610fgRN0ijvz
 0eY/DfkKFYbNiww0yglQ32uyyb2iXQJp/xpvFd6wAhnYP42o10MtUXMyF/kmTr3rW6Wj
 CrvzJe3w3Gg2Gj/at9AA5m71BPaUnEvqeqFWZeMohsXtH8xyaZxxa517Paq2EQOWTjst
 CjmzxmjTD9t2NUD4hCLA9CWDf8JjUuHHrCwiDTHBdPgW/B/3CpvzIdToCMIZUB0BbyHd
 LtlEBKgTbf9t0S+JSwxQjhJtWBjUe9KxSYibzw38pFj55NPxbomlIVX85hyUbcBXffp1
 nndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7MUXZC+mXIJp+jIPw0KzkHr23yG7+1R5ua9TjhMwqb0=;
 b=uiyLK2I6mBNghGeJ5sJHehQZKfdBi7AvwWqmIPCzTbC2ptATabvaZfbBJQ4AebCWlY
 7VVb+OsFgkfIYAHWLHL0vYm4Wt23f4l3R6pddhKaSdQtRbokhBZZ09cOqR5XhNIHxI/p
 S22Al2Zp+OoJ9VjvVkW4poNbkRJ/LBsTecU9PqGClcHF2WDJCycWk4KLG3x5ILT41Sq9
 dGIBVqCmj+MYWyhFU+wgevMw9OokfHtEyK+jz1SQzIuGnmtAQYVvLE/IrUHrr5qeRfuG
 skqQPweZr4QO5vr1fI9aW6RK52uPoT7n9CVw7EcYlOWc0ioRYwz0ugrsU7m+JzQJ3jfT
 c12A==
X-Gm-Message-State: AOAM530d/RDqv33Zn4FDe/yXDNYVJ8dgNINpNvpd9DnPqgiOI97mDpEI
 yjzuV0cnGSHsSGVnMLiYFjbKeIvXhm15fMoZEoI65w==
X-Google-Smtp-Source: ABdhPJz3H82KNXgLh681T0VBPAE8qqEQ4LwDqsWUskZMFwv8IXi2uNwToRE8itt1ATIgdN79Pbb2ilqjKoUg/tHqD6I=
X-Received: by 2002:a05:6e02:c2e:: with SMTP id
 q14mr2654604ilg.286.1598899830406; 
 Mon, 31 Aug 2020 11:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-56-frank.chang@sifive.com>
 <d94182cc-8846-9eb6-6a93-87968d0d32c1@linaro.org>
 <2cbf253f-8fe1-d840-50f1-582767bf600c@linaro.org>
In-Reply-To: <2cbf253f-8fe1-d840-50f1-582767bf600c@linaro.org>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 1 Sep 2020 02:50:19 +0800
Message-ID: <CAEiOBXXY4ZMoCfo2tmLw3g6hmj6EjDXMzm_ybHd-ENC3=zTwAg@mail.gmail.com>
Subject: Re: [RFC v4 55/70] target/riscv: rvv-1.0: single-width floating-point
 reduction
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006c7ec905ae30e07a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=chihmin.chao@sifive.com; helo=mail-il1-x130.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006c7ec905ae30e07a
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 30, 2020 at 7:58 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/29/20 4:50 PM, Richard Henderson wrote:
> > It doesn't actually say anything about the way in which we've
> implemented the
> > *_noprop functions.
>
> Ho hum.  It seems v2.2 has changed fmin/fmax for the fpu as well.
>
> We really should fix that too...
>
>
> r~
>
>
The noprop is implemented in below patch and could  be applied to scalar
part
https://patchew.org/QEMU/1597908641-6293-1-git-send-email-chihmin.chao@sifive.com/

Chih-Min Chao

--0000000000006c7ec905ae30e07a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><br></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sun, Aug 30, 2020 at 7:58 AM Richard Henderson &=
lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On 8/29/20 4:50 PM, Richard Henderson wrote:<br>
&gt; It doesn&#39;t actually say anything about the way in which we&#39;ve =
implemented the<br>
&gt; *_noprop functions.<br>
<br>
Ho hum.=C2=A0 It seems v2.2 has changed fmin/fmax for the fpu as well.<br>
<br>
We really should fix that too...<br>
<br>
<br>
r~<br>
<br></blockquote><div><br></div><div>The noprop is implemented in below pat=
ch and could=C2=A0 be applied to scalar part<br><a href=3D"https://patchew.=
org/QEMU/1597908641-6293-1-git-send-email-chihmin.chao@sifive.com/">https:/=
/patchew.org/QEMU/1597908641-6293-1-git-send-email-chihmin.chao@sifive.com/=
</a><br></div><div><br></div><div><span style=3D"color:rgb(136,136,136)">Ch=
ih-Min Chao</span><div style=3D"color:rgb(136,136,136)"><br></div></div></d=
iv></div>

--0000000000006c7ec905ae30e07a--

