Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB0EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B9420866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B9420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrMP-0008Vc-3V
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrCv-0003Jw-Rg; Mon, 31 Aug 2020 17:19:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrCu-0001Vb-Ar; Mon, 31 Aug 2020 17:19:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id w186so7631028qkd.1;
 Mon, 31 Aug 2020 14:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UnOhsdclhNGw6uOGPI/gGfLGWUI4yxWuQ7GxNhBiXXY=;
 b=OthKF68Qoz2N9jqnZrklL9ziytcoVRkIoMBVjE4xr8euND0rJ7sjA3Q/iV9avHabnZ
 8VG1WBdeOyDAqgFv44chG74oywNFBWSgi0KhZo3egXtXZbGmyjmI//mTngCXxPhUE1M7
 G82GXeW1csECoZnCNrY149saPoWa41sNUTXPfnP8Bp2qZBMkaNyGJDTnN9hJfWQovkiS
 ZvsK/gIG3RPaPv0d1oPhk+/aKbv+kTqFJNslRuIFrnhe2a02p9Ar7UWFgJLk0Vdae6iu
 T4gpr0/7rgUw25GP0WyrxYs7FxEuAWMok+CwRlh6eLGSpRwDXNYLBvUaXjetwzkDRqpC
 6eEg==
X-Gm-Message-State: AOAM533y6XvmxzTZNEHiOYEQFWvrBodeVEKKBJpEXlWum4dAC8BOuI7v
 4ByDNu2FbI7se8aGdanszn+of+nA9KlkJ3JqRT0=
X-Google-Smtp-Source: ABdhPJxfa32tuC+xChS76Fw4Z0e72GsfsVgVnV/mr69cDCnsNgNsq0L1/+2yKzvHGOPR0EUSxSbhlnAA6MKhw/gPK/o=
X-Received: by 2002:a37:498e:: with SMTP id w136mr2794711qka.187.1598908755128; 
 Mon, 31 Aug 2020 14:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200827175520.32355-1-sw@weilnetz.de>
In-Reply-To: <20200827175520.32355-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 21:59:53 +0200
Message-ID: <CAAdtpL5VS8P2uhgToFHH=y58ZKK44UVVRHj71g7NgriN6O-1Fg@mail.gmail.com>
Subject: Re: [PATCH] main-loop: Fix comment
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="00000000000060b5f105ae32f490"
Received-SPF: pass client-ip=209.85.222.193;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000060b5f105ae32f490
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 19:55, Stefan Weil <sw@weilnetz.de> a =C3=A9crit =
:

> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  include/qemu/main-loop.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index 8e98613656..d6892fd208 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -52,7 +52,7 @@ int qemu_init_main_loop(Error **errp);
>   * repeatedly calls main_loop_wait(false).
>   *
>   * Main loop services include file descriptor callbacks, bottom halves
> - * and timers (defined in qemu-timer.h).  Bottom halves are similar to
> timers
> + * and timers (defined in qemu/timer.h).  Bottom halves are similar to
> timers
>   * that execute immediately, but have a lower overhead and scheduling th=
em
>   * is wait-free, thread-safe and signal-safe.
>   *
> --
> 2.28.0
>
>

--00000000000060b5f105ae32f490
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 19:55, Stefan Weil &lt;<a hr=
ef=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; a =C3=A9crit=C2=A0:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Signed-off-by: Stefan Weil &lt;<a href=
=3D"mailto:sw@weilnetz.de" target=3D"_blank" rel=3D"noreferrer">sw@weilnetz=
.de</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">Review=
ed-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat=
.org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:sans-=
serif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-family:san=
s-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
---<br>
=C2=A0include/qemu/main-loop.h | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h<br>
index 8e98613656..d6892fd208 100644<br>
--- a/include/qemu/main-loop.h<br>
+++ b/include/qemu/main-loop.h<br>
@@ -52,7 +52,7 @@ int qemu_init_main_loop(Error **errp);<br>
=C2=A0 * repeatedly calls main_loop_wait(false).<br>
=C2=A0 *<br>
=C2=A0 * Main loop services include file descriptor callbacks, bottom halve=
s<br>
- * and timers (defined in qemu-timer.h).=C2=A0 Bottom halves are similar t=
o timers<br>
+ * and timers (defined in qemu/timer.h).=C2=A0 Bottom halves are similar t=
o timers<br>
=C2=A0 * that execute immediately, but have a lower overhead and scheduling=
 them<br>
=C2=A0 * is wait-free, thread-safe and signal-safe.<br>
=C2=A0 *<br>
-- <br>
2.28.0<br>
<br></blockquote></div></div></div>

--00000000000060b5f105ae32f490--

