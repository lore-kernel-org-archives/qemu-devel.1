Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7686AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADFF2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUq9iVPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADFF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAy0o-0005i7-FR
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAy06-000567-0N
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:10:14 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:33300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAy04-0004ld-Db
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:10:13 -0400
Received: by mail-lf1-x12d.google.com with SMTP id x77so276402lfa.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=8g8pMrdL90Cfpjfm+De4RKEpwS8nxQcKmhUKJ1oxE8k=;
 b=AUq9iVPEioegC6rHrdeBlKsQMT1erv07JW/rJGpzFAzLqUlhbqAmf+TSCYNgZQ0fqA
 2qS5MMwUb2c4+MOBawrFd/W9WtqN5EVgo7erOig2E+fliSDq6d+Igijz+rNK5585zkdj
 fu8OTnyb8EE978PlDHV8QYU005K8bh9VwfSuw4xauZDQgj8BgEIyk7aN0FYc1mfLXFVl
 cxxy5hRzJHu4zhFaGij+q/QolMBS/heuUsNrlvnOdlJ9xtfpQ55tzyKxez9CV9siYYqj
 AgxkZhAeGcZArFlZb8X8HtMtIwtaRpYvA49T6fT+ouBLWinVEwQcDLRRE0YcoJctrJWx
 5fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=8g8pMrdL90Cfpjfm+De4RKEpwS8nxQcKmhUKJ1oxE8k=;
 b=V2HpaYvh16iFVLcbbfqcmY1W7FUx0Lrj43D8lExL1bneEh9i2d9B1Nu8ARSGFIHgbp
 G2r+B8EonV7rQ6jkr3vSLE4+SO6ZCHyHGtLAAMFJKyTA6O2JhessfsAIexn4iQJzGOeT
 bgf5gWMfyFGy6qQWqkfk189+0tjlCLRHiVd+CUMWcEbNeSncyX3W7IkKNRAlxZg1Q3Hp
 HEgjTEhUl6AcgqQaeZli7UqpZlN9UfovIscFQDaLnniaY8pDe/NnA+uQtU6EK4gQ+1fK
 COqGNP2KGQujzeEm35y2NSlavh9itcDL7e5OIeUmvu8hegTTCZUCG+xnu51G0LUPbUch
 DLFw==
X-Gm-Message-State: AOAM5338QjMOel+NWMf033jKY2u3tkmJDyWpDOpX2G/83aNfZ4J9oSiY
 pCQi8HAh3lMhz0WUMdlL5ryPVOkdTrenjhLo2+c=
X-Google-Smtp-Source: ABdhPJzZQYGbZNXhhqVRxx7mDS5/6ZaJZ7t28g4H0ISUAJtCV0xMT/aGz43anF9OEIKqiyIbutuLKECraZ/J+Zj5BkU=
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr7698711lfl.117.1598458210516; 
 Wed, 26 Aug 2020 09:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
 <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
 <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
 <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
 <CAE2XoE8LDYbGkJXQBorg9=R632PNtZ_onawrm=jsJQ_+gAA1rA@mail.gmail.com>
 <CABgObfbFJx5uzTPmthJSkUEwRryZgLNTeYdetgBEUtztRa0oiA@mail.gmail.com>
In-Reply-To: <CABgObfbFJx5uzTPmthJSkUEwRryZgLNTeYdetgBEUtztRa0oiA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 27 Aug 2020 00:09:58 +0800
Message-ID: <CAE2XoE-jBa9f_RRqS4_ESYBhAKftKg3n1TrswLiNgyFeLwab0w@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d381fa05adca0dd4"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12d.google.com
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d381fa05adca0dd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:56 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Yes that would be great. We are tracking all CI "holes" that we didn't
> catch before committing the Meson transition, and MSYS is certainly
> one of them.
>
> You can send a patch and it will be reviewed and included.
>
> Thanks,
>
After these patches merged, I'll do that

>
> Paolo
>
> On Wed, Aug 26, 2020 at 5:48 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 <luoyonggang@gmail.com>
> wrote:
> >
> > How about enabling github actions to enable MSYS2 builds in CI.
> > So we won't break msys2 silently.
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d381fa05adca0dd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:56 PM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Yes=
 that would be great. We are tracking all CI &quot;holes&quot; that we didn=
&#39;t<br>
catch before committing the Meson transition, and MSYS is certainly<br>
one of them.<br>
<br>
You can send a patch and it will be reviewed and included.<br>
<br>
Thanks,<br></blockquote><div>After these patches merged, I&#39;ll do that=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br>
On Wed, Aug 26, 2020 at 5:48 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &=
lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@g=
mail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; How about enabling github actions to enable MSYS2 builds in CI.<br>
&gt; So we won&#39;t break msys2 silently.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000d381fa05adca0dd4--

