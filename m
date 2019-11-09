Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D55C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 21:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966B221924
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7TQ/TE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966B221924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTXz1-00027e-OB
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 16:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTXyJ-0001fC-JM
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 16:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTXyI-0006bN-9U
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 16:08:39 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:35187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iTXyI-0006Yi-4O
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 16:08:38 -0500
Received: by mail-oi1-x229.google.com with SMTP id n16so8358909oig.2
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 13:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=URfP3n3L4+3/5EtC2UJ8TnkqEvt2W2ujVmt59hzbGv4=;
 b=q7TQ/TE3o0IEJp37FeaykaPhGc+4xm1Wn+OqhgZmqinr4gwlqArZcXNDrLdUss2JYh
 YGwvYEUG70a5hI14GWPFhwoo9D/XNqr4uq7FWqyhevk0i5Ch8m1J0tWuemBfRVlx3ROl
 9EU5qEBT0zaDmVZsZ9owNFYI2fj1el2X+QjNXgkrbrpo/O5oj2TskDEGTeTwSAH3kFRJ
 1T4xohvvSpBFN1Kixj/bnkMcVgLvrec5jOXqKAWWCiHe25nnjAEsTqEjV46xZSer52FZ
 Gdg16P3ODNoiySZobtXSQlPVTx5FSho006XXytwjUZctIrCdz706cM/ldDm+w91NIkzA
 9HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=URfP3n3L4+3/5EtC2UJ8TnkqEvt2W2ujVmt59hzbGv4=;
 b=XXty0J6JeVLOdUFNz0Hyk5Eb1ZThwRyJDwIxc7VMgrFrdS3VdLynDccoD1ILChjwZw
 IZ/MxMB7U8NUf185WvWuzWNnjVhUFDNVZYAhqZz7MYpVym5UujdLrZ5gMEz2l0kj0z68
 fRhuFGAh1IchrOPcVcK4AIJuULW+scAkFasgk9/38QHpusCXKoQYBXoH+WWe1hSCGMUt
 StWu7a2i89hdN4nuHSbDJBICYRo6Z5AGD/Ij6xp2mNiSWbyqszkxKCaNgpMdtXBPPiTU
 X/Ygh3eBR8TS9Q0a9cksOTttsBC//seymTpB7MdbDOxqncpi7kfgDmXg+v3OTpsTjPJO
 5dtw==
X-Gm-Message-State: APjAAAU0vHXHt8QLZLnSZoxmyZ2r4UoT7dVbZlUnQUkf1byW60xtC+s0
 00MS94z7ToTV0wgqqW613RXKzGEaoUnwgA8t5gA=
X-Google-Smtp-Source: APXvYqxvphgYi6jLvARqdxX/+0qwRBG9c5lfDanoKuEhcBNFxXmFz7J7mTedDtF8n12szhSRvMeccKsHdi6rRmAdAs4=
X-Received: by 2002:aca:650a:: with SMTP id m10mr15851742oim.106.1573333716996; 
 Sat, 09 Nov 2019 13:08:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP;
 Sat, 9 Nov 2019 13:08:36 -0800 (PST)
In-Reply-To: <CAFEAcA-tNBNGE75+MZ3+r_9iLA-_3+meoseVxhgzJZ5PvDofuA@mail.gmail.com>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <CAL1e-=hcS8_2Y1YJS01GTwFbMYBJmWopYkSDi_aw6yzOHk=3Lg@mail.gmail.com>
 <CAFEAcA-tNBNGE75+MZ3+r_9iLA-_3+meoseVxhgzJZ5PvDofuA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 9 Nov 2019 22:08:36 +0100
Message-ID: <CAL1e-=jONDYiF+W6cEvrDFN_RkGSS3FVmaaj2-YE0RpO=GOb7w@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005096770596f04d9e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: Rajath Shashidhara <rajaths@cs.utexas.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005096770596f04d9e
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 9, 2019, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 8 Nov 2019 at 19:32, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > > [a] Is there any particular reason that you picked DS3231 ? Linux
> kernel
> > > has drivers for DS3232/34 only [1]. I did read the datasheets of both
> > > 3232 & 3231 and found that they are quite similar except for the 236
> > > bytes of SRAM support found only in 3232.
> > >
> >
> > Yes, DS3231 is a part of a board we want to support in future.
>
> We should probably prefer to go with a device that's a
> missing part of a board we already support -- generally
> the project prefers not to take device models that don't
> have a use, ie they go in with the board model rather
> than before. This also means we have some way of testing
> the code :-)
>
>
All agreed, Peter.

However, there is an additional interesting aspect here:

DS3231 is a fairly common module for RasPi. (and, is common for some other
systems with non-arm cpus too)

I hoped that setting up RasPi emulation with newly created RTC device would
be a peace of cake, but it might be that I was wrong. I see certain
inconsistency between our command line switches "-rtc" and "-watchdog".
Using "-watchdog", a watchdog timer model can be specified, but for "-rtc",
it looks, there is no such posibility.

Given modularity of RasPi, wouldn't it be nice for end users to be able to
specify an RTC via command line?

If usage of command line is ruled out, what would be an alternative way to
integrate particular RTC support in RasPi (for any QEMU-supported RTC, not
only (for now, just envisioned) DS3231)?

Sory if I missed something big here.

Yours,
Aleksandar



> thanks
> -- PMM
>

--0000000000005096770596f04d9e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 9, 2019, Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Fri, 8 Nov 2019 at 19:32, Aleksandar Markovic<b=
r>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; [a] Is there any particular reason that you picked DS3231 ? Linux=
 kernel<br>
&gt; &gt; has drivers for DS3232/34 only [1]. I did read the datasheets of =
both<br>
&gt; &gt; 3232 &amp; 3231 and found that they are quite similar except for =
the 236<br>
&gt; &gt; bytes of SRAM support found only in 3232.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Yes, DS3231 is a part of a board we want to support in future.<br>
<br>
We should probably prefer to go with a device that&#39;s a<br>
missing part of a board we already support -- generally<br>
the project prefers not to take device models that don&#39;t<br>
have a use, ie they go in with the board model rather<br>
than before. This also means we have some way of testing<br>
the code :-)<br>
<br></blockquote><div><br></div><div>All agreed, Peter.</div><div><br></div=
><div>However, there is an additional interesting aspect here:</div><div><b=
r></div><div>DS3231 is a fairly common module for RasPi. (and, is common fo=
r some other systems with non-arm cpus too)</div><div><br></div><div>I hope=
d that setting up RasPi emulation with newly created RTC device would be a =
peace of cake, but it might be that I was wrong. I see certain inconsistenc=
y between our command line switches &quot;-rtc&quot; and &quot;-watchdog&qu=
ot;. Using &quot;-watchdog&quot;, a watchdog timer model can be specified, =
but for &quot;-rtc&quot;, it looks, there is no such posibility.</div><div>=
<br></div><div>Given modularity of RasPi, wouldn&#39;t it be nice for end u=
sers to be able to specify an RTC via command line?</div><div><br></div><di=
v>If usage of command line is ruled out, what would be an alternative way t=
o integrate particular RTC support in RasPi (for any QEMU-supported RTC, no=
t only (for now, just envisioned) DS3231)?</div><div><br></div><div>Sory if=
 I missed something big here.</div><div><br></div><div>Yours,</div><div>Ale=
ksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
thanks<br>
-- PMM<br>
</blockquote>

--0000000000005096770596f04d9e--

