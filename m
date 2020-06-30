Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE29A2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKp6w14/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE29A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE8l-0005UW-1J
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqE5C-0000oP-2f
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:05:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqE58-0006Zv-Np
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:05:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id s10so19637422wrw.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3iro8JmvXXWVtN5UBBez1yfs1I2KG20NDx3D7XdzmOM=;
 b=GKp6w14/ncvLExcg1Da4ckFtb9AH5Lrsk1glceLsCM1jZtD1fH5nBnrL/h37vTO00v
 IMcXzvHzS0v5l8mRkjj86VmrKmVjNj8+YYIu3jcqD3J3ICneEa74xtCQrlgya5NR2v/o
 y8VahPCip2bg6SQ8YrzqJ54QryJzQeJ2omYY9UN/RkeO4S66uOotQIr6dpM66dEQalnp
 4Y5K4WsYon/z+u8I3gp6ve/CiTEqWMWi/6HgjwkafrUGwQGTl8g0qUkukXeA7KePklDV
 YHm/1vMIR5zoTQ40iyk/TyDmyRM4tZe2/tWkcYx50slbkCeT2vcKEl0kbVBuGojw2kl8
 jIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3iro8JmvXXWVtN5UBBez1yfs1I2KG20NDx3D7XdzmOM=;
 b=QW6qvp7HWz0sHvEAnV5fbAfG4VUXOvne2PX8RMboFsile+r8IczGg/vYubTKkBPYnp
 WTlsVStshUxg4dj1DbAVlvz811XYmOBiQShqAIsj9Pp/GNOt4m5pLGgYVVQZntKedZgk
 /BtqhwS6N/9OtifpKKKqwm3MQ98HMMOOUHq4w5wcIjsNOa5J92Fc7TzNRkpKQZuq5FZd
 aJAFvIy7PqaFFu35YtUE8sErNOoP8uah84byLtpc8dFMnKB8X3wloA3M6KxLq3eR0/J0
 BH7Bwql6fnkw9C3MZJBDp52EHIRlwBrmywvqPFgp85HhKUnz5aHcZmXfcNOYuHPI8OkO
 o/Mg==
X-Gm-Message-State: AOAM531/YS7PbjmQUpbD0xLCSuSqdI/u9roPxx6EmXGV3rGEXpd/JhDA
 qcEIQjsMUGQS7e8/PziN0bzBgnkhxDzspDeH9TU=
X-Google-Smtp-Source: ABdhPJyGTFNzpGsR9Bcfmi82roAFHF5Z/SKem/mdFuSPXSQyirXZte5IFTI6Xjd18GMQiFAq3O3MIQmbpvuzcwS1C74=
X-Received: by 2002:adf:f885:: with SMTP id u5mr20945284wrp.402.1593515141230; 
 Tue, 30 Jun 2020 04:05:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 04:05:40
 -0700 (PDT)
In-Reply-To: <f7d92c99-9b24-1425-3cb0-45cc6b3258c8@amsat.org>
References: <20200630081322.19146-1-f4bug@amsat.org>
 <CAHiYmc6coeBBOvCAs+=Ccw2aXfw0m3gTdSM1Pc8AQvJ4QNBhow@mail.gmail.com>
 <da6c2f55-b8b7-3492-37b3-d24a25106d72@amsat.org>
 <CAHiYmc6gzvEAk6oNFzQHc9DrsZ6xfWZFKr6+FHVfus-jjcyp7Q@mail.gmail.com>
 <f7d92c99-9b24-1425-3cb0-45cc6b3258c8@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 13:05:40 +0200
Message-ID: <CAHiYmc7hxPtqhm5S2k+VjuzRavYjvQarA_rWdqMLAv9BP9GsqQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM
 on 64-bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000eff47705a94b2756"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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

--000000000000eff47705a94b2756
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On 6/30/20 12:54 PM, Aleksandar Markovic wrote:
> >
> >
> > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Phi=
lippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> > <mailto:f4bug@amsat.org>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >     On 6/30/20 12:48 PM, Aleksandar Markovic wrote:
> >     >
> >     >
> >     > =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020=
., Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> >     <mailto:f4bug@amsat.org>
> >     > <mailto:f4bug@amsat.org <mailto:f4bug@amsat.org>>> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >     >
> >     >     Hi,
> >     >
> >     >     Following Jiaxun Yang's patch and discussion:
> >     >     https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>
> >     >     <https://patchwork.kernel.org/patch/11416915/
> >     <https://patchwork.kernel.org/patch/11416915/>>
> >     >
> >     >     - Rename the current machine as 'malta-virt' (keeping 'malta'
> >     aliased)
> >     >       Suggestions for better names are welcome, maybe
> >     'malta-unreal' or
> >     >       'malta-unleashed' instead?
> >     >     - Add 'malta-phys' which respects hardware restrictions (on
> >     RAM so far)
> >     >     - Unleash 'malta-virt' to allow more than 2GB on 64-bit
> >     >
> >     >     Philippe Mathieu-Daud=C3=A9 (7):
> >     >       hw/mips/malta: Trivial code movement
> >     >       hw/mips/malta: Register the machine as a TypeInfo
> >     >       hw/mips/malta: Rename 'malta' machine as 'malta-virt'
> >     >       hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >     >       hw/mips/malta: Introduce the 'malta-phys' machine
> >     >       hw/mips/malta: Verify malta-phys machine uses correct DIMM
> sizes
> >     >       hw/mips/malta: Allow more than 2GB on 64-bit malta-virt
> >     >
> >     >      hw/mips/malta.c | 121
> >     +++++++++++++++++++++++++++++++++++++++---------
> >     >      1 file changed, 99 insertions(+), 22 deletions(-)
> >     >
> >     >     --
> >     >
> >     >
> >     >
> >     > Thank you, Philippe, for providing this series.
> >     >
> >     > However, in previous discussion on the patch you mention above, I
> >     > already expressed serious reservations on the approach taken in
> that
> >     > patch. These reservations stay today too.
> >     >
> >     > There is nothing qualitatively different between the original
> >     patch and
> >     > this series. Naming and related stuff are just cosmetic issues.
> >
> >     OK, what about considering all patches except the last one?
> >     So we can run firmware on a real Malta board, not the QEMU
> >     imaginary one (in the discussion you said QEMU should respect
> >     real hardware, which I agree).
> >
> >
> > Redo the series, and we can discuss, of course.
>
> I can resend without the last patch but I don't see the point,
> why not discuss first?
>
> QEMU should do its best to model a real Malta board. I don't
> want to break the current users for the existing 'malta' machine.
> How do you want me to name the real malta machine?
>
>
You now self-convinced yourself that only the last patch is wrong. I
repeat, the concept of the series is not ok, and, if you will, all patches
in the series are not good.

