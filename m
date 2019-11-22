Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A999C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6422070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIA88tg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6422070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4Zn-0005wr-VQ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY4Xi-0004FF-39
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iY4Xg-0005Ev-WC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:43:53 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iY4Xg-0005EG-Ql
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:43:52 -0500
Received: by mail-ot1-x344.google.com with SMTP id c19so5484567otr.11
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 00:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QKx8c+dkfd7S/Ya9oIYiIsWuM7FbZyebt1LyQ/UV4Fg=;
 b=kIA88tg8r6Kkzjnvri6N2IvGDtC0VT663E6IJqECq2Ojm4eM3ZCx1vn2iX1VZewSP2
 pkXGkZeJgsl9A2bWCcbRksq1X8krADyYJ2riFAfWyB0MHx0Vu5KHWaZQHt4WLr3yxZwj
 XeDxUFXyEL4eFmfxX3yiI27xXBBKAc2l9ZBfHcjHYVMjVGUUU8vlIEtcq7bOfqP2CFf/
 9QJvzHjvFAAYsYnv6CKEZYrCZUjbt2BJ0SfoCJooid73IEDGO3YvjDbia6XECsoTdsNm
 G/lON5HEpGFwUPFXe49vPfReh92n52oZzabdk20UDg3+SedjrZVvDeWSw0OfYn3iEdw2
 kZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QKx8c+dkfd7S/Ya9oIYiIsWuM7FbZyebt1LyQ/UV4Fg=;
 b=sKFSBnNDfXAL447yyMAcJx+PXY08ntj7g1MlNCMfNLhEXQZR0odstpBigiR50i46i2
 meeRu6kpMzCB3HYWy6M41qgQGIKfie/pMQnHiW9Ddoh58sfiZ77QFzoRg5ZUlTmdEtfC
 xTebanuFXb12le2acIY5f/XYDDgiKzfEO7WwcimDLV5uKof04rb1fY/m8rb8JK+z0z3x
 YNojGfvuH8aQh6DkzZpEzJ1b63WjtCIJmt8krn2OraT0wLFILtakyri2KGA2f5aj9Eac
 TpGItP+w2wTn7LEevJxMUSpRRdL9oMXgXEIbrfT+hw+zVStWwcacv97p9WCbFF5BKH0t
 ot2g==
X-Gm-Message-State: APjAAAV0BHU80wxhYnhBJS7nxvnnxpziGLEKiZirej+6QezuShjRdi7F
 af37JavztKIxlelxxXzRf7JGbI/5v1G76kZ27RM=
X-Google-Smtp-Source: APXvYqyBMWAbQ96ikH4gc4M5M+t1wwsk+7umK+G63mxvIvXDS28bbKkngiw3K9ZHI9H1OaPVO0vCO17BkummzoNGDhU=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr10546170otc.295.1574412231807; 
 Fri, 22 Nov 2019 00:43:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Fri, 22 Nov 2019 00:43:51
 -0800 (PST)
In-Reply-To: <e1fedeff-3eab-f215-a376-334417f5bf53@linaro.org>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAK4993gtPkqESswLBoo1cMuvJFzwSVgUP=Oh-hpG2JSTKezjmw@mail.gmail.com>
 <CAK4993iFuC3LTzkwjAx7uKA18jh-zOo5aYx2+1ugc9fw8UPtYg@mail.gmail.com>
 <e1fedeff-3eab-f215-a376-334417f5bf53@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 09:43:51 +0100
Message-ID: <CAL1e-=hKepMcesqsOwxp_HSRO9mvF6V6k4TAoVn5kcmb=20FQg@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ce98a10597eb6985"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ce98a10597eb6985
Content-Type: text/plain; charset="UTF-8"

On Friday, November 22, 2019, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 11/21/19 8:53 PM, Michael Rolnik wrote:
> > It seems to be a huge investment. this function should parse the
> > binary data as `decode_insn` does, so I suggest to modify decodetree
> > tool to make decoding information available to the instruction print
> > function.
> > what do you think?
>
> See target/openrisc/disas.c, which makes use of decodetree.
> It shouldn't be difficult to do something slimiar for avr.
>
>
I support Richard's suggested direction. Since you already implemenred core
AVR decoder using decodetree, and you have this openrisc QEMU disassembler
example, could you perhaps give a try to what Richard said, Michael?

Aleksandar



> r~
>

--000000000000ce98a10597eb6985
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, November 22, 2019, Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">On 11/21/19 8:53 PM, Michael Rolnik wro=
te:<br>
&gt; It seems to be a huge investment. this function should parse the<br>
&gt; binary data as `decode_insn` does, so I suggest to modify decodetree<b=
r>
&gt; tool to make decoding information available to the instruction print<b=
r>
&gt; function.<br>
&gt; what do you think?<br>
<br>
See target/openrisc/disas.c, which makes use of decodetree.<br>
It shouldn&#39;t be difficult to do something slimiar for avr.<br><br></blo=
ckquote><div><br></div><div>I support Richard&#39;s suggested direction. Si=
nce you already implemenred core AVR decoder using decodetree, and you have=
 this openrisc QEMU disassembler example, could you perhaps give a try to w=
hat Richard said, Michael?</div><div><br></div><div>Aleksandar</div><div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
r~<br>
</blockquote>

--000000000000ce98a10597eb6985--

