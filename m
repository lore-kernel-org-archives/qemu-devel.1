Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DA8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B2A207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8MnYZT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B2A207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOgw-0005Db-Km
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jrOdR-00075j-DZ; Fri, 03 Jul 2020 12:33:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jrOdP-0008By-Eh; Fri, 03 Jul 2020 12:33:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id f2so5390567wrp.7;
 Fri, 03 Jul 2020 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=lwqrshE3SFgIfBQJgR5LS5fQjVpk8NcYgjwEADsQE0U=;
 b=d8MnYZT7ptWEI23tkG77EZkEvym+tWSAQl3/hDB1P10EYgvOaHcfmi9447/LqIQmYu
 Octadlz+hZKqwEQ/Ti3L1fVnb9PungU24UaRGFCfo/v7+nq6U++uR6Jac9VI11KZMAZV
 56N2SCiPGJRJUvR4Ql2MG0SLNdxKrZ2vEHpZTZCbsQJSnlLVXeQZMF3mtvwFaJMrurMY
 JYcSi9P2CYJtCtsDSImBvy6sdJPs+adBEbsaIon6yAs8xPDwmdoEqnRO9E5ObONfsN6r
 5fzeAO2paKctv/b/n6NNWet8zYXoWizKQVXFQokbO37Y8KKJMgt/r2VO6CSfLZGHYeLQ
 4rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=lwqrshE3SFgIfBQJgR5LS5fQjVpk8NcYgjwEADsQE0U=;
 b=pMBBRH7ByAWWa2zk/1GQFaV+6coVYXoafYsw6sGdk86KlNZd4DtDvbvjsm72smuNyp
 +Ad6sG4E36oAOLIW7zaSBLpunbBs2ORBFM/0j1JGIJStjCn5Ck5q+sbJoKbTnCUWOG37
 oCO4+groBXj5Q4yYrse7MuIP1CZU73/zJKnEi5lBsVYVVOm5MO6rDkH9frj4l8OCEkck
 msdnbf5+DA1LxUiZd9GcxlVxribCUR3dR4Hi/NY5Q+BKrNOuXseOTAGjjDsBVl05OxOy
 OPdU+fHPnAJZnQ9HbdfFksMr095Qvot4QslVXg0TwmjmQodr2EzOmXkw3d8DETv+nOhc
 ALgg==
X-Gm-Message-State: AOAM530USVfQ7+dytbcgaitpsnc5l27LD+HEp7XkMOFjtOvEC74EPHKk
 BPBO6EqAHBlF3a9iBJLiVsi7TXRHTtZ3P8bFnjQ=
X-Google-Smtp-Source: ABdhPJy3RBBCXtAO2oORlOkHTGNm3dLRoK2AIAa1SoiYGPFQWkGs+Ct04ycITPL8FKhmHvijW3lfcKWTqcA6e897utA=
X-Received: by 2002:adf:8462:: with SMTP id 89mr36952781wrf.420.1593794032963; 
 Fri, 03 Jul 2020 09:33:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Fri, 3 Jul 2020 09:33:52 -0700 (PDT)
In-Reply-To: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
References: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 3 Jul 2020 18:33:52 +0200
Message-ID: <CAHiYmc7xgHJcqqCtym-xV+7_Vtze+=NjFw83Cn2DRDACNvLk+w@mail.gmail.com>
Subject: Re: [PATCH] Fix MIPS add.s after
 1ace099f2acb952eaaef0ba7725879949a7e4406
To: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Content-Type: multipart/alternative; boundary="0000000000002e164505a98c179e"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002e164505a98c179e
Content-Type: text/plain; charset="UTF-8"

On Friday, July 3, 2020, Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
wrote:

> After merging latest QEMU upstream into our CHERI fork, I noticed that
> some of the FPU tests in our MIPS baremetal testsuite
> (https://github.com/CTSRD-CHERI/cheritest) started failing. It turns out
> this commit accidentally changed add.s into a subtract.
>
>
Alex, all you said sounds very probable to me. I currently don't have any
dev system, at hand, but as soon as I get it, I will confirm/disconfirm
(but again, most likely confirm) this problem, and than we'll give you
green lifght for your patch.

Yours,
Aleksandar




> Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> ---
>  target/mips/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
> index 7a3a61cab3..56beda49d8 100644
> --- a/target/mips/fpu_helper.c
> +++ b/target/mips/fpu_helper.c
> @@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
>  {
>      uint32_t wt2;
>
> -    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
> +    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
>      update_fcr31(env, GETPC());
>      return wt2;
>  }
> --
> 2.27.0
>
>

--0000000000002e164505a98c179e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, July 3, 2020, Alex Richardson &lt;<a href=3D"mailto:Alex=
ander.Richardson@cl.cam.ac.uk">Alexander.Richardson@cl.cam.ac.uk</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">After merging latest QEMU upstream i=
nto our CHERI fork, I noticed that<br>
some of the FPU tests in our MIPS baremetal testsuite<br>
(<a href=3D"https://github.com/CTSRD-CHERI/cheritest" target=3D"_blank">htt=
ps://github.com/CTSRD-<wbr>CHERI/cheritest</a>) started failing. It turns o=
ut<br>
this commit accidentally changed add.s into a subtract.<br>
<br></blockquote><div><br></div><div>Alex, all you said sounds very probabl=
e to me. I currently don&#39;t have any dev system, at hand, but as soon as=
 I get it, I will confirm/disconfirm (but again, most likely confirm) this =
problem, and than we&#39;ll give you green lifght for your patch.</div><div=
><br></div><div>Yours,</div><div>Aleksandar</div><div><br></div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Alex Richardson &lt;<a href=3D"mailto:Alexander.Richardson@c=
l.cam.ac.uk">Alexander.Richardson@cl.cam.<wbr>ac.uk</a>&gt;<br>
---<br>
=C2=A0target/mips/fpu_helper.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c<br>
index 7a3a61cab3..56beda49d8 100644<br>
--- a/target/mips/fpu_helper.c<br>
+++ b/target/mips/fpu_helper.c<br>
@@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(<wbr>CPUMIPSState *env,<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t wt2;<br>
<br>
-=C2=A0 =C2=A0 wt2 =3D float32_sub(fst0, fst1, &amp;env-&gt;active_fpu.fp_s=
tatus);<br>
+=C2=A0 =C2=A0 wt2 =3D float32_add(fst0, fst1, &amp;env-&gt;active_fpu.fp_s=
tatus);<br>
=C2=A0 =C2=A0 =C2=A0update_fcr31(env, GETPC());<br>
=C2=A0 =C2=A0 =C2=A0return wt2;<br>
=C2=A0}<br>
-- <br>
2.27.0<br>
<br>
</blockquote>

--0000000000002e164505a98c179e--

