Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA20CC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8446206DA
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ5511BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8446206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNL1L-0002hX-TB
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jNL0g-00029E-Uj
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jNL0f-0000Js-Vk
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:37:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jNL0f-0000Jh-NN
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:37:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id a25so5838531wrd.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MYAeZo6w3Ye5pRx66r0Cmuf9FwhkmUFWIOOr3suSs4I=;
 b=DJ5511BZViPNqr/Y2w+V5g0rCcZgOAMZzdg7A2R45O0UcbklikvNxiIQ+LARpQg9C5
 yR/z+ak4/Pxri8+xC0mRj1JpmvgJMTG6g8MdvEr7vYomXp8SKgcC7vF7Kpbjx1dYrPwT
 2Mr5lfCeCo6x7E00WmtfS4na+F7kTlBnRignnRu8j+/lEtvY/xMExwds1NgEwL1r7ubP
 eoobelT9R5LqzeMkRHlvfFYTgsK2r/1JsEUBcI561CP5j+L6UaC1VfMPbuxslW/lY0Sr
 EZECmLMTRiNseKEfJxkLXfc4bR5xksYTMiEaByRNNNOunpv/efMkNWMiPQOBcEMgUOVX
 38cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MYAeZo6w3Ye5pRx66r0Cmuf9FwhkmUFWIOOr3suSs4I=;
 b=YbngGzwKVh6cZKpokrbTUlXRX+fAKKttsTpe21YC0pHJkCch6iclYKoXm5LvW0rSlY
 IPrXsP6Ic/YyUmtZ7ckz4PPON7cMOSrhwY3WHNeix8XnwzXMLWlwmaIZ3qakPJT2AlO3
 ZY1Xz5Hw1iele6Tu45/nrBdWhwJhiU06Njcpc4TMF+LQgeiHobzrkDmMXoXlzP7hs/L1
 1VZhfIGXK1JaY3siKfKk8rev2kOzrdGuT1xfVejINXfBUlxuk2jyDVU17rbfOneV2RrX
 97FeZLh2DwG4qigceHHoqg1/pPkUWvs2deFwNuz4pyUKWSu3eNV53+GYtRHxhm+zZKyT
 DVqA==
X-Gm-Message-State: AGi0PuZzV3MYAXBFBDyctNbvqz4RIxEPGtd2D2D9SnrHxBukU5ZM3rZN
 DWSyokTIbCE2x/jMEHI1phsZs8txbqF44NVarZI=
X-Google-Smtp-Source: APiQypKiIEpv1dKidHk3Sew4+0Ak+QXgdmG7d0/nxwXYl6Z4PsXPuF/D4m7V7G5bOwcQuVMXEpJJZdKWE/+TVtWLJjs=
X-Received: by 2002:a5d:65c4:: with SMTP id e4mr10056305wrw.147.1586630260400; 
 Sat, 11 Apr 2020 11:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
 <c3fac325-df9a-be96-72d0-1898635afef9@linaro.org>
In-Reply-To: <c3fac325-df9a-be96-72d0-1898635afef9@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 11 Apr 2020 20:37:23 +0200
Message-ID: <CAHiYmc4r4zcRX02FQa0pjLYExZquVBrLGKYF_SDFZOYZhMFaCw@mail.gmail.com>
Subject: Re: [PATCH] tcg/mips: mips sync* encode error
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000fa76105a3082512"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: arikalo@wavecomp.com, Aurelien Jarno <aurelien@aurel32.net>,
 QEMU Developers <qemu-devel@nongnu.org>, lixinyu <precinct@mail.ustc.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000fa76105a3082512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

20:08 Sub, 11.04.2020. Richard Henderson <richard.henderson@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 4/11/20 5:46 AM, lixinyu wrote:
> > OPC_SYNC_WMB, OPC_SYNC_MB, OPC_SYNC_ACQUIRE, OPC_SYNC_RELEASE and
> > OPC_SYNC_RMB have wrong encode. According to the mips manual,
> > their encode should be 'OPC_SYNC | 0x?? << 6' rather than
> > 'OPC_SYNC | 0x?? << 5'. Wrong encode can lead illegal instruction
> > errors. These instructions often appear with multi-threaded
> > simulation.
>
> Good catch.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Queued to tcg-for-5.0.
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Thanks to Lixinyu, in the first place, for reporting the problem, and also
thanks to Richard for reviewing and incorporating this patch into his queue
for 5.0. I also think, as Richard does, that this should go into 5.0, even
in this final stages.

Happy Easter, or hapy and sunny weekend, whatever you choose.

Aleksandar

>
> r~
>

--0000000000000fa76105a3082512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">20:08 Sub, 11.04.2020. Richard Henderson &lt;<a href=3D"mail=
to:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt; =D1=
=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 4/11/20 5:46 AM, lixinyu wrote:<br>
&gt; &gt; OPC_SYNC_WMB, OPC_SYNC_MB, OPC_SYNC_ACQUIRE, OPC_SYNC_RELEASE and=
<br>
&gt; &gt; OPC_SYNC_RMB have wrong encode. According to the mips manual,<br>
&gt; &gt; their encode should be &#39;OPC_SYNC | 0x?? &lt;&lt; 6&#39; rathe=
r than<br>
&gt; &gt; &#39;OPC_SYNC | 0x?? &lt;&lt; 5&#39;. Wrong encode can lead illeg=
al instruction<br>
&gt; &gt; errors. These instructions often appear with multi-threaded<br>
&gt; &gt; simulation.<br>
&gt;<br>
&gt; Good catch.<br>
&gt;<br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org">richard.henderson@linaro.org</a>&gt;<br>
&gt;<br>
&gt; Queued to tcg-for-5.0.<br>
&gt;</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleks=
andar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;</p>
<p dir=3D"ltr">Thanks to Lixinyu, in the first place, for reporting the pro=
blem, and also thanks to Richard for reviewing and incorporating this patch=
 into his queue for 5.0. I also think, as Richard does, that this should go=
 into 5.0, even in this final stages.</p>
<p dir=3D"ltr">Happy Easter, or hapy and sunny weekend, whatever you choose=
.</p>
<p dir=3D"ltr">Aleksandar<br><br></p>
<p dir=3D"ltr">&gt;<br>
&gt; r~<br>
&gt;<br>
</p>

--0000000000000fa76105a3082512--

