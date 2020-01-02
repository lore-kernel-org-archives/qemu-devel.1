Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 19:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AAE21655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 19:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJEwX+S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AAE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in6XY-0000G0-1e
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 14:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1in6Ws-00087X-PL
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 14:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1in6Wr-00026w-7H
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 14:53:10 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:32924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1in6Wq-00026c-VJ; Thu, 02 Jan 2020 14:53:09 -0500
Received: by mail-io1-xd44.google.com with SMTP id z8so39328761ioh.0;
 Thu, 02 Jan 2020 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kbIeFMqX1abDrXX6q7PzoWqqewZ5j7pF9WBRxkX6s1o=;
 b=uJEwX+S0RjPHNw0ezsm0crmOkfUoS20zNl1YieusQwkqCgJI+olzKnRLT66RuCukme
 chUTyWprbAC4pYK9e5JvFbMBjwFZU1j1d75JWeoh/W/3ahPrW54CJAL0lLanf9r6hB5J
 zz2lCM/SPuqgPLn5zVev4o3ziIjuL+0gxrCHf51C3C2qTqkUOtPh2dL3snkMmXXL8lhM
 eC3xBWWIpCrxLDrTYTDv4Mr8pvZ1sQu4TMZlfj3RKPb49ikmuDjKVWm7YH6yq2Ces1lI
 gT4BCXD7A5ITeGhSXmjiYCXl4+k8DiXfEudZTxSRC11o5r9mTobD1zc4Ag7aY53UHt6f
 11gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kbIeFMqX1abDrXX6q7PzoWqqewZ5j7pF9WBRxkX6s1o=;
 b=eK50R966kOQV7NYRRUvGeWtaSinYMCSLzcW2JIvPHbQ1u1lsAzR8hxo1Tfj26KL2ob
 6/+6SySuJqvzWEbS0YS9Tt/qy4sK1gNTU3E9ya4KzAurKh7vx0shJqOf5WafBKgBaVAQ
 yFMuZO6m0RPFggLsjcOgU9voQ5y5kbVgplx3lIsFRHAhqCc1ZCad1RodoN1VTZivKDeY
 ZnWIfFFgDPa1T6pHJUox8QhPBEeqSlRkoon/Ux5haEZSjn0wykAfW2p2DT8c4+EH3ty/
 AZkLfVzOJC/dtygIl+kkhTmyeAg0/56eyUSlggEGyB0xw1K8iZFOVTEejP1t1mz7z9hV
 6Hwg==
X-Gm-Message-State: APjAAAX9BYnIcdFtk6RYLnZEBIOlei4FmW4lxWYgcVP3uwdNI6RVX4pn
 7LARFYJJGKHWnunnDWCs5rq6BYCNIhGWSwX+Qno=
X-Google-Smtp-Source: APXvYqwnywkEt2ppXTogrFsbtD0naUsYwfHJrKoNQuwjZWNAnQ9qA0oVlAsYXvnQoOu2aEGb+quAw62RXJb7+Y2mmNk=
X-Received: by 2002:a6b:6f01:: with SMTP id k1mr56341756ioc.28.1577994787736; 
 Thu, 02 Jan 2020 11:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
 <CAPan3WpDbWb_cBMJPgokSLKAJndMQLvRdOav6CPpDbFv+ChN0g@mail.gmail.com>
 <9756419b-55bf-23a9-556a-d5bc5fb29331@redhat.com>
 <CAPan3WrYAK+PFtFM7ZDCVsKLc_ksGxZeHEcwB9_FK=4v5p8h=w@mail.gmail.com>
In-Reply-To: <CAPan3WrYAK+PFtFM7ZDCVsKLc_ksGxZeHEcwB9_FK=4v5p8h=w@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 2 Jan 2020 20:52:56 +0100
Message-ID: <CAPan3WoP8MYubKaArOuWVCo65iOYNc2TpQ8KA0f_wRZwLATMAA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c7d298059b2d8af9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c7d298059b2d8af9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I'm almost ready to send out v3 here.

Now for documentation I'm not sure yet what to do:

