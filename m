Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DCCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45BB2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb4ltEgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45BB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BGc-0007V3-8r
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k0BFx-0006pu-0Q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 18:06:01 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1k0BFu-0005UJ-O7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 18:06:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so16224518wml.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Rd7/3lgqX9EsRwGBofFGHvyaXidj+bwVM4fbePKyHBE=;
 b=sb4ltEgEOy/lp3syHKtEPUu9ZeGvRmIt25sgstF14MDuK/92PVAe4jRHhghKizM8ak
 KPb/BfI7/L/zBlXvmv1Zs8JsGgv6/OR/ArMr/caIGfDI/eFbtYo6HHasJ/5bwY/vmVHW
 jrizrQw4s9MBoylautNLAI2ThMg/acBYVrbbhCeepWoLs8bpV2AjM6A1FWGWttveVp/Z
 E9Gcigiu+X8cXab4KP2j9+gqSY2jQUx0HU4gSYQ9etQIrOwXwjNjHbuIQWu4k1wB9kbO
 ViK42uI7noJastnkZTqVGXl2kxONnjgxltmN7vizVEcCOjgzRXOlwNxmzVS8w2WLCqRR
 80MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Rd7/3lgqX9EsRwGBofFGHvyaXidj+bwVM4fbePKyHBE=;
 b=OASCZLNSyrkE4taEdsmlMGiiYJC7Nh5ICmPVauK/V+5R7h2YOw14K7ctJngYwgKt44
 BYkpljKrB0Wq27JyXk7QnczdthPVNB6RYHt0jZ3nUYVMWwdbmfAj/Ecv4kPL859eTW0n
 Z/VbykDENQ9K+MKx0D/ZDajeE1p5rVaEyPcKFqE6hq3u85sCKyAtApPURTWIiZ6XlMjV
 pyKMZpUULwmJnHc0Bu7HNlcS1FIRq2lIR06quuNy9eDPzgh0CcwV++ATv1R+6qvVl5Dg
 YxzhHKEWrcOy7lzGylDiFpSO4isd0Sub8dNhrW0nNnKP8E5kOq+28D91SDSgaGlxoFWX
 1/HQ==
X-Gm-Message-State: AOAM5314Rwb/Ojf4AoplQqDHFjXbQX61UGq3fGxO99+Gw1WFk93EL7QW
 hj4j+NfhJfRU9RZ0SyDVdq4pB87xUXSqBlZxpPw=
X-Google-Smtp-Source: ABdhPJzPsjAFXP1f4G/8MY3++P/skfck/sOcgSfG27yjMvAqyf3p42mas9triQnQMlwmc2LQ5JouohIgyz0Ch87G+mg=
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr1039579wme.159.1595887556640; 
 Mon, 27 Jul 2020 15:05:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1bca:0:0:0:0:0 with HTTP; Mon, 27 Jul 2020 15:05:56
 -0700 (PDT)
In-Reply-To: <a8c14108-7320-c8aa-c849-10e082496058@redhat.com>
References: <20200721231536.21604-1-ahmedkhaledkaraman@gmail.com>
 <20200721231536.21604-2-ahmedkhaledkaraman@gmail.com>
 <CAHiYmc4e=8cb4q1Gn5i=Jx=coPQBozXHT=7kK+gKeA=vi16-7g@mail.gmail.com>
 <a8c14108-7320-c8aa-c849-10e082496058@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 28 Jul 2020 00:05:56 +0200
Message-ID: <CAHiYmc6jmy6tJBDOH8GErD11TSPx++tcV8VM1XYZ4+7MJxtUew@mail.gmail.com>
Subject: Re: [PATCH 1/1] scripts/performance: Add bisect.py script
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ea422305ab738652"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 "crosa@redhat.com" <crosa@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ea422305ab738652
Content-Type: text/plain; charset="UTF-8"

On Monday, July 27, 2020, John Snow <jsnow@redhat.com> wrote:

