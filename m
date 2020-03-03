Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EACC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA9C20857
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRhsDtw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA9C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j973m-00058V-Rx
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j9730-0004K4-4b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <priyamvad.agnisys@gmail.com>) id 1j972y-000747-UV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:53:18 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1j972y-00073j-M6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:53:16 -0500
Received: by mail-lf1-x142.google.com with SMTP id t21so1587059lfe.9
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W8LUhE2BUPTv+4SOGexUL1x/IisGYh3jEkaQsX/4+wc=;
 b=jRhsDtw6BgLtCkjYWyd8pIOSbZahsLbRkSxnQ8NpYV6W1lxGCBBUZ6gaJF+JGzie9K
 oCr4OMigqgIb2G6gr+T5ntKzCwirOcOcdrXqG63VrV8joZeg/31nYWaT7J7F7FGwiHF6
 ij7OC5mXOpHsf3JiNZ0uar6sjP2Pv1zE2dp+FBHr+FOLl1f5dBp+O+XoFyNPt95Mk1/d
 gDBCGMP8JocgTZ5kip3OTFA7q22H/mvD1uxnL1XrTIrzFGwUvR9MCB1xYpQaDyDdnd8D
 7u702M5EbCaAlUJDe4B5JHqByOO6bcPKDTVtfmV0IPPDBSM0ZpXj5ZkJisEupatRS9dq
 EYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W8LUhE2BUPTv+4SOGexUL1x/IisGYh3jEkaQsX/4+wc=;
 b=QihFqkzEl+hFMoxCB3aMoBbWxtcJT2ABtJGyvyuts0//AwRlYWFdgHg31fojYeB/JC
 uTrik1tu8oQu/Di9Euzvc4OZT6hLpuMITpCkO0b0E4dAlJwc2kfyXsaxoUjnGPMDrCCc
 iFEZlaEy4EBAigOw5vwGkUSxMGlodykYOOO5rxhyh6CKkyH62AYTGPKUcX2F6IMAlU0Y
 9EBI+qWclk5Ll117MVncVfaEqFaB06TZJCs/EDGVtOo9BznfzgGy1ln5OE71KEYKF4va
 EZeenx/6Y28rkmH7iRIw5PU93zJz5XcO4ppGMgGrIyJfhzLtF/m7iYm9y6NMY9ANiMm+
 qQXQ==
X-Gm-Message-State: ANhLgQ2KWD4PtYkIflLHAnQvRkupBewWOlW+eoqVajcUL1fzyNLqTOqK
 1hJ+dQ302KyWdXJM59TcXu5Yn+ZHIVAE9AWJl/c=
X-Google-Smtp-Source: ADFU+vvOWMzSZ9m2k7Ks9A1NQPiVT6vXWZiEVnpkL7SAzuyJtICXBQjlxJTFVQqGbdS0E+l6XLHz/oRjZ+XIbCnk4e8=
X-Received: by 2002:a05:6512:6f:: with SMTP id
 i15mr2671633lfo.45.1583239995224; 
 Tue, 03 Mar 2020 04:53:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
In-Reply-To: <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Tue, 3 Mar 2020 18:23:03 +0530
Message-ID: <CAPV47zesfbVEBc75kDg9YFjGjQi5ZpjrPasQZJvmkp3bTcaR3w@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000008276ce059ff2c98c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008276ce059ff2c98c
Content-Type: text/plain; charset="UTF-8"

 >.* Using git-log(1) can be helpful because it shows how new devices were
introduced.*

What is git-log(1) ?
How to use git-log(1) in Qemu?

On Tue, 3 Mar 2020 at 18:15, Priyamvad Acharya <priyamvad.agnisys@gmail.com>
wrote:

