Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECEC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE57206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbDqJt6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE57206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYbFR-0007Bs-0n
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYbDq-0006TS-Df
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYbDo-0001ei-3v
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604090523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aA+Z/ohyF/Xaz4RGR1v3fIUg0Rh/SxgBog9dsKiz+Dk=;
 b=JbDqJt6Okore5xy4azjd8xfcN05WwF9f34Mm5SINwd8kiaCHPPU9lKiPsXdCA1mBhg103l
 b3dPjKSc2KI7Vn4E7O0THIxsQhLW0nc7CcLx5oVTqIPYN/GQ+QB5DO7/9tP5sa7qiYstPA
 BXYgvMZ9lQ3V+EXZo4Vw60qXWQkMOzM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-q4k6_nQHOOip1nNPA2hDjg-1; Fri, 30 Oct 2020 16:42:01 -0400
X-MC-Unique: q4k6_nQHOOip1nNPA2hDjg-1
Received: by mail-pg1-f198.google.com with SMTP id e16so5427075pgm.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 13:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aA+Z/ohyF/Xaz4RGR1v3fIUg0Rh/SxgBog9dsKiz+Dk=;
 b=MSQDdjImwsLODX4ypyPJ37moG6a9oecF8OLOgWFLuwv6JdIkWZCA1d9AxhzfRJQcjR
 56kiplVpesWvgJIPGaZ3WYphrjwWP4N4jPf2evKTdpEWeywZOuySg/XDHCJvlOEWl/d/
 6DU8/m4nd3DHjaO5KINBen4EVmg7bAHzEWOAhk3P4FhmcRUk049Qlsd7GwVl7i+9BcYN
 z0spPY7WFg/vv2G3ZfVK96uOY8ZHG3Us5FlN1mzPNUuLpKcwXxGl60Fq4pJSPFa9dtBK
 Gg+6igW6AoEKaELYW/B2NUdN8QEsvW/7d3zcTgPum/BZFekjcSQySK5G4uECFlf1RlH/
 mAtg==
X-Gm-Message-State: AOAM533SEdD1drFhrJeQh8uBeHnsTa/sE5/L3+hp4l5Brp5WSZPZadxn
 wHJFmy1dgdJaLHIGenAMFDIu08KTXi1l/rEFt5V/XSpBd0fliLKt2VFlPwZmq3OrY5DIKY+CDGP
 kNVHqR0HAqxtcEzSpStj9m1z1hwHsTDo=
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr3654820pgi.281.1604090519133; 
 Fri, 30 Oct 2020 13:41:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWHZFBsqiTDCX6slLRC5hNSFcodM3bpvel6dQmgG3UWDFbIzw5pRK818FMkqCIwhNwI4wYo4U1cJnbZrC6hUs=
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr3654800pgi.281.1604090518872; 
 Fri, 30 Oct 2020 13:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-35-ehabkost@redhat.com>
 <ae632c6e-017b-e0e6-0cb2-9ace77a13ff9@redhat.com>
 <20201030200348.GQ5733@habkost.net>
In-Reply-To: <20201030200348.GQ5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 30 Oct 2020 21:41:46 +0100
Message-ID: <CABgObfa5Yt=Si7i0ohhYQdMSzGqj5QEnMmTpO7MsCds0fgW_Mg@mail.gmail.com>
Subject: Re: [PATCH 34/36] machine: Use DEFINE_PROP_STRING for string
 properties
To: Eduardo Habkost <ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000090c25605b2e96da2"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 16:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000090c25605b2e96da2
Content-Type: text/plain; charset="UTF-8"

Il ven 30 ott 2020, 21:03 Eduardo Habkost <ehabkost@redhat.com> ha scritto:

> >     OBJECT_CLASS_PROPERTY_ADD_STR(oc, MachineState, kernel_filename,
> >                                   "kernel", prop_allow_set_always);
>
> I like the idea of having an interface like this, but I would
> like to avoid having to write even more boilerplate for each
> property type to make this work.
>
> What would you think of:
>    OBJECT_CLASS_PROPERTY_ADD(oc,
>        PROP_STRING("kernel", MachineState, kernel_filename),
>        prop_allow_set_always);
>
> Then we could make the same PROP_STRING macro usable both as
> object_class_property_add_static() argument and as initializer
> for existing static Property arrays.
>