> On 7/25/20 8:31 AM, Aleksandar Markovic wrote:
>
>>
>>
>> On Wednesday, July 22, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>> <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
>>
>>     Python script that locates the commit that caused a performance
>>     degradation or improvement in QEMU using the git bisect command
>>     (binary search).
>>
>>     Syntax:
>>     bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
>>     --target TARGET --tool {perf,callgrind} -- \
>>     <target executable> [<target executable options>]
>>
>>     [-h] - Print the script arguments help message
>>     -s,--start START - First commit hash in the search range
>>     [-e,--end END] - Last commit hash in the search range
>>                      (default: Latest commit)
>>     [-q,--qemu QEMU] - QEMU path.
>>                      (default: Path to a GitHub QEMU clone)
>>     --target TARGET - QEMU target name
>>     --tool {perf,callgrind} - Underlying tool used for measurements
>>
>>     Example of usage:
>>     bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc \
>>     --tool=perf -- coulomb_double-ppc -n 1000
>>
>>     Example output:
>>     Start Commit Instructions:     12,710,790,060
>>     End Commit Instructions:       13,031,083,512
>>     Performance Change:            -2.458%
>>
>>     Estimated Number of Steps:     10
>>
>>     *****************BISECT STEP 1*****************
>>     Instructions:        13,031,097,790
>>     Status:              slow commit
>>     *****************BISECT STEP 2*****************
>>     Instructions:        12,710,805,265
>>     Status:              fast commit
>>     *****************BISECT STEP 3*****************
>>     Instructions:        13,031,028,053
>>     Status:              slow commit
>>     *****************BISECT STEP 4*****************
>>     Instructions:        12,711,763,211
>>     Status:              fast commit
>>     *****************BISECT STEP 5*****************
>>     Instructions:        13,031,027,292
>>     Status:              slow commit
>>     *****************BISECT STEP 6*****************
>>     Instructions:        12,711,748,738
>>     Status:              fast commit
>>     *****************BISECT STEP 7*****************
>>     Instructions:        12,711,748,788
>>     Status:              fast commit
>>     *****************BISECT STEP 8*****************
>>     Instructions:        13,031,100,493
>>     Status:              slow commit
>>     *****************BISECT STEP 9*****************
>>     Instructions:        12,714,472,954
>>     Status:              fast commit
>>     ****************BISECT STEP 10*****************
>>     Instructions:        12,715,409,153
>>     Status:              fast commit
>>     ****************BISECT STEP 11*****************
>>     Instructions:        12,715,394,739
>>     Status:              fast commit
>>
>>     *****************BISECT RESULT*****************
>>     commit 0673ecdf6cb2b1445a85283db8cbacb251c46516
>>     Author: Richard Henderson <richard.henderson@linaro.org
>>     <mailto:richard.henderson@linaro.org>>
>>     Date:   Tue May 5 10:40:23 2020 -0700
>>
>>          softfloat: Inline float64 compare specializations
>>
>>          Replace the float64 compare specializations with inline functions
>>          that call the standard float64_compare{,_quiet} functions.
>>          Use bool as the return type.
>>     ***********************************************
>>
>>     Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>>     <mailto:ahmedkhaledkaraman@gmail.com>>
>>     ---
>>       scripts/performance/bisect.py | 374 ++++++++++++++++++++++++++++++
>> ++++
>>       1 file changed, 374 insertions(+)
>>       create mode 100755 scripts/performance/bisect.py
>>
>>     diff --git a/scripts/performance/bisect.py
>>     b/scripts/performance/bisect.py
>>     new file mode 100755
>>     index 0000000000..869cc69ef4
>>     --- /dev/null
>>     +++ b/scripts/performance/bisect.py
>>     @@ -0,0 +1,374 @@
>>     +#!/usr/bin/env python3
>>     +
>>     +#  Locate the commit that caused a performance degradation or
>>     improvement in
>>     +#  QEMU using the git bisect command (binary search).
>>     +#
>>     +#  Syntax:
>>     +#  bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEMU] \
>>     +#  --target TARGET --tool {perf,callgrind} -- \
>>     +#  <target executable> [<target executable options>]
>>     +#
>>     +#  [-h] - Print the script arguments help message
>>     +#  -s,--start START - First commit hash in the search range
>>     +#  [-e,--end END] - Last commit hash in the search range
>>     +#             (default: Latest commit)
>>     +#  [-q,--qemu QEMU] - QEMU path.
>>     +#              (default: Path to a GitHub QEMU clone)
>>     +#  --target TARGET - QEMU target name
>>     +#  --tool {perf,callgrind} - Underlying tool used for measurements
>>     +
>>     +#  Example of usage:
>>     +#  bisect.py --start=fdd76fecdd --qemu=/path/to/qemu --target=ppc
>>     --tool=perf \
>>     +#  -- coulomb_double-ppc -n 1000
>>     +#
>>     +#  This file is a part of the project "TCG Continuous Benchmarking".
>>     +#
>>     +#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>>     <mailto:ahmedkhaledkaraman@gmail.com>>
>>     +#  Copyright (C) 2020  Aleksandar Markovic
>>     <aleksandar.qemu.devel@gmail.com
>>     <mailto:aleksandar.qemu.devel@gmail.com>>
>>     +#
>>
>>
>> Hi, Ahmed.
>>
>> Yes, somewhat related to John's hints on these comments, it is customary
>> to have just a brief description before "Copyright" lines. This means one
>> sentence, or a short paragraph (3-4 sentences max). The lenghty syntax
>> commemt should be, in my opinion, moved after the license preamble, just
>> before the start of real Python code.
>>
>>
> I think it's fine in the module-level docstring. Those are sometimes
> pretty long and generally refer you to other functions/classes/etc of
> interest.
>
> In this case, this is intended to be an executable script / entrypoint, so
> having the syntax up top isn't really such a cumbersome thing.
>
> That said, it might be prone to rot up here. Moving it to a docstring for
> the main() function, near where the parser is actually constructed, might
> help preserve accuracy for longer, at the expense of burying it deeper into
> the file.
>
>
Yes,, I too actually think that is a better position.

