Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25D0C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48F92073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 19:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePJAGxrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48F92073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZgBE-0007Ui-RP
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 14:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iZgAa-00074i-60
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iZgAY-0007Za-Ua
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:06:39 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iZgAY-0007Yi-O2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 14:06:38 -0500
Received: by mail-qt1-x843.google.com with SMTP id 14so22616291qtf.5
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 11:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4MHj6bsTtOjEFH4q5rBMA7yirJfKMilMDkA6CDU6zEA=;
 b=ePJAGxrIvnabfqAF+7slj0xA+jsPlC+EPa9zFlRQQc61XpDhomtIQCkySaNJSd+gSB
 9ecDtVDPiubollDUZT3p9cm3+CEw6Z0jsYZ5UTum8lhgPrDdfF3MVmKTxBfrIMsVtVMm
 oE28TRquvqwR7EZHeXYgsgp334bSUhaoYrWkNMUtH/fVPKH1G/oHde0oHbkxUYDXRzI1
 oAdnrjL5NGDhH8VqkUmRlJbCnmdACEhisIerwYAuLCtSKaYAoV+Igs/tzcDyIwk4VVZb
 4gxs8aIB/mUX+K4R8hPeNxXOuMxFwGYuQXrgFJlpYeuj6Q/Yibeg0mKYFNyDQA+mX/fE
 FRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4MHj6bsTtOjEFH4q5rBMA7yirJfKMilMDkA6CDU6zEA=;
 b=coquvgeaZg1FrynHebTntZD+1jVEJ6mLtJbF2L2TTEZu9GL+8daxMU3cW1Ibpv0tNn
 PxlTYZjiMKYI8/ZIdWZHD54cUgQnsI+7SfHULarzbuOEntcM62v2baCM8g5WbHo3iPhf
 p65PIf43QFbkU23RvwmHDdjdxKJDms74heFHvZo2dQEVTNviesfI2T39GXRv/Eez6TyW
 4q43O1BOakrZ6HifYCZE3TcMGK6+4gHIxUbvqUDFS8lm4rYLktp7gMIy1qSrm++ZNa0P
 nnqYEuNcNTDax03D1eAmlRutl4Q0c4PJMsqI49ENVSYtuBAMx1mpZ/742UrZ7issrb8U
 bvGQ==
X-Gm-Message-State: APjAAAW4H38B51hhmnSspmCS6d7zuecfN30daHnWmBeDHiRIbxqaW/0q
 WayHxDVNbS2mCQ6AVR290Ow3srjgv7H+AnC1/JI=
X-Google-Smtp-Source: APXvYqyLbsGs04CaKacYgrs7wUVQVfV7wqqGDTmWKU89Kyg8u9gJ00xbPHSoeQBJaTwRiz1D2fQ7UyQw3ase398tXMU=
X-Received: by 2002:ac8:3094:: with SMTP id v20mr22622940qta.306.1574795197241; 
 Tue, 26 Nov 2019 11:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
 <CAL1e-=gBBFRxAsDnRyQqiZSLWhMmfyp2YXge4E12VaEmEG=a9g@mail.gmail.com>
In-Reply-To: <CAL1e-=gBBFRxAsDnRyQqiZSLWhMmfyp2YXge4E12VaEmEG=a9g@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 26 Nov 2019 21:05:28 +0200
Message-ID: <CAK4993jvnA+rkBQzyp7jCY5Vo6TLzL8A7uN+ah8hmJa3-d4YFg@mail.gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000535f5705984494c4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000535f5705984494c4
Content-Type: text/plain; charset="UTF-8"

Aleksandar,

there was an email from Sarah, stating that she does not want to be a
maintainer.

On Tue, Nov 26, 2019 at 5:17 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> Include AVR maintaners in MAINTAINERS file
>>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5e5e3e52d6..ad2d9dd04a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -163,6 +163,15 @@ S: Maintained
>>  F: hw/arm/smmu*
>>  F: include/hw/arm/smmu*
>>
>> +AVR TCG CPUs
>> +M: Michael Rolnik <mrolnik@gmail.com>
>> +S: Maintained
>> +F: target/avr/
>> +F: hw/misc/avr_mask.c
>> +F: hw/char/avr_usart.c
>> +F: hw/timer/avr_timer16.c
>> +F: hw/avr/
>> +
>
>
> I had a strange feeling that something is missing here, and I finally
> realized what that was:
>
> R: Sarah Harris <S.E.Harris@kent.ac.uk>
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html
>
>
>
>  CRIS TCG CPUs
>>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>>  S: Maintained
>> --
>> 2.17.2 (Apple Git-113)
>>
>>

-- 
Best Regards,
Michael Rolnik

--000000000000535f5705984494c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Aleksandar,<div><br></div><div>there was an email from Sar=
ah, stating that she does not want to be a maintainer.=C2=A0</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, N=
ov 26, 2019 at 5:17 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar=
.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Sunday, November 2=
4, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"=
_blank">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Include AVR maintaners in MAINTAINERS file<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 5e5e3e52d6..ad2d9dd04a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,15 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blan=
k">mrolnik@gmail.com</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/<br>
+F: hw/misc/avr_mask.c<br>
+F: hw/char/avr_usart.c<br>
+F: hw/timer/avr_timer16.c<br>
+F: hw/avr/<br>
+</blockquote><div><br></div><div>I had a strange feeling that something is=
 missing here, and I finally realized what that was:=C2=A0</div><div><br></=
div><div>R:=C2=A0<span style=3D"color:rgb(34,34,34);font-size:14px;line-hei=
ght:22.12px">Sarah Harris &lt;</span><a href=3D"mailto:S.E.Harris@kent.ac.u=
k" style=3D"font-size:14px;line-height:22.12px" target=3D"_blank">S.E.Harri=
s@kent.ac.uk</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-heig=
ht:22.12px">&gt;</span></div><div>=C2=A0</div><div><a href=3D"https://lists=
.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html" target=3D"_blank">h=
ttps://lists.gnu.org/archive/html/qemu-devel/2019-10/msg04225.html</a><br><=
/div><div><br></div><div><br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" =
target=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000535f5705984494c4--

