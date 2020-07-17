Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08309C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AF620717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdrj2fCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AF620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPF2-0004Ih-4k
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jwPEM-0003nS-NW
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:12:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jwPEK-0007hA-VD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:12:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id f139so16674697wmf.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B2KWoE7LClMe8XEOEplE+B7mIaoJdmCgeAYlAUIg5TA=;
 b=sdrj2fCGYjIq1wRiF3AUHrpEmxAITCKGPgxiSyBUSopB4VpQKGrFtloPfE+sFMTW/J
 GhheaY6Q/rZsCbDZ9y2LON1V2QWMnej+MbBgA4SladthIp/efPuPLDFtPRMlP/yAGS9L
 zvUM4ZzuL3jBNBrXc04X7jzqReOYn3zDQ+hua46Fhuopo9eBdhqHGXz6PTCGNNa4zsuC
 Tja744DDcH0UPtGJtxiD8Y2BoT2OcAu2Qf4nSYODRJmOM1IO6/SvfpNHO2eF2P+JJVLl
 4FM5Ho/ozTxc3PmIzOlcLdcV3D6vas1DTTRlIBBX/MGJrRqwl+TIjsGgAoCybEVLjJMp
 QhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B2KWoE7LClMe8XEOEplE+B7mIaoJdmCgeAYlAUIg5TA=;
 b=NNA6jmeq2J6mAEhF5oCrD0d5Mjmue9nuPn89e/9wXVEyXRixAU6yrfnfeZ6crk0UDY
 zhzHELy0UR30Ufeob3eEXO/FB9fqYe7oFGswrmWxY0A3XOddzjRLRNCBBM3zlSiLsHUa
 rTuRz8m/MNIzIR4YsDIbZpREAc/vBgoziZvBzztlxIbUvjpn3gt55hepRrZHSeR6vtbe
 tGuhF8HyapUtO0jd2lwiiQ1K0L5X4wPOlWWRbDm13foj8m89DCoYWTYQceXKZepo4VAf
 v0cT8QrpgbktAQZiRyqPDn04YdV3+jvjEPxIIQwb/BLWrIWpnWWb6jy0Nr0+05KaWUAg
 sRAQ==
X-Gm-Message-State: AOAM533iSY9HXul95yKuKbxxKxEuW5Eeusog67HhQ9ZNgf4rihm991tI
 X8oo6xSZltRBmVcuGYNIHFL0BllN+bs0SuwEyr0YSxYt
X-Google-Smtp-Source: ABdhPJy752oDiQUWz1tgqPH8njUTV80VyD+6HdAqjgY1YI3Vmp3EjWgmSwJ99vsTq2O3yUAk/K7QsKJpK5Lo/gmZEmc=
X-Received: by 2002:a1c:b608:: with SMTP id g8mr8920989wmf.55.1594987960122;
 Fri, 17 Jul 2020 05:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200713083250.2955536-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200713083250.2955536-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jul 2020 16:12:27 +0400
Message-ID: <CAJ+F1CLn9wT__zFxNv_WiGfzmdCmoA+im42=EY7uqHXB6MnzLg@mail.gmail.com>
Subject: Re: [PATCH] slirp: update to v4.3.1
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c8c32105aaa212ec"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c8c32105aaa212ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 13, 2020 at 12:33 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Switch from stable-4.2 branch back to master (which is actually
> maintained, I think we tend to forget about stable...).
>
> git shortlog 2faae0f7..a62d3673:
>
> 5eraph (2):
>       disable_dns option
>       limit vnameserver_addr to port 53
>
> Akihiro Suda (1):
>       libslirp.h: fix SlirpConfig v3 documentation
>
> Jindrich Novy (4):
>       Fix possible infinite loops and use-after-free
>       Use secure string copy to avoid overflow
>       Be sure to initialize sockaddr structure
>       Check lseek() for failure
>
> Marc-Andr=C3=A9 Lureau (12):
>       Merge branch 'master' into 'master'
>       Merge branch 'fix-slirpconfig-3-doc' into 'master'
>       Fix use-afte-free in ip_reass() (CVE-2020-1983)
>       Update CHANGELOG
>       Merge branch 'cve-2020-1983' into 'master'
>       Release v4.3.0
>       Merge branch 'release-v4.3.0' into 'master'
>       changelog: post-release
>       util: do not silently truncate
>       Merge branch 'slirp-fmt-truncate' into 'master'
>       Release v4.3.1
>       Merge branch 'release-v4.3.1' into 'master'
>
> Philippe Mathieu-Daud=C3=A9 (3):
>       Fix win32 builds by using the SLIRP_PACKED definition
>       Fix constness warnings
>       Remove unnecessary break
>
> Ralf Haferkamp (2):
>       Drop bogus IPv6 messages
>       Fix MTU check
>
> Samuel Thibault (1):
>       Merge branch 'ip6_payload_len' into 'master'
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/slirp b/slirp
> index 2faae0f778f..a62d36734ff 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> +Subproject commit a62d36734ffe9828d0f70df1b3898a3b4fbda755
> --
> 2.27.0.221.ga08a83db2b
>
>
>
Anyone willing to ack this, or nack it and then someone (me?) will have to
backport the fixes in the slirp stable-4.2 branch.