It's an extremely minor point, and I'm afraid of getting lost too deeply in
> bikeshedding for a GSoC submission. I will be happy to see pylint/flake8
> pass. (In pylint's case: some minimum exceptions to turn off warnings for
> too many lines / too many variables is good.)
>
>
Close to or even after the end of the project, Ahmed could clean up all
previously submitted scripts as well. It is natural that he perfects his
style over time.

Aleksandar


--js
>
>

--000000000000ea422305ab738652
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, July 27, 2020, John Snow &lt;<a href=3D"mailto:jsnow@red=
hat.com">jsnow@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On 7/25/20 8:31 AM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On Wednesday, July 22, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhale=
dkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a> &lt;=
mailto:<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blank">ah=
medkhaledkaraman@gma<wbr>il.com</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 Python script that locates the commit that caused a performan=
ce<br>
=C2=A0 =C2=A0 degradation or improvement in QEMU using the git bisect comma=
nd<br>
=C2=A0 =C2=A0 (binary search).<br>
<br>
=C2=A0 =C2=A0 Syntax:<br>
=C2=A0 =C2=A0 bisect.py [-h] -s,--start START [-e,--end END] [-q,--qemu QEM=
U] \<br>
=C2=A0 =C2=A0 --target TARGET --tool {perf,callgrind} -- \<br>
=C2=A0 =C2=A0 &lt;target executable&gt; [&lt;target executable options&gt;]=
<br>
<br>
=C2=A0 =C2=A0 [-h] - Print the script arguments help message<br>
=C2=A0 =C2=A0 -s,--start START - First commit hash in the search range<br>
=C2=A0 =C2=A0 [-e,--end END] - Last commit hash in the search range<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (default: Latest commit)<br>
=C2=A0 =C2=A0 [-q,--qemu QEMU] - QEMU path.<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (default: Path to a GitHub QEMU clone)<br>
=C2=A0 =C2=A0 --target TARGET - QEMU target name<br>
=C2=A0 =C2=A0 --tool {perf,callgrind} - Underlying tool used for measuremen=
ts<br>
<br>
=C2=A0 =C2=A0 Example of usage:<br>
=C2=A0 =C2=A0 bisect.py --start=3Dfdd76fecdd --qemu=3D/path/to/qemu --targe=
t=3Dppc \<br>
=C2=A0 =C2=A0 --tool=3Dperf -- coulomb_double-ppc -n 1000<br>
<br>
=C2=A0 =C2=A0 Example output:<br>
=C2=A0 =C2=A0 Start Commit Instructions:=C2=A0 =C2=A0 =C2=A012,710,790,060<=
br>
=C2=A0 =C2=A0 End Commit Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A013,031,083=
,512<br>
=C2=A0 =C2=A0 Performance Change:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
-2.458%<br>
<br>
=C2=A0 =C2=A0 Estimated Number of Steps:=C2=A0 =C2=A0 =C2=A010<br>
<br>
=C2=A0 =C2=A0 *****************BISECT STEP 1*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,097,790<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 2*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,710,805,265<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 3*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,028,053<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 4*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,711,763,211<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 5*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,027,292<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 6*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,711,748,738<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 7*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,711,748,788<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 8*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 13,031,100,493<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slow =
commit<br>
=C2=A0 =C2=A0 *****************BISECT STEP 9*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,714,472,954<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
=C2=A0 =C2=A0 ****************BISECT STEP 10*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,715,409,153<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
=C2=A0 =C2=A0 ****************BISECT STEP 11*****************<br>
=C2=A0 =C2=A0 Instructions:=C2=A0 =C2=A0 =C2=A0 =C2=A0 12,715,394,739<br>
=C2=A0 =C2=A0 Status:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fast =
commit<br>
<br>
=C2=A0 =C2=A0 *****************BISECT RESULT*****************<br>
=C2=A0 =C2=A0 commit 0673ecdf6cb2b1445a85283db8cbac<wbr>b251c46516<br>
=C2=A0 =C2=A0 Author: Richard Henderson &lt;<a href=3D"mailto:richard.hende=
rson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:richard.henderson@linaro.org" ta=
rget=3D"_blank">richard.henderson@lina<wbr>ro.org</a>&gt;&gt;<br>
=C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Tue May 5 10:40:23 2020 -0700<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 softfloat: Inline float64 compare special=
izations<br>
<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 Replace the float64 compare specializatio=
ns with inline functions<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 that call the standard float64_compare{,_=
quiet} functions.<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 Use bool as the return type.<br>
=C2=A0 =C2=A0 ******************************<wbr>*****************<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhale=
dkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaraman@gmail.com</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" ta=
rget=3D"_blank">ahmedkhaledkaraman@gma<wbr>il.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0scripts/performance/bisect.<wbr>py | 374 ++++++++=
++++++++++++++++++++++<wbr>++++<br>
=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 374 insertions(+)<br>
=C2=A0 =C2=A0 =C2=A0=C2=A0create mode 100755 scripts/performance/bisect.py<=
br>
<br>
=C2=A0 =C2=A0 diff --git a/scripts/performance/bisect.p<wbr>y<br>
=C2=A0 =C2=A0 b/scripts/performance/bisect.p<wbr>y<br>
=C2=A0 =C2=A0 new file mode 100755<br>
=C2=A0 =C2=A0 index 0000000000..869cc69ef4<br>
=C2=A0 =C2=A0 --- /dev/null<br>
=C2=A0 =C2=A0 +++ b/scripts/performance/bisect.p<wbr>y<br>
=C2=A0 =C2=A0 @@ -0,0 +1,374 @@<br>
=C2=A0 =C2=A0 +#!/usr/bin/env python3<br>
=C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 +#=C2=A0 Locate the commit that caused a performance degradat=
ion or<br>
=C2=A0 =C2=A0 improvement in<br>
=C2=A0 =C2=A0 +#=C2=A0 QEMU using the git bisect command (binary search).<b=
r>
=C2=A0 =C2=A0 +#<br>
=C2=A0 =C2=A0 +#=C2=A0 Syntax:<br>
=C2=A0 =C2=A0 +#=C2=A0 bisect.py [-h] -s,--start START [-e,--end END] [-q,-=
-qemu QEMU] \<br>
=C2=A0 =C2=A0 +#=C2=A0 --target TARGET --tool {perf,callgrind} -- \<br>
=C2=A0 =C2=A0 +#=C2=A0 &lt;target executable&gt; [&lt;target executable opt=
ions&gt;]<br>
=C2=A0 =C2=A0 +#<br>
=C2=A0 =C2=A0 +#=C2=A0 [-h] - Print the script arguments help message<br>
=C2=A0 =C2=A0 +#=C2=A0 -s,--start START - First commit hash in the search r=
ange<br>
=C2=A0 =C2=A0 +#=C2=A0 [-e,--end END] - Last commit hash in the search rang=
e<br>
=C2=A0 =C2=A0 +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(default: L=
atest commit)<br>
=C2=A0 =C2=A0 +#=C2=A0 [-q,--qemu QEMU] - QEMU path.<br>
=C2=A0 =C2=A0 +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (default: =
Path to a GitHub QEMU clone)<br>
=C2=A0 =C2=A0 +#=C2=A0 --target TARGET - QEMU target name<br>
=C2=A0 =C2=A0 +#=C2=A0 --tool {perf,callgrind} - Underlying tool used for m=
easurements<br>
=C2=A0 =C2=A0 +<br>
=C2=A0 =C2=A0 +#=C2=A0 Example of usage:<br>
=C2=A0 =C2=A0 +#=C2=A0 bisect.py --start=3Dfdd76fecdd --qemu=3D/path/to/qem=
u --target=3Dppc<br>
=C2=A0 =C2=A0 --tool=3Dperf \<br>
=C2=A0 =C2=A0 +#=C2=A0 -- coulomb_double-ppc -n 1000<br>
=C2=A0 =C2=A0 +#<br>
=C2=A0 =C2=A0 +#=C2=A0 This file is a part of the project &quot;TCG Continu=
ous Benchmarking&quot;.<br>
=C2=A0 =C2=A0 +#<br>
=C2=A0 =C2=A0 +#=C2=A0 Copyright (C) 2020=C2=A0 Ahmed Karaman &lt;<a href=
=3D"mailto:ahmedkhaledkaraman@gmail.com" target=3D"_blank">ahmedkhaledkaram=
an@gmail.com</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:ahmedkhaledkaraman@gmail.com" ta=
rget=3D"_blank">ahmedkhaledkaraman@gma<wbr>il.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 +#=C2=A0 Copyright (C) 2020=C2=A0 Aleksandar Markovic<br>
=C2=A0 =C2=A0 &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=
=3D"_blank">aleksandar.qemu.devel@gmail.c<wbr>om</a><br>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:aleksandar.qemu.devel@gmail.com"=
 target=3D"_blank">aleksandar.qemu.devel@<wbr>gmail.com</a>&gt;&gt;<br>
