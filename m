Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8CEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CF62078D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 14:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+h9Sms2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CF62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Ux6-0001o1-H2
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 10:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k9UwY-0001Gs-E2
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:56:30 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:37109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k9UwW-00068K-LN
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 10:56:30 -0400
Received: by mail-lf1-x133.google.com with SMTP id s9so2317754lfs.4
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+JL9qzw4rulZ3I6gwGmQXe0DS8oc5rDRRYRGhgIsGC4=;
 b=T+h9Sms2OnSvWsN/0/VhCpOMaFIVezVKe7sffm8m6fV7pT2mtxeAKO4e1Ep48CeQDD
 tfbXJq9oqfIlRjepQMKjZBQ59Uhm3wl6Sman50VzG5zlGOHhXkJ0ySITSjD6cu5xY1Ii
 4gg1HnRIYi9hSEpiAN72aEegExf5/+TjaebfcEL2t270nBKfzGruLBCIXGT9xdzL8qTI
 gcSvQX0ScEXYDOHgG6WrL0RQYunYrcX68KdJr03oyV/VzIHsmkOvtvZLoJd50Kg9pOFO
 QiOj+EFVG+UMGRbsWviEwQA6S9254TbJnXIe1smGICz9fYl8Aest2GPkbaYzsP+f5zwC
 Ny4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+JL9qzw4rulZ3I6gwGmQXe0DS8oc5rDRRYRGhgIsGC4=;
 b=FWGIHq+sF/mAhLG9i8DclEkbALY89se1iGZo8RicWjmUrD0H7nangiXsJvR0pPLQ7K
 ZrlGO58Fmm4iJ2fy/iP60dgUqvAIHgS/tIPETLMc1wq9WoXxUA8lMpvse3E4vQHz/iQM
 JurfUNxJ/zxH40J7QmB2zXaRt8bGNMTa5zZpVwijyggsiiXPWbulrimYbFpsyk4vCtvK
 MivG0xf628WvEvAXlNBwYwDSOh4bRnu2Lx304zzt3M0KlHl6rH72p0InAiOk2BhOb6/b
 26OX2yt7pk8YCSv2oWBcHrnJO4ibkUOvKz/rQRYPLp5i+kFco46tAskMuNtAXKFuyj8z
 IEpw==
X-Gm-Message-State: AOAM533Bvty911NM2FSB97t3ZYw2Tpe9sRxefMp2iA2gQJImKD90wvE5
 OPXO3Gph0Xl54fAbd3HjasfFqB/ZUZFYD4IYDBA=
X-Google-Smtp-Source: ABdhPJxoXjRpZA61Gxs5m/cjbqN8VLoNamnJEZGYqFErN8Xnx/JF63k+G0q5K35vgLTqLXe4zO44UNmee+UXCPQXZ/4=
X-Received: by 2002:a19:ae06:: with SMTP id f6mr3669236lfc.42.1598108186293;
 Sat, 22 Aug 2020 07:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrWnseJidqDTDQM9TY3JfmvXy_0JufH9rR6hZHoAXkP8VQ@mail.gmail.com>
 <CAHiYmc5Z5T9-vKe-c9N2GHwHdc+QM9Aznb84oOR6u+A53NuJOQ@mail.gmail.com>
In-Reply-To: <CAHiYmc5Z5T9-vKe-c9N2GHwHdc+QM9Aznb84oOR6u+A53NuJOQ@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sat, 22 Aug 2020 16:56:15 +0200
Message-ID: <CALTWKrUzr=njypa-g0rqRvNjUd5630X0R5bE51x2_Csg9VewTA@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#6] Performance
 Comparison of Two QEMU Builds
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c1b8d905ad788ec5"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x133.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c1b8d905ad788ec5
Content-Type: text/plain; charset="UTF-8"

Thanks Mr. Aleksandar for your feedback!

On Sat, Aug 22, 2020, 1:09 PM Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

