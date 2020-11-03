Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCB1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F7A2236F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+vM0Fpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F7A2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxLX-00081e-EC
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kZxHj-0005AK-0I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:27:43 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:34896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kZxHX-0003x4-VT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:27:42 -0500
Received: by mail-lf1-x12c.google.com with SMTP id f9so22443452lfq.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=iLEK5z9BkfG9QawHkYxUSvEVGBg618FWwMmX1fAG5DQ=;
 b=S+vM0FpzHvCkKYlKE9CFVi93NEGMnAjA9yLX8AlDV2xdEAU0PwL4ZjCg+d2dSY4kTY
 OVQH/e0HdYatsvRic/CXlkI5aqKl30hhW1U3cJPVrW9m9CeRkxmqotXdyBCztkEu1XGs
 5aQbtGmPQlNLY8Pb9GR/xF31SoahlQ6+T+xBMHN/TGqjJrFEOUIpItw+YAB0nxxHGX7c
 GBdR/5Iw/Cu21Lvg3flFfQfjCTUdXtN1ltRzO4nQ469JbOf88EvmZj/PQ5w6HNCknYRc
 EbteGDWYU+P20nuK3+jH+iZf7z5cxSceCJklOc249rifWCnfrYU0GCK+H1Fvb6Cr9Xpa
 hCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=iLEK5z9BkfG9QawHkYxUSvEVGBg618FWwMmX1fAG5DQ=;
 b=uTAjrIjsQuln5XwYJx+iLdqnBPZwM+5OFc8dxeZLy2F5OcYN3v4o3tb03B8bsewZ6w
 xhBFd03pxplqx4fpivOWKh7s/6zKSNGHlkMM5HILonH+hvOLCwF6e3aqPfalRHcv3YO8
 qYflE9vCoyPG4Yq1Pz1t3n+XGQexnsDUlBHeoyKj889R3vJWfZyuPkxyvK+4+WBBS00O
 v5d0Nq883YvGHRWgA6DOdv/pjNR4S7iIQVxZlv0Qfkyp8pAKhZyPBZa7V/uSpo3BbwH+
 JdtOg18WNxMoonvyGJepIX8YebAAJn14UIvIBZupQttNH8ps5B8/r2i64wVfzmzNt96W
 Xyiw==
X-Gm-Message-State: AOAM533kuOVCepy022FOZQhc8oORXn8jveVAvDngLX/DZHM/lTTlrQEL
 3XFEur0gl4JjypWiVFYWjEtY5WeUNIhhhg3s2T4=
X-Google-Smtp-Source: ABdhPJwFMl3XEgLMDMO3Bdwz3EYgLs3kSHb/z4nGtLQqn+XtgBgizkgK9siRXmScN2haFvy94jHnReO/3k4GrR+nuO0=
X-Received: by 2002:a19:8605:: with SMTP id i5mr3142875lfd.356.1604413649930; 
 Tue, 03 Nov 2020 06:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20200821102329.29777-1-pbonzini@redhat.com>
 <20200821102329.29777-63-pbonzini@redhat.com>
 <f896a0d5-721e-2346-58c2-38e26c2c352e@redhat.com>
 <CAE2XoE9vwFNdJ4NAQXeNEDJkEEiLSXWqf8_dsKKx3FzKpsvFcQ@mail.gmail.com>
 <c7568f79-2f5e-7f73-c9bb-87dcea7c4519@redhat.com>
In-Reply-To: <c7568f79-2f5e-7f73-c9bb-87dcea7c4519@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 3 Nov 2020 22:27:02 +0800
Message-ID: <CAE2XoE-K0MC45a7xGzs0sOoCZq9khaRVFc_c28To87qf8SCrPw@mail.gmail.com>
Subject: Re: [PULL v8 062/152] meson: infrastructure for building emulators
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ad4cac05b334a932"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12c.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ad4cac05b334a932
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2020 at 10:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/11/20 15:19, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >> > +#include CONFIG_DEVICES
> > Mybe add config-devices.h back and detecting the target_cpu and include
> > it properly?
>
> We could add a one-line config-devices.h that contains "#include
> CONFIG_DEVICES" if desirable.
>
> Paolo
>
Make sense


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ad4cac05b334a932
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Nov 3, 2020 at 10:25 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 03/11/20 15:19, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt;&gt; &gt; +#include CONFIG_DEVICES<br>&gt; &gt; Mybe ad=
d config-devices.h back and detecting the target_cpu and include<br>&gt; &g=
t; it properly?<br>&gt;<br>&gt; We could add a one-line config-devices.h th=
at contains &quot;#include<br>&gt; CONFIG_DEVICES&quot; if desirable.<br>&g=
t;<br>&gt; Paolo<br>&gt;<div>Make sense<br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000ad4cac05b334a932--

