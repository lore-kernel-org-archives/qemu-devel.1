Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07ACC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 06:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75F1217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 06:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPZQQId0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75F1217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlnoZ-0005t7-UX
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 02:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jlnnx-0005TY-DT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 02:13:41 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jlnns-00033w-2X
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 02:13:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id m2so3625900otr.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PQQASfNXOk86dqFvsxhtgwOhYshu+hD14zP4ayd3dZ0=;
 b=sPZQQId06C3hwSGGU2hWgq2/LTiDK8k/i+2hiE1gfh2uG4XLOGcIrMysJoLTrvpYzA
 JKO3KtnsI9X2CGTtqoSgVYKOa5BgfNnMfpjnkTJFP5J3T0tHSgg3lllilDGoiHajU0jq
 xUavvM1aZimM+IzjmpwYNscwHmwFN8akYl6+a6RTWSERYTwAdbOgU4sI/SFflCyuTjkZ
 29T6cvbhZLXxY9qdocI1D/pTFBsEdO0QFMKlSfjVTr7/9sp+KuGZOzVyMEea9I6eOtq+
 lYQWt5UJUJaMW9iWZrxD2k0kMpvtx6QsPiJXPc4VKfzXz5dSrsEGJoKs3EETq6GUuXE7
 mWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PQQASfNXOk86dqFvsxhtgwOhYshu+hD14zP4ayd3dZ0=;
 b=Wne7Raafwn5kKUyONsik75Zr8kgs1JwA+jJ13TnuhcUBwu82bGlp8jw6b8SA4uhPIe
 3kJaVXSRvAtcT9UWdLqoOKV7mJ/pOQehyiNyGAX2RNPnAcxNbfd+FFaBAzYA9gsWHrYg
 dOGAj+IIiqePkOn1w1HzHNjQukp+hAYaTJH2e0oEKKaFqku8OCU/FKb7VHmxnG5Kfhp6
 4aredaN3c6PvncLXPD6wkSnG0Ac3Z3/PmbyUaDeqwiFXWCWEHocUmlgJBELfd7yKb4qQ
 rTaVyovbtAoYochy+sIx33ORbwrSZ4wcedLRvFsFSxKLFcrGYg6qWrKwSlEZwjdOFa9H
 HJVA==
X-Gm-Message-State: AOAM532bTI1qnxsRSfPGAHT5Xfa6cQel3KOFjzegoLMG9mTyhjdMO0w1
 h71jYwkk8JpWkHZzIF8fau6YqqpBnqBhj4n1Y48=
X-Google-Smtp-Source: ABdhPJy5vJUIlKgWDdftx6OgP57/TBrcrvLyrPvUQ2PE8D17zbkP3HpkGNpv7LZM+fk9kPGrxio0kWdq9FpWzq6jEA4=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr2064865otj.181.1592460814558; 
 Wed, 17 Jun 2020 23:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200603161409.54682-1-liq3ea@163.com>
In-Reply-To: <20200603161409.54682-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Jun 2020 14:12:58 +0800
Message-ID: <CAKXe6SJ-HNK-ZKYcGCGsiUmYi_MVGrVmSvric2OjK5m2q=TBjg@mail.gmail.com>
Subject: Re: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
To: Li Qiang <liq3ea@163.com>
Content-Type: multipart/alternative; boundary="0000000000002bac3c05a855add8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: zxq_yx_007@163.com, marcandre lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002bac3c05a855add8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping..
Anyone queued this?

Thanks,
Li Qiang

Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=884=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:31=E5=86=99=E9=81=93=EF=BC=9A

> After build qemu with '-fsanitize=3Daddress' extra-cflags,
> 'make check' show following leak:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D44580=3D=3DERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 2500 byte(s) in 1 object(s) allocated from:
>     #0 0x7f1b5a8b8d28 in __interceptor_calloc
> (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
>     #1 0x7f1b5a514b10 in g_malloc0
> (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
>     #2 0xd79ea4e4c0ad31c3  (<unknown module>)
>
> SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).
>
> Call 'g_rand_free' in the end of function to avoid this.
>
> Fixes: 4d3a329af59("tests/util-sockets: add abstract unix socket cases")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/test-util-sockets.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
> index 2ca1e99f17..ca6671f9bf 100644
> --- a/tests/test-util-sockets.c
> +++ b/tests/test-util-sockets.c
> @@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
>      g_thread_join(serv);
>
>      g_free(abstract_sock_name);
> +    g_rand_free(r);
>  }
>  #endif
>
> --
> 2.17.1
>
>
>

--0000000000002bac3c05a855add8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping..<div>Anyone queued this?</div><div><br></div><div>Th=
anks,</div><div>Li Qiang</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com=
">liq3ea@163.com</a>&gt; =E4=BA=8E2020=E5=B9=B46=E6=9C=884=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:31=E5=86=99=E9=81=93=EF=BC=9A<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">After build qemu with &#39;=
-fsanitize=3Daddress&#39; extra-cflags,<br>
&#39;make check&#39; show following leak:<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
=3D=3D44580=3D=3DERROR: LeakSanitizer: detected memory leaks<br>
<br>
Direct leak of 2500 byte(s) in 1 object(s) allocated from:<br>
=C2=A0 =C2=A0 #0 0x7f1b5a8b8d28 in __interceptor_calloc (/usr/lib/x86_64-li=
nux-gnu/libasan.so.4+0xded28)<br>
=C2=A0 =C2=A0 #1 0x7f1b5a514b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/lib=
glib-2.0.so.0+0x51b10)<br>
=C2=A0 =C2=A0 #2 0xd79ea4e4c0ad31c3=C2=A0 (&lt;unknown module&gt;)<br>
<br>
SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).<br>
<br>
Call &#39;g_rand_free&#39; in the end of function to avoid this.<br>
<br>
Fixes: 4d3a329af59(&quot;tests/util-sockets: add abstract unix socket cases=
&quot;)<br>
Signed-off-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com" target=3D"_bl=
ank">liq3ea@163.com</a>&gt;<br>
---<br>
=C2=A0tests/test-util-sockets.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c<br>
index 2ca1e99f17..ca6671f9bf 100644<br>
--- a/tests/test-util-sockets.c<br>
+++ b/tests/test-util-sockets.c<br>
@@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)<br>
=C2=A0 =C2=A0 =C2=A0g_thread_join(serv);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(abstract_sock_name);<br>
+=C2=A0 =C2=A0 g_rand_free(r);<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
-- <br>
2.17.1<br>
<br>
<br>
</blockquote></div>

--0000000000002bac3c05a855add8--

