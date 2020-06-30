Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F46C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42032065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLlxPumc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42032065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDpa-0003qP-W7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqDon-0002ak-WA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:48:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqDom-0003xM-1g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:48:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so8355011wrl.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Sq2BXACYp6szDvRExx5OLTmJS8onwFpwaZt/OXsu3/k=;
 b=SLlxPumcAQ7WlYnZ3JwNpNQ5sLaNN4mVB5yRmPug5ClstoMU0MDsz+ZiBePFyfTAJ1
 rNP4kndQworwlh6xqdyU0dPDBgLnMYz99m02enA4PJ2Hp6n0gE09TpN2eeyHZuY5Eawm
 R2vHv28cM3peTGHTAie1psCBmPrKuP61POTZpebMHA7wCsaG9Aqkq747MiO2Lw6zyhax
 m8FiuardOQ36Lzf3UEczfvGCHvycXgRaQGWlXlYa5RTNU4IUWYV0TvEQaK2OK3ypFhnt
 /UB/cdns2DND921Mx6BaeEeunJPaXFvwhUAiUJPtqSLLOMYZjSanSsk+cq2U6iIU5WC7
 fMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Sq2BXACYp6szDvRExx5OLTmJS8onwFpwaZt/OXsu3/k=;
 b=HuED3wIq9ojIxL1iaVcFmI2fIGiaBtFHBmhhyQQjLWJALGvw0qDZBQro/tEIOklIpS
 /o/ZowAI2IXLU3xl4mwDqi1bcVn1D0zwPCqxOL+DolNgipZ8agjkL6kKkhvbM6ixmVQ/
 JhDGgGY1GHYSa/bG+zCLWiTJ9O+mKpRdWrhM/wf1Amc3Bcbzpf/imiyu54x0ubVMrA6J
 SmBz85zqT8hMSs8MSxAgp2AMvCkCorSOoUxXRIo4rD8x388cfQJmWADql+hLnFmZsL0T
 weK7XgSnwBtLBBgeyfHhLNLupTFvpAq1BWESWZj+j+pr3uGaKcmzG3b7i/Mog80UTJ6r
 fUvQ==
X-Gm-Message-State: AOAM530gYfwPebX50BsHHiw84omx/gSUKovX7oYdn3nZnVPu/K1sTcBu
 EAvLcBBoblUY4FMPNdpUvUcUs+FQ9T1w/zOiFJM=
X-Google-Smtp-Source: ABdhPJzckX+wj8PrqslBBhKh5xw1aXzdKUsrZzGHTHjQDxWIQdjPq1GZDGYXGawjoVhX8t8I90Ma5y3oVuRj9itQIok=
X-Received: by 2002:adf:8462:: with SMTP id 89mr20946225wrf.420.1593514125983; 
 Tue, 30 Jun 2020 03:48:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 03:48:45
 -0700 (PDT)
In-Reply-To: <20200630081322.19146-1-f4bug@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 12:48:45 +0200
Message-ID: <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000006c82a505a94aebfc"
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006c82a505a94aebfc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Hi,
>
> Following Jiaxun Yang's patch and discussion:
> https://patchwork.kernel.org/patch/11416915/
>
> - Rename the current machine as 'malta-virt' (keeping 'malta' aliased)
>   Suggestions for better names are welcome, maybe 'malta-unreal' or
>   'malta-unleashed' instead?
> - Add 'malta-phys' which respects hardware restrictions (on RAM so far)
> - Unleash 'malta-virt' to allow more than 2GB on 64-bit
>
> Philippe Mathieu-Daud=C3=A9 (7):
>   hw/mips/malta: Trivial code movement
>   hw/mips/malta: Register the machine as a TypeInfo
>   hw/mips/malta: Rename 'malta' machine as 'malta-virt'
>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>   hw/mips/malta: Introduce the 'malta-phys' machine
>   hw/mips/malta: Verify malta-phys machine uses correct DIMM sizes
>   hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
>
>  hw/mips/malta.c | 121 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 99 insertions(+), 22 deletions(-)
>
> --



Thank you, Philippe, for providing this series.

However, in previous discussion on the patch you mention above, I already
expressed serious reservations on the approach taken in that patch. These
reservations stay today too.

There is nothing qualitatively different between the original patch and
this series. Naming and related stuff are just cosmetic issues.

The good thing about this series is that one can apply it dowstream, if one
finds it useful. However, it is not suitable for upstreaming

Regards,
Aleksandar



> 2.21.3
>
>

--0000000000006c82a505a94aebfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020.,=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
Following Jiaxun Yang&#39;s patch and discussion:<br>
<a href=3D"https://patchwork.kernel.org/patch/11416915/" target=3D"_blank">=
https://patchwork.kernel.org/<wbr>patch/11416915/</a><br>
<br>
- Rename the current machine as &#39;malta-virt&#39; (keeping &#39;malta&#3=
9; aliased)<br>
=C2=A0 Suggestions for better names are welcome, maybe &#39;malta-unreal&#3=
9; or<br>
=C2=A0 &#39;malta-unleashed&#39; instead?<br>
- Add &#39;malta-phys&#39; which respects hardware restrictions (on RAM so =
far)<br>
- Unleash &#39;malta-virt&#39; to allow more than 2GB on 64-bit<br>
<br>
Philippe Mathieu-Daud=C3=A9 (7):<br>
=C2=A0 hw/mips/malta: Trivial code movement<br>
=C2=A0 hw/mips/malta: Register the machine as a TypeInfo<br>
=C2=A0 hw/mips/malta: Rename &#39;malta&#39; machine as &#39;malta-virt&#39=
;<br>
=C2=A0 hw/mips/malta: Introduce MaltaMachineClass::max_ramsize<br>
=C2=A0 hw/mips/malta: Introduce the &#39;malta-phys&#39; machine<br>
=C2=A0 hw/mips/malta: Verify malta-phys machine uses correct DIMM sizes<br>
=C2=A0 hw/mips/malta: Allow more than 2GB on 64-bit malta-virt<br>
<br>
=C2=A0hw/mips/malta.c | 121 ++++++++++++++++++++++++++++++<wbr>+++++++++---=
------<br>
=C2=A01 file changed, 99 insertions(+), 22 deletions(-)<br>
<br>
--=C2=A0</blockquote><div><br></div><div><br></div><div>Thank you, Philippe=
, for providing this series.</div><div><br></div><div>However, in previous =
discussion on the patch you mention above,=C2=A0I already expressed serious=
=C2=A0reservations on the=C2=A0approach taken in that patch. These reservat=
ions stay today too.</div><div><br></div><div>There is nothing qualitativel=
y different between the original patch and this series. Naming and related =
stuff are just cosmetic issues.</div><div><br></div><div>The good thing abo=
ut this series is that one can apply it dowstream, if one finds it useful. =
However, it is not suitable for upstreaming=C2=A0</div><div><br></div><div>=
Regards,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
2.21.3<br>
<br>
</blockquote>

--0000000000006c82a505a94aebfc--

