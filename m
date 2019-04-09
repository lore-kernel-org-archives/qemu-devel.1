Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D87C10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 00:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5945A20883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 00:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plY8DqmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5945A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDeUZ-00043c-Ao
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 20:19:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hDeTk-0003kg-J0
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 20:19:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hDeTj-0003se-Ko
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 20:19:08 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hDeTj-0003rj-AC
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 20:19:07 -0400
Received: by mail-oi1-x242.google.com with SMTP id j132so12078042oib.2
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=CIhuUegJajUNz6EWYh4L1T90ctOIJrkbhyiQc0RX1ZE=;
	b=plY8DqmCVQ9E4mT8NX68KKaWPVoJ9yL47w8S4WtCMmpo0V3tUGKx4cFjUBIvQyOUF7
	XdHemz/mZe6ozm6KlWCugQQAGSEF4oAf57Q5O3hXc196riKHeU1vqgyB26poIlpXoort
	luxee4HueGJNfvRbr8L56kjq3qE3cQYxGeP4F6jBGfTJAjnsMbmg/HORQPNheqFC5AEN
	uKFbaveluYzCkG7wZvfTih09uC3Qud6GFfzS52qgnBb44OtW/5EjvVAa9wyvcD/k9Yte
	g7MbJ61sJ4OGv1YaB0Fn5Za7xEbCCC1ojA4OK57MW5SPH/jxhA6NcK/OJgjin3rRHxMV
	+tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=CIhuUegJajUNz6EWYh4L1T90ctOIJrkbhyiQc0RX1ZE=;
	b=XvRM3G+CRl92AA52hvCHg8oAhc80ZAhgFlkOlajhWYHrdEZfnMKf/q5xENk9o9KcmE
	5lOSHQDgaa7ijr42jMp5OlPeYXwPiCbYB/TXm8JN9Bxd+cUO7OlypiYG/qy4d5UnOhPo
	ft0ojHXzZmChj1ewrlfK9nT9pkPmgcosgTPDirdCs3LansLuo53wPAXdUZtC+2T8R9rY
	6MdUa5xKO9ysUqJx+WZUb2lc/YAKGdDENvWrXgPaEoWpJCc21joKb4RGNF247iOR/Zwh
	O23fCe5QvaqgHTivAtgJEbfGLlZ4hdNe4SsuRzLG/6IQK/VULb0RxeIrV900WdJd6+Sb
	OWhA==
X-Gm-Message-State: APjAAAVFdiq28XEQZcFc6CvU5yvjMRIAFLzuS3lY3SDcd/zlHA++3dVN
	QW1msUuZr0a9oHahJu93m72hzz8S7wk0FrjsP7g=
X-Google-Smtp-Source: APXvYqxMR6nASKewzUtHlkl5KJJkRjpZ0UNUIvIgOXy4dBqMR1QXC2jR5TwlgwCBdORsJE+5kz6WNoFw031EO+o/6kY=
X-Received: by 2002:aca:df05:: with SMTP id w5mr17867826oig.150.1554769145635; 
	Mon, 08 Apr 2019 17:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 9 Apr 2019 08:18:29 +0800
Message-ID:
 <CAKXe6SLnou3TMsdorK0Ck-c+D6ECzWg10rBdQ_v3kLPb4FY7-A@mail.gmail.com>
To: Lidong Chen <lidong.chen@oracle.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Darren Kenny <darren.kenny@oracle.com>,
	Qemu Developers <qemu-devel@nongnu.org>, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409001829.PZDtlWxosVHNZr90ntZyQPoq7Zyj2ttkXf_9REXPLc0@z>

Lidong Chen <lidong.chen@oracle.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:51=E5=86=99=E9=81=93=EF=BC=9A

> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates
> state)
>      if (state =3D=3D sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <=3D ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp=
)
>      if (rsp =3D=3D sd_r1b) {
>          rsp =3D sd_r1;
>      }
> -    assert(rsp <=3D ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }
>
> --
> 1.8.3.1
>
>
>
