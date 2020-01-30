Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D39C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F5C20678
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwbZDII0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F5C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBS9-00047h-Eo
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1ixBRV-0003ZW-Nd
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1ixBRU-0007cb-Oa
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:09:17 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1ixBRU-0007c7-JW; Thu, 30 Jan 2020 10:09:16 -0500
Received: by mail-ot1-x343.google.com with SMTP id b18so3459224otp.0;
 Thu, 30 Jan 2020 07:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cFATQpzQNU17smYHCyopvBByflLAEHZ878jKdScNHDY=;
 b=JwbZDII0NemQ5eDf7II4dwL5ZReEgo2Rg+n2W01e0z0THO27aqwNkP043M3454eRTF
 +pMGQ1H7bYNzi4btRRCveCD4FregrANin0BfkTQzNenG1OmtHpmVs0xbwO6ltfdoK+Sd
 /0trJAnj0kB4gpxXnHr3yCHAAylEQnSECyQGOShtvrdJfWZqqYayBIAF4fbnVnQYzAAK
 XYwZXobUc/DxZJXnt6ciMqhwU0R+eL2lgQCE8NJ9lHYK/w2SHsZGiBcS7T1ZqXLF8YEf
 bM07Iz11VRAXX4yaSxpaiWTNpHsWhtiJOmuBH5AN88HlQzTBCN3nNDDqQg03njKqdpO4
 CK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cFATQpzQNU17smYHCyopvBByflLAEHZ878jKdScNHDY=;
 b=tVCwNHHjW0rig5BeQKoDr9UAUFzEQnjqLAFbVpTP/pA8mZe71myx+fx47JB0s9iu7c
 1oNaO07qufxiIFXxGLLu8nO8jFfsYIISJrNXUwTOT+VgFx/3vD/6PASdM3Wi+0fuJcM/
 Thi1btxsJpm8G36X6MIJ4Cro0LXdJcWv3kKZf37GP8gt4uhLbITUtuvYNTa4Ib4d0UZ1
 srarvA5CzJLouQXrC1u25Dlr1RJ8ZTDgI+atnuls1SmUnVB5vYLZjGB4TNrlcmCBgZIa
 FnDSp+XlhdY/ouJxwL3ywZ39oyYdecZXxp2voQZqZrZ0Qzv8eQqaj1vftUJp4QcdRvqz
 bUOw==
X-Gm-Message-State: APjAAAWQVQisD16CxhtCdPHGtUcdnz0UP5047Rx9NQ9X2r0PfvxBExgY
 +fPKI51fYli8QeHZVUFr9r3H1qkfQGm8FkiSh84=
X-Google-Smtp-Source: APXvYqxR0SZLUQXNYuoPmI48GL7n+MBUpaJulcLbuNH7Ls8V7+ENXc1y56JpG3+flPiWmaj6oaMQvpG6/wjqQ0ATsKs=
X-Received: by 2002:a05:6830:139a:: with SMTP id
 d26mr3977216otq.75.1580396955898; 
 Thu, 30 Jan 2020 07:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20200129235040.24022-1-richard.henderson@linaro.org>
In-Reply-To: <20200129235040.24022-1-richard.henderson@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 30 Jan 2020 16:09:04 +0100
Message-ID: <CABLmASHGOGsDYo-jmqs2XCTvGbw80x1OAghx1AVTCOz2WMFKxw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/ppc: Use probe_access
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002918aa059d5cd71b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002918aa059d5cd71b
Content-Type: text/plain; charset="UTF-8"

As this patch set solved the performance issue and even led to the highest
scores I ever saw on the benchmark tool I used, let me add a:

Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>

On Thu, Jan 30, 2020 at 12:50 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The first two address the performance regression noticed
> by Howard Spoelstra.  The last two are just something I
> noticed at the same time.
>
>
> r~
>
>
> Richard Henderson (4):
>   target/ppc: Use probe_access for LSW, STSW
>   target/ppc: Use probe_access for LMW, STMW
>   target/ppc: Remove redundant mask in DCBZ
>   target/ppc: Use probe_write for DCBZ
>
>  target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 162 insertions(+), 35 deletions(-)
>
> --
> 2.20.1
>
>

--0000000000002918aa059d5cd71b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>As this patch set solved the performance issue and ev=
en led to the highest scores I ever saw on the benchmark tool I used, let m=
e add a:</div><div><br></div><div>Tested-by: Howard Spoelstra &lt;<a href=
=3D"mailto:hsp.cat7@gmail.com" target=3D"_blank">hsp.cat7@gmail.com</a>&gt;=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Thu, Jan 30, 2020 at 12:50 AM Richard Henderson &lt;<a href=3D"mai=
lto:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">The first two address the performance regression noticed<br>
by Howard Spoelstra.=C2=A0 The last two are just something I<br>
noticed at the same time.<br>
<br>
<br>
r~<br>
<br>
<br>
Richard Henderson (4):<br>
=C2=A0 target/ppc: Use probe_access for LSW, STSW<br>
=C2=A0 target/ppc: Use probe_access for LMW, STMW<br>
=C2=A0 target/ppc: Remove redundant mask in DCBZ<br>
=C2=A0 target/ppc: Use probe_write for DCBZ<br>
<br>
=C2=A0target/ppc/mem_helper.c | 197 +++++++++++++++++++++++++++++++++------=
-<br>
=C2=A01 file changed, 162 insertions(+), 35 deletions(-)<br>
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div>

--0000000000002918aa059d5cd71b--

