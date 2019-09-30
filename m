Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0966C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6954821855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuDJrhWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6954821855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwp4-0006gA-Fx
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEwno-0005pm-Sq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iEwnn-0000UM-Qi
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:37:28 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:33918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iEwnl-0000TA-Is; Mon, 30 Sep 2019 10:37:25 -0400
Received: by mail-ot1-x332.google.com with SMTP id m19so8534291otp.1;
 Mon, 30 Sep 2019 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=7tRE2xKjPvNzsA3rxJN83DpZubWzL77WPfFJ4406V5c=;
 b=tuDJrhWDCdEoC/gcnzXKpDoD/zMjA+P3Qid/L4RpWplTaLs53boYakYJ3VIVUROic9
 9W8XbiYRcUlSbtJAPjtGdp6LsQZcOR4M/l7QLcd5NFR3PBXeWzhiPyk78+B1J8beHOYS
 /rp4aOmAJtzdkwHLgAQrr4gO/fXH3fXSVrzzj0OPkg4oZIeYh8CYP9B9U+6d5lD703CT
 guP4JjMa4z9b31kQsH9jbuFIj8lsWAe91hpvYXsqt6sTrmXAZ9iQx4oqiNNyCbhvgmOE
 SWO7/4/jINk025ynEzfYDGw2lJNvnv9iTngx8OTtMinsruOX1h11vb/MSvTBUDnpuchS
 bJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=7tRE2xKjPvNzsA3rxJN83DpZubWzL77WPfFJ4406V5c=;
 b=MRYSN/gXk8ATjI989OiZbpaA8L/kYyM3Q4BY2+wov98Jsm49kDG8a5GvwYR1HhKbyq
 yvdmriMJSD28o8MEWEFP7EIpu4UDbcXoPFyhiv6Lteq4zPskVxiTvXXRfLWQPnFfFJMg
 xl+giTJvfgvUYN/k4M4mn4G5ZqVA2IqDC+gwhlqb6mV9BtnikaER+4cmhEafQbAQBbxh
 6SpvbVf7bLpkA594oA62wTHBzAcYmP1ZBFewGcNSMbh3fC/+HOXqcqj2cQg+gvOR9WBI
 uyRbBGYAyMvX8aD1VBkVNJ2Rab/1NEKEkmpKz7cThFP04ap0mlxbVrzgtdVbcgtNqcP8
 GUNg==
X-Gm-Message-State: APjAAAXacjcqf+DLjgdSRITWACyNJsbFSaHOgYxyiIokUGEQZNARBO0R
 kM4HAJAIjICel5SL3UI/NfPXlzYsIVpWVjSw06U=
X-Google-Smtp-Source: APXvYqx8Knpa+Uc16Yp7E9nld1o3TSdPfcNPMgcDZ0/j4240nINKe6RjHY3gJz2DhL7dzluKZYbSCeY4RLYGk/wgcPs=
X-Received: by 2002:a9d:6b19:: with SMTP id g25mr13562992otp.64.1569854244337; 
 Mon, 30 Sep 2019 07:37:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 30 Sep 2019 07:37:23
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 30 Sep 2019 07:37:23
 -0700 (PDT)
In-Reply-To: <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 30 Sep 2019 16:37:23 +0200
Message-ID: <CAL1e-=icPjx3=wD=D7s4qhHgS1nTBgt2xPwvycEjtJu9+yo4ag@mail.gmail.com>
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="000000000000953f230593c62ca1"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: stefan.brankovic@rt-rk.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000953f230593c62ca1
Content-Type: text/plain; charset="UTF-8"

> 5. (a question for Mark) After all recent changes, does get_avr64(...,
..., true) always (for any endian configuration) return the "high" half of
an Altivec register, and get_avr64(..., ..., false) the "low" one?
>
> Given all these circumstances, perhaps the most reasonable solution would
be to revert the commit in question, and allow Stefan enough dev and test
time to hopefully submit a new, better, version later on.
>

Mark, can you verify please that this is true? The thing is, 'vsl/vsr'
belong to the group of SIMD instructions where the distinction between
'high' and 'low' 64-bit halves of the source and destination registers is
important (as opposed to the majority of 'regular' SIMD instructions, like
vector addition, vector max/min, etc., that act only as parallel operations
on corresdponding data elements).

Regards, Aleksandar

> Sincerely,
> Aleksandar
>

--000000000000953f230593c62ca1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
&gt; 5. (a question for Mark) After all recent changes, does get_avr64(...,=
 ..., true) always (for any endian configuration) return the &quot;high&quo=
t; half of an Altivec register, and get_avr64(..., ..., false) the &quot;lo=
w&quot; one?<br>
&gt;<br>
&gt; Given all these circumstances, perhaps the most reasonable solution wo=
uld be to revert the commit in question, and allow Stefan enough dev and te=
st time to hopefully submit a new, better, version later on.<br>
&gt;</p>
<p dir=3D"ltr">Mark, can you verify please that this is true? The thing is,=
 &#39;vsl/vsr&#39; belong to the group of SIMD instructions where the disti=
nction between &#39;high&#39; and &#39;low&#39; 64-bit halves of the source=
 and destination registers is important (as opposed to the majority of &#39=
;regular&#39; SIMD instructions, like vector addition, vector max/min, etc.=
, that act only as parallel operations on corresdponding data elements).</p=
>
<p dir=3D"ltr">Regards, Aleksandar<br></p>
<p dir=3D"ltr">&gt; Sincerely,<br>
&gt; Aleksandar<br>
&gt;<br>
</p>

--000000000000953f230593c62ca1--

