Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A8C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D429320756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYWc3mF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkCL-0002rh-Vs
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHkAK-0007dR-8F; Mon, 14 Sep 2020 04:48:48 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHkAI-0005He-FW; Mon, 14 Sep 2020 04:48:47 -0400
Received: by mail-lf1-x141.google.com with SMTP id x77so12547416lfa.0;
 Mon, 14 Sep 2020 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=9dk1cB9J9OAz5tHPdR37OGX9IkumYg5PLfAmqD+4Lhs=;
 b=uYWc3mF5BMeM2pHRQ31JE8odMmFLLG8q48dj/3F/FaXOxb3V+G8t3MrMmL4gkt0Fqm
 GcU+CQOBOpI7SZsQOLgrtr/p41BJFe6tC3a0m73StpSepONuCxnoTKJpGaXdn798d3Xi
 9nW6cU6gu57SzgwGeSOqJa+PY2X+SqiUPlrnL3g0usXOv8JPAWVuFmsktnm3SU+bK17W
 u3RjTUuTTwOBjLZMECDJ7Nyh+brtqW9SBkCa7xtIhS/uRXb063csc/d1ijsgr8YwjYxk
 vYKzf/mJnbLO6EqPmQ7Eenugwuk1BCr8nkfwqDekdb03s7/C6D894HcJEOSMBneQ/BPd
 POQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=9dk1cB9J9OAz5tHPdR37OGX9IkumYg5PLfAmqD+4Lhs=;
 b=AFVhbsb+EZZvFzIALEL7ZiMj+HBlncgkkGMc8IGvGMQtmZ8+9SSoX2RsENOiGO1oip
 vGiRoLJYCYFGuaUu9CRVTA+IebvOgSY97hJM53BevKExit9wrIJapfjqZMx6TKsO+myC
 vfUpl/h09BvXfU8EEkqXROd5mACvNgMuiTvNEsZ4C8JiXZ/UscgIjjCHAjxXAqBMBt20
 VCJVQVAZSitORAMjCeUkzJ/4APOvnZsH6/FHtVwfQr+S3IfqirYPrWFcFGhBAEkrFfHy
 iEcdBToQ5cqqURiZp/Mh2sXseVSuJSTy39ssjAw2BHgDJ1EaVKHdChGXigmjYCnRUNsY
 YlzQ==
X-Gm-Message-State: AOAM533B1Fp4tQ71BD+e4Sd1ZUl6nwAYcIZXHTbdrXkgtECkS29v3f9H
 pjy/QHnVXGkrlbwZ71pcCGsPGIluKeQE+lUO2zk=
X-Google-Smtp-Source: ABdhPJxS0yMm97Uq+SAzZYPt/tJ27JK7ILueafww3iyz2g7sQI9RSOtov1hNRomw0giq1fa90YhxOEJdnKbaa0xDjSo=
X-Received: by 2002:a19:383:: with SMTP id 125mr4289969lfd.356.1600073324170; 
 Mon, 14 Sep 2020 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
 <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
 <CAE2XoE8Ly=bhkLPbnUm1eg91Re0rf-UkAy25f8LgPLJUaYyHNw@mail.gmail.com>
 <d7b83b76-ff7a-85cb-0676-559d5680f070@redhat.com>
In-Reply-To: <d7b83b76-ff7a-85cb-0676-559d5680f070@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 16:48:34 +0800
Message-ID: <CAE2XoE9GdOZzp+kZB52RObK4tSUuF3tTKRx7b5iRyovUYj3mag@mail.gmail.com>
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001a118c05af421abf"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001a118c05af421abf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 4:45 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 13/09/20 18:14, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > I am hurry to revert --ninja option because when the meson are changed,
the
> > make -j10 can not automatically re configure, that would raise ninja ca=
n
> > not found error
>
> My understanding is that with 0.55.2 you don't need --ninja at all (the
> default search works), and also the previously configured build tree
> should work.
>
> What's the issue there?
>
Oh, I mis-understood the --ninja option, so the ninja option doesn't have
to be revert, but upgrade meson to 0.55.2 are necessary
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

--0000000000001a118c05af421abf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2020 at 4:45 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 13/09/20 18:14, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt; I am hurry to revert --ninja option because when the m=
eson are changed, the<br>&gt; &gt; make -j10 can not automatically re confi=
gure, that would raise ninja can<br>&gt; &gt; not found error <br>&gt;<br>&=
gt; My understanding is that with 0.55.2 you don&#39;t need --ninja at all =
(the<br>&gt; default search works), and also the previously configured buil=
d tree<br>&gt; should work.<br>&gt;<br>&gt; What&#39;s the issue there?<br>=
&gt;<br>Oh, I mis-understood the --ninja option, so the ninja option doesn&=
#39;t have to be revert, but upgrade meson to 0.55.2 are necessary<br>&gt;<=
br>&gt; Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000001a118c05af421abf--

