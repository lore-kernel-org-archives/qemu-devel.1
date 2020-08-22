Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82052C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 11:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479EC20720
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 11:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6b5RoE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479EC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9RPI-0001Hn-J8
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 07:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k9ROT-0000qj-UB
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 07:09:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k9ROR-0008Bj-Rd
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 07:09:05 -0400
Received: by mail-wr1-x434.google.com with SMTP id a5so4187912wrm.6
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=fHTGMUds8xS31xKTH1dHltNEJ13HotOQmnjytc3G5cI=;
 b=p6b5RoE1NVOmAsI3MDe79CE/L3oAVhSuGri9qDBv6/nPxKfR1/rBETO9SpIGZoag6R
 dshxyt7DP3lDgRV7qeow+5+jxxDF2sCLrGzCzs8eorsPPLnRZdK42g9qwNdSAWwjw03n
 HogFP9wd+b4JFIWLUkh0DBa3x0RxGfWENoCSbB0d/ye6S2iMQveAK4TaTJYPIh7w/pjQ
 JxA6KsXcdUfJikjjhRwmK7OltbnWVvTj/WeKH7VeF6YmwiwMhnIFqgxUEN021/cuRLQJ
 SUmiIlYyF0ga+8E3rYZCf9WSoQEdZgcCnVOuRTNKnWAhGdwppBywkyJL4/DTIMJM2VUf
 QTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=fHTGMUds8xS31xKTH1dHltNEJ13HotOQmnjytc3G5cI=;
 b=XWRBlSKGqyCEm5EXwAnCKJY8gOnpLEz+FPTw3fY4ESEXZt0qyNZjHInv9yvZ63iWUd
 q7JALyKYQD20HGp+T/YTTuTWw+uwDyEN6dDVoVeKifSIqMAccuiiqXCz0XMINjZvDbfZ
 8X30MLfVzV/M8reOz5GcmX929YRRQWgknD2DN42TKZCdR0ZPBZbIywOvm9HWf4L3zBX+
 tSPGHbrtnT6otbUgpMCBRvYkUzCJkRV/jM0I7oPmkuzIF+bZmEHIWGJgCs2fw7FD616q
 HVJ+4t1iYNMRvD5g6FivwCugF6WBqBKlTJowiDk2CT2cJniDSY/CZ9mV2UVaePYHN8R7
 hvUQ==
X-Gm-Message-State: AOAM532DRUNVJy6yUi+pFWb8ds1SSdyoYzN2nTCaQV5tpULVZMj7NReU
 YuHSaSOthH4DCWRvbs1sNNzldq6Q713azvb0hMI=
X-Google-Smtp-Source: ABdhPJw8DDuESaW4PaS3e8n/Qw0hicu+Y/7n7OFKlEhBVlXGkO5I0maSBivFjuW6tyhLV3AajRmtMX62oOVdUIu/Lss=
X-Received: by 2002:adf:b34a:: with SMTP id k10mr6656768wrd.402.1598094542339; 
 Sat, 22 Aug 2020 04:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:2489:0:0:0:0:0 with HTTP; Sat, 22 Aug 2020 04:09:02
 -0700 (PDT)
In-Reply-To: <CALTWKrWnseJidqDTDQM9TY3JfmvXy_0JufH9rR6hZHoAXkP8VQ@mail.gmail.com>
References: <CALTWKrWnseJidqDTDQM9TY3JfmvXy_0JufH9rR6hZHoAXkP8VQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 22 Aug 2020 13:09:02 +0200
Message-ID: <CAHiYmc5Z5T9-vKe-c9N2GHwHdc+QM9Aznb84oOR6u+A53NuJOQ@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#6] Performance
 Comparison of Two QEMU Builds
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008381bf05ad756128"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x434.google.com
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

--0000000000008381bf05ad756128
Content-Type: text/plain; charset="UTF-8"

Hi, Ahmed.

