Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCA0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E41B2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC+qSSJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E41B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTt8-0004a4-7i
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTro-0003fF-AX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:01:40 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTrl-0002qa-04
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:01:39 -0400
Received: by mail-lf1-x142.google.com with SMTP id y11so11747059lfl.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=uvRi+Y4NeCjV04cTu/q9zjCV/Sk1wwoGGuQsrbu5n2U=;
 b=MC+qSSJm58HCyacVrFaLso64wP1SbPJAX+uewOndMsw6doumuwDN2g7hUnD2euJ3EU
 zGa9L4P2P2jmFLGk4L03GB5TNITCV0xDHymGhpYFDCdJQjKMygblq3IiRpsBw0JNl+Nm
 GiPS0CNp2yAaKTJn1xKB9+mFMsPxoc/5VgbFTdkMBzFcVWzCrqSbFznDifOAb1VPgalR
 x8KWo9he3iW28kXFHAro5PTyPWye0HlKO0eSE9ygR71gYFEAArXXOY32I0d04VpRqkw1
 GwmiqHubaw7ZshahhsCRjmAq3x8YajZFXg0bOTxElBifGMDCSCNMBFdv3c2Ucnr9p9mz
 GiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=uvRi+Y4NeCjV04cTu/q9zjCV/Sk1wwoGGuQsrbu5n2U=;
 b=BDEnIzQsKDRfBfmbESNgBz5Z4LKjfZk/wscheJ83GwnX7kRhIrMw/SK6AJYBG6zbLl
 hpvP/aVN88o3JfYOAGzamWR18IrFjSiqH8FyJC4ssUfHiNi8VX80w7udO/Hp9r86cmT1
 r5EqFnjfpQKphGwIMJ+Nng077mM8ODUMyMv/ug6MwKzr/34Ze1IqfQVJ5F/ThXmY3V3Q
 G6XKGTQJi9Qd52pMq+ZIrSQ+9KPjZN+F3C8yztF3NzLJS7bO+TVh2p2T9hNyhXsHmh1L
 +DN2ypcn6XXRmdFa8Tg8SpJ7NacNFg2ivsToPOva65U55C/9C5I0JwUVjpJdy/8bpfJB
 U1gQ==
X-Gm-Message-State: AOAM53292PqJbqNSjKbPbR2BOdLWM2fpY+ktVYTMm9N49CalsT4X/lph
 ExkXSBf7E/FSg8TUJ6fNlKBOMq0ZsRLzoYWF0cw=
X-Google-Smtp-Source: ABdhPJy0JXb6WTKTZu0qeMDqLv5EGdJewprTiYdqc09g0EgwJHmwfXoa0TxLqqPiiEZFbH6eqH7cIhzB+yzcbC7xLb0=
X-Received: by 2002:a19:a407:: with SMTP id q7mr124916lfc.377.1601917294953;
 Mon, 05 Oct 2020 10:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200924163509.142565-1-f4bug@amsat.org>
In-Reply-To: <20200924163509.142565-1-f4bug@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2020 01:01:25 +0800
Message-ID: <CAE2XoE8WULp8zuXjCuB8eaJQKEWhenKpBOV9crCTK_hLJ5awjg@mail.gmail.com>
Subject: Re: [RFC PATCH] scripts/qemu-version.sh: Always describe tag version
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000534cca05b0ef6f49"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000534cca05b0ef6f49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On windows executing
"pkgversion=3D$(git describe --match 'v*' --dirty --always | echo "")"
$ bash ./scripts/qemu-version.sh . '' ''
#define QEMU_PKGVERSION ""
#define QEMU_FULL_VERSION ""

The result are empty.

By removing echo ""
        pkgversion=3D$(git describe --match 'v*' --dirty --always)
the result are
```
$ bash ./scripts/qemu-version.sh . '' ''
#define QEMU_PKGVERSION "v5.1.0-1922-g94f35f943a-dirty"
#define QEMU_FULL_VERSION " (v5.1.0-1922-g94f35f943a-dirty)"
```

What are expected?


