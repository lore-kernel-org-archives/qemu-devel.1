Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D7C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EF62086D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSUdF4O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EF62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMul-0003gt-4A
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iIMty-00030U-H7
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iIMtw-0003Dl-ML
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:05:58 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:40889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1iIMtw-0003DI-H3; Wed, 09 Oct 2019 21:05:56 -0400
Received: by mail-oi1-x234.google.com with SMTP id k9so3437509oib.7;
 Wed, 09 Oct 2019 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NF2T/p7EZoElBDCPihxvRc7fyYMOzP9CcsrzyEtRNnc=;
 b=SSUdF4O0YnW+aJKNQajb/7S5Z2Nc1hOlbXE0EODz3AKu3IiXKsgUQa84phJE4JEosA
 7XPWKFuhA01JzQSApfWykDOiMFbglxGD0F8azwr/vmcJMtlGwhnXGNHUYzQctvad6Db1
 Ecoj1QuP6FwXMU7/iL8j80A3CxkzYKOZc+cHtGBaSPESGRjcv5e/ShWvyIDWRSKuMEwD
 vu7aAEERZZOr5HvucUYUKea89dlrm7eowJIEQN7m4pt4l88mN533xNddgcNHuJLWMRps
 KXWpJNu77Lr3gxfBT9bAF8cB9KWj1fpcTXG60SuAL3b0AQS1XcSrGZkUeka4tf+NLZF3
 yBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NF2T/p7EZoElBDCPihxvRc7fyYMOzP9CcsrzyEtRNnc=;
 b=cXBGJf7Rr17+rxJs3sQ3zCsWPMl7z+wQyXaULGicUGuO6k8HSi6aptOk/i8kqIxBFu
 63Pmmo0tKwagYXJ8uQM/ovy65MJv6cEc88PSbfJOiN4OOIdFQAanS9BnuNgrndzua07/
 C6YuZXbyw6q9lxNp2zuGdp6N6YSdvNxnayeTrxefIEB1UhGJHYjLpU88zLYYzQ1959qr
 oVaNJreuZkDOevY6oqlw7iIERPCMjOruw8H/2PQ7hDaf0wBBcmlSQMW2XuZYhrFfvPJ9
 4U6Gv1O9dqzyPIfKl4B1KfjHSlxFWLodwa57GuXW9EziyY2TrUhzQIiTx2wF3vdSq/IG
 iHFw==
X-Gm-Message-State: APjAAAUhV6HVwVIN7hWeAHOFh5+vVK/AmoSNaNwA4cbkUx2yslO7hX2y
 tX/vEH5FIXrjggGsROqdCKU5HINb4HU42XPcSlo=
X-Google-Smtp-Source: APXvYqw0DLyBYkbNBKpf8FnL5uUoX/fQf4kEnrGg9Dk9EX//guD9dc1wEu6kc1DHRxs2qdtC7+DSJfMX2G0Tkv7FMBM=
X-Received: by 2002:aca:d18:: with SMTP id 24mr5236456oin.56.1570669555418;
 Wed, 09 Oct 2019 18:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191008142539.7793-1-philmd@redhat.com>
 <CAKXe6S+JX_O8pUS-vtJSML5c4qTqoX-PWWfTYQLJVq6DPO37Zg@mail.gmail.com>
 <f6876b2c-547f-6254-9796-47e293a021bc@redhat.com>
In-Reply-To: <f6876b2c-547f-6254-9796-47e293a021bc@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Oct 2019 09:05:19 +0800
Message-ID: <CAKXe6SKUfG7hNAEzTbktzkSuH-0obi9Di8K7oH_saCjqbiRusg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] hw: Convert various reset() handler to DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e90c8605948400ff"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e90c8605948400ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:54=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> On 10/9/19 4:28 AM, Li Qiang wrote:
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E
> > 2019=E5=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=88=
10:47=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     Since v1:
> >     - Removed the pci-host devices
> >
> >
> > Hello  I want to know why  remove this?
>
> I haven't removed the devices, I simply remove the patches converting
> them to DeviceReset,


Yes, I mean the patches.


> basically because I've not enough time to check if
> the are on a bus that would reset them.


IIUC, they are right.


> I added these devices on my TODO
> list for later, so meanwhile the other devices can be easily reviewed
> and merged. When few patches from a series are not reviewed or
> incorrect, sometime the rest of the series is not merged, so I prefer to
> split it and get these patches merged.


As far as I can see, most of the devices' usage of qemu_register_reset
function can be
convert to 'dc->reset'. In the main function.

qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());

The 'qbus_reset_all_fn' calls 'qbus_reset_all' from the 'main-sys-bus'.
Then 'qdev_reset_one'
will call 'device_reset'. So IIUC every bus attached to 'main-sys-bus' can
be reset through 'dc->reset'

So I'm quite sure most of the cases that devices use 'qemu_register_reset'
can be changed to 'dc->reset'.
Seems you're busy,  If you don't mind, I can do some of the work to convert
'reset' callback(not a patchset, one by one).