The name should be an argument to OBJECT_CLASS_PROPERTY_ADD though (which
could be a function and not  macro; perhaps
object_class_property_add_field?). PROP_STRING would be
DEFINE_PROP_STRING(NULL, etc.) and would not be entirely reusable in
Property arrays.

But even with that snag I agree with your less-boilerplate argument against
my proposal.

Since most if not all device properties would have to specify the same
allow-set function, we would end up defining more macros
DEVICE_CLASS_PROPERTY_ADD_STR, and so on. If the Property isbpassed a
struct, instead, we can define just one wrapper
device_class_property_add_field.

So what about:

1) add new constructors without the DEFINE prefix and without the name
argument

2) add object_class_property_add_field

And later:

3) add device_class_property_add_field and remove dc->props

4) remove the name field from Property.

Paolo


> --
> Eduardo
>
>

--00000000000090c25605b2e96da2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 30 ott 2020, 21:03 Eduardo Habkost &lt;<a href=
=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0OBJECT_CLASS_P=
ROPERTY_ADD_STR(oc, MachineState, kernel_filename,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;kernel&quot;, =
prop_allow_set_always);<br>
<br>
I like the idea of having an interface like this, but I would<br>
like to avoid having to write even more boilerplate for each<br>
property type to make this work.<br>
<br>
What would you think of:<br>
=C2=A0 =C2=A0OBJECT_CLASS_PROPERTY_ADD(oc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0PROP_STRING(&quot;kernel&quot;, MachineState, ke=
rnel_filename),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0prop_allow_set_always);<br>
<br>
Then we could make the same PROP_STRING macro usable both as<br>
object_class_property_add_static() argument and as initializer<br>
for existing static Property arrays.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">The name should be an argument to=C2=
=A0<span style=3D"font-family:sans-serif">OBJECT_CLASS_PROPERTY_ADD though =
(which could be a function and not=C2=A0 macro; perhaps object_class_proper=
ty_add_field?). PROP_STRING would be DEFINE_PROP_STRING(NULL, etc.) and wou=
ld not be entirely reusable in Property arrays.</span></div><div dir=3D"aut=
o"><span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto=
"><span style=3D"font-family:sans-serif">But even with that snag I agree wi=
th your less-boilerplate argument against my proposal.</span></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif"><br></span></div><div dir=
=3D"auto"><span style=3D"font-family:sans-serif">Since most if not all devi=
ce properties would have to specify the same allow-set function, we would e=
nd up defining more macros DEVICE_CLASS_PROPERTY_ADD_STR, and so on. If the=
 Property isbpassed a struct, instead, we can define just one wrapper devic=
e_class_property_add_field.</span></div><div dir=3D"auto"><span style=3D"fo=
nt-family:sans-serif"><br></span></div><div dir=3D"auto"><span style=3D"fon=
t-family:sans-serif">So what about:</span></div><div dir=3D"auto"><span sty=
le=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><span styl=
e=3D"font-family:sans-serif">1) add new constructors without the DEFINE pre=
fix and without the name argument</span></div><div dir=3D"auto"><span style=
=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"><span style=
=3D"font-family:sans-serif">2) add object_class_property_add_field</span></=
div><div dir=3D"auto"><span style=3D"font-family:sans-serif"><br></span></d=
iv><div dir=3D"auto"><span style=3D"font-family:sans-serif">And later:</spa=
n></div><div dir=3D"auto"><span style=3D"font-family:sans-serif"><br></span=
></div><div dir=3D"auto"><span style=3D"font-family:sans-serif">3) add devi=
ce_class_property_add_field and remove dc-&gt;props</span></div><div dir=3D=
"auto"><span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"=
auto"><span style=3D"font-family:sans-serif">4) remove the name field from =
Property.</span></div><div dir=3D"auto"><span style=3D"font-family:sans-ser=
if"><br></span></div><div dir=3D"auto"><span style=3D"font-family:sans-seri=
f">Paolo</span></div><div dir=3D"auto"><span style=3D"font-family:sans-seri=
f"><br></span></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
-- <br>
Eduardo<br>
<br>
</blockquote></div></div></div>

--00000000000090c25605b2e96da2--


