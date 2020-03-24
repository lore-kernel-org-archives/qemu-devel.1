Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D70FC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF98F2078A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt7daCNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF98F2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGseg-0002m3-Se
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jGrBk-0004Hp-ET
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jGrBi-00085U-Rx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:34:20 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:44175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jGrBi-00083c-GL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:34:18 -0400
Received: by mail-lf1-x136.google.com with SMTP id j188so39267lfj.11
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=53/md1JqTQkFD74L2EFCTp7jsBSAsRO0O7qmEfqN7Cw=;
 b=Qt7daCNoRXiv1/P1p5X04kPkpqa4b2hh0sW7Wj/cZ8FN62kY/3I/OBW433BQpj2CKb
 BW6AAw5xbbPzC+umU+j9bDAftx0fpEcYOztjGUaJJKDJ4Q0V5OMKz0fSv9sqwGlyauoN
 971nMMtimdQYkVLGuhtOzy4L7uO+UpSYR1VvzZl0LG4XJwR8nT29pWseHLhw4uzvB1/l
 VctLlnnP7uO9u9BLzt0DGojpzFBqHcmfcOUDnJ/m20S4yAJMkEhWeGS83lESFFLSJ9aD
 qPYxKCLdVzXA5fi1KK96G44Nh75a32vvyr10jL/HhMPGXPRJI0Y2EitNke9X5wdUprmQ
 C3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=53/md1JqTQkFD74L2EFCTp7jsBSAsRO0O7qmEfqN7Cw=;
 b=CPGn1SV7XrKi93c9t3L6LtuNuixF1YCBcXQ8X35gEH6Uya/hh0mVIIjVoKLnkfCIUo
 k9eQtVUmlJtNDqZVjGyCsAe7Tv0vwnyDzvbzT6g9C13N0rX1/QPEgWIM6PQOvGNSXbh3
 VCeK1wKDljvB5GAa6AsnR1dpbWHQ44v1xlClYX4ZsGG3Mmj9gcx7T13exKuZympQQTkd
 ZhJXuleUb334hh+EAuSyjajo45X6hWyYvixNGqna0MGFutWmRkyZcC8YkcM0BIyeH0nd
 eiRNPyOWpT1k9KVADQsfZWTx78ze9q+cctIthT9Lfc0R2O67ImdZ2xvHrzm4yWBCUe9I
 Hm7w==
X-Gm-Message-State: ANhLgQ1KGTxotPvy4akR6TfjdsVbXfBaprvOpmNLX2Y8fjSjdnEIuIZt
 p3MivjYfsx6TxDl2Lle4p7HloqNGUqRmEatwX/8=
X-Google-Smtp-Source: ADFU+vumr9fuzuWKikNP/LaVWIWeYaIc3orWCwuXfUgbWshp/HuDrnPVDN2UsDYOYjZtQQY4Os0o3weeCBHjuWN22Kg=
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr59575lfi.57.1585085656850;
 Tue, 24 Mar 2020 14:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGT9xrDKJQW6HV6OWDDck=H0bGzk=7ZTVn6tTfNnv=tH0sr1nA@mail.gmail.com>
 <CAFEAcA-sY_H5s6j4ZEZ+SMvQgyENF+w+v5ajiJOhHDrn_zfjrA@mail.gmail.com>
 <CAGT9xrBS_Hp5VHjZeSP4q5CMEbzu33B3Jza+nxGybK-n4QLQGA@mail.gmail.com>
 <CAFEAcA_nwwOyaadO7AuQ1dax0gQTfVEvwtCQS2OSmn+OcMUAWQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_nwwOyaadO7AuQ1dax0gQTfVEvwtCQS2OSmn+OcMUAWQ@mail.gmail.com>
From: Mansour Ahmadi <mansourweb@gmail.com>
Date: Tue, 24 Mar 2020 17:34:05 -0400
Message-ID: <CAGT9xrDmBD8BR3mYXho9T4a3Q3Xg2OTdJZ82Ggx9TRMGMxG9rQ@mail.gmail.com>
Subject: Re: Potential missing checks
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000083e88405a1a08369"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::136
X-Mailman-Approved-At: Tue, 24 Mar 2020 19:07:07 -0400
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000083e88405a1a08369
Content-Type: text/plain; charset="UTF-8"

Thanks for the explanation.


