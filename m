Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2DCC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C8320674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSVpcCiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C8320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykf4-0002H6-5i
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 17:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iykeD-0001eY-GW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iykeA-00032b-E6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:56:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyke9-0002yU-8f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580770607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ooyf6kTf8yYia5cYQQQiOqPh9V69vI0ZYvx6GetJlQ8=;
 b=iSVpcCiuNAKue2tY7RIF7eRU+TKfkhXXuUai8+knj8gvuPM2bqGlITgVkVoKFKifQ0uYPX
 W/e1M1y3dzPUkwTW6kqRtPJr5O9/uZbSWVbOip2lo4WRK+96bgvlNxLZqwuRPxwPP3VIET
 QLn6I3aeY/WIvm0XZKatvqXKcUGY5f4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-KT_kbwfYPN6usWA-H94Pxg-1; Mon, 03 Feb 2020 17:56:44 -0500
Received: by mail-ed1-f72.google.com with SMTP id l19so11381796edq.19
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 14:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+oq2IgrZ3aksNSBuo2adjOMSYhMX3SYfglvXBcO7dqA=;
 b=pcypgTq4P+WxUrmIIAiK+inwoWLjzuUQD9PvrMuUXlXfCw2vDnaETeBXE6GyJ5F9EZ
 MM7NCrAuLiet69VqJ0zXpgy+6MQp7UjPqjXKrdfbHQQJki7yTOKHLP0NH/9Tw5/SH9Dv
 +Z1AIL/GA5ybr4OVZtqBTSemDEY5ZAQmeH9hC8Jqn/0ffibBubV5zc0EMwa50sijWk8D
 DAeDoSC68OsiF85ld/Nmu/BIJoCwzVZVmR+PtW+DUGqk1wI/vTBoVxrEIVPk0HM6cL17
 8meyUMSafxiBwdBMVGrxYb7PnV5D1s0xjjpPwKFwGZXgYpQpk5Rb49E+AqgqSc6ySzhO
 8wrg==
X-Gm-Message-State: APjAAAVe97ehN+/gox+eHsNb8e5y0aXF8zDlP0Yu9CZcFlxpBSwPONim
 fllg0P/qAjfJRsspPispWh9ZgBe8iVd4a6oBFusgQvUUz5Qf+TAgUUvuRMhamySAU3+/RDZzE+4
 iLNrCkZSYgEzWGPuGLWU5onVdPvNUUh8=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr14048234edd.193.1580770603491; 
 Mon, 03 Feb 2020 14:56:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnD+OaRxOkxVkq3Qwe6ioKvnxQGkxOREJfdTHMUhCO89TRQ43FzDeu9JjOZY4s2rvDmD6qhhWwLatWM1YTHcU=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr14048211edd.193.1580770603167; 
 Mon, 03 Feb 2020 14:56:43 -0800 (PST)
MIME-Version: 1.0
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
In-Reply-To: <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Feb 2020 23:56:31 +0100
Message-ID: <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
Subject: Re: VW ELF loader
To: Alexey Kardashevskiy <aik@ozlabs.ru>
X-MC-Unique: KT_kbwfYPN6usWA-H94Pxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000462e97059db3d69a"
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

--000000000000462e97059db3d69a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 3 feb 2020, 23:36 Alexey Kardashevskiy <aik@ozlabs.ru> ha scritto:

>
> > What partition formats would have to be supported?
>
> MBR, GPT, is there anything else? "Support" is limited to converting a
> number after command to [start, size] couple. I am not going for file
> systems.
>
> > But honestly I'm
> > more worried about the networking part.
>
> Fair enough.
>
> > Yes, SLOF is big and slow.  petitboot is not petit at all either, and
> > has the disadvantage that you have to find a way to run GRUB afterwards=
.
> >  But would a similarly minimal OF implementation (no network, almost no
> > interpret so no Forth, device tree built entirely in the host, etc.)
> > be just as big and slow?
>
> I doubt. We will be getting rid of unnecessary drivers, bus scanning
> code (SCSI, PCI), device tree synchronization.
>

What I mean is, if you write a firmware that exposes a minimal OF device
interface but runs it in the guest, and does a hypercall for everything
else, would it be as big and slow as SLOF?

Paolo

>
>
> --
> Alexey
>
>

--000000000000462e97059db3d69a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 3 feb 2020, 23:36 Alexey Kardashevskiy &lt;<a h=
ref=3D"mailto:aik@ozlabs.ru">aik@ozlabs.ru</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><br>&gt; What partition formats would have to b=
e supported? <br>
<br>
MBR, GPT, is there anything else? &quot;Support&quot; is limited to convert=
ing a<br>
number after command to [start, size] couple. I am not going for file<br>
systems.<br>
<br>
&gt; But honestly I&#39;m<br>
&gt; more worried about the networking part.<br>
<br>
Fair enough.<br>
<br>&gt; Yes, SLOF is big and slow.=C2=A0 petitboot is not petit at all eit=
her, and<br>
&gt; has the disadvantage that you have to find a way to run GRUB afterward=
s.<br>
&gt;=C2=A0 But would a similarly minimal OF implementation (no network, alm=
ost no<br>
&gt; interpret so no Forth, device tree built entirely in the host, etc.)<b=
r>&gt; be just as big and slow?<br>
<br>
I doubt. We will be getting rid of unnecessary drivers, bus scanning<br>
code (SCSI, PCI), device tree synchronization.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">What I mean is, if you write =
a firmware that exposes a minimal OF device interface but runs it in the gu=
est, and does a hypercall for everything else, would it be as big and slow =
as SLOF?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
-- <br>
Alexey<br>
<br>
</blockquote></div></div></div>

--000000000000462e97059db3d69a--


