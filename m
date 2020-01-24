Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB3C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 03:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD5B21835
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 03:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="buHpN25d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD5B21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iupZi-0004GV-QU
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 22:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iupZ9-0003pT-4s
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 22:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iupZ7-0003La-JH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 22:23:26 -0500
Received: from rs224.mailgun.us ([209.61.151.224]:61067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1iupZ7-0003Kv-2J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 22:23:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1579836205; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=ApKgkmw6aGyORE9DRhnBP4AbLmTM1OpHrHOib//MXSo=;
 b=buHpN25ddHdahfO9E1DP9ljGkNZYMGuMr4H0uJSsmChzhjxxVrjAjDVYVC5SyVaf5XUVEdKB
 rJDhytUlbJ8qtUqk1N+eh796hV9lPJpQKB6+5bTf/zqVJIeCloO58ZUmd31NZ0jhfufzeDXF
 Gxc2XaSYQkq9SXK+7SGEySAiIHK/HYG8DNhT5beZ39IW8lmaut8u6PkmlGD8A8dwI0okjgNF
 9rvxWss3ejTjT2lhXEL/fT+/5gV2x6cYDYhbqLYMsO++shlnEdfsOj7TZfH1ryOmgfuM+55h
 mjnCcwd2hByYRsAXeeqi1hhZiy7/x4c8SwvWYKFdeeMeXGq+3PhctA==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mxa.mailgun.org with ESMTP id 5e2a6327.7f0606e0fab0-smtp-out-n01;
 Fri, 24 Jan 2020 03:23:19 -0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id o11so790421ljc.6;
 Thu, 23 Jan 2020 19:23:18 -0800 (PST)
X-Gm-Message-State: APjAAAXrK3HXUavFjboBdLrgCj58JdlFI2sDzrwU39HjqLHRz5Bq5Ufr
 VYVwBK0kKk/PImkn4rE7iVniM/2Gn27DtmMk9Rc=
X-Google-Smtp-Source: APXvYqyhXAxEUX1ZTUy5fCcbzrAmUp65xftvCScytbdvS45VSQS7X/pBazg0hSCHDIMU4UBDCAyFUJJ70GyTzKW/Aas=
X-Received: by 2002:a2e:7009:: with SMTP id l9mr889727ljc.96.1579836197030;
 Thu, 23 Jan 2020 19:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20200123195200.206355-1-jonathan@fintelia.io>
 <5d74dfd1-f1f5-df3d-e0b1-771781497553@linaro.org>
In-Reply-To: <5d74dfd1-f1f5-df3d-e0b1-771781497553@linaro.org>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Thu, 23 Jan 2020 22:22:51 -0500
X-Gmail-Original-Message-ID: <CANnJOVFwL3UeOzf49r9JvUkFEN-2WJ2o-A0kME=HLOMUf7mO7A@mail.gmail.com>
Message-ID: <CANnJOVFwL3UeOzf49r9JvUkFEN-2WJ2o-A0kME=HLOMUf7mO7A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Disallow WFI instruction from U-mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000053d075059cda47da"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000053d075059cda47da
Content-Type: text/plain; charset="UTF-8"

Haha, fair enough. I just copied that line from one of the other functions
in that file, which all use the same style. The check is actually a bit
worse than it looks because PRV_S is defined to be 1. Hence, the whole
thing is equivalent to just writing `env->priv == PRV_U`. I can send out a
new version with that changed.

Jonathan

On Thu, Jan 23, 2020 at 6:35 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 1/23/20 9:52 AM, Jonathan Behrens wrote:
> > +    if (!(env->priv >= PRV_S) ||
>
> For integers, !(x >= y) is a poor way to write x < y.
>
>
> r~
>
>

--00000000000053d075059cda47da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Haha, fair enough. I just copied that line from one o=
f the other functions in that file, which all use the same style. The check=
 is actually a bit worse than it looks because PRV_S is defined to be  1. H=
ence, the whole thing is equivalent to just writing `env-&gt;priv =3D=3D PR=
V_U`. I can send out a new version with that changed.</div><div><br></div><=
div>Jonathan<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, Jan 23, 2020 at 6:35 PM Richard Henderson &lt=
;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 1/23/20 9:52 AM, Jonathan Behrens wrote:<br>
&gt; +=C2=A0 =C2=A0 if (!(env-&gt;priv &gt;=3D PRV_S) ||<br>
<br>
For integers, !(x &gt;=3D y) is a poor way to write x &lt; y.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div>

--00000000000053d075059cda47da--

