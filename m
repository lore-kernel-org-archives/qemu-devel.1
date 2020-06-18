Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C263AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6552073E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhS/d4mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6552073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0Q0-00028M-Lt
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jm0PQ-0001j9-Uo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:41:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jm0PG-0004na-AE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:41:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id u26so7325377wmn.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
 bh=gDZmXbnIP0ehX7oBYVkX9Dq58L6eLEJ50Tx/jZONaXM=;
 b=IhS/d4mV+oWz3JNEhep48dJSm1FPuj/FphJCYCxqCm2SdS8ew0dTeYvXuLhbLduoVL
 9G0RW3jyWGPS7EcZjglvcEsb3sIhGUybDCr8UXppozLfiVy2YgfxvvhZeIKzlRwdB++/
 pTdLkRlmNhXaQtvR/PqDVNhjZknkK7yllkCo900QtnGZ1syOWxGKapJmL/lrHB7Hh4XL
 6VIpRmygO3wPT/PztimQ27PLVxbjTH3qfoaobOqKeOfpMmjWYx3306N0/Hkc8pJQUPTe
 AP0rmAWxrI9bw9j/Xwx8OwBLdjJb7vxUV0N7klZwjwAXKwoc65m6SPDCoNDBA7bjbYgh
 U2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to;
 bh=gDZmXbnIP0ehX7oBYVkX9Dq58L6eLEJ50Tx/jZONaXM=;
 b=Aq/nNtycC65Kg1w+NdtE/2Hs7mt9t58I6W1YwD1Kj0aMUf2cXnyLsHQ+ja2/E9Nyep
 Nz1s76wfKJcxYeOMSvysCpLLaM5v/4Lrb8ZzM2TzS5BCQnRDmX8oghcZS2yB8+vZQzog
 YuOxts2K4cGyLEBootIaEI9OLgdVtj7EI9mRcv/jZkIvKXR1oYF/ulZPFnduwVEDhqzU
 I7sFVvRuA++0Ekye7NXjZ3puPN46yy4axPvPLy05dLqZxOHAmzMneFcSVnN6CQQnBrJq
 OEvvr6g02D8/66+Y8De5ywIoFLnDXnaJkh0eSrwUbrt5pyX+EVH15kDPVUs9d5E3Dyf2
 Yjrg==
X-Gm-Message-State: AOAM531cvfGt0+pngPsiUCaxM0g1rASQl23R2K/kaCHjJxX2+zAT2qyK
 4viOD5kqMgy4g0GA1hFoHr84MSY4i4ppr9qqOXJyMvW2
X-Google-Smtp-Source: ABdhPJxoe+KyOUu8eLvS/G4UUJp1pp06UHu7aTiFdVkjMIIAD0o/7i0sLdfIR40cg4MLDl+SWFSkuuUdw1ZTWfAnDxU=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr5364840wmf.129.1592509260560; 
 Thu, 18 Jun 2020 12:41:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Thu, 18 Jun 2020 12:41:00 -0700 (PDT)
In-Reply-To: <CAHiYmc7iD4AoV3Lj5igTQMYESNHU6_-_7cwujhsgJYv5zKraDQ@mail.gmail.com>
References: <CAHiYmc7iD4AoV3Lj5igTQMYESNHU6_-_7cwujhsgJYv5zKraDQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 18 Jun 2020 21:41:00 +0200
Message-ID: <CAHiYmc4TmQ+67GNQJY3Mm0BSFuipUBFPpBLuNxBfhArCn823CQ@mail.gmail.com>
Subject: Re: [DISCUSSION] GCOV support
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c6ff2905a860f463"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x331.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c6ff2905a860f463
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=D0=BD 20=
20., Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Hi, Alex, Peter.
>
> You may recall that I signalled on couple of occasions that there are som=
e
> problems related to gcov builds in out-of-tree builds.
>
> It turned out that those problems manifest on some opder Linux
> distribution, and are always related to the gcovr being older than 4.1. F=
or
> older gcovr, the tool simply doesn't connect properly executable and its
> source files, and no coverage report is generated (or perhaps only some
> small portions, but, on any case, gcov builds are virtually unusable).
>
> I propose that we don't bother supporting systems with gcovr older than
> 4.1. We could check version of gcovr in confugure, and refuse gcov builds
> if that version is older than 4.1.
>
>
More precisely, I propose that "configure --enable-gcov" should not be
possible if gcovr version is older than 4.1, or, of course, absent from the
system altogether.

(Note: In-tree gcov builds do not have this problem, older gcovr work
perfectly, but we anyway want to switch to out-of-tree builds only.)



> This would remove one obstacle towards removing the support of in-tree
> builds. (I am not sure about future Mason-based builds, I hope they will
> support gcov builds, and work in almost identical way.).
>
> If you agree with proposal on the level of design, Alex, can you perhaps
> write the corresponding patch, I gather you are more familiar with
> modifying configure than me? Or I should do it?
>
> Warmly,
> Aleksandar
>

--000000000000c6ff2905a860f463
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=
=D0=BD 2020., Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.dev=
el@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">Hi, Alex, Peter.<div><br></div><div>You may recall that I signall=
ed on couple of occasions that there are some problems related to gcov buil=
ds in out-of-tree builds.</div><div><br></div><div>It turned out that those=
 problems manifest on some opder Linux distribution, and are always related=
 to the gcovr being older than 4.1. For older gcovr, the tool simply doesn&=
#39;t connect properly executable and its source files, and no coverage rep=
ort is generated (or perhaps only some small portions, but, on any case, gc=
ov builds are virtually unusable).</div><div><br></div><div>I propose that =
we don&#39;t bother supporting systems with gcovr older than 4.1. We could =
check version of gcovr in confugure, and refuse gcov builds if that version=
 is older than 4.1.</div><div><br></div></blockquote><div><br></div><div>Mo=
re precisely, I propose that &quot;configure --enable-gcov&quot; should not=
 be possible if gcovr version is older than 4.1, or, of course, absent from=
 the system altogether.</div><div><br></div><div>(Note: In-tree gcov builds=
 do not have this problem, older gcovr work perfectly, but we anyway want t=
o switch to out-of-tree builds only.)</div><div><br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>This would remove one obstacle towards =
removing the support of in-tree builds. (I am not sure about future Mason-b=
ased builds, I hope they will support gcov builds, and work in almost ident=
ical way.).</div><div><br></div><div>If you agree with proposal on the leve=
l of design, Alex, can you perhaps write the corresponding patch, I gather =
you are more familiar with modifying configure than me? Or I should do it?<=
/div><div><br></div><div>Warmly,</div><div>Aleksandar</div>
</blockquote>

--000000000000c6ff2905a860f463--

