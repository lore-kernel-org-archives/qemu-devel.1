Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6FDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4607D206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc7C+IpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4607D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIM8-00065G-EL
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHpW-0004XC-M9
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:42:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHpU-0003uX-W0
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+WAwotAy68UUoWChwPDe7d1tI8AOGVg1p8qlVWWa2Y=;
 b=Lc7C+IpDcGYheZEVbwoH7IqTa+eC1imeJHKpaxFUY6JE90qjbI4BzLquR1J5PHyPpaerQk
 ++FTUPWvcGFl51AE26IpwjzkWZ5OcbgNuT9l+acXULiO3VJMFa7fADDw/mhZT4rfmm2TCO
 +if6ulxl/aNk3E4tVbc57p5r1ACXMUo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-4ovaCZ4QPgOIJwUbpVTw7g-1; Wed, 08 Jul 2020 14:41:31 -0400
X-MC-Unique: 4ovaCZ4QPgOIJwUbpVTw7g-1
Received: by mail-ej1-f69.google.com with SMTP id cf15so44563286ejb.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 11:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7+WAwotAy68UUoWChwPDe7d1tI8AOGVg1p8qlVWWa2Y=;
 b=dYw1e+VxFGaWiVtAa+2HMX5ebrk/ypXtGQGIlbYlEbhKyWFfTQjES/1MgiCTEMtRC2
 BpHVQ7IxzWjF1WZ4EJOm8HNbEe7q2RpvPbrzWunNhIATzeEYpbZ9918U/tXRCg/5/553
 e7KopIkbd7IEUQZg6xI0AC+mY+0KicI7pC0cDTCGPmh4vYlKOqY80J5Jte+hp27WzUX/
 4xzvWn3CbQUtkifdvb7+pXIt2VuFUBJzhhFIZJZ4C7wZUm7yEMLY/pLIWlvCSAv+I1ve
 k2k8cf1bjYCNPMHmL+LRHabwaS71OuFg3BpzOSMZ353N1qX8oUl4vCwT08Vxk13njtGR
 EIyg==
X-Gm-Message-State: AOAM533VCI7mOJvUSa45J1lLJ8Aeki9hhQEr++gRdDOA/IH+nn8grtMZ
 5Kd39D8jVb6TxYvqnToC8I8KCRTP6AdIcxVnQ0CmfJfA7kYnyWVUIziWGnTkwVpDAM0/Ty9TfYn
 KcVGelMP6VaxiVGmZWPn+doSD3uMwhtQ=
X-Received: by 2002:a17:906:5657:: with SMTP id
 v23mr54690178ejr.196.1594233690071; 
 Wed, 08 Jul 2020 11:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmeMf5hFTyo/lpUv49Csts1upu35yhEmMo7zelt5HsQo/4YwZKK6U/vyjIvNDKG7PFczLZ+BmzbWWyShov57k=
X-Received: by 2002:a17:906:5657:: with SMTP id
 v23mr54690162ejr.196.1594233689831; 
 Wed, 08 Jul 2020 11:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
 <1a9ad36f-f4ae-2ea5-3d69-03aa5580b60e@suse.de>
 <de27589f-6afb-b8cf-05a0-f5d34f9d2a58@redhat.com>
 <f17ca47d-f5e9-e710-5edb-9d92839ee7c1@suse.de>
 <56c7e153-e47b-aa5c-80c0-ab4f5c3d85e8@redhat.com>
 <57c79f36-4cf9-6188-ef40-b4f775add83d@suse.de>
 <0a3ab45d-468a-65f2-5b9d-440a0a950ded@suse.de>
In-Reply-To: <0a3ab45d-468a-65f2-5b9d-440a0a950ded@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Jul 2020 20:41:18 +0200
Message-ID: <CABgObfZA4+7q9+mg2NTXQC1f+usEsF0sXaNVt0+ursiJ4rAS=A@mail.gmail.com>
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Claudio Fontana <cfontana@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000c5a09c05a9f274cb"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c5a09c05a9f274cb
Content-Type: text/plain; charset="UTF-8"

Il mer 8 lug 2020, 20:25 Claudio Fontana <cfontana@suse.de> ha scritto:

> What I did notice is that all the code that directly or indirectly uses
> the functions is under an
>
> if (0) (
> )
>
> since tcg_enabled is the constant 0.
>
> By "indirectly" I mean that the static void qemu_tcg_cpu_thread_fn()
> function that calls those is referenced only by static void
> qemu_tcg_init_vcpu(), which is called only under an if (0),
> ie if (tcg_enabled()).
>

Maybe my compiler is older.

I admit I am not familiar with the rationale of why the stubs are all built
> regardless, could we have that icount.o from stubs/ is replacing
> softmmu/icount.o to cause this?
>

No, stubs are in a static library and therefore are always overridden by
symbols in the executable's .o files.

Paolo


> Thanks,
>
> Claudio
>
>
>
>

--000000000000c5a09c05a9f274cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 8 lug 2020, 20:25 Claudio Fontana &lt;<a href=
=3D"mailto:cfontana@suse.de">cfontana@suse.de</a>&gt; ha scritto:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">What I did notice is that all the code that =
directly or indirectly uses the functions is under an<br>
<br>
if (0) (<br>
)<br>
<br>
since tcg_enabled is the constant 0.<br>
<br>
By &quot;indirectly&quot; I mean that the static void qemu_tcg_cpu_thread_f=
n() function that calls those is referenced only by static void qemu_tcg_in=
it_vcpu(), which is called only under an if (0),<br>
ie if (tcg_enabled()).<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Maybe my compiler is older.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">I admit I am not familiar with the rationale of why the stubs are =
all built regardless, could we have that icount.o from stubs/ is replacing =
softmmu/icount.o to cause this?<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">No, stubs are in a static library and theref=
ore are always overridden by symbols in the executable&#39;s .o files.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Thanks,<br>
<br>
Claudio<br>
<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000c5a09c05a9f274cb--


