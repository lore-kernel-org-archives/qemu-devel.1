Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44076C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B171A20759
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo1SCyaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B171A20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvro-0001tv-R7
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLvqQ-00010Z-PX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:05:34 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:41181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLvqO-000736-GZ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:05:34 -0400
Received: by mail-lf1-x12e.google.com with SMTP id y17so4410484lfa.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=B6Ll+GPJvZlWNhoW+uRlnRwgAZ7hPRSUQQ9vgkTUr6s=;
 b=Vo1SCyaLxIbNLEUrCborxHPIc426dLoyqzdk5lc3T/aMbTTni8/hyy+fnFADO2ZIpV
 odKK6hYRmm52w4nk+r9QokBElHXpX3whv9QLaxjnsTcXMw3Ts8yDwjBdK28jf9Suf9U5
 rDu7szDOX8+m186A5cVDh+2h0ZsiZZSRs8zdBqu1koZ1RdkT91xjzwB/j00f2W7goXHD
 ZN2zxOfVpZKqSt6bysMJcNMsgmL3a6x8p4/ME60fTBHHwv5VXa+BMMm5FxfBzuAJUbaI
 nGCmtkANzkicFs+9JtGzEjcFPXFYj/haqqY95Ehin/uDcpUCS3I64Bgbk4QqLmH8uSXg
 8sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=B6Ll+GPJvZlWNhoW+uRlnRwgAZ7hPRSUQQ9vgkTUr6s=;
 b=JYVc7aQ/MWsbNvQ4deuma7j0CmleFtvb2q9mTIcuv9BMXJav/pWrL7ecEl48pgu1Az
 6Tcoy4lIGL77IXQr0/VfVKBa32mqYjrQitY6oMwDl5Nhxi8nnCm7FohSGBM5JMlHs9fR
 3sx6B54Le0tCnTdrFzOHUahCDt+Yk7rEDj8kK8rFEQ3jijQHQFiMMlODqPRj3GlPPG9D
 4jItiZSUBF79xUnZ1DJGIv0ReA76tE1wCqsnrYOXffpb6H4E+J1IxuCQ0RZnIPj+EunN
 vROQvF+gWtnxarSo9Rj6+HF52tZMvKIz8b0rphiVtpCZk89XgJ1FVCqrEcPSYX3cy9u9
 9GNg==
X-Gm-Message-State: AOAM532LR1K7UhkJMVDdLGiWxo44VoYpwib1VG0+4q7W9ecpiKXXHair
 ZFGs9YkPhbAd53Xut7mn7v+b2IMkeY6U93KP8uY=
X-Google-Smtp-Source: ABdhPJx+TdNfQ5rgJXia9DnvIpVTKyzgG2GoAtF7d7n7+exzteJuSsMK3/SfGoGX2Fb6lPWIFD+F2G71AlVNje1JqfU=
X-Received: by 2002:a19:484d:: with SMTP id v74mr268561lfa.382.1601071529521; 
 Fri, 25 Sep 2020 15:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
 <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
 <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
 <c0eee78e-9336-65e2-bd12-a762aab78c3e@linaro.org>
 <56d6a3f9-8740-2274-5489-2d80aecf9387@redhat.com>
In-Reply-To: <56d6a3f9-8740-2274-5489-2d80aecf9387@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 26 Sep 2020 06:04:57 +0800
Message-ID: <CAE2XoE9iryf+BBN9u1VGqG=fyXBVi6yqqBiu8fm5qHziaKbcug@mail.gmail.com>
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c6f8bb05b02a837f"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12e.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c6f8bb05b02a837f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 4:59 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/09/20 22:50, Richard Henderson wrote:
> > On 9/25/20 12:25 PM, Paolo Bonzini wrote:
> >> On 25/09/20 21:23, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >>> That's what I am tring to fixes? what does  one import library per
> >>> emulator, can we do this like NodeJS does?
> >>>  NodeJS have NAPI support across platform. They create a windows .lib
from
> >>> node.exe
> >>
> >> You'd have to create a .lib for qemu-system-aarch64.exe, one for
> >> qemu-system-arm.exe, etc.  On Linux the same plugin will work for all
> >> emulators.
> >
> > Which is clearly silly.
> >
> > So what you'd do is create a common .lib that all of the plugins link
to, and
> > so do all of the qemu-foo.exe.
> >
> > This would probably involve creating a set of call-backs that
qemu-foo.exe
> > would need to pass to the common .lib at startup.  It's harder to do
with
> > windows than linux, but it's not impossible.
>
> Yes, or you can skip the .lib/.dll completely; you just place pointers
> to the callbacks in a struct and pass it to the plugin when it's loaded,
> through qemu_info_t.
I also got another idea to resolve this issue by loading these API by
dl_sym(NULL, "qemu_plug_api_function_name"),
so we won't change any current API. And creating a plugin_api.lib for
static linkage to(only for windows).
>
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000c6f8bb05b02a837f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Sep 26, 2020 at 4:59 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 25/09/20 22:50, Richard Henderson wrote:<br>&gt; &gt; On =
9/25/20 12:25 PM, Paolo Bonzini wrote:<br>&gt; &gt;&gt; On 25/09/20 21:23, =
=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>&gt; &gt;&gt;&gt; That&=
#39;s what I am tring to fixes? what does =C2=A0one import library per<br>&=
gt; &gt;&gt;&gt; emulator, can we do this like NodeJS does?<br>&gt; &gt;&gt=
;&gt; =C2=A0NodeJS have NAPI support across platform. They create a windows=
 .lib from<br>&gt; &gt;&gt;&gt; node.exe<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; =
You&#39;d have to create a .lib for qemu-system-aarch64.exe, one for<br>&gt=
; &gt;&gt; qemu-system-arm.exe, etc.=C2=A0 On Linux the same plugin will wo=
rk for all<br>&gt; &gt;&gt; emulators.<br>&gt; &gt;<br>&gt; &gt; Which is c=
learly silly.<br>&gt; &gt;<br>&gt; &gt; So what you&#39;d do is create a co=
mmon .lib that all of the plugins link to, and<br>&gt; &gt; so do all of th=
e qemu-foo.exe.<br>&gt; &gt;<br>&gt; &gt; This would probably involve creat=
ing a set of call-backs that qemu-foo.exe<br>&gt; &gt; would need to pass t=
o the common .lib at startup.=C2=A0 It&#39;s harder to do with<br>&gt; &gt;=
 windows than linux, but it&#39;s not impossible.<br>&gt;<br>&gt; Yes, or y=
ou can skip the .lib/.dll completely; you just place pointers<br>&gt; to th=
e callbacks in a struct and pass it to the plugin when it&#39;s loaded,<br>=
&gt; through qemu_info_t.<br>I also got another idea to resolve this issue =
by loading these API by dl_sym(NULL, &quot;qemu_plug_api_function_name&quot=
;),<br>so we won&#39;t change any current API. And creating a plugin_api.li=
b for static linkage to(only for windows).<br>&gt;<br>&gt; Paolo<br>&gt;<br=
><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo<br></div>

--000000000000c6f8bb05b02a837f--