The report, and the topic in general, look quite interesting. However, I
would suggest two improvements:

- The title should reflect the content in a clearer way. Let's say,
"Compilers and QEMU performance" would be IMHO better. The expression "two
builds" is just missing the central motivation of the report, which is
comparing gcc-built QEMU and clang-built QEMU, performance-wise.

- At the end, a section "Useful links" would be handy, akin to the similar
section in Report 1. There were many people that analysed (and posted their
results on the internet) gcc vs clang in terms of performance of produced
executables (in contexts other than QEMU). Having the most useful and
informative ones (3-5 links with a short summary for each one would be more
than sufficient) listed in this report would enhance it significantly.

Yours,
Aleksandar


On Monday, July 27, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> Hi everyone,
>
> The sixth report of the TCG Continuous Benchmarking project presents a
> performance comparison between two different QEMU builds, GCC and Clang.
>
> The report also presents five new benchmarks to allow for a variety of
> test workloads. Each of the five benchmarks is executed for seventeen
> different QEMU targets on both the GCC and Clang builds.
>
> The resulting ten tables are then summarized then analyzed using the
> list_helpers.py and list_fn_callees.py scripts. The entire workflow is
> automated using Python scripts that are posted in the report.
>
> Report link:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/
> Performance-Comparison-of-Two-QEMU-Builds/
>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> Report 2 - Dissecting QEMU Into Three Main Parts:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
> Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
> Report 4 - Listing QEMU Helpers and Function Callees:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
> Report 5 - Finding Commits Affecting QEMU Performance:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html
>
> Best regards,
> Ahmed Karaman
>

--0000000000008381bf05ad756128
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ahmed.<div><br></div><div>The report, and the topic in general, look qu=
ite interesting. However, I would suggest two improvements:<div><div><br></=
div><div>- The title should reflect the content in a clearer way. Let&#39;s=
 say, &quot;Compilers and QEMU performance&quot; would be IMHO better. The =
expression &quot;two builds&quot; is just missing the central motivation of=
 the report, which is comparing gcc-built QEMU and clang-built QEMU, perfor=
mance-wise.</div><div><br></div><div>- At the end, a section &quot;Useful l=
inks&quot; would be handy, akin to the similar section in Report 1. There w=
ere many people that analysed (and posted their results on the internet) gc=
c vs clang in terms of performance of produced executables (in contexts oth=
er than QEMU). Having the most useful and informative ones (3-5 links with =
a short summary for each one would be more than sufficient) listed in this =
report would enhance it significantly.</div><div><br></div><div>Yours,</div=
><div>Aleksandar</div><div><br></div><div><br>On Monday, July 27, 2020, Ahm=
ed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">ahmedkhaledk=
araman@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"auto">Hi everyone,<br>
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
nce-Comparison-of-Two-QEMU-Builds/" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://ahmedkrmn.github.io/<wbr>TCG-Continuous-Benchmarking/<wbr>=
Performance-Comparison-of-Two-<wbr>QEMU-Builds/</a><br>
<br>
Previous reports:<br>
Report 1 - Measuring Basic Performance Metrics of QEMU:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/<wbr>html/qemu-devel/2020-06/<wbr>msg06692.html</a><br>
Report 2 - Dissecting QEMU Into Three Main Parts:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/<wbr>html/qemu-devel/2020-06/<wbr>msg09441.html</a><br>
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/<wbr>html/qemu-devel/2020-07/<wbr>msg01978.html</a><br>
Report 4 - Listing QEMU Helpers and Function Callees:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/<wbr>html/qemu-devel/2020-07/<wbr>msg04227.html</a><br>
Report 5 - Finding Commits Affecting QEMU Performance:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/<wbr>html/qemu-devel/2020-07/<wbr>msg05769.html</a><br>
<br>
Best regards,<br>
Ahmed Karaman<br></div>
</blockquote></div></div></div>

--0000000000008381bf05ad756128--