> Thanks Stefan for explaining the method.
> After following above method when I run below command to compile my custom
> device in Qemu source code , I get the output on terminal which is attached
> in a file for your reference.
>
> Command:- make -j8 -C build
>
> Most of the lines in attached file indicate that error might be due to
> helper.c file.
>
> How to resolve it?
>
> My qemu version:4.2.50
>
>
> Thanks,
> Priyamvad Acharya
>
> On Tue, 3 Mar 2020 at 16:16, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
>> On Tue, Mar 3, 2020 at 7:45 AM Priyamvad Acharya
>> <priyamvad.agnisys@gmail.com> wrote:
>>
>> Please use Reply-All when replying to mailing list emails so that
>> qemu-devel@nongnu.org is included in the CC list.  That way the
>> discussion stays on the mailing list.
>>
>> > Hi,
>> > I have written code to emulate a custom PCI device.
>> > Now I want to run custom device with Qemu, so that user application can
>> perform read/write operation with custom PCI device.
>> > So what is the method to do it?
>>
>> 1. Add the source file somewhere below hw/.
>> 2. Add a make rule to build the object file in Makefile.objs in the
>> same directory as the source file.
>> 3. Compile QEMU and run with -device testpci.
>>
>> > I am new to emulating a custom device model in Qemu, so request you to
>> explain me in that way.
>>
>> Reading the source code is necessary to understand how things work.
>> You can find many examples of devices in the hw/ directory.  Using
>> git-log(1) can be helpful because it shows how new devices were
>> introduced.
>>
>> Stefan
>>
>

--0000000000008276ce059ff2c98c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><font color=3D"#888888">
 &gt;.<font color=3D"#888888"><span style=3D"background-color:rgb(249,203,1=
56)"><b>
 Using git-log(1) can be helpful because it shows how new devices were intr=
oduced.</b></span><font color=3D"#888888"><br></font></font></font></div><d=
iv><br></div><div>What is git-log(1) ?<br></div><div><span style=3D"backgro=
und-color:rgb(243,243,243)"><span style=3D"">How to use git-log(1) in Qemu?=
</span></span><br></div><div><font color=3D"#888888"><font color=3D"#888888=
"><font color=3D"#888888">
</font>

</font>

</font></div>

</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, 3 Mar 2020 at 18:15, Priyamvad Acharya &lt;<a href=3D"mailto:priyam=
vad.agnisys@gmail.com">priyamvad.agnisys@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Tha=
nks Stefan for explaining the method.</div><div>After following above metho=
d when I run below command to compile my custom device in Qemu source code =
, I get the output on terminal which is attached in a file for your referen=
ce.</div><div><br></div><div>Command:- make -j8 -C build</div><div><br></di=
v><div>Most of the lines in attached file indicate that error might be due =
to helper.c file.</div><div><br></div><div>How to resolve it?</div><div><br=
></div><div>My qemu version:4.2.50<br></div><div><br></div><div><br></div><=
div>Thanks,</div><div>Priyamvad Acharya<br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 3 Mar 2020 at 16:1=
6, Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gmail.com" target=3D"_bla=
nk">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Tue, Mar 3, 2020 at 7:45 AM Priyamvad Acharya<br>
&lt;<a href=3D"mailto:priyamvad.agnisys@gmail.com" target=3D"_blank">priyam=
vad.agnisys@gmail.com</a>&gt; wrote:<br>
<br>
Please use Reply-All when replying to mailing list emails so that<br>
<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@nongn=
u.org</a> is included in the CC list.=C2=A0 That way the<br>
discussion stays on the mailing list.<br>
<br>
&gt; Hi,<br>
&gt; I have written code to emulate a custom PCI device.<br>
&gt; Now I want to run custom device with Qemu, so that user application ca=
n perform read/write operation with custom PCI device.<br>
&gt; So what is the method to do it?<br>
<br>
1. Add the source file somewhere below hw/.<br>
2. Add a make rule to build the object file in Makefile.objs in the<br>
same directory as the source file.<br>
3. Compile QEMU and run with -device testpci.<br>
<br>
&gt; I am new to emulating a custom device model in Qemu, so request you to=
 explain me in that way.<br>
<br>
Reading the source code is necessary to understand how things work.<br>
You can find many examples of devices in the hw/ directory.=C2=A0 Using<br>
git-log(1) can be helpful because it shows how new devices were<br>
introduced.<br>
<br>
Stefan<br>
</blockquote></div>
</blockquote></div>

--0000000000008276ce059ff2c98c--

