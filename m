Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7EBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A657F206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQoWKUeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A657F206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ1Us-0002Qo-Ij
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 16:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <scw@google.com>) id 1jJ1UB-000202-H9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <scw@google.com>) id 1jJ1UA-0004wr-7f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:58:19 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <scw@google.com>) id 1jJ1U9-0004uw-Vq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:58:18 -0400
Received: by mail-io1-xd43.google.com with SMTP id x9so12942771iom.10
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zw5SfoHViZzIJrh/e8QJf4+nGpQl9J6Oc9y+FNv/NlE=;
 b=jQoWKUeERQa81D1gr5sSOlWflmk7gNFWTO3u0R5oDFqc8/rXSt4nVxcYZUpA0LEHGv
 s2wQjEwfFncykaLB2xyyeNX7OPs3lBPAbscS+ST2lVSyBvkT5zKqX3ME7Ozm6jbb2jbR
 20Fh2t7VAxseIx8SgwJc2oB6nmiGqGW/ovr171EULZOsp+FWEiisroZTtXTpOfNuM/Ak
 TXT5bF7TeZR7HtvCWelMZDFdi9OntMYEVix/iehuySRo/1rfybdC5Z+drklqqCtb4rML
 Fuc30EvG2UOwQikISdIOwFZWrZrS4BEFtYzV9T0mt+RZk32PYBmkrCFTSFE6NXV6pDzc
 UoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zw5SfoHViZzIJrh/e8QJf4+nGpQl9J6Oc9y+FNv/NlE=;
 b=pwtdhzAie7TYtJIlv/YPT4ADZDcB8QOqiKWSwUGuNtKeu4F5vPxZmnH1pQd7ruJLx5
 YnzLo/yyby6hyNiJdVr77sNi3C0Sw1yeR5puNtYIAey/Gw8mf4xeZbmy6+z1lZRG8HE+
 0ArKY+xJLoSArpNVrn6OZw4vwOlp/YFaCi8LbNNQwvhy5rqGxcgT4xFYsjw6vzGenQZq
 6GYE7zFmxPnOSkpOgKn1fCczkc/7NoxqOdnIocqfGJu63VhggiL4tTykMfNT5rkx1nVu
 n3UyXzwiILvOMCTHlmNe7MtpGLWypavEgTuE+BdRdg0ftQB7eEzZF5kDW0K7puWv1wNu
 x9Ew==
X-Gm-Message-State: ANhLgQ1C5iHXm61GSSJSnH8xCaps+FYCBe3H1uwet3GFF0sQOZvP4NcU
 XX4kxZQW+2YY4DQ1xXU4p9Sxkj4DvSUqtKCsXUXe6w==
X-Google-Smtp-Source: ADFU+vssCyHA7TQxzGuUps3qEKU1uV3nO7yg5wBt/kUwWxNGoRzUi/fWEXr48Zu+eeFOWUgOKvXyUg6w3pyq8Ea21Yo=
X-Received: by 2002:a02:7a18:: with SMTP id a24mr12796771jac.54.1585601894974; 
 Mon, 30 Mar 2020 13:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200318062057.224953-1-scw@google.com>
In-Reply-To: <20200318062057.224953-1-scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Mon, 30 Mar 2020 13:58:03 -0700
Message-ID: <CAF3nBxj_8GXyGziVu3iEtz6gYidMFk6joZayUCAwQ4-xKB6T0w@mail.gmail.com>
Subject: Re: [PATCH] Makes softmmu compile with clang at HEAD
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000bb9c0d05a218b540"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

--000000000000bb9c0d05a218b540
Content-Type: multipart/alternative; boundary="000000000000b5337305a218b5b1"

--000000000000b5337305a218b5b1
Content-Type: text/plain; charset="UTF-8"

Ping.

On Tue, Mar 17, 2020 at 11:21 PM Shu-Chun Weng <scw@google.com> wrote:

