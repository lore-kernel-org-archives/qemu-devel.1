Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763FEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A65255BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFtR0y7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A65255BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpyQJ-0006vL-H7
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpyP1-0006SW-Jq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 14:21:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:39379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jpyOz-0008Ad-R7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 14:21:11 -0400
Received: by mail-ej1-x62f.google.com with SMTP id w6so17669944ejq.6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SBWye2lOG/Myll06BwCeEmWXzd7L7/MK2DVIfHgVsJo=;
 b=RFtR0y7V4ZZX8o50ez2DbE8+iaIMslaSS9sWyTDLcQjesAySgzWQHU6IMXqhBltcYq
 60lFXRDDmcNFYH2ptR1nvvxquJ4cJcI+EsnxwOu3vHzeGe4lvBgvskt9JQS3nlskw+H6
 ybfeuQ1Ql/S+oGZFQVHbDPL2vt0TDv7RqpVeqr2Rw4o13SayMZamNZ5ui7+5gwlOsnEj
 gzWlQSPFm6mwEpDPwyZ5pOx3T9ooKqINRy5UoO95JiFfQJ3qi2EKQj8kJypww/x5qsqW
 0ZgLTaMZTZLX4wqE6Yo043eWn6o5evu/SGuVO1jjlJZel19ZimzGqB2xz5Uxzikqfx0Q
 bV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SBWye2lOG/Myll06BwCeEmWXzd7L7/MK2DVIfHgVsJo=;
 b=BK5aP8DPW8wR565rvUdj2ZAq9Rd9qWQUDVocQMZohabBcn5LASP3MQQjbjN2tLr760
 FbccmwrB2s2pNtNsqAFh90STTLZ44am2Yem5uZEJyVkUrGSTYurXBt1Zwf64s8kPd8ZW
 bqxgSo749iSgFUBO49g6KD2h+6dewupFTIfR+h2Sa5thKAPBztzC46MZjHVF2xH5EFDz
 iprjnJooyUUoKm0OmkHNgph4c1zqqDvZJAhKmjAUwGd6LHRUukiv8DTrQu3q3ZwjIrUk
 ME0cfM5AXTxjKJJVxqYQS18P43fLdXaNKA4SVI0+fwNW8ByJ6TCuXxKIkpnSQfTXqLqK
 2VSA==
X-Gm-Message-State: AOAM532An4tzKgs6AEA0n+y1O0IHax8lb2IEq0Kwn63BL3ML8lYm7tWA
 dqGr/L0yP7TqvW42XqIxg9yuYMpObp2aB+bnKfo=
X-Google-Smtp-Source: ABdhPJzbo2ArQSbIWWcplYcFu2JYLKp9NlihxMHnDYvTjamkZAYPlBYiAn8CCqkX6ESpqcPS5k/3FiLPCREVUcfDqeY=
X-Received: by 2002:a17:907:20c4:: with SMTP id
 qq4mr14692849ejb.85.1593454865324; 
 Mon, 29 Jun 2020 11:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3d0d:0:0:0:0:0 with HTTP; Mon, 29 Jun 2020 11:21:04
 -0700 (PDT)
In-Reply-To: <878sg5svu5.fsf@linaro.org>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <878sg5svu5.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 29 Jun 2020 20:21:04 +0200
Message-ID: <CAL1e-=iGn_YW9w9ZDw5_HZcTU3SjbN4TzEOFAMm8fLs3+-xq2A@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000369e7605a93d1fbb"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ej1-x62f.google.com
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000369e7605a93d1fbb
Content-Type: text/plain; charset="UTF-8"

> I should have also pointed out in your
> by only having one benchmark you are going to miss out on the envelope
> of use cases.
>

Alex, thank you for all your comments, and other perspectives that you
always bring to Ahmed's and everyones else's attention. I always imagine
you as a "four-dimensional" engineer for the your unabashed presentation of
out-of-the-box ideas. I actually truly like this, quite often, inspiring
style.

However, it seems to me that this last paragraph is a little unjust
critique, and as if doesn't come from you.

The report is not about a benchmark, it is about a script that does
something. Ahmed never said "we are going to benchmark" anything. The
program in the report is just an example used for illustration.

And, now you say: it is not good for benchmarking. Well, no example is good
for benchmarking, and, again, the report is not about benchmarking. Why do
you mwntion benchmarking at all than? And what is Ahmed supposed to do? To
flood the report with dozens of programs and dozens of tables, thousands of
numbers, find some average - just to illustrate the script?

The variety of test programs will be the subject of future reports.

Otherwise, all intriguing and useful proposals from your side, and many
thanks for them!!

Yours,
Aleksandar

--000000000000369e7605a93d1fbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">I should have also pointed out in your<b=
r>
by only having one benchmark you are going to miss out on the envelope<br>
of use cases.<br></blockquote><div><br></div><div>Alex, thank you for all y=
our comments, and other perspectives that you always bring to Ahmed&#39;s a=
nd everyones else&#39;s attention. I always imagine you as a &quot;four-dim=
ensional&quot; engineer for the your unabashed presentation of out-of-the-b=
ox ideas. I actually truly like this, quite often, inspiring style.</div><d=
iv><br></div><div>However, it seems to me that this last paragraph is a lit=
tle unjust critique, and as if doesn&#39;t come from you.</div><div><br></d=
iv><div>The report is not about a benchmark, it is about a script that does=
 something. Ahmed never said &quot;we are going to benchmark&quot; anything=
. The program in the report is just an example used for illustration.</div>=
<div><br></div><div>And, now you say: it is not good for benchmarking. Well=
, no example is good for benchmarking, and, again, the report is not about =
benchmarking. Why do you mwntion benchmarking at all than? And what is Ahme=
d supposed to do? To flood the report with dozens of programs and dozens of=
 tables, thousands of numbers, find some average - just to illustrate the s=
cript?</div><div><br></div><div>The variety of test programs will be the su=
bject of future reports.</div><div><br></div><div>Otherwise, all intriguing=
 and useful proposals from your side, and many thanks for them!!</div><div>=
<br></div><div>Yours,</div><div>Aleksandar</div><div><br></div><div><br></d=
iv><div><br></div>

--000000000000369e7605a93d1fbb--

