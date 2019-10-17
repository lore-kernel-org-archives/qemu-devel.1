Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9746FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9526721835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoXEWvL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9526721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL848-0006Cv-I1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Dz-0006Zd-45
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Dx-0003X0-VC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7Dx-0003Wg-PD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:57:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id 89so2109112oth.13
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UO8y+iLdG9g2V4CwYbvIhKno0T8jlsZTKpOiMonsgII=;
 b=aoXEWvL8/r6DsnGg4Pzz8TVq1YVKHkv8Ridi7m0t88Ze9/gpMrEhhEoSgOSTQ+fWJ7
 kFrnwtwYFQEi+i4qQY5V+gfhzw72t9dUC75mMmsNEDCNiT6EJrJTMZaPw0V6ghyWjzca
 z8Vd6IUvshIipGtbu5Kd6G2oKZgbYVP16C4Y4OVM8tN1yuqVwr6cYA/kthPcOW5qJI1T
 Tn++LIs4hZJOV9T5q/cWKpLAmybTeN8B7Rl7NwSzF6YbjMldW+idzBGC6QOMfBl+txUZ
 AbdfQ9mWnHDr0VEguPg6Q9gn8SIiidEaSeIqeuEn0pEDncWqAHKnS7BUXOASPS8t/eNd
 3/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UO8y+iLdG9g2V4CwYbvIhKno0T8jlsZTKpOiMonsgII=;
 b=HnguCgthReG8zfQlr+wib8lbhon2SfSGZMqf64EyTEJrzzxrZi+m4iAwmB5FFSN5WP
 gvMi67zuQVV1h+bxw0j1pI+BEqCK5HvM716BNJgbFM2AziweESiUOZiY6ElW3/HcCnFl
 9N4/aNruLw5Gf5/lDK5ukibYAUAsnDP2qAdCVF5MKvS6ChLm43DtOYVjIegYdeE0X8D5
 vE0k8RG1m/oq0wvw6a8fE4RLeeNfP5ajbv0TWZpvT/7jCezTwbm+VpXpl9Lr7LByvJqw
 f8CuY0BnXRDwYRi7CQi6O10FSQERlRr1ibibpDMt7uuXHk8qT0+rpXBXAyYx3ZKbc8l1
 qsww==
X-Gm-Message-State: APjAAAWfrNhMMYm+47WWIB5GqVhjlumR1zYKnGSeE7ugzvVUsvxSt8K3
 qP3M7BP+XRPv0fjU6ygs38yynBK6xchYe2ZV1P4=
X-Google-Smtp-Source: APXvYqwWAe+vSjSgjnG+5YAXfAGJX878tAPFljp8f/R9dQSCsB1wmfCOPr/krIrieBGxbclPDXbcwlgf6NAkmGruHdg=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr3341811oth.306.1571324276848; 
 Thu, 17 Oct 2019 07:57:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:57:56
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-3-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-3-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:57:56 +0200
Message-ID: <CAL1e-=iC9hR-jqTSu9c6KtgiNWFwftnTMq9W87NWFPb37hjCoA@mail.gmail.com>
Subject: Re: [PATCH 02/32] hw/i386/pc: Move kvm_i8259_init() declaration to
 sysemu/kvm.h
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000593e2905951c7108"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000593e2905951c7108
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> Move the KVM-related call to "sysemu/kvm.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/hw/i386/pc.h | 1 -
>  include/sysemu/kvm.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
>
Is there any other similar case in our code base?

A.



> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6df4f4b6fb..09e74e7764 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -158,7 +158,6 @@ typedef struct PCMachineClass {
>
>  extern DeviceState *isa_pic;
>  qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);
> -qemu_irq *kvm_i8259_init(ISABus *bus);
>  int pic_read_irq(DeviceState *d);
>  int pic_get_output(DeviceState *d);
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 9d143282bc..da8aa9f5a8 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -513,6 +513,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s,
> qemu_irq irq, int gsi);
>  void kvm_pc_gsi_handler(void *opaque, int n, int level);
>  void kvm_pc_setup_irq_routing(bool pci_enabled);
>  void kvm_init_irq_routing(KVMState *s);
> +qemu_irq *kvm_i8259_init(ISABus *bus);
>
>  /**
>   * kvm_arch_irqchip_create:
> --
> 2.21.0
>
>
>

--000000000000593e2905951c7108
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Move the KVM-related call to &quot;sysemu/kvm.h&quo=
t;.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/hw/i386/pc.h | 1 -<br>
=C2=A0include/sysemu/kvm.h | 1 +<br>
=C2=A02 files changed, 1 insertion(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div>Is there any other similar case in our=
 code base?</div><div><br></div><div>A.</div><div><br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
index 6df4f4b6fb..09e74e7764 100644<br>
--- a/include/hw/i386/pc.h<br>
+++ b/include/hw/i386/pc.h<br>
@@ -158,7 +158,6 @@ typedef struct PCMachineClass {<br>
<br>
=C2=A0extern DeviceState *isa_pic;<br>
=C2=A0qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq);<br>
-qemu_irq *kvm_i8259_init(ISABus *bus);<br>
=C2=A0int pic_read_irq(DeviceState *d);<br>
=C2=A0int pic_get_output(DeviceState *d);<br>
<br>
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h<br>
index 9d143282bc..da8aa9f5a8 100644<br>
--- a/include/sysemu/kvm.h<br>
+++ b/include/sysemu/kvm.h<br>
@@ -513,6 +513,7 @@ void kvm_irqchip_set_qemuirq_gsi(<wbr>KVMState *s, qemu=
_irq irq, int gsi);<br>
=C2=A0void kvm_pc_gsi_handler(void *opaque, int n, int level);<br>
=C2=A0void kvm_pc_setup_irq_routing(bool pci_enabled);<br>
=C2=A0void kvm_init_irq_routing(KVMState *s);<br>
+qemu_irq *kvm_i8259_init(ISABus *bus);<br>
<br>
=C2=A0/**<br>
=C2=A0 * kvm_arch_irqchip_create:<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000593e2905951c7108--

