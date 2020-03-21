Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F6CC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 09:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C61A20739
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9tRxbq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C61A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFapG-0001YI-NS
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerry.geis@gmail.com>) id 1jFaoR-00019A-DV
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 05:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jerry.geis@gmail.com>) id 1jFaoQ-0004Wh-CX
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 05:53:03 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jerry.geis@gmail.com>)
 id 1jFaoQ-0004WO-8l
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 05:53:02 -0400
Received: by mail-qt1-x829.google.com with SMTP id z8so7286133qto.12
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pdHUA/ZPHTCoavJ9+Q1AmslBbk7pF2mCaJ2CXiKgRso=;
 b=O9tRxbq9hjNqE2MOkbDN494+wKEfZKcu/wcUClX4WEY2NF0un8+OMH3FwpM1nDzw5K
 vrqJYSgwo232xVtZ7lyJF47znTDZCi0aqjBMjO8Ia6NxVck/zZd3sR4C3tD1NpXKfYYe
 UwhUhaT+GK8sFIQi6GfcYaiW2vfPT/BgQ6U08aClRGpY5C/vGDaJzQDVtYwzhaDzjjzp
 G2296pp6XbvwYTdNLOT5vRTFB0QslDAiMVBHc2+Dm3qLfnEDZXUxkeb8Ni327A782BH5
 Oz/YY1Y6jLDQwIEkA/RUHiMs/4bfd/FD8MGYsShgVHmB1r5orAzuuHIadl3+loZrhz9o
 GLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pdHUA/ZPHTCoavJ9+Q1AmslBbk7pF2mCaJ2CXiKgRso=;
 b=SUBlf/jgU9qqwGte6u4CL8JcJqc/eWHRKSv3VTfgR7BICxUDI+Qvyw9u5Ij5urhpTW
 nnuHaOLmN0kFiPhAyjOVMA7OO+wBlphMJcuMbiP/Ye9Hggp1LgkgtoNb12oUTHF+eLVg
 x8TrjZZyyuT5MJrQvf0+tGiIXnmZn++86+WqP/OW53LI5G3we5Nau7CZhGvfCLjT406Z
 2/PhiZH1qw2iP2omJwcTv5faQnzuT9l/AZYt7i5SAPBlhqo0gU5dMKh0g7AKsNHCaNdB
 ZoQ/HvK7yCquNZJvjH+VhWdZwNciOkleEvNLCFHYZ7O5Elsjbhb3EMObKZQlYzN4twv7
 3ZLA==
X-Gm-Message-State: ANhLgQ0X9k8JU4ULkN3pmFwsSVmG+nQytoL/roetCStOr2NCSaI4T2+Z
 B24epFhohkH737UwsamDucxoAJ0dWM+s7vx0Ywt/RA==
X-Google-Smtp-Source: ADFU+vtr++WUsN1gqY83sw0W01VCh7owWla4Rrl7vjAxb7U0xGnfZQ15bRb008jKFQEhDFutMwLXzYW7uqX3hCHh5cE=
X-Received: by 2002:ac8:1c72:: with SMTP id j47mr12781295qtk.377.1584784381575; 
 Sat, 21 Mar 2020 02:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABr8-B4RQo3OT6ogt7J=OWGhOpD6LqHt9zkp7dZTmqifiPCtyA@mail.gmail.com>
 <f51c571b-5eda-7837-36bb-9dfd3be39eb9@weilnetz.de>
 <CABr8-B5fCLfLk39f9s-4TyV+0iQbqHborKyV_SR1PsdCHXRNkg@mail.gmail.com>
 <a2444be7-425d-4f10-b466-21d7ddc1cd30@weilnetz.de>
In-Reply-To: <a2444be7-425d-4f10-b466-21d7ddc1cd30@weilnetz.de>
From: Jerry Geis <jerry.geis@gmail.com>
Date: Sat, 21 Mar 2020 13:24:17 -0400
Message-ID: <CABr8-B6siYYx2wRFHYrgfco1+CWOAUsRA3aR5BnRQSLUtaCogw@mail.gmail.com>
Subject: Re: Qemu on Windows 10 - no acceleration found
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="0000000000001c060905a15a5ebc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::829
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001c060905a15a5ebc
Content-Type: text/plain; charset="UTF-8"

Perfect Stefan - that did the trick.
Thank you.

Jerry

On Sat, Mar 21, 2020 at 3:14 AM Stefan Weil <sw@weilnetz.de> wrote:

> Am 20.03.20 um 21:22 schrieb Jerry Geis:
>
> > So I tried --enable-whpx and I get Invalid option. Im on Windows 10
> > and QEMU 4.2.0
> >
> > I'm confused.  Then I don't know where to download the HAXM. The place
> > I found is GIT and it wants the user to compile it. I was looking for
> > just an EXE.
> >
> > Thanks
> >
> > Jerry
>
>
> Sorry, the FAQ was outdated. I updated it now.
>
> Run `qemu-system-x86_64 --accel whpx`.
>
> Using WHPX is easier than using HAX.
>
> Stefan
>
>

--0000000000001c060905a15a5ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Perfect Stefan - that did the trick.<div>Thank you.</div><=
div><br></div><div>Jerry</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Mar 21, 2020 at 3:14 AM Stefan Weil &=
lt;<a href=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Am 20.03.20 um 21:22 sch=
rieb Jerry Geis:<br>
<br>
&gt; So I tried --enable-whpx and I get Invalid option. Im on=C2=A0Windows =
10<br>
&gt; and QEMU 4.2.0<br>
&gt;<br>
&gt; I&#39;m confused.=C2=A0 Then I don&#39;t know where to download the HA=
XM. The place<br>
&gt; I found is GIT and it wants the user to compile it. I was looking for<=
br>
&gt; just an EXE.<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Jerry<br>
<br>
<br>
Sorry, the FAQ was outdated. I updated it now.<br>
<br>
Run `qemu-system-x86_64 --accel whpx`.<br>
<br>
Using WHPX is easier than using HAX.<br>
<br>
Stefan<br>
<br>
</blockquote></div>

--0000000000001c060905a15a5ebc--

