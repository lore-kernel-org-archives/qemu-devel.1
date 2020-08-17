Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A739C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 00:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74962075D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 00:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgfYYbco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74962075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7TTM-0005tp-0k
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 20:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k7TSp-0005UY-MV
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 20:57:27 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k7TSn-0002JK-KH
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 20:57:27 -0400
Received: by mail-pl1-x641.google.com with SMTP id y10so5112940plr.11
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7zlZk3GKzoTit/XWuBAHjBdnMzBNhoyRYauuJQwjvMs=;
 b=pgfYYbcotXfFrgtfTZAOKUrJRnY5OUkKMY8zxI2ztdZ+g9cNgelhmX3ksUktCDmp1+
 I0Pq1og9gDhHh2aGhC/XfsqhdwPZNZW1LzQPtlVyUReDGigL4l6UjnXAPs+aOT1cTqyW
 uK/zCnV3ooPmq0pAeUcwpqRkaxlSWhao6TXG6NfEQwDBmgAeop8IwwinNGx/wGhA4dBb
 ILj7AGZQv/kDIISh4K2hfLlpllrOM/bMR+smF1MEqnhFYwnhNhVq5KcpMn7RL99hC7ed
 ZXCOtdEb4RiyJIl6LP9HXyqDJSCaoLxrZsfLwR4KvcVNm7mD+cKqttbw5brCj+ofbSUZ
 ECbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7zlZk3GKzoTit/XWuBAHjBdnMzBNhoyRYauuJQwjvMs=;
 b=MlINgpg8jZ+zww3Ce2riaY+aL7BSQeoNnfsI2SyjVMNmJcJBpxRPLh9HqzX3f1sewI
 y/HRcyMS77iaCWTMkRDEjkzUM+CeOwWYHAlk7PcBUocVSMl2w39RbMgB4y7IgpHQX9v/
 kZtAnOzjZpHT0eTW4eBeP2dpaxsVackG82SpId9/pGkj3W+lM8+drBlxDkAEbvM920T1
 /S2weAp2UckBTUnOFBjtwBNKwnvXKEK14ML+FvlnCC3FtN63WffeopUkn9jZ5ZwzIWnF
 4rgyR2jrNqhRT8cKmPYudE03Al9cn6xjgtdmEtFll1+8abdMaaCKtLnXAgRmii6OVliC
 58sQ==
X-Gm-Message-State: AOAM533nFx8xORUY1a43g3oOOueELaiXjpcprvoMQZkigUbXpTVIKNm9
 jx+CRQjuazdvAHvWqViMIqlmeO33lO4U5lvTxwo=
X-Google-Smtp-Source: ABdhPJx/q6DzN0i0C5+NXEB5C9bLL71dvtqKl2x2rKoLu42ZQ9fj+tI3hnv2k7bHnqmJD9Rq0Ab57yzGhLa1Qr5qd2Q=
X-Received: by 2002:a17:90a:ac0b:: with SMTP id
 o11mr11130085pjq.191.1597625844032; 
 Sun, 16 Aug 2020 17:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
 <9abbbc9d-b5d5-fdd1-e6ff-c89071189f7f@linaro.org>
 <CA+Ai=tB3QW7+vt4qSrfSBornPmPJ+1rVajvvXf=p4kg3FG2+ZA@mail.gmail.com>
 <125714a6-e441-629f-e9ab-d04ce8b0d94e@linaro.org>
In-Reply-To: <125714a6-e441-629f-e9ab-d04ce8b0d94e@linaro.org>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Sun, 16 Aug 2020 20:57:13 -0400
Message-ID: <CA+Ai=tAy1C3UwxPw26Jkbm7+DGA_mrryG8Sekm9t9Bk3ZhPTow@mail.gmail.com>
Subject: Re: [PATCH v4] qapi/opts-visitor: Fixed fallthrough compiler warning
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000eae9c805ad084012"
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eae9c805ad084012
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 16, 2020 at 6:52 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/16/20 9:55 AM, Rohit Shinde wrote:
> > Hey Richard,
> >
> >  1. So I should fork off the master again?
>
> Yes.
>
> There need to be special circumstances for not posting a patch set
> relative to
> master, and even then your cover letter would need to detail against what
> base
> the patch set applies.
>
> >  2. I just checked and my version of the code doesn't contain that line,
> so I
> >     am unsure on how that line got there. I was trying to fix the
> compiler
> >     warnings. Could you please guide me on how I create the next version
> of a
> >     patch?
>
> That makes no sense at all.  The line was added at the same time as the
> code
> above it, in d8754f40acb.
>
I misread the comment. The comment /* fallthrough */ was meant to stop the
compiler warning from occurring. I am trying to complete the bite sized
task mentioned here <https://wiki.qemu.org/Contribute/BiteSizedTasks> under
"Compiler driven cleanups". I wanted to take that up to get more familiar
with the codebase.

>
> There should be nothing to fix.
>
>
> r~
>

--000000000000eae9c805ad084012
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 16, 2020 at 6:52 PM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hender=
son@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 8/16/20 9:55 AM, Rohit Shinde wrote:<br>
&gt; Hey Richard,<br>
&gt; <br>
&gt;=C2=A0 1. So I should=C2=A0fork off the master again?<br>
<br>
Yes.<br>
<br>
There need to be special circumstances for not posting a patch set relative=
 to<br>
master, and even then your cover letter would need to detail against what b=
ase<br>
the patch set applies.<br>
<br>
&gt;=C2=A0 2. I just checked and my version of the code doesn&#39;t contain=
 that line, so I<br>
&gt;=C2=A0 =C2=A0 =C2=A0am unsure on how that line got there. I was trying =
to fix the compiler<br>
&gt;=C2=A0 =C2=A0 =C2=A0warnings. Could you please guide me on how I create=
 the next version of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0patch?<br>
<br>
That makes no sense at all.=C2=A0 The line was added at the same time as th=
e code<br>
above it, in d8754f40acb.<br></blockquote><div>I misread the comment. The c=
omment /* fallthrough */ was meant to stop the compiler warning from occurr=
ing. I am trying to complete the bite sized task mentioned <a href=3D"https=
://wiki.qemu.org/Contribute/BiteSizedTasks">here</a>=C2=A0under &quot;Compi=
ler driven cleanups&quot;. I wanted to take that up to get more familiar wi=
th the codebase.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
There should be nothing to fix.<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--000000000000eae9c805ad084012--