=C2=A0 =C2=A0 +#<br>
<br>
<br>
Hi, Ahmed.<br>
<br>
Yes, somewhat related to John&#39;s hints on these comments, it is customar=
y to have just a brief description before &quot;Copyright&quot; lines. This=
 means one sentence, or a short paragraph (3-4 sentences max). The lenghty =
syntax commemt should be, in my opinion, moved after the license preamble, =
just before the start of real Python code.<br>
<br>
</blockquote>
<br>
I think it&#39;s fine in the module-level docstring. Those are sometimes pr=
etty long and generally refer you to other functions/classes/etc of interes=
t.<br>
<br>
In this case, this is intended to be an executable script / entrypoint, so =
having the syntax up top isn&#39;t really such a cumbersome thing.<br>
<br>
That said, it might be prone to rot up here. Moving it to a docstring for t=
he main() function, near where the parser is actually constructed, might he=
lp preserve accuracy for longer, at the expense of burying it deeper into t=
he file.<br>
<br></blockquote><div><br></div><div>Yes,, I too actually think that is a b=
etter position.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
It&#39;s an extremely minor point, and I&#39;m afraid of getting lost too d=
eeply in bikeshedding for a GSoC submission. I will be happy to see pylint/=
flake8 pass. (In pylint&#39;s case: some minimum exceptions to turn off war=
nings for too many lines / too many variables is good.)<br>
<br></blockquote><div><br></div><div>Close to or even after the end of the =
project, Ahmed could clean up all previously submitted scripts as well. It =
is natural that he perfects his style over time.</div><div><br></div><div>A=
leksandar</div><div><br></div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
--js<br>
<br>
</blockquote>

--000000000000ea422305ab738652--