On Tue, Mar 24, 2020 at 5:17 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 24 Mar 2020 at 20:39, Mansour Ahmadi <mansourweb@gmail.com> wrote:
> >
> > Thank you for looking into this, Peter. I agree that static analysis has
> false positives; that's why I called them potential. Basically, they are
> found based on code similarity so I might be wrong and I need a second
> opinion from QEMU developers. I appreciate your effort.
>
> The thing is, you're making us do all the work here. That's
> not very useful to us. It's doubly unuseful when there's
> a strong chance that when we do do the work of looking
> at the code it turns out that there's no problem.
>
> "I did some static analysis, and I looked at the
> results, and I dug through the QEMU code, and it
> does seem to me that this could well be a bug" is
> definitely useful. "I did some static analysis using
> only analysis techniques that have an pretty
> low false positive rate, and here is a selection of
> the results" is also useful. But "I just ran the
> code through an analyser that produces lots of
> false positives and then I didn't do any further
> human examination of the results" is of much less
> utility to the project, I'm afraid.
>
> > For the first case, I noticed a check on offset (if (offset)) before
> negating it and passing to stream function here.
> >
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748
> >
> > Similar scenario happened here WITHOUT the check:
> >
> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2731-L2733
>
> So, this is in the disassembler. The difference is
> just whether we print out a register+offset memory
> reference where the offset happens to be zero
> as "[reg, #0]" or just "[reg]", and the no-special-case-0
> is for encodings which are always pc-relative.
> So even if it was a missing check the results are
> entirely harmless, since anybody reading the disassembly
> will understand the #0 fine.
>
> Secondly, this code is imported from binutils,
> so we usually don't worry too much about fixing
> up minor bugs in it.
>
> Finally, I went and checked the Arm specs, and for
> the kinds of PC-relative load/store that the second
> example is handling the specified disassembly format
> does mandate the "pc, #0" (whereas the other example
> is correctly skipping it for 0-immediates because
> in those insns the offset is optional in disassembly).
>
> So the code is correct as it stands.
>
> thanks
> -- PMM
>

--00000000000083e88405a1a08369
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large">Thanks for the explanation.=C2=A0</div><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Mar 24, 2020 at 5:17 PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@l=
inaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Tue, 24 Mar 2020 at 20:39, Mansour Ah=
madi &lt;<a href=3D"mailto:mansourweb@gmail.com" target=3D"_blank">mansourw=
eb@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Thank you for looking into this, Peter. I agree that static analysis h=
as false positives; that&#39;s why I called them potential. Basically, they=
 are found based on code similarity so I might be wrong and I need a second=
 opinion from QEMU developers. I appreciate your effort.<br>
<br>
The thing is, you&#39;re making us do all the work here. That&#39;s<br>
not very useful to us. It&#39;s doubly unuseful when there&#39;s<br>
a strong chance that when we do do the work of looking<br>
at the code it turns out that there&#39;s no problem.<br>
<br>
&quot;I did some static analysis, and I looked at the<br>
results, and I dug through the QEMU code, and it<br>
does seem to me that this could well be a bug&quot; is<br>
definitely useful. &quot;I did some static analysis using<br>
only analysis techniques that have an pretty<br>
low false positive rate, and here is a selection of<br>
the results&quot; is also useful. But &quot;I just ran the<br>
code through an analyser that produces lots of<br>
false positives and then I didn&#39;t do any further<br>
human examination of the results&quot; is of much less<br>
utility to the project, I&#39;m afraid.<br>
<br>
&gt; For the first case, I noticed a check on offset (if (offset)) before n=
egating it and passing to stream function here.<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308=
f75f1b95bd4df76/disas/arm.c#L1748" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/dis=
as/arm.c#L1748</a><br>
&gt;<br>
&gt; Similar scenario happened here WITHOUT the check:<br>
&gt; <a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308=
f75f1b95bd4df76/disas/arm.c#L2731-L2733" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df=
76/disas/arm.c#L2731-L2733</a><br>
<br>
So, this is in the disassembler. The difference is<br>
just whether we print out a register+offset memory<br>
reference where the offset happens to be zero<br>
as &quot;[reg, #0]&quot; or just &quot;[reg]&quot;, and the no-special-case=
-0<br>
is for encodings which are always pc-relative.<br>
So even if it was a missing check the results are<br>
entirely harmless, since anybody reading the disassembly<br>
will understand the #0 fine.<br>
<br>
Secondly, this code is imported from binutils,<br>
so we usually don&#39;t worry too much about fixing<br>
up minor bugs in it.<br>
<br>
Finally, I went and checked the Arm specs, and for<br>
the kinds of PC-relative load/store that the second<br>
example is handling the specified disassembly format<br>
does mandate the &quot;pc, #0&quot; (whereas the other example<br>
is correctly skipping it for 0-immediates because<br>
in those insns the offset is optional in disassembly).<br>
<br>
So the code is correct as it stands.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--00000000000083e88405a1a08369--

