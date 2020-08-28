Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4027CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E5420737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnIPRhFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E5420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBh5X-0003jN-72
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBh4r-0003KH-Ix
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:18:09 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:44659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBh4q-0005jD-7V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:18:09 -0400
Received: by mail-lj1-x233.google.com with SMTP id g6so1917291ljn.11
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=eKoeCEbJxJMTQPo6CyKO8aqPHfjQGGjcg52uVm6XIpo=;
 b=YnIPRhFnT9jP+R7phZ+gZW3OTbo5at1wYzE5jJMekutTs9ICb55Ua3NYXXwYQZAmpV
 KgTnt9qLs5/3Vjk0ScRSwHSu4uRnAFL/1JoEUIIMfA+hO4YQKAHDbZ3aFaMY4QVlkzsb
 IAmMftrJFn4wv0pLNeWI/Kp3G8ruRx2xUxQ/ybGw33+UAacIeqhtV5tDu5Lb8fC1wSr7
 5it/BvGeWBNMILIAYdXHFNM6gQc85YsCP45WaSEbw1P1kUbEgEBox9MhetQncf2BM6tS
 k4QxxP6W+ZqFlxxD7PVG7IsKi4ZsRSfwNBYHlthn0chk2d0CjfZLMdzZirPCv+U5QyDh
 ECYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=eKoeCEbJxJMTQPo6CyKO8aqPHfjQGGjcg52uVm6XIpo=;
 b=hVjzH13GGyfs3N3ZeQNHLQubkybp6ZVbgoCuF9VCHZlkCaCvHVDWo0ISG1qZZUglmR
 NexGAyMXx2d7zpWvPe4BYw/bX46/TG02+bdy/w721Pyz+OSPzsdrI7Hm4P2tKjlq5MzS
 lw8KH9VciwdpHcrZm7Hi8NGMjYOocznnLODjkEf8M3Ks0ytVmHpv8uHqexFD4ZlqSiwI
 +sWv2zDzbkvatCSVT+tAEMiEbOi0kyMrbKHdm5+1SmJMsSqfA5unWpG1Eq11deijwz6u
 2SMHECesfJ0nXydoryL2kGe+qPf6g0WWTba9WYxrn9a0YYWVaRyZyVun8EXhRX46hB+g
 ZOCg==
X-Gm-Message-State: AOAM533oP4qPnCXjP8DttQyJnAfQrPWi0xZjSJW4BhdaGKk3C58AL2Kj
 VKd1xKjA6JCpEjkNOpzu3fAQFwi2q1qk6Idk9LxH6nhB0005zw==
X-Google-Smtp-Source: ABdhPJy0F4SvSuT4jTFCbDnMq9tN0UiHiLsPxG8Z+pUW0nm02sOYuZRNVr6sW/P1M/n9IW1+d6iHvRuiAnYiWnnl2A8=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr1260774ljj.171.1598631486031; 
 Fri, 28 Aug 2020 09:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200828161315.193-1-luoyonggang@gmail.com>
In-Reply-To: <20200828161315.193-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 29 Aug 2020 00:17:53 +0800
Message-ID: <CAE2XoE8w+GpqPmVDxg6yHA4kv8_-0v_u+1CzHv7-OfjuyFTuGg@mail.gmail.com>
Subject: Re: [PATCH v2] meson: Convert undefsym.sh to undefsym.py
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000da0c8705adf2655b"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x233.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000da0c8705adf2655b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am confusing, why my patch are not recognized by Patchew?

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000da0c8705adf2655b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am confusing, why my patch are not recognized by Pa=
tchew?</div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo<br></div></div>

--000000000000da0c8705adf2655b--

