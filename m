Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC92C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C826920786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+EmM4Ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C826920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8zv-0006O6-W8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jl8zM-0005yC-Kt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:38:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jl8zL-0002ou-6T
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:38:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id j10so20204004wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=SIQWFmpA4xfEF6S8pxfvO0wssEwK8KRzAhqBxvI2r0g=;
 b=h+EmM4AiscAraEmV1V3ekrGTeDkdKDYu+hYFaRPT8Jgf4WRZrYyc0PWl2O72a3dPdq
 kF/2uzd/IXrLAQPM39tUklPzRsC0Qe++Zrt1cSY6rNICLCpKfnn2L8cfp8gy0Kcdhdnv
 zfZ0o6bp5nhp2ZteOS8Jzv4uTpEgOujVNpy/49bOwQkLgWb74dcqZN8mx10l1K6BHjVz
 ubRaIW4raKQMGxJx3jfxMCGZ/smVGUPyY18bnpsPA3k3WLCkv0F01Olj5RM9lLSlDlr+
 W5cCxJxuoXigqiMUsYuBLkVvREFhqeIDjsHQBYCoU3DVeFaxJzxpKKNBFjEhb+olRSH2
 3mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=SIQWFmpA4xfEF6S8pxfvO0wssEwK8KRzAhqBxvI2r0g=;
 b=BQ7F2N45OzLnlxUMnXg5qqymJ0jvKFJNA4hVNJ6q78z+Zz4BGSA00t3XZ/xRCEm8gj
 UzjW0LqRSnMeAv5AIHZKYFHcUqJnOiwcRKqZWxmsOXfUWe6YCyxpWrmi1UqxykqTZfGJ
 6xiksimBQ/elAWYUNug7YHeP2PueC3+rsQWEisOUTnVhubHNYRZUzMH6ereErptkGhah
 BrtXn3cP42Lw9ij2aRH5uIvymEqfz4jHXGdjxKdIr94MLDAifh0l/hFUPQG8Z9hZnzTu
 Gm5EqRlqqQuFPw33p40RQwmOdfsXWY2BtM7nLQ1MqFcZUT425ZfhLX0/i0rH/Knk9egl
 efMw==
X-Gm-Message-State: AOAM530uMnaLmOKefum7gTM20f1zIfUuEFLDFiiyVPZVpporFKnnzHob
 tZmwZDLYMJ2iTVZxUcMYj2E1wcqLeQ5tnZOHGgbz1kA/
X-Google-Smtp-Source: ABdhPJzy9OH8gktkPgdILszPI6R+EemN0tSTReDjCnH9efJfKsNUToyGM/xVl0IB+RaE5Ki9fOon76FGWh0hu2I5ZsY=
X-Received: by 2002:adf:a283:: with SMTP id s3mr2227883wra.147.1592303920895; 
 Tue, 16 Jun 2020 03:38:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Tue, 16 Jun 2020 03:38:40 -0700 (PDT)
In-Reply-To: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
References: <20200616073359.2999656-1-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 16 Jun 2020 12:38:40 +0200
Message-ID: <CAHiYmc6QEU4zk=0Xa6_gs1JEV+1mGNp3oNYQ6rZoxeLF5cABBw@mail.gmail.com>
Subject: [PATCH v2 0/2] target/mips: Add two groups of loongson-ext
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: multipart/alternative; boundary="000000000000945de305a831259f"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
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
Cc: "chenhc@lemote.com" <chenhc@lemote.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000945de305a831259f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020., Jiaxun =
Yang <jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> This is the sucessor of:
> "Basic TCG Loongson-3A1000 Support"
>
> Thanks!
>
>
Hi, Jiaxun.

Thanks for providing updated version of the series.

I wonder, given so many "#if defined(TARGET_MIPS64)" lines in this series,
what would be the 32-bit processors that support Loongson EXT ASE?

Thanks,
Aleksandar



> Jiaxun Yang (2):
>   target/mips: Add loongson-ext lsdc2 group of instructions
>   target/mips: Add loongson-ext lswc2 group of instrustions
>
>
Also, a spelling mistake in the second title.


>  target/mips/translate.c | 437 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 437 insertions(+)
>
> --
> 2.27.0.rc2
>
>

--000000000000945de305a831259f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 16. =D1=98=D1=83=D0=BD 2020.,=
 Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com" target=3D"_blan=
k">jiaxun.yang@flygoat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This is the=
 sucessor of:<br>
&quot;Basic TCG Loongson-3A1000 Support&quot;<br>
<br>
Thanks!<br>
<br></blockquote><div><br></div><div>Hi, Jiaxun.</div><div><br></div><div>T=
hanks for providing updated version of the series.</div><div><br></div><div=
>I wonder, given so many &quot;#if defined(TARGET_MIPS64)&quot; lines in th=
is series, what would be the 32-bit processors that support Loongson EXT AS=
E?</div><div><br></div><div>Thanks,</div><div>Aleksandar</div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
Jiaxun Yang (2):<br>
=C2=A0 target/mips: Add loongson-ext lsdc2 group of instructions<br>
=C2=A0 target/mips: Add loongson-ext lswc2 group of instrustions<br>
<br></blockquote><div><br></div><div>Also, a spelling mistake in the second=
 title.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0target/mips/translate.c | 437 ++++++++++++++++++++++++++++++<wbr>++++=
++++++<br>
=C2=A01 file changed, 437 insertions(+)<br>
<br>
-- <br>
2.27.0.rc2<br>
<br>
</blockquote>

--000000000000945de305a831259f--

