Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6198AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD49206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkqB6r6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD49206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igvzK-0006ZK-7R
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1igvyU-0005px-Im
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1igvyR-0001GL-Al
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:24:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1igvyR-0001EX-6F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576524246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tRx3yfboFqYCOst/uqLCVk7NiHZ1ND7FfHVygV3k/A=;
 b=TkqB6r6oYMdo1RftAH7c1Bql+OCkRf5Tog0PE1Df1PuDN3rj3LsHWhQKKxPw+86dYhSSfH
 LfLNNtoFDSo++3sRvvWpoVXOjNMBKc0CPQD8euWwLsmxyjo3NHesxo5XYehcWB6z5rJwlS
 CPmGGYScLmA2rfNhMYR1IAnMloijSGE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-x2xUWiEtNTS7nK29QyiDSw-1; Mon, 16 Dec 2019 14:24:04 -0500
Received: by mail-ed1-f71.google.com with SMTP id b13so1473136edf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 11:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8tRx3yfboFqYCOst/uqLCVk7NiHZ1ND7FfHVygV3k/A=;
 b=nc8J6ZhRGlORT4l9eBfvXrQFkEf6Nc/o3rxe6LK3geJfx3ohur0R9nDTsXKDOaSHRM
 S5v61Ca93HdAClP6l5CyTVoh/3Pqmdl3jMj6X/y9SFgU1SLCMxf8h8GM9kW3nmVToQLm
 CzSRawBEqpD9TUmrqOtxKkp8RfYWOZ8ZYHlwL+r6AVYmfBy59xiR4TDc0YZhWQgkm/rn
 +9n379iC8LndJTKzOGIrQegSoCpTi2oxfYH81MkGuyigHdTYGNHxO1HfgcXcSOH7qKc5
 q/GeYvN6JdjIZ8s6hl/4HRwO5nDZfRCfWq6jaskppA0LJGDZW/9XeAIZ8bVw8klEyWrT
 N5pQ==
X-Gm-Message-State: APjAAAXAdsXB7rWdU9k0W+IrsKdCmz41eH1itlo/kXmlU9eZY7HABO3F
 mo6Fko5iiuE62dpkgamFp2gx5blShxIfv6TzFzLBcHNOLe6quAjW2rBLRdIfE5uQIj/YS+nXXvV
 SWLtD200JjUHmeRljFVvgeYyzJHPpfDs=
X-Received: by 2002:aa7:d9c6:: with SMTP id v6mr912208eds.107.1576524242705;
 Mon, 16 Dec 2019 11:24:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+BMy+erO9ecr3jHbJLE9NQCREdq7h7exg4LE5BXUH1/uUxx8d2dnl4wDXzfGmR8iqSdKANfYXt+Y5mzkqYeY=
X-Received: by 2002:aa7:d9c6:: with SMTP id v6mr912178eds.107.1576524242486;
 Mon, 16 Dec 2019 11:24:02 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR11MB4089A0B695CB84FB288068B89A540@DM6PR11MB4089.namprd11.prod.outlook.com>
 <2c28287e-1869-751d-f7c8-04605ef4b337@redhat.com>
 <d969066a-b10c-ebbc-b784-a19a66a5a831@redhat.com>
 <DM6PR11MB4089FF5F11BC215320EB502E9A510@DM6PR11MB4089.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB4089FF5F11BC215320EB502E9A510@DM6PR11MB4089.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Dec 2019 20:23:50 +0100
