Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38507C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9A120767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="t+T16Blz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9A120767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmEN-00012w-Th
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmDJ-0008Al-DM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:11:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kDmDH-0006Dt-7t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:11:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id a9so2286342wmm.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YWjeXhoskgbczv5H81Kg1ggEeL1doL5d1wqOuLctZVs=;
 b=t+T16BlzdD43b4jRiKwlSGjsLEqpce/Z78w3GjN/hXXKD+vxs8L4x9oxGAUJfIQIM6
 HWHF3wlA8RtH3dhe4v2m0APdztHYNRW9nw9lWFVF+2B73tg4XTem+lcNVkUbteu1mfHF
 ScF7CZ4LkFxQ5nL5p0Sf/iXHQOVVdvov/BNkaOqnHsbgKeBPayqbiI/CF9p36Red7JHr
 zw1AlZZ7aa++++VxCpaM1bA63FdeEnkxrxmX80Ve0M4aOWFi9kaWQFRtzS2CLi+SIO+D
 I9J9L63bsQkSHsJ5F/9p5mGDLXu29F3/KNYJ5SDb/XwwUKGMevbYofpfybFwzzD9yS0r
 eZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YWjeXhoskgbczv5H81Kg1ggEeL1doL5d1wqOuLctZVs=;
 b=S720dSwz0+KCAlaWNJHVblSyHrsoateYKWTbp8syW8FmOM65/gom2orW6G9Z6H4sQd
 oZt4TDPGQco1uyUQ47m9otsNVbseYTeQwRggVgYVnPCtLsV//vBaPZBXPR2C5PitJo2J
 QmzBUPIf8458nwHukqBiKsBtgTjAIQdawHDaFdXu3O+YYckPRyZggrYauWkrc0gN0+1O
 vycnMdWkd+CDatyH3DyJhfVOfGsFwcy+W0W6lQSB+oCHQ9I/MLtsS+vDSn1iukWrgAIZ
 L3oHAW2Jb43fdMsnSq50f67E1GFA3wDIlp4A1eieddZKyQDNRm31uSRzpi+SpWCT1Up8
 gM5Q==
X-Gm-Message-State: AOAM530P1oa68pUGR+4WQjv6DNEzcAA0TegiOFJOjV5ZKkenD61Z8BvS
 Ue7aEcPna4VTsF7zeVyfaMQStKrnh9ZDGKRRfPd+xg==
X-Google-Smtp-Source: ABdhPJxa51s9VClibWZJYwmB0Vva7KcHsr2dSjEN3a0Ir25oN0NHtm6B9Oh305CN/vRV6900uWSvP1ntNy/NoP8d2L8=
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr1735193wme.102.1599127885240; 
 Thu, 03 Sep 2020 03:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200829081233.10120-1-ani@anisinha.ca>
 <20200903060332-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200903060332-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 3 Sep 2020 15:41:13 +0530
Message-ID: <CAARzgwwFRUOoq7GOttzJVT8+67+7uNugC529SB8DX242p8A_QQ@mail.gmail.com>
Subject: Re: [PATCH] Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
 non-hotpluggable bus
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008cf8f005ae65f9f1"
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008cf8f005ae65f9f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On Sep 3, 2020, 15:35 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote:

On Sat, Aug 29, 2020 at 01:42:33PM +0530, Ani Sinha wrote:

When ACPI hotplug for the root bus is disabled, the bsel property for that

bus is not set. Please see the following commit:


3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on
the root bus").


As a result, when acpi_pcihp_find_hotplug_bus() is called

with bsel set to 0, it may return the root bus. This would be wrong since
the

root bus is not hotpluggable. In general, this can potentially happen to
other

buses as well.

In this patch, we fix the issue in this function by checking if the bus
returned

by the function is actually hotpluggable. If not, we simply return NULL.
This

avoids the scenario where we are actually returning a non-hotpluggable bus.


Signed-off-by: Ani Sinha <ani@anisinha.ca>


What exactly are the consequences though?


The root bus might get ejected by the user when it should not if the user
does the following:

outl 0xae10 0
outl 0xae08 your_slot

Please see Julia=E2=80=99s comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html

--0000000000008cf8f005ae65f9f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">



<div>
<div name=3D"messageReplySection">
<div dir=3D"auto">On Sep 3, 2020, 15:35 +0530, Michael S. Tsirkin &lt;<a hr=
ef=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt;, wrot=
e:</div>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">On Sat, Aug 29, 2020 at 01:42:33PM +0530, Ani Sinha wrote:=
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">When ACPI hotplug for the root bus is disabled, the bsel p=
roperty for that</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">bus is not set. Please see the following commit:</blockquo=
te>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">3d7e78aa7777f (&quot;Introduce a new flag for i440fx to di=
sable PCI hotplug on the root bus&quot;).</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">As a result, when acpi_pcihp_find_hotplug_bus() is called<=
/blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">with bsel set to 0, it may return the root bus. This would=
 be wrong since the</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">root bus is not hotpluggable. In general, this can potenti=
ally happen to other</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">buses as well.</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">In this patch, we fix the issue in this function by checki=
ng if the bus returned</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">by the function is actually hotpluggable. If not, we simpl=
y return NULL. This</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">avoids the scenario where we are actually returning a non-=
hotpluggable bus.</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">Signed-off-by: Ani Sinha &lt;<a href=3D"mailto:ani@anisinh=
a.ca" target=3D"_blank">ani@anisinha.ca</a>&gt;</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">What exactly are the consequences though?</blockquote>
<div dir=3D"auto"><br>
The root bus might get ejected by the user when it should not if the user d=
oes the following:</div><div dir=3D"auto"><pre>outl 0xae10 0
outl 0xae08 your_slot</pre></div><div dir=3D"auto">Please see Julia=E2=80=
=99s comment:</div><div dir=3D"auto"><a href=3D"https://www.mail-archive.co=
m/qemu-devel@nongnu.org/msg734548.html">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg734548.html</a></div><div dir=3D"auto"><br></div></div>
</div>

</div>

--0000000000008cf8f005ae65f9f1--