> With clang at HEAD, linking fails with "undefined symbol:
> qemu_build_not_reached". It's because `store_helper` and
> `helper_ret_stb_mmu` are mutually recursive and clang inlined latter
> inside the former, making `store_helper` a recursive function and no
> longer fully inlineable preventing constant propogation.
>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  accel/tcg/cputlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e3b5750c3b..a7c812ed72 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2050,6 +2050,7 @@ store_helper(CPUArchState *env, target_ulong addr,
> uint64_t val,
>      store_memop(haddr, val, op);
>  }
>
> +__attribute__((noinline))
>  void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
>                          TCGMemOpIdx oi, uintptr_t retaddr)
>  {
> --
> 2.25.1.481.gfbce0eb801-goog
>
>

--000000000000b5337305a218b5b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Mar 17, 2020 at 11:21 PM Shu-Chun Weng &lt;<a=
 href=3D"mailto:scw@google.com">scw@google.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">With clang at HEAD, linking f=
ails with &quot;undefined symbol:<br>
qemu_build_not_reached&quot;. It&#39;s because `store_helper` and<br>
`helper_ret_stb_mmu` are mutually recursive and clang inlined latter<br>
inside the former, making `store_helper` a recursive function and no<br>
longer fully inlineable preventing constant propogation.<br>
<br>
Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" target=
=3D"_blank">scw@google.com</a>&gt;<br>
---<br>
=C2=A0accel/tcg/cputlb.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c<br>
index e3b5750c3b..a7c812ed72 100644<br>
--- a/accel/tcg/cputlb.c<br>
+++ b/accel/tcg/cputlb.c<br>
@@ -2050,6 +2050,7 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,<br>
=C2=A0 =C2=A0 =C2=A0store_memop(haddr, val, op);<br>
=C2=A0}<br>
<br>
+__attribute__((noinline))<br>
=C2=A0void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t=
 val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TCGMemOpIdx oi, uintptr_t retaddr)<br>
=C2=A0{<br>
-- <br>
2.25.1.481.gfbce0eb801-goog<br>
<br>
</blockquote></div>

--000000000000b5337305a218b5b1--

--000000000000bb9c0d05a218b540
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQCIS5x6oSNiy9rVVvWM1LLGW/GJRuJqJjxTQRX0vB8Q2dt69IcOdxtPuO4m8xHB
JUG51zkwLknBPKsjWa307RYEPJOng+V/YkhYd8/FJYYj5cvcPtZys4LgWnebcinz5cV/FGzif0om
WukAzW4F/rvex3DtFWhC6W8vD4poQ0HnzS117oY4t84ZR8SQXMQWXIy0cl+QFVRL8pHmK244DhTY
ltAJnpTivF5qP4pfd1EBBqKyzJO+mFMTXAjpaYWNvAERovIgY49pcMqTvJTox1M6zxR/OkIFVSz0
+bxYtfeghScGty7r3QGM8j8v+gy/AmZVkKEF/J248G47GOX6REviMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhABDwaWa5t9R3AuNjPZx468MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCCBwe+YncqFCajWZS25s0BejHfNqRsI7wtIaM1Q2Kx7ZDAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDAzMzAyMDU4MTVaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAVYjr
anG87Dz4LYnxz8gPXqRAcIVCdsUSdBf5Vnizwo93X7+K/+I34D6anh59ZiipnV5Kc1Sv1zBcQ8np
cbNLr0sEk1h5hp3utLaBn2VPxjEPt4cDXB+8BXeVhU7V67q9DYlQNahCqgEHsRutdKHopoiV3sv2
uxan3tBITsoQ6qW8bSgwjShJpp1CR7EWwFKRNjxD8zoowhcTu1FtMHSEGjZOQHedv6kseH4rfBYE
eM/IRD10Op9cTSQWFwsNyXDljRQUVNVCXDCc4GtAlfbG7va/9cUfM4QQiZ+AgXc52oRqTX/dnltE
TOQlMOR8hrNPsCT5LMqul7iXd9KEd+Uipg==
--000000000000bb9c0d05a218b540--

