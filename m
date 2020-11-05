Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281EDC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646B82087D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtVUDhE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646B82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahez-00068s-77
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaheL-0005W5-Sx; Thu, 05 Nov 2020 10:58:09 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:41657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaheJ-0002Hr-BN; Thu, 05 Nov 2020 10:58:09 -0500
Received: by mail-ej1-x644.google.com with SMTP id cw8so3337459ejb.8;
 Thu, 05 Nov 2020 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=akGYpSdXwXTO+slFHz9QRa/ovyy+/e8Ht98Yg4n5bOU=;
 b=dtVUDhE/CzgiNp69y43doUWVHmeaTMbDeUS6Re52KZJAByFa/MpeNgfSMt8Bf1xSuB
 A09tqQwyd80IYie/jtt8Gg6Hl3c1UpllwyevhLb8+aQiCCxfIP0t0i1XBkMAmubq6vQo
 FwJXXFgnT2dC1g6doZJ8R465CNfXH4LWnohie3aBv5wgVF4mpxWk/dt+oLKL1f2yvLaK
 w4T9i7NBPUSlxDvzfKHOVWdHs1uLYx5RhPfLC9PVQOkyLyIgn+pbpc/nadu3gqvz9F9N
 70pbo1bTqgN4f1fy6gFgsLYJhQaf+N36k5bKQauslqa9fl3wNGTYs5Z84YgxIKPTyMN5
 f/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=akGYpSdXwXTO+slFHz9QRa/ovyy+/e8Ht98Yg4n5bOU=;
 b=s4eSxuM9qVI+QREBQuvL4p5WIVK5WYbQwXDpFvfPzsDVRHe1GdpquZ6sEfF9z1EW9j
 BZ18tPGq0B0OOcTdT7z6dG6oASg4wV8/FGcWRMq10grNS2kPYQ5rdrVfITDWOW2jTWp6
 HTxhet1MLmRJBnYkuW+24bCMZS/hBpe++2EQJaMF+xDtysgYwkI+aVVWX7OOsRv0G2YQ
 14xe23/K6Z/eZb4hZP26A99nBLfS/ppe4tpORs3TqwDySckffaQsUaRnA6S46XG+UknV
 p0hMrhySsYmineQQ0103mklQJO20afvV+PkgG1Wq9lKl0Dg+E+cMArGUpqfuT7MSnP/E
 vZng==
X-Gm-Message-State: AOAM530/Avl63nQd9fX7VunWU0/6Qx7nphOxvC4xCitogFHc4W8BfqBn
 5MYIn+vac2FNykNXowkAatRk3SDHR3KXrrwChNI=
X-Google-Smtp-Source: ABdhPJyj5Csj2Qb+e79XAHPl7Yb1LCv8IaA8GUhHsmo4jXTcZY7fXqNt/gJ39avMtL+Wcbk2+aktZLJDM7gUc2RpaQw=
X-Received: by 2002:a17:906:5618:: with SMTP id
 f24mr2900200ejq.381.1604591885326; 
 Thu, 05 Nov 2020 07:58:05 -0800 (PST)
MIME-Version: 1.0
References: <5FA41448.4040404@huawei.com>
In-Reply-To: <5FA41448.4040404@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Nov 2020 19:57:51 +0400
Message-ID: <CAJ+F1CKHmJk2ngLRoEXdOhZk8DDjaOsWZu6O5qsNhWKDfidAgw@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/tpm: Remove redundant check in the
 tpm_test_swtpm_test()
To: AlexChen <alex.chen@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000559e6c05b35e29df"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000559e6c05b35e29df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2020 at 7:05 PM AlexChen <alex.chen@huawei.com> wrote:

> The 'addr' would not be NULL after checking 'succ' is valid,
> and it has been dereferenced in the previous code(args =3D
> g_strdup_printf()).
> So the check on 'addr' in the tpm_test_swtpm_test() is redundant. Remove
> it.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  tests/qtest/tpm-tests.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index 70c80f8379..0da3a8a4df 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -70,10 +70,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path,
> tx_func *tx,
>      qtest_end();
>      tpm_util_swtpm_kill(swtpm_pid);
>
> -    if (addr) {
> -        g_unlink(addr->u.q_unix.path);
> -        qapi_free_SocketAddress(addr);
> -    }
> +    g_unlink(addr->u.q_unix.path);
> +    qapi_free_SocketAddress(addr);
>  }
>
>  void tpm_test_swtpm_migration_test(const char *src_tpm_path,
> --
> 2.19.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000559e6c05b35e29df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 5, 2020 at 7:05 PM AlexCh=
en &lt;<a href=3D"mailto:alex.chen@huawei.com">alex.chen@huawei.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The &#39=
;addr&#39; would not be NULL after checking &#39;succ&#39; is valid,<br>
and it has been dereferenced in the previous code(args =3D g_strdup_printf(=
)).<br>
So the check on &#39;addr&#39; in the tpm_test_swtpm_test() is redundant. R=
emove it.<br>
<br>
Reported-by: Euler Robot &lt;<a href=3D"mailto:euler.robot@huawei.com" targ=
et=3D"_blank">euler.robot@huawei.com</a>&gt;<br>
Signed-off-by: Alex Chen &lt;<a href=3D"mailto:alex.chen@huawei.com" target=
=3D"_blank">alex.chen@huawei.com</a>&gt;<br></blockquote><div><br></div><di=
v>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tests/qtest/tpm-tests.c | 6 ++----<br>
=C2=A01 file changed, 2 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c<br>
index 70c80f8379..0da3a8a4df 100644<br>
--- a/tests/qtest/tpm-tests.c<br>
+++ b/tests/qtest/tpm-tests.c<br>
@@ -70,10 +70,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_fu=
nc *tx,<br>
=C2=A0 =C2=A0 =C2=A0qtest_end();<br>
=C2=A0 =C2=A0 =C2=A0tpm_util_swtpm_kill(swtpm_pid);<br>
<br>
-=C2=A0 =C2=A0 if (addr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_unlink(addr-&gt;u.q_unix.path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_free_SocketAddress(addr);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_unlink(addr-&gt;u.q_unix.path);<br>
+=C2=A0 =C2=A0 qapi_free_SocketAddress(addr);<br>
=C2=A0}<br>
<br>
=C2=A0void tpm_test_swtpm_migration_test(const char *src_tpm_path,<br>
-- <br>
2.19.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000559e6c05b35e29df--

