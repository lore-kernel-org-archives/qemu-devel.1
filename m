Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B13C3E8AB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 10:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8D22133F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 10:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4uBVbga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8D22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGh3A-0001NE-I9
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 06:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1iGh2P-0000vh-1Q
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 06:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1iGh2O-0000KI-6J
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 06:11:45 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:46966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1iGh2O-0000JK-2j
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 06:11:44 -0400
Received: by mail-qt1-x829.google.com with SMTP id u22so12211094qtq.13
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zrX9DdtZeerMrXHviwDUfTuG8fPlNtUyGEMAoSLdXJU=;
 b=n4uBVbgaQlxB5QGvG05EWpUTyMidnL2Txkx54NHxvH7Piphl4fKb/affU9M3ASJDal
 xK0jqKnRM+2L8s063gmDhtEulNNEGOySRxMgHsg1p1WIzJW1cLpWbW7AUv5IJ0IGNSKa
 WeeuFLeoD5iyyfZQaMhV3hxQPjK7CHXngyG2jLYSlR8QByz90yIz2ZUmi9yYup8ahJT7
 EggQ21treg9tPA6jLKpk/mlLipakIjzGq4wPlA0Pq00r1doH7GOnS/jTKP8+PB+neUJU
 vIHK6FtqDQ6r1W4RdoiDwt5zzAE8yEiXLVWsnr5KW9qLRrLZ5qOaSe1t93c8Cq4rpt58
 uCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zrX9DdtZeerMrXHviwDUfTuG8fPlNtUyGEMAoSLdXJU=;
 b=WofM41+YBDsXQtjmmtUfEg+sH9KRsD3bAelITtdJT0HT961qV3wt0yJe2H3cjHFuqW
 W0LV46SIUBK2+XGmeFTsvDnusbkuNTDTfVSUbCLSN6cp1a14/bkqLcWBNYcQWB4DS/EZ
 1zYLuOSuCspP4a3t8M01XqMCpG9C3f9AfcI8IkJplqjUp1hdCVahyXvZ8eY2lkbTfaYc
 vK65JCsYxpLAFlEGbu9tfpa42nptidHJADGIRbd9kdGntBhdsLM6zE49Uw/deBi1JExE
 RLttrYP7+xdyhHr3pZPGS7rIPpcPOS02bk4JhWMb4r9vFhlqJEKMxyfeXLtdpDVAACDM
 HQ+w==
X-Gm-Message-State: APjAAAVyxEwc3GfT+lIiOfTk0CSXC2npRAexXWpKRdmIcZktbe9GakIF
 KJtFf0r25oqrcfSOhCQ1I44u52OW9dVPy5nUg6ULQQ==
X-Google-Smtp-Source: APXvYqwCJp1YY7c5ei62STJSfgSx/96bjCVa6/bW0cyEtwk9VrN1HUOPuR2oLgrHQYK5HNNKJfJbu2ZZdw5KY64peCo=
X-Received: by 2002:ac8:5448:: with SMTP id d8mr3798871qtq.287.1570270303121; 
 Sat, 05 Oct 2019 03:11:43 -0700 (PDT)
MIME-Version: 1.0
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Sat, 5 Oct 2019 19:11:25 +0900
Message-ID: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
Subject: RFC: Why dont we move to newer capstone?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000009e74ab0594270b4b"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e74ab0594270b4b
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Whilst working on a m68k patch I noticed that the capstone in use today
(3.0) doesnt support the M68K and thus a hand turned disasm function is
used.

The newer capstone (5.0) appears to support a few more CPU, inc. m68k.

Why we move to this newer capstone?

Furthermore, if making a move why not move to something with wider cpu
support like libopcodes  ?

Cheers,
Luc

--0000000000009e74ab0594270b4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi folks,<div><br></div><div>Whilst working on a m68k patc=
h I noticed that the capstone in use today (3.0) doesnt support the M68K an=
d thus a hand turned disasm function is used.=C2=A0=C2=A0</div><div><br></d=
iv><div>The newer capstone (5.0) appears to support a few more CPU, inc. m6=
8k.</div><div><br></div><div>Why we move to this newer capstone?<br></div><=
div><br></div><div>Furthermore, if making a move why not move to something =
with wider cpu support like libopcodes=C2=A0 ?</div><div><br></div><div>Che=
ers,<br></div><div>Luc</div><div><br></div></div>

--0000000000009e74ab0594270b4b--

