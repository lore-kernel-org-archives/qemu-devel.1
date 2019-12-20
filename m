Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7DFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EE221655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwqwpzU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiKNs-0001Io-Qk
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 10:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iiKNH-0000rt-9S
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iiKNE-0000RF-3F
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:39:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iiKND-0000Pl-VL
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 10:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576856366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5gtgAbpBYgOB4pxz86Va3aJ0avkTlQUsFdHI0cgBRc=;
 b=RwqwpzU3emosiCJpVy9/92w2YID3Qn+LSMV2crx3paXc99BtgnqZpOlQuIqfxtkT9TTDEu
 jMq/C8plCn7csiPCT4q4EsQe4mkdkuT+rM6JXS7FohCgZtyXLSUZiY6yGbFYmCkJx41KTf
 36pux/IY6n/4AjfRhMBRHQtja2ECZXQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-YQ3StpM_P7qn-T4VXBjPGA-1; Fri, 20 Dec 2019 10:39:24 -0500
Received: by mail-ed1-f70.google.com with SMTP id cy24so3845472edb.12
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 07:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZNOGi6D8Z2v5GvuunSizo/nTz3VMeb7awNsthN4DHbw=;
 b=BFQOHjH1uNvCBHF5rWSnsKYYWUwjk78LGHODKhiXGBJTOXt07EbO0/ZmTpj8oD6/3S
 ETi+RxwpAqRQm13I7KEWBRIYVARf0diRR6eeMrO8IvPIUXgqPS+b1TbsZyoFzO3nMp/P
 ADrQC3FsdiIe+stnozdUtTf7YPO+lgSm3rqRLxkHkSA+4g7tdMzuIMPYn4FHp7nFAeVa
 O57+ipdGa4qM0cNFL+E/9zmNFgCd3BUHkfqdY7byPsUNqygLw9IDqcyAUJBnJb5aeSzU
 KEzJDZ+kqnYOUd+a2BqeB3I89eIK3rYFU/+oYLDxAQwPpuOw+nFp8hr3WQ7xmtw+VMx4
 QXwA==
X-Gm-Message-State: APjAAAXvGBH1zyFXPBVF+PUdJ2R3zZSt/5mzi4l56fxRwWpHhAvnFAEp
 /n+0cmzVeDVkMsUd46mIIZ3NIRXfIE9DvEhRoTPASswz942ks3gTH1BtW7dgqcqBMmnLTX0zvrK
 zmrKhrHcx9YiWTZDBJY8viKBvEMtsjZY=
X-Received: by 2002:a05:6402:c9c:: with SMTP id
 cm28mr16461692edb.88.1576856363859; 
 Fri, 20 Dec 2019 07:39:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuZGRu3e2kaEIGY3HNxVjXe7imrQDMzA6m386yfCVSar+kFgEA0YBlX3RnBId4Qpxd0pA18e5JwtmaWsKIBUg=
X-Received: by 2002:a05:6402:c9c:: with SMTP id
 cm28mr16461674edb.88.1576856363636; 
 Fri, 20 Dec 2019 07:39:23 -0800 (PST)
MIME-Version: 1.0
References: <87eewz84ts.fsf@vitty.brq.redhat.com>
In-Reply-To: <87eewz84ts.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Dec 2019 16:39:11 +0100
Message-ID: <CABgObfbKM_QNXJaAk7m2JYOoZgAAa+98d2x3==eYUkTi_CGw6Q@mail.gmail.com>
Subject: Re: [BUG] No irqchip created after commit 11bc4a13d1f4 ("kvm: convert
 "-machine kernel_irqchip" to an accelerator property")
To: Vitaly Kuznetsov <vkuznets@redhat.com>
X-MC-Unique: YQ3StpM_P7qn-T4VXBjPGA-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="0000000000006ab95e059a247b28"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006ab95e059a247b28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, absolutely not. I was sure I had tested it, but I will take a look.

Paolo

Il ven 20 dic 2019, 15:11 Vitaly Kuznetsov <vkuznets@redhat.com> ha scritto=
:

> I apologize if this was already reported,
>
> I just noticed that with the latest updates QEMU doesn't start with the
> following configuration:
>
> qemu-system-x86_64 -name guest=3Dwin10 -machine pc,accel=3Dkvm -cpu
> host,hv_vpindex,hv_synic ...
>
> qemu-system-x86_64: failed to turn on HyperV SynIC in KVM: Invalid argume=
nt
> qemu-system-x86_64: kvm_init_vcpu failed: Invalid argument
>
> If I add 'kernel-irqchip=3Dsplit' or ',kernel-irqchip=3Don' it starts as
> usual. I bisected this to the following commit:
>
> commit 11bc4a13d1f4b07dafbd1dda4d4bf0fdd7ad65f2 (HEAD, refs/bisect/bad)
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Wed Nov 13 10:56:53 2019 +0100
>
>     kvm: convert "-machine kernel_irqchip" to an accelerator property
>
> so aparently we now default to 'kernel_irqchip=3Doff'. Is this the desire=
d
> behavior?
>
> --
> Vitaly
>
>

--0000000000006ab95e059a247b28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">No, absolutely not. I was sure I had te=
sted it, but I will take a look.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Il ven 20 dic 2019, 15:11 Vitaly Kuznetsov &lt;<a href=3D"m=
ailto:vkuznets@redhat.com" target=3D"_blank" rel=3D"noreferrer">vkuznets@re=
dhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I apol=
ogize if this was already reported,<br>
<br>
I just noticed that with the latest updates QEMU doesn&#39;t start with the=
<br>
following configuration:<br>
<br>
qemu-system-x86_64 -name guest=3Dwin10 -machine pc,accel=3Dkvm -cpu host,hv=
_vpindex,hv_synic ...<br>
<br>
qemu-system-x86_64: failed to turn on HyperV SynIC in KVM: Invalid argument=
<br>
qemu-system-x86_64: kvm_init_vcpu failed: Invalid argument<br>
<br>
If I add &#39;kernel-irqchip=3Dsplit&#39; or &#39;,kernel-irqchip=3Don&#39;=
 it starts as<br>
usual. I bisected this to the following commit:<br>
<br>
commit 11bc4a13d1f4b07dafbd1dda4d4bf0fdd7ad65f2 (HEAD, refs/bisect/bad)<br>
Author: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Nov 13 10:56:53 2019 +0100<br>
<br>
=C2=A0 =C2=A0 kvm: convert &quot;-machine kernel_irqchip&quot; to an accele=
rator property<br>
<br>
so aparently we now default to &#39;kernel_irqchip=3Doff&#39;. Is this the =
desired<br>
behavior?<br>
<br>
-- <br>
Vitaly<br>
<br>
</blockquote></div></div>

--0000000000006ab95e059a247b28--


