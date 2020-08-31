Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2819C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804CE20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804CE20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrNC-0001aX-DH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrAg-0000il-DK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:16:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrAe-0001Lp-Ds
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:16:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id o5so245238qke.12
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3BmZw6TT/RtFu1WOtUkX75t7jyI9lJT/TCFegZ5kmBU=;
 b=QrhEAXMH4oEud63PvUUcpSNx8xYHirDa/lgrpfvrYGpnNQn/VVWTCxAU1m/JHTikzB
 8AMLF5l7eUofWXnP23UQMU/Oj25HWpqowAW9Y24qjYQ+zJOAz6n/oyz1wUBDA98SYWW9
 JqemoMAxWb9OIkzjV0eQ4YVhr/rV3IRnDR7tklzzOKrWiLBYliabkXg+ARVXgk0IlTCh
 c4UTiXHTVVnxu3GN/VGCH4mG/qy/Wib+inZi0RswKds0sIl+plVO35NpgUtyMTHvduu2
 or4755lpsl8NJnVHqSN+G/dh9Svm900g/5NbIVbWKpeWCQgiXkn7Qrv0+6CmXstvQpyl
 0X7Q==
X-Gm-Message-State: AOAM533bfA63enDo/CNdRpK3yzO3Fs6UPwqGky72wfhTWURvYb9cELu7
 5f/elF3NjBOaEeSmqyxKxboQwpuIiTQfmYhApWjF3tA8
X-Google-Smtp-Source: ABdhPJweFowWAeIpAWCG2ZWESerqi/Dg+AWQ34JsZJ24r0cXOQbhyS1Ub+/UHGBqhCmkp5mXjCL4nu0b7PeqlNZ8PDo=
X-Received: by 2002:ae9:f101:: with SMTP id k1mr3382376qkg.122.1598908615544; 
 Mon, 31 Aug 2020 14:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
 <20200828110734.1638685-13-marcandre.lureau@redhat.com>
In-Reply-To: <20200828110734.1638685-13-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 19:43:05 +0200
Message-ID: <CAAdtpL6xB3_YhuDExyWHxtTe=RRAnLgXOqQ5GSn28BBYsp2geg@mail.gmail.com>
Subject: Re: [PATCH 12/16] tests: do not print benchmark output to stdout
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000ed66c05ae32ec50"
Received-SPF: pass client-ip=209.85.222.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000ed66c05ae32ec50
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 13:11, <marcandre.lureau@redhat.com> a =C3=A9crit=
 :

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> As this makes the TAP output invalid. Use g_test_message().
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tests/benchmark-crypto-cipher.c | 8 ++++----
>  tests/benchmark-crypto-hash.c   | 2 +-
>  tests/benchmark-crypto-hmac.c   | 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tests/benchmark-crypto-cipher.c
> b/tests/benchmark-crypto-cipher.c
> index 53032334ec..1936aa4ae0 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -70,8 +70,8 @@ static void test_cipher_speed(size_t chunk_size,
>      }
>      g_test_timer_elapsed();
>
> -    g_print("Enc chunk %zu bytes ", chunk_size);
> -    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
> +    g_test_message("Enc chunk %zu bytes ", chunk_size);
> +    g_test_message("%.2f MB/sec ", (double)total / MiB /
> g_test_timer_last());
>
>      g_test_timer_start();
>      remain =3D total;
> @@ -85,8 +85,8 @@ static void test_cipher_speed(size_t chunk_size,
>      }
>      g_test_timer_elapsed();
>
> -    g_print("Dec chunk %zu bytes ", chunk_size);
> -    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
> +    g_test_message("Dec chunk %zu bytes ", chunk_size);
> +    g_test_message("%.2f MB/sec ", (double)total / MiB /
> g_test_timer_last());
>
>      qcrypto_cipher_free(cipher);
>      g_free(plaintext);
> diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.=
c
> index d16837d00a..598111e75a 100644
> --- a/tests/benchmark-crypto-hash.c
> +++ b/tests/benchmark-crypto-hash.c
> @@ -48,7 +48,7 @@ static void test_hash_speed(const void *opaque)
>      }
>      g_test_timer_elapsed();
>
> -    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
> +    g_test_message("%.2f MB/sec ", (double)total / MiB /
> g_test_timer_last());
>
>      g_free(out);
>      g_free(in);
> diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.=
c
> index f1dfa240cb..f9fa22df95 100644
> --- a/tests/benchmark-crypto-hmac.c
> +++ b/tests/benchmark-crypto-hmac.c
> @@ -55,10 +55,10 @@ static void test_hmac_speed(const void *opaque)
>      } while (g_test_timer_elapsed() < 5.0);
>
>      total /=3D MiB;
> -    g_print("hmac(sha256): ");
> -    g_print("Testing chunk_size %zu bytes ", chunk_size);
> -    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
> -    g_print("%.2f MB/sec\n", total / g_test_timer_last());
> +    g_test_message("hmac(sha256): ");
> +    g_test_message("Testing chunk_size %zu bytes ", chunk_size);
> +    g_test_message("done: %.2f MB in %.2f secs: ", total,
> g_test_timer_last());
> +    g_test_message("%.2f MB/sec\n", total / g_test_timer_last());
>
>      g_free(out);
>      g_free(in);
> --
> 2.26.2
>
>
>