1) Where should I place board documentation?
    For example, the information that I wrote on the cover letter with
instructions on how to get the board up and running,
    some description of the design, where to find more inforformation,
datasheet sources, etc. I don't yet see any documentation
   for the other boards in the source. In my opinion, it is important to
keep that information somewhere, such that also in the future
   the boards can still be properly maintained. Can I / shall I place a new
file like ./docs/hw/arm/orangepi.txt for that?

 2) Is is allowed / encouraged to provide Doxygen-style comments in the
header files in include/hw/*?
   I see that some of the API's have that, but the boards and devices
mostly are free of Doxygen-style comments.
   It takes some work, but I think it can really help to give more insight
/ background info on how things are working
   for the devices and boards. But if it's not preferred for QEMU, I'm fine
with that as well.

Regards,
Niek

On Mon, Dec 30, 2019 at 9:10 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

>
>
> On Mon, Dec 30, 2019 at 3:56 PM Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> On 12/30/19 12:28 PM, Niek Linnenbank wrote:
>> > Hi,
>> >
>> > Here a short status report of this patch series.
>>
>> Good idea!
>>
>> >
>> > For V3 update I already prepared the following:
>> >   - reworked all review comments from Philippe, except:
>> >     - patch#8: question for the SID, whether command-line override is
>> > required (and how is the best way for machine-specific cli arg?) [1]
>>
>> Answered recently.
>>
> Thanks!
>
>>
>> > - added BootROM support, allows booting with only specifying -sd <IMG>
>> > - added SDRAM controller driver, for U-Boot SPL
>> > - added Allwinner generic RTC driver (for both Cubieboard and OrangePi
>> > PC, supports sun4i, sun6i, sun7i)
>> > - small fixes for EMAC
>> >
>> > My current TODO:
>> >   - integrate Philips acceptance tests in the series
>>
>> You can queue them in your series, adding your Signed-off-by tag after
>> mine. See:
>>
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#s=
ign-your-work-the-developer-s-certificate-of-origin
>>
>>    The sign-off is a simple line at the end of the explanation for the
>> patch, which certifies that you wrote it or otherwise have the right to
>> pass it on as an open-source patch.
>>
>> See point (c).
>>
>> Ah that certainly helps. I'll read that page.
>
>
>> >   - integrate Philips work for generalizing the Allwinner timer, and
>> > finish it
>>
>> We can also do that later, and get your work merged first.
>>
>
> Ok that sounds very good! Agreed, lets do the timer work later.
>
>
>>
>> >   - test and fix BSD targets (NetBSD, FreeBSD) [2, 3]
>> >   - further generalize the series to cover very similar SoCs: H2+, H5
>> >
>> > Does anyone have more comments/requests for the V3 update?
>> >
>> > [1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04049.htm=
l
>> > [2] https://wiki.netbsd.org/ports/evbarm/allwinner/
>> > [3]
>> >
>> https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dshow&redirec=
t=3DFreeBSD%2Farm%2FAllwinner
>>
>>
>
> --
> Niek Linnenbank
>
>

--=20
Niek Linnenbank

--000000000000c7d298059b2d8af9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>I&#39;m almost =
ready to send out v3 here.</div><div><br></div><div>Now for documentation I=
&#39;m not sure yet what to do:</div><div><br></div><div>1) Where should I =
place board documentation?</div><div>=C2=A0=C2=A0=C2=A0 For example, the  i=
nformation that I wrote on the cover letter with instructions on how to get=
 the board up and running,</div><div>=C2=A0=C2=A0=C2=A0 some description of=
 the design, where to find more inforformation, datasheet sources, etc. I d=
on&#39;t yet see any documentation</div><div>=C2=A0=C2=A0 for the other boa=
rds in the source. In my opinion, it is important to keep that information =
somewhere, such that also in the future</div><div>=C2=A0=C2=A0 the boards c=
an still be properly maintained. Can I / shall I place a new file like ./do=
cs/hw/arm/orangepi.txt for that?</div><div><br></div><div>=C2=A02) Is is al=
lowed / encouraged to provide Doxygen-style comments in the header files in=
 include/hw/*?</div><div>=C2=A0=C2=A0 I see that some of the API&#39;s have=
 that, but the boards and devices mostly are free of Doxygen-style comments=
.</div><div>=C2=A0=C2=A0 It takes some work, but I think it can really help=
 to give more insight / background info on how things are working</div><div=
>=C2=A0=C2=A0 for the devices and boards. But if it&#39;s not preferred for=
 QEMU, I&#39;m fine with that as well.<br></div><div><br></div><div>Regards=
,</div><div>Niek<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Dec 30, 2019 at 9:10 PM Niek Linnenbank &lt;<a =
href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30, 2019 at 3:56 PM Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">p=
hilmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On 12/30/19 12:28 PM, Niek Linnenbank wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Here a short status report of this patch series.<br>
<br>
Good idea!<br>
<br>
&gt; <br>
&gt; For V3 update I already prepared the following:<br>
&gt;=C2=A0 =C2=A0- reworked all review comments from Philippe, except:<br>
&gt;=C2=A0 =C2=A0=C2=A0 - patch#8: question for the SID, whether command-li=
ne override is <br>
&gt; required (and how is the best way for machine-specific cli arg?) [1]<b=
r>
<br>
Answered recently.<br></blockquote><div>Thanks! <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; - added BootROM support, allows booting with only specifying -sd &lt;I=
MG&gt;<br>
&gt; - added SDRAM controller driver, for U-Boot SPL<br>
&gt; - added Allwinner generic RTC driver (for both Cubieboard and OrangePi=
 <br>
&gt; PC, supports sun4i, sun6i, sun7i)<br>
&gt; - small fixes for EMAC<br>
&gt; <br>
&gt; My current TODO:<br>
&gt;=C2=A0 =C2=A0- integrate Philips acceptance tests in the series<br>
<br>
You can queue them in your series, adding your Signed-off-by tag after <br>
mine. See:<br>
<a href=3D"https://www.kernel.org/doc/html/latest/process/submitting-patche=
s.html#sign-your-work-the-developer-s-certificate-of-origin" rel=3D"norefer=
rer" target=3D"_blank">https://www.kernel.org/doc/html/latest/process/submi=
tting-patches.html#sign-your-work-the-developer-s-certificate-of-origin</a>=
<br>
<br>
=C2=A0 =C2=A0The sign-off is a simple line at the end of the explanation fo=
r the <br>
patch, which certifies that you wrote it or otherwise have the right to <br=
>
pass it on as an open-source patch.<br>
<br>
See point (c).<br>
<br></blockquote><div>Ah that certainly helps. I&#39;ll read that page.<br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0- integrate Philips work for generalizing the Allwinner ti=
mer, and <br>
&gt; finish it<br>
<br>
We can also do that later, and get your work merged first.<br></blockquote>=
<div><br></div><div>Ok that sounds very good! Agreed, lets do the timer wor=
k later.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
&gt;=C2=A0 =C2=A0- test and fix BSD targets (NetBSD, FreeBSD) [2, 3]<br>
&gt;=C2=A0 =C2=A0- further generalize the series to cover very similar SoCs=
: H2+, H5<br>
&gt; <br>
&gt; Does anyone have more comments/requests for the V3 update?<br>
&gt; <br>
&gt; [1] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/m=
sg04049.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2019-12/msg04049.html</a><br>
&gt; [2] <a href=3D"https://wiki.netbsd.org/ports/evbarm/allwinner/" rel=3D=
"noreferrer" target=3D"_blank">https://wiki.netbsd.org/ports/evbarm/allwinn=
er/</a><br>
&gt; [3] <br>
&gt; <a href=3D"https://wiki.freebsd.org/action/show/arm/Allwinner?action=
=3Dshow&amp;redirect=3DFreeBSD%2Farm%2FAllwinner" rel=3D"noreferrer" target=
=3D"_blank">https://wiki.freebsd.org/action/show/arm/Allwinner?action=3Dsho=
w&amp;redirect=3DFreeBSD%2Farm%2FAllwinner</a><br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000c7d298059b2d8af9--

