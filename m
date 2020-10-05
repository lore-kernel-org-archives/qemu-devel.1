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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE6C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D04B2074F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIbwsz7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D04B2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPLW3-0005jU-7p
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1kPLVM-0005Ca-Il
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:05:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1kPLVK-0004zZ-0X
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:05:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id u24so5514893pgi.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k26SsgOiKRMGLBoMnC4kVL2SE57XM2HtHz2RFJgcjHs=;
 b=rIbwsz7i5jtfywmwV/b+9xjxn2uJ/WiYMRAYCOxHnG/oS7G2DMrH6pMQbWs2+fYnyP
 ZI+OLiSmAzj1oL4nvYOxXiMHT2XVmQyz6cU3SRW1+1IWAWPeTstWnsnvLUvEsWE8pp4M
 a583D483KudWW2Uda12Rh3i0q+NiWtV4eDHe/IUCJvLY2uIEGvkgPbq4E8xYWr/ElR88
 j3zlObVWUqhyjPzgSMmyPbeJyW+mk9I4LHCu7n4vcNDBLxTo+kBtxmbuHlh3c7/VvZnU
 H8JIS2QPfboacGmTVpHT+/0WcTou2XIywor8/jTxifDvUbJeU2Lgzk56cdxyVkUzUVsh
 PRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k26SsgOiKRMGLBoMnC4kVL2SE57XM2HtHz2RFJgcjHs=;
 b=uEAXlTHFZiwzb7hFnMlOD2LjqAB1xeQnSsyQJQ3LpZcojtoBCo2MHrUzUgmeXv1uTR
 espmvfUfCU1r4nLzacUlDo/iGxy/keDorpo79FhS/35S0htkakUtp80y1KumjwNueqSx
 kQD0mkialKW/lavUn3+pFPkHsSMmeKmdm09E7K/SEGlPbp3/tlCctNQpbFcfH11c1GlR
 k4rw6rrPlcoOs+RsO3T3igPc1n95PGlUB/iVmr29gl/+FkmVkdp55wpSz/3TkBRMd3Xq
 dTa2GhihGQqyz3uzQ1KsIC9lrv63HIWnlTj5p9arjDCB+GU26RIE2OFjH97Vn0nL3ps6
 Xbuw==
X-Gm-Message-State: AOAM533JEVpn0C+sdSU0g1ta4/lrBP9LUwgkzLfU99uZ6f3HX1GBy+jG
 YDquooyJV6TV7DE+dRFlve6LXPxfQYW6O0o5ip8=
X-Google-Smtp-Source: ABdhPJyRQdfpBaEMwU54C6+C6axfRlmDZlqeYAIuAHE8RVX2N40H3TbcZabPf/X+B4RSE3+WaFDYGH65xxY6Pn+3YJo=
X-Received: by 2002:a63:f345:: with SMTP id t5mr13531455pgj.147.1601885150520; 
 Mon, 05 Oct 2020 01:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-14-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-14-f4bug@amsat.org>
From: Frediano Ziglio <freddy77@gmail.com>
Date: Mon, 5 Oct 2020 09:05:39 +0100
Message-ID: <CAHt6W4fAsxiNx11x53Q6BE_oCs9RwZtL8gg4dPHpfa7sQfp9AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/21] contrib/gitdm: Add more entries to the Red Hat
 domain
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000005e28c205b0e7f3fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=freddy77@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005e28c205b0e7f3fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
  can I disagree? If the contribution is personal I use my personal
address, if the contribution is from the job in the company I'm using the
company address.

Regards,
   Frediano


Il giorno dom 4 ott 2020 alle ore 19:05 Philippe Mathieu-Daud=C3=A9 <
f4bug@amsat.org> ha scritto:

> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Frediano Ziglio <fziglio@redhat.com>
> Cc: Nir Soffer <nirsof@gmail.com>
> Cc: Nir Soffer <nsoffer@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> ---
>  contrib/gitdm/group-map-redhat | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/contrib/gitdm/group-map-redhat
> b/contrib/gitdm/group-map-redhat
> index d15db2d35e..0419e82795 100644
> --- a/contrib/gitdm/group-map-redhat
> +++ b/contrib/gitdm/group-map-redhat
> @@ -6,3 +6,5 @@ david@gibson.dropbear.id.au
>  laurent@vivier.eu
>  pjp@fedoraproject.org
>  armbru@pond.sub.org
> +freddy77@gmail.com
> +nirsof@gmail.com
> --
> 2.26.2
>
>

--0000000000005e28c205b0e7f3fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>=C2=A0 can I disagree? If the contribut=
ion is personal I use my personal address, if the contribution is from the =
job in the company I&#39;m using the company address.<br></div><div><br></d=
iv><div>Regards,<br></div><div><div><div dir=3D"ltr" class=3D"gmail_signatu=
re" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=C2=A0=C2=A0 Fredia=
no</div></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Il giorno dom 4 ott 2020 alle ore 19:05 Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Cc: Frediano Ziglio &lt;<a href=3D"mailto:freddy77@gmail.com" target=
=3D"_blank">freddy77@gmail.com</a>&gt;<br>
Cc: Frediano Ziglio &lt;<a href=3D"mailto:fziglio@redhat.com" target=3D"_bl=
ank">fziglio@redhat.com</a>&gt;<br>
Cc: Nir Soffer &lt;<a href=3D"mailto:nirsof@gmail.com" target=3D"_blank">ni=
rsof@gmail.com</a>&gt;<br>
Cc: Nir Soffer &lt;<a href=3D"mailto:nsoffer@redhat.com" target=3D"_blank">=
nsoffer@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
To the developers Cc&#39;ed: If you agree with your entry, please<br>
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn&#39;t<br>
care, please either reply with Nack-by or ignore this patch.<br>
I&#39;ll repost in 2 weeks as formal patch (not RFC) with only the<br>
entries acked by their author.<br>
---<br>
=C2=A0contrib/gitdm/group-map-redhat | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redha=
t<br>
index d15db2d35e..0419e82795 100644<br>
--- a/contrib/gitdm/group-map-redhat<br>
+++ b/contrib/gitdm/group-map-redhat<br>
@@ -6,3 +6,5 @@ <a href=3D"mailto:david@gibson.dropbear.id.au" target=3D"_b=
lank">david@gibson.dropbear.id.au</a><br>
=C2=A0<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">laurent@vivier=
.eu</a><br>
=C2=A0<a href=3D"mailto:pjp@fedoraproject.org" target=3D"_blank">pjp@fedora=
project.org</a><br>
=C2=A0<a href=3D"mailto:armbru@pond.sub.org" target=3D"_blank">armbru@pond.=
sub.org</a><br>
+<a href=3D"mailto:freddy77@gmail.com" target=3D"_blank">freddy77@gmail.com=
</a><br>
+<a href=3D"mailto:nirsof@gmail.com" target=3D"_blank">nirsof@gmail.com</a>=
<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div>

--0000000000005e28c205b0e7f3fc--