--0000000000000ed66c05ae32ec50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 13:11,  &lt;<a href=3D"mailt=
o:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; a =C3=A9=
crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Marc-Andr=C3=A9 L=
ureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
As this makes the TAP output invalid. Use g_test_message().<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.=
com</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Review=
ed-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat=
.org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-=
serif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:san=
s-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
---<br>
=C2=A0tests/benchmark-crypto-cipher.c | 8 ++++----<br>
=C2=A0tests/benchmark-crypto-hash.c=C2=A0 =C2=A0| 2 +-<br>
=C2=A0tests/benchmark-crypto-hmac.c=C2=A0 =C2=A0| 8 ++++----<br>
=C2=A03 files changed, 9 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-ciphe=
r.c<br>
index 53032334ec..1936aa4ae0 100644<br>
--- a/tests/benchmark-crypto-cipher.c<br>
+++ b/tests/benchmark-crypto-cipher.c<br>
@@ -70,8 +70,8 @@ static void test_cipher_speed(size_t chunk_size,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_test_timer_elapsed();<br>
<br>
-=C2=A0 =C2=A0 g_print(&quot;Enc chunk %zu bytes &quot;, chunk_size);<br>
-=C2=A0 =C2=A0 g_print(&quot;%.2f MB/sec &quot;, (double)total / MiB / g_te=
st_timer_last());<br>
+=C2=A0 =C2=A0 g_test_message(&quot;Enc chunk %zu bytes &quot;, chunk_size)=
;<br>
+=C2=A0 =C2=A0 g_test_message(&quot;%.2f MB/sec &quot;, (double)total / MiB=
 / g_test_timer_last());<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_test_timer_start();<br>
=C2=A0 =C2=A0 =C2=A0remain =3D total;<br>
@@ -85,8 +85,8 @@ static void test_cipher_speed(size_t chunk_size,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_test_timer_elapsed();<br>
<br>
-=C2=A0 =C2=A0 g_print(&quot;Dec chunk %zu bytes &quot;, chunk_size);<br>
-=C2=A0 =C2=A0 g_print(&quot;%.2f MB/sec &quot;, (double)total / MiB / g_te=
st_timer_last());<br>
+=C2=A0 =C2=A0 g_test_message(&quot;Dec chunk %zu bytes &quot;, chunk_size)=
;<br>
+=C2=A0 =C2=A0 g_test_message(&quot;%.2f MB/sec &quot;, (double)total / MiB=
 / g_test_timer_last());<br>
<br>
=C2=A0 =C2=A0 =C2=A0qcrypto_cipher_free(cipher);<br>
=C2=A0 =C2=A0 =C2=A0g_free(plaintext);<br>
diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c<=
br>
index d16837d00a..598111e75a 100644<br>
--- a/tests/benchmark-crypto-hash.c<br>
+++ b/tests/benchmark-crypto-hash.c<br>
@@ -48,7 +48,7 @@ static void test_hash_speed(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_test_timer_elapsed();<br>
<br>
-=C2=A0 =C2=A0 g_print(&quot;%.2f MB/sec &quot;, (double)total / MiB / g_te=
st_timer_last());<br>
+=C2=A0 =C2=A0 g_test_message(&quot;%.2f MB/sec &quot;, (double)total / MiB=
 / g_test_timer_last());<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(out);<br>
=C2=A0 =C2=A0 =C2=A0g_free(in);<br>
diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c<=
br>
index f1dfa240cb..f9fa22df95 100644<br>
--- a/tests/benchmark-crypto-hmac.c<br>
+++ b/tests/benchmark-crypto-hmac.c<br>
@@ -55,10 +55,10 @@ static void test_hmac_speed(const void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0} while (g_test_timer_elapsed() &lt; 5.0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0total /=3D MiB;<br>
-=C2=A0 =C2=A0 g_print(&quot;hmac(sha256): &quot;);<br>
-=C2=A0 =C2=A0 g_print(&quot;Testing chunk_size %zu bytes &quot;, chunk_siz=
e);<br>
-=C2=A0 =C2=A0 g_print(&quot;done: %.2f MB in %.2f secs: &quot;, total, g_t=
est_timer_last());<br>
-=C2=A0 =C2=A0 g_print(&quot;%.2f MB/sec\n&quot;, total / g_test_timer_last=
());<br>
+=C2=A0 =C2=A0 g_test_message(&quot;hmac(sha256): &quot;);<br>
+=C2=A0 =C2=A0 g_test_message(&quot;Testing chunk_size %zu bytes &quot;, ch=
unk_size);<br>
+=C2=A0 =C2=A0 g_test_message(&quot;done: %.2f MB in %.2f secs: &quot;, tot=
al, g_test_timer_last());<br>
+=C2=A0 =C2=A0 g_test_message(&quot;%.2f MB/sec\n&quot;, total / g_test_tim=
er_last());<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(out);<br>
=C2=A0 =C2=A0 =C2=A0g_free(in);<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000000ed66c05ae32ec50--