--=20
Marc-Andr=C3=A9 Lureau

--000000000000c8c32105aaa212ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 13, 2020 at 12:33 PM Ma=
rc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">mar=
candre.lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Switch from stable-4.2 branch back to master (which=
 is actually<br>
maintained, I think we tend to forget about stable...).<br>
<br>
git shortlog 2faae0f7..a62d3673:<br>
<br>
5eraph (2):<br>
=C2=A0 =C2=A0 =C2=A0 disable_dns option<br>
=C2=A0 =C2=A0 =C2=A0 limit vnameserver_addr to port 53<br>
<br>
Akihiro Suda (1):<br>
=C2=A0 =C2=A0 =C2=A0 libslirp.h: fix SlirpConfig v3 documentation<br>
<br>
Jindrich Novy (4):<br>
=C2=A0 =C2=A0 =C2=A0 Fix possible infinite loops and use-after-free<br>
=C2=A0 =C2=A0 =C2=A0 Use secure string copy to avoid overflow<br>
=C2=A0 =C2=A0 =C2=A0 Be sure to initialize sockaddr structure<br>
=C2=A0 =C2=A0 =C2=A0 Check lseek() for failure<br>
<br>
Marc-Andr=C3=A9 Lureau (12):<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;master&#39; into &#39;master&#39;<br=
>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;fix-slirpconfig-3-doc&#39; into &#39=
;master&#39;<br>
=C2=A0 =C2=A0 =C2=A0 Fix use-afte-free in ip_reass() (CVE-2020-1983)<br>
=C2=A0 =C2=A0 =C2=A0 Update CHANGELOG<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;cve-2020-1983&#39; into &#39;master&=
#39;<br>
=C2=A0 =C2=A0 =C2=A0 Release v4.3.0<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;release-v4.3.0&#39; into &#39;master=
&#39;<br>
=C2=A0 =C2=A0 =C2=A0 changelog: post-release<br>
=C2=A0 =C2=A0 =C2=A0 util: do not silently truncate<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;slirp-fmt-truncate&#39; into &#39;ma=
ster&#39;<br>
=C2=A0 =C2=A0 =C2=A0 Release v4.3.1<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;release-v4.3.1&#39; into &#39;master=
&#39;<br>
<br>
Philippe Mathieu-Daud=C3=A9 (3):<br>
=C2=A0 =C2=A0 =C2=A0 Fix win32 builds by using the SLIRP_PACKED definition<=
br>
=C2=A0 =C2=A0 =C2=A0 Fix constness warnings<br>
=C2=A0 =C2=A0 =C2=A0 Remove unnecessary break<br>
<br>
Ralf Haferkamp (2):<br>
=C2=A0 =C2=A0 =C2=A0 Drop bogus IPv6 messages<br>
=C2=A0 =C2=A0 =C2=A0 Fix MTU check<br>
<br>
Samuel Thibault (1):<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;ip6_payload_len&#39; into &#39;maste=
r&#39;<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0slirp | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/slirp b/slirp<br>
index 2faae0f778f..a62d36734ff 160000<br>
--- a/slirp<br>
+++ b/slirp<br>
@@ -1 +1 @@<br>
-Subproject commit 2faae0f778f818fadc873308f983289df697eb93<br>
+Subproject commit a62d36734ffe9828d0f70df1b3898a3b4fbda755<br>
-- <br>
2.27.0.221.ga08a83db2b<br>
<br>
<br>
</blockquote></div><div><br></div><div>Anyone willing to ack this, or nack =
it and then someone (me?) will have to backport the fixes in the slirp stab=
le-4.2 branch.</div><div><br></div><br>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000c8c32105aaa212ec--