Thanks,
Li Qiang




>
> >
> >     - Removed the vmcoreinfo conversion (elmarco) but add a comment.
> >     - Added Igor's R-b tag.
> >
> >     Following the thread discussion between Peter/Markus/Damien about
> >     reset handlers:
> >     https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
> >     I started to remove qemu_register_reset() calls from few qdevified
> >     devices (the trivial ones).
> >
> >     Regards,
> >
> >     Phil.
> >
> >     v1:
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06367.html
> >
> >     Philippe Mathieu-Daud=C3=A9 (8):
> >        hw/acpi/piix4: Convert reset handler to DeviceReset
> >        hw/isa/piix4: Convert reset handler to DeviceReset
> >        hw/ide/piix: Convert reset handler to DeviceReset
> >        hw/ide/sii3112: Convert reset handler to DeviceReset
> >        hw/ide/via82c: Convert reset handler to DeviceReset
> >        hw/isa/vt82c686: Convert reset handler to DeviceReset
> >        hw/input/lm832x: Convert reset handler to DeviceReset
> >        hw/misc/vmcoreinfo: Document its reset handler
>

--000000000000e90c8605948400ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:54=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Li,<br>
<br>
On 10/9/19 4:28 AM, Li Qiang wrote:<br>
&gt; Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" t=
arget=3D"_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;&gt; =E4=BA=8E <br>
&gt; 2019=E5=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=
=8810:47=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Since v1:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Removed the pci-host devices<br>
&gt; <br>
&gt; <br>
&gt; Hello=C2=A0 I want to know why=C2=A0 remove this?<br>
<br>
I haven&#39;t removed the devices, I simply remove the patches converting <=
br>
them to DeviceReset, </blockquote><div><br></div><div>Yes, I mean the patch=
es.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>basically because I&#39;ve not enough time to check if <br>
the are on a bus that would reset them. </blockquote><div><br></div><div>II=
UC, they are right.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">I added these devices on my TODO <br>
list for later, so meanwhile the other devices can be easily reviewed <br>
and merged. When few patches from a series are not reviewed or <br>
incorrect, sometime the rest of the series is not merged, so I prefer to <b=
r>
split it and get these patches merged.</blockquote><div><br></div><div>As f=
ar as I can see, most of the devices&#39; usage of qemu_register_reset func=
tion can be=C2=A0</div><div>convert to &#39;dc-&gt;reset&#39;. In the main =
function.</div><div><br></div><div>qemu_register_reset(qbus_reset_all_fn, s=
ysbus_get_default());</div><div><br></div><div>The &#39;qbus_reset_all_fn&#=
39; calls &#39;qbus_reset_all&#39; from the &#39;main-sys-bus&#39;. Then &#=
39;qdev_reset_one&#39;</div><div>will call &#39;device_reset&#39;. So IIUC =
every bus attached to &#39;main-sys-bus&#39; can be reset through &#39;dc-&=
gt;reset&#39;</div><div><br></div><div>So I&#39;m quite sure most of the ca=
ses that devices use &#39;qemu_register_reset&#39; can be changed to &#39;d=
c-&gt;reset&#39;.</div><div>Seems you&#39;re busy,=C2=A0 If you don&#39;t m=
ind, I can do some of the work to convert &#39;reset&#39; callback(not a pa=
tchset, one by one).</div><div><br></div><div>Thanks,</div><div>Li Qiang</d=
iv><div><br></div><div>=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- Removed the vmcoreinfo conversion (elmarco) but a=
dd a comment.<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Added Igor&#39;s R-b tag.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Following the thread discussion between Peter/Marku=
s/Damien about<br>
&gt;=C2=A0 =C2=A0 =C2=A0reset handlers:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://www.mail-archive.com/qemu-devel@=
nongnu.org/msg617103.html" rel=3D"noreferrer" target=3D"_blank">https://www=
.mail-archive.com/qemu-devel@nongnu.org/msg617103.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0I started to remove qemu_register_reset() calls fro=
m few qdevified<br>
&gt;=C2=A0 =C2=A0 =C2=A0devices (the trivial ones).<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Phil.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0v1: <a href=3D"https://lists.gnu.org/archive/html/q=
emu-devel/2019-09/msg06367.html" rel=3D"noreferrer" target=3D"_blank">https=
://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06367.html</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Philippe Mathieu-Daud=C3=A9 (8):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/acpi/piix4: Convert reset handler to Dev=
iceReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/isa/piix4: Convert reset handler to Devi=
ceReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/ide/piix: Convert reset handler to Devic=
eReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/ide/sii3112: Convert reset handler to De=
viceReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/ide/via82c: Convert reset handler to Dev=
iceReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/isa/vt82c686: Convert reset handler to D=
eviceReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/input/lm832x: Convert reset handler to D=
eviceReset<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw/misc/vmcoreinfo: Document its reset hand=
ler<br>
</blockquote></div></div>

--000000000000e90c8605948400ff--

