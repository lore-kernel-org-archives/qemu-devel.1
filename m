Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE860206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QADritpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE860206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVEp-0002NN-89
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jgVE8-0001Os-Ly
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:22:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jgVE7-0000MD-Mt
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:22:48 -0400
Received: by mail-ot1-x341.google.com with SMTP id u23so2149426otq.10
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3kLafc+2TY60mtrr2u6qXT2bPTDzKxiLAvZLbPhgy+k=;
 b=QADritptpF5WBcU4Hh0nn5w808OL660ysZMoo8lhwdeG4hGcyU19PRnNWBdmLWn0UY
 YF/pTRmFLmYueS1qTZIEAFhUaeTZN9QqSyqZeDqZqdpdLc0g50e4o9XMyK+bQ0qwx6Px
 9sXDwlEbLwtxbRA9jhtAhAMev2YQUhvP9AfzjIobeJzBH/9YOyEJ0lNwPAFMCgq6pLjF
 7huU2l4HSvW05HwZZEwKOQpuMWwg6lghaJCkNgsF+aGz3pwr4ykn4Sw06JJ0zxJ2hMoA
 nw5WwpyW1Bu+vBwFXEOS3c84q52AEYIHiqFWqP3z9VUHFInrC1mtn1HqbuJrrRa8O5Eu
 cK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3kLafc+2TY60mtrr2u6qXT2bPTDzKxiLAvZLbPhgy+k=;
 b=kFHSkzYy653kA80bf+5u/xZEEPhnDcek0s+L0spykg3pBzIAs/1y+NmTuvytRO4fPM
 N7nDtC0jh51scKor1fh6FHN2hofFCGd7pFGScZaoz72a0YFcxiEoMC/2H9UE78iokjlD
 9KFrhKTc6cQ+lSNhtoeRU1Ul4J4mAVmfkMyvMeGAmADfjjazpLpaYHLychXnIGY4Za1o
 LsNu9uCaiSZn5v8mvykaX/OGvakWvW80527QVYF3lpSjXhN83mCe/ic2j8yW0YZshws/
 nFP7iZnp2fRR3YUdsiCvBryj7UERus0NYqObFt+EGMCRlkD/kNvH+/y2X/Di4Hr2fUnT
 pInQ==
X-Gm-Message-State: AOAM531ovKlVbUpdmY+YM2i/H/zVRLCIVcE1Rg/Rbn/lScAQcJRGtpHf
 mo37leLW1nOkcjDzgIOdx0w1UmX4nY+KTWu+FIo=
X-Google-Smtp-Source: ABdhPJxA8l+lDAG8Plo84ZKFHWoUDmcz/0ElXPKRbNIzSXJpu4fCFrDpnUx1QAchdbi12inE0PcvEGN30kDcpXFh0qo=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr329397otk.181.1591197766152; 
 Wed, 03 Jun 2020 08:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200603070338.7922-1-pannengyuan@huawei.com>
In-Reply-To: <20200603070338.7922-1-pannengyuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 3 Jun 2020 23:22:10 +0800
Message-ID: <CAKXe6SKz1Eg-F+Z5OkXFtKZE+wZEd+1=N+EYKgxt0+ZRCktUFQ@mail.gmail.com>
Subject: Re: [PATCH] qom-hmp-cmds: fix a memleak in hmp_qom_get
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000009e778f05a72f9904"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, euler.robot@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009e778f05a72f9904
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:17=E5=86=99=E9=81=93=EF=BC=9A

> 'obj' forgot to free at the end of hmp_qom_get(). Fix that.
>
> The leak stack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f4e3a779ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae=
8)
>     #1 0x7f4e398f91d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x55c9fd9a3999 in qstring_from_substr
> /build/qemu/src/qobject/qstring.c:45
>     #3 0x55c9fd894bd3 in qobject_output_type_str
> /build/qemu/src/qapi/qobject-output-visitor.c:175
>     #4 0x55c9fd894bd3 in qobject_output_type_str
> /build/qemu/src/qapi/qobject-output-visitor.c:168
>     #5 0x55c9fd88b34d in visit_type_str
> /build/qemu/src/qapi/qapi-visit-core.c:308
>     #6 0x55c9fd59aa6b in property_get_str /build/qemu/src/qom/object.c:20=
64
>     #7 0x55c9fd5adb8a in object_property_get_qobject
> /build/qemu/src/qom/qom-qobject.c:38
>     #8 0x55c9fd4a029d in hmp_qom_get /build/qemu/src/qom/qom-hmp-cmds.c:6=
6
>
> Fixes: 89cf4fe34f4
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>


