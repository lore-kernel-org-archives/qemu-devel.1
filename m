Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SHORTENED_URL_HREF,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F80C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EB4207EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="S+FTs0uL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EB4207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEC0C-0001PI-1K
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEBwn-0004jS-QC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEBwl-0005dh-Hs
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:40:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id a17so6780322wrn.6
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pAcLXleH3BATZtRYycrQT63Ow9w76K6zXf0hadGR3uw=;
 b=S+FTs0uLz4RAckKdZeiMGxWNrmC8z1+aWH6erRX5WtXDkVDzmKvVZ8PYJ+7V4N9aHJ
 L/sQlzopXhWynNT9dZ8O9rbwpdKlZR3T3ihXWf9wqkDaTb7lpYdLeMcHH61mojhzT9Pf
 CCvbgt9mZ7+2HWBfRGmdmwdtS8RPEWuOi2gfbrZQNpzEFzHGeDc9BDSyCgNWhi+Ut8r0
 m/gsJHRcDjzMamJnO4iKj2RlovWBwecxQMKYVfudIEh0BzNkIA21C3Z5j7bWZ/Mu8hv2
 UeWJzCAjmo07Pqfvb0jY/HNBDzypRwIOMi9GO8N5DGYNi0pVwLx11GlC6JOOYAC3fr2j
 EzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pAcLXleH3BATZtRYycrQT63Ow9w76K6zXf0hadGR3uw=;
 b=DgkqNaGUxsZpGmmFtthKrGINdSR8fAj1+XD07UqOIY1S/FPvdzHbOMBhtfNtkv+o8q
 22PMvxX7L7YFabyA6ndhlq/ewspcrFNXEuvKAr/89oAfQC3XQfZog0UPUvsnPAzbhYhe
 eQwnjYn3CJx02uUg80NhAuL+DWcpexDx2xqGtmN7c282QM8P9ltmJ+oq3rJtaWLHqhCb
 79UcwPfeL9ESYq/D5g26LYMq48A9vfmncEYy9Zj9/GNPVifwgALmnaN0fjy70x+h9KmP
 BussOwXhYjq1evoKZLDyUcotEs5C3ooz9nQ5uR5ZdrBl/ymQ4/tY0BYPfDwpOFXxxoBs
 gHmg==
X-Gm-Message-State: AOAM530vRPAEsdcGFHN4csCci+tQWQdocaUPlE3WqQ1avjETG9jK8l8q
 TrHz6QELdqdxC4km/GPC+TtK3lebUx4gZZWjz+QBcK9Qeh4=
X-Google-Smtp-Source: ABdhPJxsqOZKZagbohgA7yqNkD7uKlwO8W4ANHEZQEAwKc6P168QzphvVCkOZCscu8KoaIZCJv6zOz+TtFSOj90HVYI=
X-Received: by 2002:adf:bb44:: with SMTP id x4mr7569776wrg.76.1599226805399;
 Fri, 04 Sep 2020 06:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200904124404.9894-1-ani@anisinha.ca>
 <2ba66be7-d4f2-6994-7794-c07fbb50151f@redhat.com>
In-Reply-To: <2ba66be7-d4f2-6994-7794-c07fbb50151f@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 4 Sep 2020 19:09:54 +0530
Message-ID: <CAARzgwwwbxqwxdni4rANsDF-f5HytcdM9NC9R8X7X0bqJSeVPw@mail.gmail.com>
Subject: Re: [PATCH v2] i440fx/acpi: disable hotplug of cold plugged bridges
 regarldless of hotplug switch
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a6d0b705ae7d010a"
Received-SPF: none client-ip=2a00:1450:4864:20::430;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x430.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a6d0b705ae7d010a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 On Sep 4, 2020, 18:59 +0530, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>,
wrote:

Hi Ani,


On 9/4/20 2:44 PM, Ani Sinha wrote:

Cold plugged bridges should not be hot unpluggable, even when their hotplug

property (acpi-pci-hotplug-with-bridge-support) is turned off. However, wit=
h

the current implementaton, windows would try to hot-unplug a pci bridge whe=
n

it's hotplug switch is off. This is regardless of whether there are devices

attached to the bridge. When devices are attached to the bridge, the bridge

is ultimately not hot-unpluggable. We have a demo video here:

https://youtu.be/pME2sjyQweo


In this fix, we identify a cold plugged bridge and for cold plugged bridges=
,

we do not add the appropriate amls and acpi methods that are used by the OS

to identify a hot-unpluggable pci device. After this change, Windows does
not

show an option to eject the PCI bridge. A demo video is here:

https://youtu.be/kbgej5B9Hgs


While at it, I have also updated a stale comment.


This change is tested with a Windows 2012R2 guest image and Windows 2019
server

guest image running on Ubuntu 18.04 host. This change is based off of
upstream

qemu master branch tag v5.1.0.


Can you add a test reproducer?


Looking at tests/qtest/virtio-rng-test.c it shouldn't be that

hard / time consuming.


I can add a unit test. If you look at the disassembled DSDT table, you can
easily see that it=E2=80=99s adding the EJ0 method for the slot in which th=
e bridge
is attached.

--000000000000a6d0b705ae7d010a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">



<div>
<div name=3D"messageReplySection">
<div dir=3D"auto">On Sep 4, 2020, 18:59 +0530, Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.co=
m</a>&gt;, wrote:</div>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">Hi Ani,</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">On 9/4/20 2:44 PM, Ani Sinha wrote:</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">Cold plugged bridges should not be hot unpluggable, even w=
hen their hotplug</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">property (acpi-pci-hotplug-with-bridge-support) is turned =
off. However, with</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">the current implementaton, windows would try to hot-unplug=
 a pci bridge when</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">it&#39;s hotplug switch is off. This is regardless of whet=
her there are devices</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">attached to the bridge. When devices are attached to the b=
ridge, the bridge</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">is ultimately not hot-unpluggable. We have a demo video he=
re:</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><a href=3D"https://youtu.be/pME2sjyQweo" target=3D"_blank"=
>https://youtu.be/pME2sjyQweo</a></blockquote>
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
padding-top:5px">In this fix, we identify a cold plugged bridge and for col=
d plugged bridges,</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">we do not add the appropriate amls and acpi methods that a=
re used by the OS</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">to identify a hot-unpluggable pci device. After this chang=
e, Windows does not</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">show an option to eject the PCI bridge. A demo video is he=
re:</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><a href=3D"https://youtu.be/kbgej5B9Hgs" target=3D"_blank"=
>https://youtu.be/kbgej5B9Hgs</a></blockquote>
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
padding-top:5px">While at it, I have also updated a stale comment.</blockqu=
ote>
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
padding-top:5px">This change is tested with a Windows 2012R2 guest image an=
d Windows 2019 server</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">guest image running on Ubuntu 18.04 host. This change is b=
ased off of upstream</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid">
<blockquote style=3D"border-left-color:rgb(230,126,34);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">qemu master branch tag v5.1.0.</blockquote>
</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">Can you add a test reproducer?</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px"><br></blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">Looking at tests/qtest/virtio-rng-test.c it shouldn&#39;t =
be that</blockquote>
<blockquote style=3D"border-left-color:rgb(26,188,156);margin:0px;padding-l=
eft:10px;border-left-width:thin;border-left-style:solid;padding-bottom:5px;=
padding-top:5px">hard / time consuming.</blockquote>
<div dir=3D"auto"><br>
I can add a unit test. If you look at the disassembled DSDT table, you can =
easily see that it=E2=80=99s adding the EJ0 method for the slot in which th=
e bridge is attached.<br></div>

</div>
</div>

</div>

--000000000000a6d0b705ae7d010a--

