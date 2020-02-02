Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B55C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 17:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D80B2067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMeYTbiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D80B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyJE0-0004vO-EE
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 12:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyJDN-0004U0-6i
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 12:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyJDK-0005J7-H8
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 12:39:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyJDK-0005I8-5t
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 12:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580665157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDDd0cYoJOZkjqMgJm0NoCq1plQbOHdYWc9yxgib78c=;
 b=bMeYTbiYenpeN2JxHwNWt9H6P3BgveUWVxV/QcdJ4j7hb0Dg13OVo3w0bac7SQp0GMYrkR
 whxTQp7AMfEeoXgAPEVVYxr0jxeR+t/YAVgdksoKn62lptAJbFcDiGIAN/mRkAtaQiA/T+
 Zju3GOKwdPoKivfsEQ15tZOkdjKS21c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-VsBdmg30NNCt2HYbAEuHDw-1; Sun, 02 Feb 2020 12:39:12 -0500
Received: by mail-ed1-f72.google.com with SMTP id y23so8507215edt.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 09:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LEqheHclh57Ie60G7IJ/frK0f/FIEp+k4/PdsuZSddc=;
 b=ry9bY4iJr5/ohhLScdSBj55NF67ixgrecjIvZOPeoflgOHoGxIoe0ZIrhYYBjaGYzq
 Epcst+i8uBJzT+rGkWnba+ebitQxTZXgdpVqH1rpJOT/3+OW0G3K1jNc4xih+GjzkLo8
 OpMrFmPEOwyhhnfnIv3XL4JSUX0bMje7gVvysmNrUuL2GOkLg5hY1shqFu5RCrWQqXT4
 ir7zg/gwe9CeHHEuVpeWMnVACQZtCs6ELIgUqyixdfVuBs+6yyCry2k7mu8w3mZPO6kA
 qBrvEkJWnP4pcsey6O5nrFmoya3/WZf0R1P030Vm8LjVd3FFqxp9+AjQslrGSanR0cEc
 iphw==
X-Gm-Message-State: APjAAAXChLKDn5ItCc+UOCxfPXBtFTtIQTsV7Q76w3OeGsRHID07M9H7
 HUzn9oI+jO7FCfw7ZEAb5eP2lNhfvdhDO7pkd0iKtT7J+VYq+7b6wZ4WHM7+g/zjcgXCL6u7po6
 c9fPQHywiCT2ImVV8gRUvIcpA8H3+060=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr8843801edd.193.1580665151535; 
 Sun, 02 Feb 2020 09:39:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxROVZnwukmMqP1AhBOep23SSPwMf02ABd626yNGnlicMq6j3cB+SgaHmyhr3O9CYmXqQ8UVIaH3kJzwS8i3ao=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr8843777edd.193.1580665151305; 
 Sun, 02 Feb 2020 09:39:11 -0800 (PST)
MIME-Version: 1.0
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <94828b1d-fa7d-149e-9eb3-d001d6484489@ozlabs.ru>
In-Reply-To: <94828b1d-fa7d-149e-9eb3-d001d6484489@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 2 Feb 2020 18:38:59 +0100
Message-ID: <CABgObfaG6th54YJkEPaqq=_UQhvmZiJz6X6Yb_PZJQ15AZvMTA@mail.gmail.com>
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>
X-MC-Unique: VsBdmg30NNCt2HYbAEuHDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000da68f6059d9b48d1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000da68f6059d9b48d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 2 feb 2020, 12:51 Alexey Kardashevskiy <aik@ozlabs.ru> ha scritto:

> > QEMU must not load GRUB from disk, that's the firmware's task.  If you
> > want to kill SLOF, you can rewrite it, but loading the kernel GRUB from
> > disk within QEMU is a bad idea: the next feature you'll be requested to
> > implement will be network boot, and there's no way to do that in QEMU.
>
> What is exactly the problem with netboot? I can hook up the OF's "net" to
> a backend (as I do for serial console and
> blockdev, in boot order)


