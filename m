Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E03C206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3+RG323"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E03C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHmb9-0008Ba-7j
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHma9-0007k5-GI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHma8-0004hH-9N
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:19:05 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHma8-0004fa-1w
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:19:04 -0400
Received: by mail-oi1-x243.google.com with SMTP id a15so8285642oic.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uy/zoZKgFogS2AQU+AbaPATBbiH6K9bvImJo1l4Qa74=;
 b=m3+RG3234JSZE7P+OL8jU9BJDlN6rKXR4AK3joejzX22yFI3AtqgkBuu+X9mQBv58o
 Y5fEZsvcI7CwA85V6ooZrfakaE2b1MrIPArbmR+qqcpKOfYtdvsTO70FQCnTJFoqGsHD
 BPbTzfIO+ovV8UbUCNusRIkbJbA4HyBzzpLneifXYo9jju3uuTHQQZ9XNSIlJgTYHBDQ
 hyHqicJYUJGKPjOPJpw0aYaGiZMJuIitzcMkhQYW1oJypRIpjmZaJcO6iER6nhcfO8xo
 HyQjMiQg9T7AznUdCIdmhu/wDfAIzF6kfbRp38hdx28R36arP9ZyTMQPfKfsrhLHGJO/
 cWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uy/zoZKgFogS2AQU+AbaPATBbiH6K9bvImJo1l4Qa74=;
 b=Ew8X2X92g6arDE4OAH/t7He+PQimgbAAjM94T0FpUWqM1+ZMOVn/0eboHvMyFt4PSI
 1iZOGJEDaO3mryijKXSCkq7iNS6q9rFP0goqFKb3k2vQC856NqGlvSTRC43DIVffbtBZ
 vFV0UIQFXkFJkpWaWMI47TIQfZyKV/5Q0AzdDF5lw0wqRrVjZdUFms6sMSVME6yEywSW
 YZjKuXYh/CbGgly3of2FglELQ585sTCMPdVYAeDpYzeuvhNYpA9DAZgLTAbDNekjQ/d+
 JJXGR1zJOpEVM17VX2ddZ+6db4hZca7FBPwSoUYHL1H6Vk6lNJ3alxZZu6YFrtYqR3Cp
 Lh2A==
X-Gm-Message-State: APjAAAXvAeDFAjeMbI3BIfZFZtCZErKPvL6vMy1zsZsfATmfWHSfFt5I
 +VfDERua5JjQsEJN0OLRFfh2iGmsp5QslBdzXqc=
X-Google-Smtp-Source: APXvYqxiRkMVN8C2tHRBPGg1+TiE2BDbyFzSkUd9kT+6frF0pqhUg8TYUu1mjUoCVslp+E1DCeB1YboBUA0Toe4RLPg=
X-Received: by 2002:a54:4084:: with SMTP id i4mr3291118oii.129.1570529942381; 
 Tue, 08 Oct 2019 03:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-2-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-2-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 18:18:26 +0800
Message-ID: <CAKXe6S+LB-YQ7AsypDbKvSAzCo_omQq4jJiBLtp6xci8c8w7mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] tests/libqos/fw_cfg: Document io_fw_cfg_init to
 drop io_fw_cfg_uninit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000532ac30594637f48"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000532ac30594637f48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=99=E9=81=
=93=EF=BC=9A

> Document io_fw_cfg_init() return value must be released
> with g_free(). Directly calling g_free() we don't really
> need io_fw_cfg_uninit(): remove it.
>
> This partly reverts commit 0729d833d6d6:
> "tests/libqos: Add io_fw_cfg_uninit()"
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>



> ---
>  tests/libqos/fw_cfg.c |  5 -----
>  tests/libqos/fw_cfg.h | 11 +++++++++--
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index 1f46258f96..37c3f2cf4d 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -157,8 +157,3 @@ QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base=
)
>
>      return fw_cfg;
>  }
> -
> -void io_fw_cfg_uninit(QFWCFG *fw_cfg)
> -{
> -    g_free(fw_cfg);
> -}
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index 13325cc4ff..15604040bd 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -36,8 +36,15 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char
> *filename,
>
>  QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
>  void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
> +/**
> + * io_fw_cfg_init():
> + * @qts: The #QTestState that will be referred to by the QFWCFG object.
> + * @base: The I/O address of the fw_cfg device in the guest.
> + *
> + * Returns a newly allocated QFWCFG object which must be released
> + * with a call to g_free() when no longer required.
> + */
>  QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> -void io_fw_cfg_uninit(QFWCFG *fw_cfg);
>
>  static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>  {
> @@ -46,7 +53,7 @@ static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>
>  static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)
>  {
> -    io_fw_cfg_uninit(fw_cfg);
> +    g_free(fw_cfg);
>  }
>
>  #endif
> --
> 2.21.0
>
>

--000000000000532ac30594637f48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:19=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Document io_fw_cfg_init() return value must be released<br>
with g_free(). Directly calling g_free() we don&#39;t really<br>
need io_fw_cfg_uninit(): remove it.<br>
<br>
This partly reverts commit 0729d833d6d6:<br>
&quot;tests/libqos: Add io_fw_cfg_uninit()&quot;<br>
<br>
Reviewed-by: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com" target=
=3D"_blank">lersek@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com"=
>liq3ea@gmail.com</a>&gt;<br></div><div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tests/libqos/fw_cfg.c |=C2=A0 5 -----<br>
=C2=A0tests/libqos/fw_cfg.h | 11 +++++++++--<br>
=C2=A02 files changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c<br>
index 1f46258f96..37c3f2cf4d 100644<br>
--- a/tests/libqos/fw_cfg.c<br>
+++ b/tests/libqos/fw_cfg.c<br>
@@ -157,8 +157,3 @@ QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0return fw_cfg;<br>
=C2=A0}<br>
-<br>
-void io_fw_cfg_uninit(QFWCFG *fw_cfg)<br>
-{<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
-}<br>
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h<br>
index 13325cc4ff..15604040bd 100644<br>
--- a/tests/libqos/fw_cfg.h<br>
+++ b/tests/libqos/fw_cfg.h<br>
@@ -36,8 +36,15 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *file=
name,<br>
<br>
=C2=A0QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);<br>
=C2=A0void mm_fw_cfg_uninit(QFWCFG *fw_cfg);<br>
+/**<br>
+ * io_fw_cfg_init():<br>
+ * @qts: The #QTestState that will be referred to by the QFWCFG object.<br=
>
+ * @base: The I/O address of the fw_cfg device in the guest.<br>
+ *<br>
+ * Returns a newly allocated QFWCFG object which must be released<br>
+ * with a call to g_free() when no longer required.<br>
+ */<br>
=C2=A0QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);<br>
-void io_fw_cfg_uninit(QFWCFG *fw_cfg);<br>
<br>
=C2=A0static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)<br>
=C2=A0{<br>
@@ -46,7 +53,7 @@ static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)<br>
<br>
=C2=A0static inline void pc_fw_cfg_uninit(QFWCFG *fw_cfg)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 io_fw_cfg_uninit(fw_cfg);<br>
+=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0}<br>
<br>
=C2=A0#endif<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--000000000000532ac30594637f48--

