Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D0C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DAB520C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdS1tL0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAB520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQQT-0001bi-0F
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGQPW-0000mT-CJ; Thu, 10 Sep 2020 13:31:02 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGQPU-0001ZS-IA; Thu, 10 Sep 2020 13:31:02 -0400
Received: by mail-lj1-x243.google.com with SMTP id w3so9251281ljo.5;
 Thu, 10 Sep 2020 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=a9s5DkWpYA9vuCVl/aHAYDvsDycShInMUBEOdqBiE6k=;
 b=sdS1tL0DLMHICmfmy7bb3SL8NqtXvF2o6QB3gsqI/TAWDMAvUyzFgio05TnAdvEk/c
 W4gmh4zJo0J7Qnj8Q2RQfL3RrSmDUjgwPGh5UBIeP3EVBlKQvzLqb7QAtDDY1xygXktN
 ywVeaOIc6TRvoaVVm+PO2JJs6gY0sFf0XpTA4y+ZhXyCIBS1mn/aj8MM4NMi1MWYZgoP
 y7FmaFGFM8QFPAfgPzqTdhO41erkJ38acdwiYjaTU7+7pJVLPs6HHpJB3dcJZYWOFTCd
 HRwjTJsJCK5BHVeZ8JqtWEHcrnfLEat7lrCAtAYBeM5w/mDtMe4jyxqk7o79fG5VJTAo
 lFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=a9s5DkWpYA9vuCVl/aHAYDvsDycShInMUBEOdqBiE6k=;
 b=jU/l+Gb1qgqHnYYqhKQFtN8OiMqFjrtXlEuABTu5GuCYhtfgtpgzNVGT5o+6rekxLz
 tBhMUJ4m+Lw01EZ1h9GxLohPITL8qBqwVHhhqHmKd/XVf27gICY1Np9wD0/4xYzESBAC
 OF7deUtLPEYEQEKD+ukdc5aRSFZAzCZ7Ea5V/VUA54diJsINbZxk4aT5A5Qll8Lo/d6q
 Xwd/8Zueh+bNwKwJsdSpk4RKellI+wU2Hm9upQrUNd1qdNlpK6HJHIEiB4Y6Y/MbY+vi
 oyJIAB+oDolzpDbhhhxnmsNtDeJyBUXyRJPPWcuwqnJGG2LF6XutV4shQuYRILt5CosL
 KXYg==
X-Gm-Message-State: AOAM531VfwduhE4FIfLSg8y1jejv55epmSiMQRrhKF0yHV0jUIE3uUUH
 QtCAPrimYmkzEabjD8UTfAXIPxh+AppqZ5QhNNE=
X-Google-Smtp-Source: ABdhPJy6nnMrB6eBuyxselUnG+IkIeSC+LYnAhBlpQ/AihS8YxycpcA59gwJUDjv32U8SLQ39gfn77rr3K6a8Zu+Lx8=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr4976165ljj.120.1599759058231; 
 Thu, 10 Sep 2020 10:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200910103725.1439-1-luoyonggang@gmail.com>
 <7f348ead-0f90-0b9e-0afd-7c828091753f@redhat.com>
In-Reply-To: <7f348ead-0f90-0b9e-0afd-7c828091753f@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 11 Sep 2020 01:30:46 +0800
Message-ID: <CAE2XoE-ROUmBJdgFkgEKCir5CEzi9fEUWpyP0zj4GTnq5VkdJg@mail.gmail.com>
Subject: Re: [PATCH v7 17/25] cirrus: Building freebsd in a single short
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000064666e05aef8eed6"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000064666e05aef8eed6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 10:18 PM Thomas Huth <thuth@redhat.com> wrote:

> On 10/09/2020 12.37, Yonggang Luo wrote:
> > This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
> > ("cirrus.yml: Split FreeBSD job into two parts").
> >
> > freebsd 1 hour limit not hit anymore
> >
> > I think we going to a wrong direction, I think there is some tests a
> stall the test runner,
> > please look at
> > https://cirrus-ci.com/task/5110577531977728
> > When its running properly, the consumed time are little, but when tests
> running too long,
> > look at the cpu usage, the cpu usage are nearly zero. doesn't consuming
> time.
> >
> > And look at
> > https://cirrus-ci.com/task/6119341601062912
> >
> > If the tests running properly, the time consuming are little
> > We should not hide the error by split them
>
> Ok, but before we merge this patch, I'd like to understand (and fix if
> necessary) what is/was causing the slowdowns. Otherwise we'll continue
> to see failing CI runs, which is very annoying.
>
> Then I need to apply your idea first, but I found
make check are rather slow without the make -j8 check.
And even make V=3D1 check would be slightly slower than make check.


>  Thomas
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000064666e05aef8eed6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 10:18 PM Thom=
as Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/09/20=
20 12.37, Yonggang Luo wrote:<br>
&gt; This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba<br>
&gt; (&quot;cirrus.yml: Split FreeBSD job into two parts&quot;).<br>
&gt; <br>
&gt; freebsd 1 hour limit not hit anymore<br>
&gt; <br>
&gt; I think we going to a wrong direction, I think there is some tests a s=
tall the test runner,<br>
&gt; please look at<br>
&gt; <a href=3D"https://cirrus-ci.com/task/5110577531977728" rel=3D"norefer=
rer" target=3D"_blank">https://cirrus-ci.com/task/5110577531977728</a><br>
&gt; When its running properly, the consumed time are little, but when test=
s running too long,<br>
&gt; look at the cpu usage, the cpu usage are nearly zero. doesn&#39;t cons=
uming time.<br>
&gt; <br>
&gt; And look at<br>
&gt; <a href=3D"https://cirrus-ci.com/task/6119341601062912" rel=3D"norefer=
rer" target=3D"_blank">https://cirrus-ci.com/task/6119341601062912</a><br>
&gt; <br>
&gt; If the tests running properly, the time consuming are little<br>
&gt; We should not hide the error by split them<br>
<br>
Ok, but before we merge this patch, I&#39;d like to understand (and fix if<=
br>
necessary) what is/was causing the slowdowns. Otherwise we&#39;ll continue<=
br>
to see failing CI runs, which is very annoying.<br>
<br></blockquote><div>Then I need to apply your idea first, but I found</di=
v><div>make check are rather slow without the make -j8 check.</div><div>And=
 even make V=3D1 check would be slightly slower than make check.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0Thomas<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000064666e05aef8eed6--

