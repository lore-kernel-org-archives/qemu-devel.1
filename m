Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7900C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F5620773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFTHJXWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F5620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOJR-0006Wn-Kh
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kDOGl-0003mL-9J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:37:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kDOGj-0005ql-Kz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:37:27 -0400
Received: by mail-wm1-x342.google.com with SMTP id b79so3603413wmb.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=z3Xm0MnmbokDkXIlArf7Jwh8S8+Si9XG1utRKJKglcQ=;
 b=AFTHJXWX2SJ21KG0Wjk5uk0st6Abqs5Y58TFuzYzYfP1q/dgEC/Hw8u+CtY2xgTWCW
 1Re4RhF8q0NEQkVbuHe7LVnut7NirTRwBs1GpYmEws0YuRORmHriuHg+VFON4NAxlyeQ
 RyuQH0/YDQ4sfSqe+y3yh4OJinAW+f76AYTKebrehio+/0hMHGn3Z/YotLGYynu3HvbV
 R5J2lKD+310hshetWKnNAg2DE/9+r49YgA2PViQTHuQAE2HN9dz1Yi9f80q+fNv0jrI4
 BnuC+TSfzilXH4eoweHl5ZEfVJ08OODiR1MZ69enc90HoTnNd6DBQRmyilOc8JWT5Zn8
 Oyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=z3Xm0MnmbokDkXIlArf7Jwh8S8+Si9XG1utRKJKglcQ=;
 b=BbWxdmCEhJnojAwjxFr6SWwyfu+OQpBBeUd71H/yruCvcLrHumE132FM3lRGeahDED
 Skbo1PTudBsLhuwu75t+m4gfjbqJ2hnvR27pRdbNgfAFIvSp6XPExYUCriw3MFmQWoRv
 q8M1YmRM93aKyc4ImSSH3/PcT6IEWw+ty20hSfc4hO0D2N2BDgnn16s51Uoa1eqSwIkD
 mh9p+qVtA/C4jAmspDliEaV5S6t5/VkAvsvYb5J6yFeQZyn73x6h3I6yy9ZkqfLMvIXo
 MKaHzipNv4oBgkX/8CWVtuFmTl8QI7QXbj5qPBq5mc2UiYCH3BmJlMhvSeiuM7ruMW7S
 lW7w==
X-Gm-Message-State: AOAM5313kEifnniXWqQW7dW8RxLB7w0I2q4lQBBfUAGFi6pmeKuqURbK
 NosuGYDeyUsPeDLkkmp2H7H0s4I2QuMXcBimYCc=
X-Google-Smtp-Source: ABdhPJy6GrY/CBH2qCDwDF5wDepKGRVpgodvlMA97vc2WPMnNqY4cMvrMQejgeOT9Zebd9840aMKhk5DxD0M7Wgm5h8=
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr5490385wmi.36.1599035844307; 
 Wed, 02 Sep 2020 01:37:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c351:0:0:0:0:0 with HTTP;
 Wed, 2 Sep 2020 01:37:23 -0700 (PDT)
In-Reply-To: <20200828104102.4490-9-ahmedkhaledkaraman@gmail.com>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-9-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 2 Sep 2020 10:37:23 +0200
Message-ID: <CAHiYmc4PjSYum0eqE-ep2ncOFvi0GUmGsBySzMS8MckMGjmbbg@mail.gmail.com>
Subject: Re: [PATCH 8/9] MAINTAINERS: Add 'tests/performance' to 'Performance
 Tools and Tests' subsection
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000007bad8a05ae508bdb"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007bad8a05ae508bdb
Content-Type: text/plain; charset="UTF-8"

On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
wrote:

> Add a new 'tests/performance' directory under the 'Performance Tools
> and Tests' subsection.
>
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>



> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a22c8be42..8923307642 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3124,3 +3124,4 @@ Performance Tools and Tests
>  M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>  S: Maintained
>  F: scripts/performance/
> +F: tests/performance/
> --
> 2.17.1
>
>

--0000000000007bad8a05ae508bdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, August 28, 2020, Ahmed Karaman &lt;<a href=3D"mailto:ahm=
edkhaledkaraman@gmail.com">ahmedkhaledkaraman@gmail.com</a>&gt; wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Add a new &#39;tests/performance&#39; directo=
ry under the &#39;Performance Tools<br>
and Tests&#39; subsection.<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_=
blank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.q=
emu.devel@gmail.c<wbr>om</a><span style=3D"color:rgb(34,34,34);font-size:14=
px;line-height:22.1200008392334px">&gt;</span></div><div><br></div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail=
.com">ahmedkhaledkaraman@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5a22c8be42..8923307642 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -3124,3 +3124,4 @@ Performance Tools and Tests<br>
=C2=A0M: Ahmed Karaman &lt;<a href=3D"mailto:ahmedkhaledkaraman@gmail.com">=
ahmedkhaledkaraman@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0F: scripts/performance/<br>
+F: tests/performance/<br>
-- <br>
2.17.1<br>
<br>
</blockquote>

--0000000000007bad8a05ae508bdb--

