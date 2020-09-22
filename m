Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C6C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082362311C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7gHKhwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082362311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmLG-00054i-UC
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKmJq-0003nx-UU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKmJn-0003mF-Ax
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600796585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IhlAb44onkIfRQczQD5ghZM6yQK05EAEDZzsyO+aRlU=;
 b=W7gHKhwb5o/rqZ2WyGhQcYe887jROy+nvom6FK2GqGMUvfOprvz/xcTnDD4YyDAv55yq5n
 LUGD66d4hNqFvRf2CpWvUj38lpZu13pgnUDNDrhMVdhu+VB1BQPjYinyGUlGHUb/maaUAT
 zokoc4Yq23ObuHYNHqL0QupROng1VqE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-9pK3R6trMmiPuO5TxpjBVQ-1; Tue, 22 Sep 2020 13:43:03 -0400
X-MC-Unique: 9pK3R6trMmiPuO5TxpjBVQ-1
Received: by mail-ej1-f70.google.com with SMTP id hh10so6546412ejb.13
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IhlAb44onkIfRQczQD5ghZM6yQK05EAEDZzsyO+aRlU=;
 b=JpcPGQZwdygJFHqM+N+Tk9WGY6N5pcre5+tVdelfagwWYmq+qjIRgvikh+236bPA/N
 WlsQ94e0cT9V9+jgDPa5fbs3ZnvB28WDEADkUbtyEYtimgsIv54aQd1eo5F5qpp0Tngv
 4R214EevHqWjMEdadj9tE2L5N8wQwj1hJgXfs4g86LcqKy9j2tjkMONq6bnBexSG39k3
 X7c+cSRf5yqMstv0a4gVnk8Gk+M/AcyRv2eKFmWJued0afZq+OtxY0tL1t5ydlaQiI1a
 qn5xFONBPi6EloYHXNbN0Q2opsXyQta3Ljmy/i6Wykc+NL61ZXjkJvUKfyfcGBXCeHsA
 0ngA==
X-Gm-Message-State: AOAM533Es3j68xYYFCXw24aqdDmvkcwPwdCZ5+q6EhbsMRnBfRHkIeDv
 C1gmMXn7f/txlOW7KiUrnk5i1aRilyv0QvM1U3S8kxZb8wSInd4sOTKIrdabIG904GYNcShcJ62
 Xi772wym0JAFyhpjGUMFnsDujUpdo0ns=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr6025113ejb.121.1600796582145; 
 Tue, 22 Sep 2020 10:43:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmMTMlvtiK+KgWDToqGrIX7bmrff5rTSh2we2uCVv0uow+U79f3ThIfuN683jhBIGXFQC2z/2LsZNrFFxJxoY=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr6025092ejb.121.1600796581895; 
 Tue, 22 Sep 2020 10:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <1473173750-11761-1-git-send-email-marcel@redhat.com>
 <5362df9c-00f8-adab-ecd2-481a33e84687@redhat.com>
 <20160906184921-mutt-send-email-mst@kernel.org>
 <41dcdc9b-ba44-3dcf-78b2-72cade130766@redhat.com>
 <20160906221822-mutt-send-email-mst@kernel.org>
 <52fc397d-bd03-e8e7-fd82-61ad278db7c3@redhat.com>
 <20200922170333.GA57321@habkost.net>
 <f6f1d85c-c805-1164-3e0d-3ca5ede4d8ff@redhat.com>
 <20200922172933.GC57321@habkost.net>
In-Reply-To: <20200922172933.GC57321@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Sep 2020 19:42:50 +0200
Message-ID: <CABgObfYV6XV_nUNPEN1OGGjqNBi74Og8Z=ZcXb3ucROLQ6J7gw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] tests/acpi: speedup acpi tests
To: Eduardo Habkost <ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009f3c2e05afea7fc1"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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
Cc: "Mammedov, Igor" <imammedo@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009f3c2e05afea7fc1
Content-Type: text/plain; charset="UTF-8"

Unfortunately my remark on this patch was only for the irq0 override thing,
which is x86-specific. I think other architectures still need userspace
irqchip in some cases.

Paolo

Il mar 22 set 2020, 19:29 Eduardo Habkost <ehabkost@redhat.com> ha scritto:

> On Tue, Sep 22, 2020 at 07:17:24PM +0200, Paolo Bonzini wrote:
> > On 22/09/20 19:03, Eduardo Habkost wrote:
> > >>  I can remove kernel_irqchip=off once
> > >> apic irq0 override is assumed.
> > > [4 years later]
> > >
> > > Can we remove it now?  I couldn't find out if we can assume
> > > kvm_has_gsi_routing() is true everywhere, or just on a few
> > > architectures.
> >
> > Yes, we can.  Other architectures don't matter, what counts is that we
> > can require kvm_has_gsi_routing() == true on x86.
>
> Do we have other architectures where we can assume that?  I'm in
> the mood for deleting some code today.
>
> --
> Eduardo
>
>

--0000000000009f3c2e05afea7fc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Unfortunately my remark on this patch was only for the ir=
q0 override thing, which is x86-specific. I think other architectures still=
 need userspace irqchip in some cases.<div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 22 set 2020, 19:29 Eduardo Habkost &lt;<a href=
=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Tue, Sep 22, 2020 at 07:17:24PM +02=
00, Paolo Bonzini wrote:<br>
&gt; On 22/09/20 19:03, Eduardo Habkost wrote:<br>
&gt; &gt;&gt;=C2=A0 I can remove kernel_irqchip=3Doff once<br>
&gt; &gt;&gt; apic irq0 override is assumed.<br>
&gt; &gt; [4 years later]<br>
&gt; &gt; <br>
&gt; &gt; Can we remove it now?=C2=A0 I couldn&#39;t find out if we can ass=
ume<br>
&gt; &gt; kvm_has_gsi_routing() is true everywhere, or just on a few<br>
&gt; &gt; architectures.<br>
&gt; <br>
&gt; Yes, we can.=C2=A0 Other architectures don&#39;t matter, what counts i=
s that we<br>
&gt; can require kvm_has_gsi_routing() =3D=3D true on x86.<br>
<br>
Do we have other architectures where we can assume that?=C2=A0 I&#39;m in<b=
r>
the mood for deleting some code today.<br>
<br>
-- <br>
Eduardo<br>
<br>
</blockquote></div>

--0000000000009f3c2e05afea7fc1--


