Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 19:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB7B20888
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 19:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJeLunh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB7B20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKoJV-0000Wh-TW
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 15:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKoIj-0008Re-Sv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 15:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKoIi-00045M-6a
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 15:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600804207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SrLuJhdWiNWGfUbdSxayls/11diifNRjILrmyk7c7AM=;
 b=LJeLunh1dgLkqkxdqEdOnNqNa2LPSCJUyxTUaG+BmqMHYfHoW2IyL41fNeyQTUDPycjLZw
 wGLX4B1OH31x2U9RBv3wMJVYY2X+CbzbGTutTy4t6djUM+wdZ+mEA9jV7rlW2zjeGisxXd
 P/YPWJ+/MHGhdfggR9Y5XrDuQBP8JXw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Fa1n7ljKN8KQrkwBDOrjbQ-1; Tue, 22 Sep 2020 15:50:03 -0400
X-MC-Unique: Fa1n7ljKN8KQrkwBDOrjbQ-1
Received: by mail-ej1-f69.google.com with SMTP id m24so6612679ejx.22
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 12:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrLuJhdWiNWGfUbdSxayls/11diifNRjILrmyk7c7AM=;
 b=cyoLq/rZWCVGbSKptKM2ASt2bf8DyWTIXZdBL5ghr44dSuK3+G/tVI2lQ8iLkcwh2z
 WXhJMxQfc+WRkOjYn5cgZwmLic8/BRfHfyX6hKWqgSbwWgparrnqALsEV7GKVEzJWr9P
 97bt3Kxhl3WlFB1qyVquCnSHdWDW+FLkN2/9XOyCxWFrNC8t2KZRlTq813pl+4/hVD80
 awJHSYy5HkjWmFrIGTD2mxE9vO25Q/Puu9102JLvOShBW+qsFzXleJADEzdUskA4WxRO
 qexh++CnpwUBu4EmEu32WFdRIU+GVm6mNpmQxEEAPj84vZfOxnZulN1kv7DL1yV5DUF9
 PAtg==
X-Gm-Message-State: AOAM532qhIfcWissviPwbT2bzRUr9yB//toOwhEt4xSAfcESF48gTRK5
 gg/NmXr2ZXL5MU6yIblXkScJJJBQm9Sa+yr3YL7Kqm827CEmSVK/cmODVnME+hrTSpa1+c+YSY1
 mLTPn7e+15vEgLQtNadEERGhbJSLDrLM=
X-Received: by 2002:a17:906:868c:: with SMTP id
 g12mr6320750ejx.230.1600804201930; 
 Tue, 22 Sep 2020 12:50:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw66bMeAspDMwVpjo8iSLAeRscANP5935AE9qB+u8kXBqNGXO4OfOu4ja7XivEHu53gPoDYQQVOtRC1/PdksXE=
X-Received: by 2002:a17:906:868c:: with SMTP id
 g12mr6320725ejx.230.1600804201730; 
 Tue, 22 Sep 2020 12:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200922151455.1763896-1-ehabkost@redhat.com>
 <87v9g5es9n.fsf@vitty.brq.redhat.com>
 <20200922161055.GY57321@habkost.net> <87pn6depau.fsf@vitty.brq.redhat.com>
 <20200922172229.GB57321@habkost.net>
 <b22127f4-9a68-99b8-bf55-b6ede236dee0@redhat.com>
 <20200922193903.GA2044576@habkost.net>
In-Reply-To: <20200922193903.GA2044576@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Sep 2020 21:49:48 +0200
Message-ID: <CABgObfasJBwoCAKaNPO0D=_USQv32rvBufU=occfOv09ch+odw@mail.gmail.com>
Subject: Re: [PATCH] i386: Don't try to set MSR_KVM_ASYNC_PF_EN if
 kernel-irqchip=off
To: Eduardo Habkost <ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000ccb2f805afec4556"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, 1896263@bugs.launchpad.net,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ccb2f805afec4556
Content-Type: text/plain; charset="UTF-8"

Il mar 22 set 2020, 21:39 Eduardo Habkost <ehabkost@redhat.com> ha scritto:

> On Tue, Sep 22, 2020 at 07:26:42PM +0200, Paolo Bonzini wrote:
> > On 22/09/20 19:22, Eduardo Habkost wrote:
> > > If it was possible, did KVM break live migration of
> > > kernel-irqchip=off guests that enabled APF?  This would mean my
> > > patch is replacing a crash with a silent migration bug.  Not nice
> > > either way.
> >
> > Let's drop kernel-irqchip=off completely so migration is not broken. :)
> >
> > I'm actually serious, I don't think we need a deprecation period even.
>
> I wasn't sure about this, but then I've noticed the man page says
> "disabling the in-kernel irqchip completely is not recommended
> except for debugging purposes."
>
> Does this note apply to all architectures?
>

At least on ARM, Raspberry Pi 4 cannot use kernel-irqchip=on at all. But
remember I am only talking about x86.

Paolo


> --
> Eduardo
>
>

--000000000000ccb2f805afec4556
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 22 set 2020, 21:39 Eduardo Habkost &lt;<a href=
=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Tue, Sep 22, 2020 at 07:26:42PM +02=
00, Paolo Bonzini wrote:<br>
&gt; On 22/09/20 19:22, Eduardo Habkost wrote:<br>
&gt; &gt; If it was possible, did KVM break live migration of<br>
&gt; &gt; kernel-irqchip=3Doff guests that enabled APF?=C2=A0 This would me=
an my<br>
&gt; &gt; patch is replacing a crash with a silent migration bug.=C2=A0 Not=
 nice<br>
&gt; &gt; either way.<br>
&gt; <br>
&gt; Let&#39;s drop kernel-irqchip=3Doff completely so migration is not bro=
ken. :)<br>
&gt; <br>
&gt; I&#39;m actually serious, I don&#39;t think we need a deprecation peri=
od even.<br>
<br>
I wasn&#39;t sure about this, but then I&#39;ve noticed the man page says<b=
r>
&quot;disabling the in-kernel irqchip completely is not recommended<br>
except for debugging purposes.&quot;<br>
<br>
Does this note apply to all architectures?<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">At least on ARM, Raspberry Pi 4 c=
annot use kernel-irqchip=3Don at all. But remember I am only talking about =
x86.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
-- <br>
Eduardo<br>
<br>
</blockquote></div></div></div>

--000000000000ccb2f805afec4556--