Message-ID: <CABgObfYLEov5YpYzsfD_WtGdnwbrr=vStpKY2+qHs0w+AVCAfQ@mail.gmail.com>
Subject: Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: Assertion
 `ret == cpu->kvm_msr_buf->nmsrs' failed.
To: "Montes, Julio" <julio.montes@intel.com>
X-MC-Unique: x2xUWiEtNTS7nK29QyiDSw-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000742d690599d7270b"
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000742d690599d7270b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
>
> > 1) running "vmxcap" on the Azure VM
>

You need to run "modprobe msr" before.

Paolo


>
> $ sudo ./vmxcap
> Basic VMX Information
> Traceback (most recent call last):
>   File "./vmxcap", line 280, in <module>
>     c.show()
>   File "./vmxcap", line 82, in show
>     value =3D msr().read(self.msr, 0)
>   File "./vmxcap", line 33, in __init__
>     self.f =3D open('/dev/msr0', 'rb', 0)
> IOError: [Errno 2] No such file or directory: '/dev/msr0'
>
> > 2) adding "-vmx-xsaves,-vmx-shadow-vmcs" to the "-cpu" option and, if i=
t
> > works, add only one of the two.
>
> nop, this didn't work
>
>
> > 3) if it doesn't work, adding "-vmx" to the "-cpu" option.  Either way,
> > run "x86info -a" in the resulting VM.
>
> yes, -vmx works
>
> x86info -a  ->  https://paste.centos.org/view/f88f02f4
>
>
> thanks
>
> -
> Julio
>
> ------------------------------
> *From:* Paolo Bonzini <pbonzini@redhat.com>
> *Sent:* Saturday, December 14, 2019 1:30 AM
> *To:* Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>; Montes, Julio <
> julio.montes@intel.com>; qemu-devel <qemu-devel@nongnu.org>
> *Cc:* Eduardo Habkost <ehabkost@redhat.com>
> *Subject:* Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000:
> Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
>
> On 14/12/19 02:31, Philippe Mathieu-Daud=C3=A9 wrote:
> >
> > failed to launch qemu: exit status 1, error messages from qemu log:
> > qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000
> > qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs:
> > Assertion `ret =3D=3D cpu->kvm_msr_buf->nmsrs' failed.
>
> It could be a KVM bug too.  The following features are being enabled:
>
> #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
> #define VMX_SECONDARY_EXEC_SHADOW_VMCS              0x00004000
> #define VMX_SECONDARY_EXEC_ENABLE_INVPCID           0x00001000
> #define VMX_SECONDARY_EXEC_RDRAND_EXITING           0x00000800
> #define VMX_SECONDARY_EXEC_ENABLE_VPID              0x00000020
> #define VMX_SECONDARY_EXEC_ENABLE_EPT               0x00000002
> #define VMX_SECONDARY_EXEC_DESC                     0x00000004
> #define VMX_SECONDARY_EXEC_RDTSCP                   0x00000008
>
> Can you try:
>
> 1) running "vmxcap" on the Azure VM
>
> 2) adding "-vmx-xsaves,-vmx-shadow-vmcs" to the "-cpu" option and, if it
> works, add only one of the two.
>
> 3) if it doesn't work, adding "-vmx" to the "-cpu" option.  Either way,
> run "x86info -a" in the resulting VM.
>
> Thanks,
>
> Paolo
>
>

--000000000000742d690599d7270b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr"><div style=3D"font-family:Calibri,Arial,Helvetica,sa=
ns-serif;font-size:12pt;color:rgb(0,0,0)"><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">1) running &quot;vmxca=
p&quot; on the Azure VM</span></font></div></div></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">You need to run &quot;modprobe=
 msr&quot; before.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-fami=