Who provides the OpenFirmware entry point when you remove SLOF and boot
directly into grub?

Or alternatively it is possible with my patchset to load petitboot (kernel
> + intramdisk, the default way of booting
> POWER8/9 baremetal systems) and that thing can do whole lot of things, we
> can consider it as a replacement for ROMs from
> devices (or I misunderstood what kind of netboot you meant).
>

Why wouldn't that have the same issue as SLOF that you describe below (I
honestly don't understand anything of it, but that's not your fault :-)).

Paolo


> > You should be able to reuse quite a lot of code from both
> > pc-bios/s390-ccw (for virtio drivers) and kvm-unit-tests (for device
> > tree parsing).  You'd have to write the glue code for PCI hypercalls,
> > and adapt virtio.c for virtio-pci instead of virtio-ccw.
>
> The reason for killing SLOF is to keep one device tree for the entire boo=
t
> process including
> ibm,client-architecture-support with possible (and annoying) configuratio=
n
> reboots. Having another firware won't help
> with that.
>
> Also the OF1275 client interface is the way for the client to get
> net/block device without need to have drivers, I'd
> like to do just this and skip the middle man (QEMU device and guest drive=
r
> in firmware/bootloader).
>
> I'll post another RFC tomorrow to give a better idea.
>
>
> --
> Alexey
>
>

--000000000000da68f6059d9b48d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 2 feb 2020, 12:51 Alexey Kardashevskiy &lt;<a h=
ref=3D"mailto:aik@ozlabs.ru">aik@ozlabs.ru</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">&gt; QEMU must not load GRUB from disk, that&#3=
9;s the firmware&#39;s task.=C2=A0 If you<br>
&gt; want to kill SLOF, you can rewrite it, but loading the kernel GRUB fro=
m<br>
&gt; disk within QEMU is a bad idea: the next feature you&#39;ll be request=
ed to<br>
&gt; implement will be network boot, and there&#39;s no way to do that in Q=
EMU.<br>
<br>
What is exactly the problem with netboot? I can hook up the OF&#39;s &quot;=
net&quot; to a backend (as I do for serial console and <br>
blockdev, in boot order)</blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Who provides the OpenFirmware entry point when you remo=
ve SLOF and boot directly into grub?</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Or a=
lternatively it is possible with my patchset to load petitboot (kernel + in=
tramdisk, the default way of booting <br>
POWER8/9 baremetal systems) and that thing can do whole lot of things, we c=
an consider it as a replacement for ROMs from <br>
devices (or I misunderstood what kind of netboot you meant).<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Why wouldn&#39;=
t that have the same issue as SLOF that you describe below (I honestly don&=
#39;t understand anything of it, but that&#39;s not your fault :-)).</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<br>
&gt; You should be able to reuse quite a lot of code from both<br>
&gt; pc-bios/s390-ccw (for virtio drivers) and kvm-unit-tests (for device<b=
r>
&gt; tree parsing).=C2=A0 You&#39;d have to write the glue code for PCI hyp=
ercalls,<br>
&gt; and adapt virtio.c for virtio-pci instead of virtio-ccw.<br>
<br>
The reason for killing SLOF is to keep one device tree for the entire boot =
process including <br>
ibm,client-architecture-support with possible (and annoying) configuration =
reboots. Having another firware won&#39;t help <br>
with that.<br>
<br>
Also the OF1275 client interface is the way for the client to get net/block=
 device without need to have drivers, I&#39;d <br>
like to do just this and skip the middle man (QEMU device and guest driver =
in firmware/bootloader).<br>
<br>
I&#39;ll post another RFC tomorrow to give a better idea.<br>
<br>
<br>
-- <br>
Alexey<br>
<br>
</blockquote></div></div></div>

--000000000000da68f6059d9b48d1--