This can be tested by compile qemu with '-fsanitize=3Daddress' cflags and:
make check

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Tested-by: Li Qiang <liq3ea@gmail.com>

Li Qiang


> ---
>  qom/qom-hmp-cmds.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index f704b6949a..3d2a23292d 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -71,6 +71,7 @@ void hmp_qom_get(Monitor *mon, const QDict *qdict)
>          qobject_unref(str);
>      }
>
> +    qobject_unref(obj);
>      hmp_handle_error(mon, err);
>  }
>
> --
> 2.18.2
>
>
>

--0000000000009e778f05a72f9904
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Pan Nengyuan &lt;<a href=3D"mailto:pa=
nnengyuan@huawei.com">pannengyuan@huawei.com</a>&gt; =E4=BA=8E2020=E5=B9=B4=
6=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:17=E5=86=99=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
&#39;obj&#39; forgot to free at the end of hmp_qom_get(). Fix that.<br>
<br>
The leak stack:<br>
Direct leak of 40 byte(s) in 1 object(s) allocated from:<br>
=C2=A0 =C2=A0 #0 0x7f4e3a779ae8 in __interceptor_malloc (/lib64/libasan.so.=
5+0xefae8)<br>
=C2=A0 =C2=A0 #1 0x7f4e398f91d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d=
5)<br>
=C2=A0 =C2=A0 #2 0x55c9fd9a3999 in qstring_from_substr /build/qemu/src/qobj=
ect/qstring.c:45<br>
=C2=A0 =C2=A0 #3 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/=
qapi/qobject-output-visitor.c:175<br>
=C2=A0 =C2=A0 #4 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/=
qapi/qobject-output-visitor.c:168<br>
=C2=A0 =C2=A0 #5 0x55c9fd88b34d in visit_type_str /build/qemu/src/qapi/qapi=
-visit-core.c:308<br>
=C2=A0 =C2=A0 #6 0x55c9fd59aa6b in property_get_str /build/qemu/src/qom/obj=
ect.c:2064<br>
=C2=A0 =C2=A0 #7 0x55c9fd5adb8a in object_property_get_qobject /build/qemu/=
src/qom/qom-qobject.c:38<br>
=C2=A0 =C2=A0 #8 0x55c9fd4a029d in hmp_qom_get /build/qemu/src/qom/qom-hmp-=
cmds.c:66<br>
<br>
Fixes: 89cf4fe34f4<br>
Reported-by: Euler Robot &lt;<a href=3D"mailto:euler.robot@huawei.com" targ=
et=3D"_blank">euler.robot@huawei.com</a>&gt;<br>
Signed-off-by: Pan Nengyuan &lt;<a href=3D"mailto:pannengyuan@huawei.com" t=
arget=3D"_blank">pannengyuan@huawei.com</a>&gt;<br></blockquote><div><br></=
div><div><br></div><div>This can be tested by compile qemu with &#39;-fsani=
tize=3Daddress&#39; cflags and:</div><div>make check</div><div><br></div><d=
iv>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com">liq3ea@gma=
il.com</a>&gt;</div><div>Tested-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@g=
mail.com">liq3ea@gmail.com</a>&gt;</div><div><br></div><div>Li Qiang</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qom/qom-hmp-cmds.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c<br>
index f704b6949a..3d2a23292d 100644<br>
--- a/qom/qom-hmp-cmds.c<br>
+++ b/qom/qom-hmp-cmds.c<br>
@@ -71,6 +71,7 @@ void hmp_qom_get(Monitor *mon, const QDict *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qobject_unref(str);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qobject_unref(obj);<br>
=C2=A0 =C2=A0 =C2=A0hmp_handle_error(mon, err);<br>
=C2=A0}<br>
<br>
-- <br>
2.18.2<br>
<br>
<br>
</blockquote></div></div>

--0000000000009e778f05a72f9904--