ly:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<span><br>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<span>$ sudo ./vmxcap <br>
</span>
<div>Basic VMX Information<br>
</div>
<div>Traceback (most recent call last):<br>
</div>
<div>=C2=A0 File &quot;./vmxcap&quot;, line 280, in &lt;module&gt;<br>
</div>
<div>=C2=A0 =C2=A0 c.show()<br>
</div>
<div>=C2=A0 File &quot;./vmxcap&quot;, line 82, in show<br>
</div>
<div>=C2=A0 =C2=A0 value =3D msr().read(self.msr, 0)<br>
</div>
<div>=C2=A0 File &quot;./vmxcap&quot;, line 33, in __init__<br>
</div>
<div>=C2=A0 =C2=A0 self.f =3D open(&#39;/dev/msr0&#39;, &#39;rb&#39;, 0)<br=
>
</div>
<span>IOError: [Errno 2] No such file or directory: &#39;/dev/msr0&#39;</sp=
an><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
&gt; <font size=3D"2"><span style=3D"font-size:11pt">2) adding &quot;-vmx-x=
saves,-vmx-shadow-vmcs&quot; to the &quot;-cpu&quot; option and, if it<br>
&gt; works, add only one of the two.<br>
</span></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
nop, this didn&#39;t work</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<font size=3D"2"><span style=3D"font-size:11pt">&gt; 3) if it doesn&#39;t w=
ork, adding &quot;-vmx&quot; to the &quot;-cpu&quot; option.=C2=A0 Either w=
ay,<br>
&gt; run &quot;x86info -a&quot; in the resulting VM.</span></font></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
yes, -vmx works</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
x86info -a=C2=A0 -&gt;=C2=A0 <a href=3D"https://paste.centos.org/view/f88f0=
2f4" id=3D"m_-2086736129460788907LPlnk201976" target=3D"_blank" rel=3D"nore=
ferrer">
https://paste.centos.org/view/f88f02f4</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
thanks</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
-</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Julio<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div id=3D"m_-2086736129460788907appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-2086736129460788907divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From:</b>=
 Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank"=
 rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<b>Sent:</b> Saturday, December 14, 2019 1:30 AM<br>
<b>To:</b> Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;; Montes=
, Julio &lt;<a href=3D"mailto:julio.montes@intel.com" target=3D"_blank" rel=
=3D"noreferrer">julio.montes@intel.com</a>&gt;; qemu-devel &lt;<a href=3D"m=
ailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noreferrer">qemu-deve=
l@nongnu.org</a>&gt;<br>
<b>Cc:</b> Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;<br>
<b>Subject:</b> Re: qemu-4.2: failed to set MSR 0x48b to 0x1582e00000000: A=
ssertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs&#39; failed.</font>
<div>=C2=A0</div>
</div>
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>On 14/12/19 02:31, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; <br>
&gt; failed to launch qemu: exit status 1, error messages from qemu log:<br=
>
&gt; qemu-system-x86_64: error: failed to set MSR 0x48b to 0x1582e00000000<=
br>
&gt; qemu-system-x86_64: /root/qemu/target/i386/kvm.c:2947: kvm_put_msrs:<b=
r>
&gt; Assertion `ret =3D=3D cpu-&gt;kvm_msr_buf-&gt;nmsrs&#39; failed.<br>
<br>
It could be a KVM bug too.=C2=A0 The following features are being enabled:<=
br>
<br>
#define VMX_SECONDARY_EXEC_XSAVES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x001000=
00<br>
#define VMX_SECONDARY_EXEC_SHADOW_VMCS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00004000<br>
#define VMX_SECONDARY_EXEC_ENABLE_INVPCID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00001000<br>
#define VMX_SECONDARY_EXEC_RDRAND_EXITING=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000800<br>
#define VMX_SECONDARY_EXEC_ENABLE_VPID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000020<br>
#define VMX_SECONDARY_EXEC_ENABLE_EPT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000002<br>
#define VMX_SECONDARY_EXEC_DESC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000004<br>
#define VMX_SECONDARY_EXEC_RDTSCP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x000000=
08<br>
<br>
Can you try:<br>
<br>
1) running &quot;vmxcap&quot; on the Azure VM<br>
<br>
2) adding &quot;-vmx-xsaves,-vmx-shadow-vmcs&quot; to the &quot;-cpu&quot; =
option and, if it<br>
works, add only one of the two.<br>
<br>
3) if it doesn&#39;t work, adding &quot;-vmx&quot; to the &quot;-cpu&quot; =
option.=C2=A0 Either way,<br>
run &quot;x86info -a&quot; in the resulting VM.<br>
<br>
Thanks,<br>
<br>
Paolo<br>
<br>
</div>
</span></font></div>
</div>

</blockquote></div></div></div>

--000000000000742d690599d7270b--