On Fri, Sep 25, 2020 at 12:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:
>
> I'm not sure why sometime I get this error:
>
>   $ make
>   Generating qemu-version.h with a meson_exe.py custom command
>   fatal: No tags can describe 'dc9f825f99eb5dc82f127e6c95fbe3a503e11346'.
>   Try --always, or create some tags.
>
> While to --always option is not clear in GIT-DESCRIBE(1):
>
>    --always
>        Show uniquely abbreviated commit object as fallback.
>
> using it works and fix my builds:
>
>   $ git describe --match 'v*' --dirty --always
>   dc9f825f99e-dirty
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> index 03128c56a2c..a7135511588 100755
> --- a/scripts/qemu-version.sh
> +++ b/scripts/qemu-version.sh
> @@ -9,7 +9,7 @@ version=3D"$3"
>  if [ -z "$pkgversion" ]; then
>      cd "$dir"
>      if [ -e .git ]; then
> -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
> +        pkgversion=3D$(git describe --match 'v*' --dirty --always | echo
"")
>      fi
>  fi
>
> --
> 2.26.2
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000534cca05b0ef6f49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On windows executing<div>&quot;pkgversion=3D$(git describe=
 --match &#39;v*&#39; --dirty --always | echo &quot;&quot;)&quot;</div><div=
>$ bash ./scripts/qemu-version.sh . &#39;&#39; &#39;&#39;<br>#define QEMU_P=
KGVERSION &quot;&quot;<br>#define QEMU_FULL_VERSION &quot;&quot;<br><br>The=
 result are empty.<br><br>By removing echo &quot;&quot;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 pkgversion=3D$(git describe --match &#39;v*&#39; --dirty --al=
ways)<br>the result are<br>```</div><div>$ bash ./scripts/qemu-version.sh .=
 &#39;&#39; &#39;&#39;<br>#define QEMU_PKGVERSION &quot;v5.1.0-1922-g94f35f=
943a-dirty&quot;<br>#define QEMU_FULL_VERSION &quot; (v5.1.0-1922-g94f35f94=
3a-dirty)&quot;<br></div><div>```</div><div><br></div><div>What are expecte=
d?<br><br><br>On Fri, Sep 25, 2020 at 12:50 AM Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br>&g=
t;<br>&gt; I&#39;m not sure why sometime I get this error:<br>&gt;<br>&gt; =
=C2=A0 $ make<br>&gt; =C2=A0 Generating qemu-version.h with a meson_exe.py =
custom command<br>&gt; =C2=A0 fatal: No tags can describe &#39;dc9f825f99eb=
5dc82f127e6c95fbe3a503e11346&#39;.<br>&gt; =C2=A0 Try --always, or create s=
ome tags.<br>&gt;<br>&gt; While to --always option is not clear in GIT-DESC=
RIBE(1):<br>&gt;<br>&gt; =C2=A0 =C2=A0--always<br>&gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0Show uniquely abbreviated commit object as fallback.<br>&gt;<br>&gt;=
 using it works and fix my builds:<br>&gt;<br>&gt; =C2=A0 $ git describe --=
match &#39;v*&#39; --dirty --always<br>&gt; =C2=A0 dc9f825f99e-dirty<br>&gt=
;<br>&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br>&gt; ---<br>&gt; =C2=A0scripts/=
qemu-version.sh | 2 +-<br>&gt; =C2=A01 file changed, 1 insertion(+), 1 dele=
tion(-)<br>&gt;<br>&gt; diff --git a/scripts/qemu-version.sh b/scripts/qemu=
-version.sh<br>&gt; index 03128c56a2c..a7135511588 100755<br>&gt; --- a/scr=
ipts/qemu-version.sh<br>&gt; +++ b/scripts/qemu-version.sh<br>&gt; @@ -9,7 =
+9,7 @@ version=3D&quot;$3&quot;<br>&gt; =C2=A0if [ -z &quot;$pkgversion&qu=
ot; ]; then<br>&gt; =C2=A0 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0if [ -e .git ]; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgv=
ersion=3D$(git describe --match &#39;v*&#39; --dirty | echo &quot;&quot;)<b=
r>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(git describe --match &#3=
9;v*&#39; --dirty --always | echo &quot;&quot;)<br>&gt; =C2=A0 =C2=A0 =C2=
=A0fi<br>&gt; =C2=A0fi<br>&gt;<br>&gt; --<br>&gt; 2.26.2<br>&gt;<br>&gt;<br=
><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo<br></div></div>

--000000000000534cca05b0ef6f49--