Regards,
Aleksandar


> >
> >
> >     >
> >     > The good thing about this series is that one can apply it
> >     dowstream, if
> >     > one finds it useful. However, it is not suitable for upstreaming
> >     >
> >     > Regards,
> >     > Aleksandar
> >     >
> >     >
> >     >
> >     >     2.21.3
> >     >
> >
>

--000000000000eff47705a94b2756
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020.,=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On 6/30/20 12:54 PM, Aleksa=
ndar Markovic wrote:<br>
&gt; <br>
&gt; <br>
&gt; =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=98=D1=83=D0=BD 2020., Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsa=
t.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;&=
gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 6/30/20 12:48 PM, Aleksandar Markovic wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 30. =D1=
=98=D1=83=D0=BD 2020., Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4=
bug@amsat.org">f4bug@amsat.org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug=
@amsat.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">=
f4bug@amsat.org</a> &lt;mailto:<a href=3D"mailto:f4bug@amsat.org">f4bug@ams=
at.org</a>&gt;&gt;&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Following Jiaxun Yang&#39;s=
 patch and discussion:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://patchwor=
k.kernel.org/patch/11416915/" target=3D"_blank">https://patchwork.kernel.or=
g/<wbr>patch/11416915/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patchwork.kernel.org/patch/1=
1416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/1141691=
5/</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patc=
hwork.kernel.org/patch/11416915/" target=3D"_blank">https://patchwork.kerne=
l.<wbr>org/patch/11416915/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://patchwork.kernel.org/patch/1=
1416915/" target=3D"_blank">https://patchwork.kernel.org/<wbr>patch/1141691=
5/</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0- Rename the current machin=
e as &#39;malta-virt&#39; (keeping &#39;malta&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0aliased)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 Suggestions for bett=
er names are welcome, maybe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;malta-unreal&#39; or<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 &#39;malta-unleashed=
&#39; instead?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0- Add &#39;malta-phys&#39; =
which respects hardware restrictions (on<br>
&gt;=C2=A0 =C2=A0 =C2=A0RAM so far)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0- Unleash &#39;malta-virt&#=
39; to allow more than 2GB on 64-bit<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9=
 (7):<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Trivi=
al code movement<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Regis=
ter the machine as a TypeInfo<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Renam=
e &#39;malta&#39; machine as &#39;malta-virt&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Intro=
duce MaltaMachineClass::max_ramsize<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Intro=
duce the &#39;malta-phys&#39; machine<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Verif=
y malta-phys machine uses correct DIMM sizes<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 hw/mips/malta: Allow=
 more than 2GB on 64-bit malta-virt<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/mips/malta.c | 121=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++++++<wbr>+++++++++-------=
--<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=C2=A01 file changed, 99 in=
sertions(+), 22 deletions(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0--=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thank you, Philippe, for providing this series=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; However, in previous discussion on the patch y=
ou mention above,=C2=A0I<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; already expressed serious=C2=A0reservations on=
 the=C2=A0approach taken in that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; patch. These reservations stay today too.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; There is nothing qualitatively different betwe=
en the original<br>
&gt;=C2=A0 =C2=A0 =C2=A0patch and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; this series. Naming and related stuff are just=
 cosmetic issues.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0OK, what about considering all patches except the l=
ast one?<br>
&gt;=C2=A0 =C2=A0 =C2=A0So we can run firmware on a real Malta board, not t=
he QEMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0imaginary one (in the discussion you said QEMU shou=
ld respect<br>
&gt;=C2=A0 =C2=A0 =C2=A0real hardware, which I agree).<br>
&gt; <br>
&gt; <br>
&gt; Redo the series, and we can discuss, of course.<br>
<br>
I can resend without the last patch but I don&#39;t see the point,<br>
why not discuss first?<br>
<br>
QEMU should do its best to model a real Malta board. I don&#39;t<br>
want to break the current users for the existing &#39;malta&#39; machine.<b=
r>
How do you want me to name the real malta machine?<br>
<br></blockquote><div><br></div><div>You now self-convinced yourself that o=
nly the last patch is wrong. I repeat, the concept of the series is not ok,=
 and, if you will, all patches in the series are not good.</div><div><br></=
div><div>Regards,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; The good thing about this series is that one c=
an apply it<br>
&gt;=C2=A0 =C2=A0 =C2=A0dowstream, if<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; one finds it useful. However, it is not suitab=
le for upstreaming=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Regards,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Aleksandar<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A02.21.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; <br>
</blockquote>

--000000000000eff47705a94b2756--