> Hi, Ahmed.
>
> The report, and the topic in general, look quite interesting. However, I
> would suggest two improvements:
>
> - The title should reflect the content in a clearer way. Let's say,
> "Compilers and QEMU performance" would be IMHO better. The expression "two
> builds" is just missing the central motivation of the report, which is
> comparing gcc-built QEMU and clang-built QEMU, performance-wise.
>
> - At the end, a section "Useful links" would be handy, akin to the similar
> section in Report 1. There were many people that analysed (and posted their
> results on the internet) gcc vs clang in terms of performance of produced
> executables (in contexts other than QEMU). Having the most useful and
> informative ones (3-5 links with a short summary for each one would be more
> than sufficient) listed in this report would enhance it significantly.
>
> Yours,
> Aleksandar
>
>
> On Monday, July 27, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> wrote:
>
>> Hi everyone,
>>
>> The sixth report of the TCG Continuous Benchmarking project presents a
>> performance comparison between two different QEMU builds, GCC and Clang.
>>
>> The report also presents five new benchmarks to allow for a variety of
>> test workloads. Each of the five benchmarks is executed for seventeen
>> different QEMU targets on both the GCC and Clang builds.
>>
>> The resulting ten tables are then summarized then analyzed using the
>> list_helpers.py and list_fn_callees.py scripts. The entire workflow is
>> automated using Python scripts that are posted in the report.
>>
>> Report link:
>>
>> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Performance-Comparison-of-Two-QEMU-Builds/
>>
>> Previous reports:
>> Report 1 - Measuring Basic Performance Metrics of QEMU:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>> Report 2 - Dissecting QEMU Into Three Main Parts:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
>> Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
>> Report 4 - Listing QEMU Helpers and Function Callees:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
>> Report 5 - Finding Commits Affecting QEMU Performance:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html
>>
>> Best regards,
>> Ahmed Karaman
>>
>

--000000000000c1b8d905ad788ec5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-family:sans-serif">Thanks Mr. Aleksan=
dar for your feedback!</span></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Aug 22, 2020, 1:09 PM Aleksandar Mark=
ovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu=
.devel@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,=
 Ahmed.<div><br></div><div>The report, and the topic in general, look quite=
 interesting. However, I would suggest two improvements:<div><div><br></div=
><div>- The title should reflect the content in a clearer way. Let&#39;s sa=
y, &quot;Compilers and QEMU performance&quot; would be IMHO better. The exp=
ression &quot;two builds&quot; is just missing the central motivation of th=
e report, which is comparing gcc-built QEMU and clang-built QEMU, performan=
ce-wise.</div><div><br></div><div>- At the end, a section &quot;Useful link=
s&quot; would be handy, akin to the similar section in Report 1. There were=
 many people that analysed (and posted their results on the internet) gcc v=
s clang in terms of performance of produced executables (in contexts other =
than QEMU). Having the most useful and informative ones (3-5 links with a s=
hort summary for each one would be more than sufficient) listed in this rep=
ort would enhance it significantly.</div><div><br></div><div>Yours,</div><d=
iv>Aleksandar</div><div><br></div><div><br>On Monday, July 27, 2020, Ahmed =
Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blan=
k" rel=3D"noreferrer">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"auto">Hi everyone,<br>
<br>
The sixth report of the TCG Continuous Benchmarking project presents a<br>
performance comparison between two different QEMU builds, GCC and Clang.<br=
>
<br>
The report also presents five new benchmarks to allow for a variety of<br>
test workloads. Each of the five benchmarks is executed for seventeen<br>
different QEMU targets on both the GCC and Clang builds.<br>
<br>
The resulting ten tables are then summarized then analyzed using the<br>
list_helpers.py and list_fn_callees.py scripts. The entire workflow is<br>
automated using Python scripts that are posted in the report.<br>
<br>
Report link:<br>
<a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Performa=
nce-Comparison-of-Two-QEMU-Builds/" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking=
/Performance-Comparison-of-Two-QEMU-Builds/</a><br>
<br>
Previous reports:<br>
Report 1 - Measuring Basic Performance Metrics of QEMU:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.h=
tml" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lis=
ts.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html</a><br>
Report 2 - Dissecting QEMU Into Three Main Parts:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.h=
tml" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lis=
ts.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html</a><br>
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.h=
tml" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lis=
ts.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html</a><br>
Report 4 - Listing QEMU Helpers and Function Callees:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.h=
tml" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lis=
ts.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html</a><br>
Report 5 - Finding Commits Affecting QEMU Performance:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.h=
tml" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lis=
ts.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html</a><br>
<br>
Best regards,<br>
Ahmed Karaman<br></div>
</blockquote></div></div></div>
</blockquote></div>

--000000000000c1b8d905ad788ec5--

