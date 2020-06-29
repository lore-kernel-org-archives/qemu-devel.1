Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABBAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A8623B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpRMuHiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A8623B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpukt-0001Qp-7n
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jpukG-00010W-PZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:26:52 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:45104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jpujz-00070e-Ln
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:26:52 -0400
Received: by mail-lj1-x234.google.com with SMTP id t25so13673386lji.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5GZcz68V4hxxoTPJ6aKrG9vSruuod3XhiqsSWZNWgrI=;
 b=XpRMuHiUvR0J0qt4g7H33+9KX7C23lbASpYELviH5brNd3foba22/S8rJJK0huAF1E
 t8eDp5KkOab0rjPiaRYhvnSrjhkqs/Oo0m9VY8KY3Rlj+YHfS1IPZSakbAMm3iDyf61p
 A36G4WPZfbrwwPZZZJ4XyAHlMsGOrnhd9QIRXQodqDJXfhXv/SowbNjxt1+AdDSPD7W5
 ayO9oVTIN6olNBt36apgSZCEpAEkQZ93fHJsG/19g1WBGTMVAM62Be4pYXQTGMGNDIGF
 M3leHVzDXIbsI4hxBjeRCmEkwB3GgnIHNlwfFybkxnlcVFfDtKRxYtudnJYNqE76sXMr
 19qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5GZcz68V4hxxoTPJ6aKrG9vSruuod3XhiqsSWZNWgrI=;
 b=M2YRjnWQEYYArT/HSWj9EYZaiAWspd4uHes0PhRSkUSJrHzTYqxHRVvyg0rDfRAsYV
 VCQF8dumNpocbDZqQSotW3CuT5xUacQ4yW4x4S+hiVohEypfDDZEuGvO9zlMJeUd8BcD
 gCri7INUGA7OP//nrd2/VvhtJkstaoToHA+1E6PtQpFr3cn81V3ywixHENU42ZfglTFB
 aEAWndhkAT0hWzPUpJKAwaWuJ82yqDFznqq4bvbag4kzn2IWrf9EtR7CEODg73tN3Z++
 fWIk1HcIe05H9DOyVtd2wzH5qwMC3ZqdFkc4uFERv+JrUb8Gr0JmpIFrbRX6Qxmz7uf5
 4ylg==
X-Gm-Message-State: AOAM531EH94NVKBTQFgv+Y4hglH3wD1setF8vV4mb6Rf/q6GqqEYHuL5
 JD/m/cCdMxrUmGNCSAvNNPZhowyw6cdSeucmWQ4=
X-Google-Smtp-Source: ABdhPJykIeAsODuX/KqTXnr4P16ZVjCKJDr4rCQfMxINgMDxDptPTdvmcZymP4q4jFGptSMY3Cm8cq5RVQo789ZRvwU=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr3875034lji.80.1593440793833;
 Mon, 29 Jun 2020 07:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <CAHiYmc561nFcHR-RxqgCt9V+tegqpDbKFuDTdOEZKd9xW6MATw@mail.gmail.com>
In-Reply-To: <CAHiYmc561nFcHR-RxqgCt9V+tegqpDbKFuDTdOEZKd9xW6MATw@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 29 Jun 2020 16:26:20 +0200
Message-ID: <CALTWKrU+Lp=XiGsC0pNH45ArnSbPAkcCDqQ+D9pWGEQ3Y=fLhw@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007cb38905a939d89c"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007cb38905a939d89c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your support!

On Mon, Jun 29, 2020, 12:40 PM Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

>
>
> =D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=D0=BA, 29. =D1=98=D1=83=
=D0=BD 2020., Ahmed Karaman <ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>> Hi,
>>
>> The second report of the TCG Continuous Benchmarking series builds
>> upon the QEMU performance metrics calculated in the previous report.
>> This report presents a method to dissect the number of instructions
>> executed by a QEMU invocation into three main phases:
>> - Code Generation
>> - JIT Execution
>> - Helpers Execution
>> It devises a Python script that automates this process.
>>
>> After that, the report presents an experiment for comparing the
>> output of running the script on 17 different targets. Many conclusions
>> can be drawn from the results and two of them are discussed in the
>> analysis section.
>>
>> Report link:
>>
>> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-=
Into-Three-Main-Parts/
>>
>> Previous reports:
>> Report 1 - Measuring Basic Performance Metrics of QEMU:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>>
>>
> My sincere congratulations on the Report 2!!
>
> And, on top of that, this is an excellent idea to list previous reports,
> as you did in the paragraph above.
>
> Keep reports coming!!
>
> Aleksandar
>
>
>
>> Best regards,
>> Ahmed Karaman
>>
>

--0000000000007cb38905a939d89c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you for your support!=C2=A0</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 29, 2020, 12=
:40 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmai=
l.com">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><br><br>=D0=BF=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D1=99=D0=B0=
=D0=BA, 29. =D1=98=D1=83=D0=BD 2020., Ahmed Karaman &lt;<a href=3D"mailto:a=
hmedkhaledkaraman@gmail.com" target=3D"_blank" rel=3D"noreferrer">ahmedkhal=
edkaraman@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">=
Hi,<br><br>The second report of the TCG Continuous Benchmarking series buil=
ds<br>upon the QEMU performance metrics calculated in the previous=C2=A0rep=
ort.<br>This report presents a method to dissect the number of instructions=
<br>executed by a QEMU invocation into three main phases:<div>- Code Genera=
tion<div>- JIT Execution<br>- Helpers Execution<br>It devises a Python scri=
pt that automates this process.<br><br></div><div>After that, the report pr=
esents an experiment for comparing the<br>output of running the script on 1=
7 different targets. Many conclusions</div><div>can be drawn from the resul=
ts and two of them are discussed in the</div><div>analysis section.<br></di=
v><div><br></div><div>Report link:</div><div><a href=3D"https://ahmedkrmn.g=
ithub.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-Into-Three-Main-Parts/=
" target=3D"_blank" rel=3D"noreferrer">https://ahmedkrmn.github.io/TCG-Cont=
inuous-Benchmarking/Dissecting-QEMU-Into-Three-Main-Parts/</a><br></div><di=
v><br>Previous reports:</div><div>Report 1 - Measuring Basic Performance Me=
trics of QEMU:<br><a href=3D"https://lists.gnu.org/archive/html/qemu-devel/=
2020-06/msg06692.html" target=3D"_blank" rel=3D"noreferrer">https://lists.g=
nu.org/archive/html/qemu-devel/2020-06/msg06692.html</a><br></div><div><br>=
</div></div></div></blockquote><div><br></div><div>My sincere congratulatio=
ns on the Report 2!!</div><div><br></div><div>And, on top of that, this is =
an excellent idea to list previous reports, as you did in the paragraph abo=
ve.</div><div><br></div><div>Keep reports coming!!</div><div><br></div><div=
>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div dir=3D"ltr"><div><div>Best regards,<br>Ahmed Karaman</div></div><=
/div>
</blockquote>
</blockquote></div>

--0000000000007cb38905a939d89c--

