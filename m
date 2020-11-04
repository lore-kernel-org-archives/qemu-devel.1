Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AFAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F31022384
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/L/zoUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F31022384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDvJ-0008Tp-Vw
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaDug-0007lp-D6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaDue-0001fR-NH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604477579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceiJjVJiuP39c7jvGZlPEkqo+iI/UIuc+xm9Ar02lws=;
 b=Y/L/zoUm+qPakX3VnLcOXVd8SVnXcxTyqrdBXjQKGDUE5pTpfXsq6K79NNncggBUOX+liu
 dw6Iib2phc5w4Gpc5v6seJL/YDVsMonf9L6ch4KCNKqxVoTTQBCT6wBaNgHnSkXMetpbT/
 I3Otu4rIoBvcLSIzZIWG+dthZ9E/FuA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-bozFZvUANseAKe3J3fdahQ-1; Wed, 04 Nov 2020 03:12:57 -0500
X-MC-Unique: bozFZvUANseAKe3J3fdahQ-1
Received: by mail-pg1-f197.google.com with SMTP id j5so13296895pgt.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ceiJjVJiuP39c7jvGZlPEkqo+iI/UIuc+xm9Ar02lws=;
 b=fzS4OuY1ZQjVVcAx1SVMt9TxnwVShldI8DYaH1RieJVIlogTTI7ZuPG6ZgTGp8ydTL
 TDFFfRbD+sCt1/b2RlTE7Kco2MWjhXizYAAu3W1aCBztNT1gLOpYAb0NMeHftj2RuU/p
 I4IMEcXQVETSp61uA78EH5rzTrgcwaP85FYFo1AnlY90kgFmxwhF+IfX5qmmC11VErqk
 dF3AEnrS0GMbJRHXSW2RNxjK228mb8Uiptr/bDGaf2Lla9kt9VhGzLuCpYMrqJ4tUeps
 /JLJ6R2JtiNV6FM0+0zsGEdjVESCL4BuyL41fnHxCvWmOvTqpE6WOAaPvKk4zM6wbgt9
 lDIw==
X-Gm-Message-State: AOAM5326tV/excO1GuVFXVq3GW77DsDy53gVz0TmxnNymofmK3KDcVth
 YMavaPZ9Ooljzgmy7vZvsbwee66WOXqrbPS/wKSlQ90gnDiVGOUhFGeECp8dhHEa1VXzmLymFIA
 0E/HIvJpkG87/uq6/9WsLiK8GzImoD5U=
X-Received: by 2002:a17:90b:783:: with SMTP id
 l3mr3441368pjz.122.1604477576584; 
 Wed, 04 Nov 2020 00:12:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9VEpGaTs4FobVdmURAavhmVrSlcOVxSA8lQRAnf6DR3hx+8yKl8lKQ0FpfM8iza8JMrUtTBW+D3SUMqpvPJM=
X-Received: by 2002:a17:90b:783:: with SMTP id
 l3mr3441336pjz.122.1604477576301; 
 Wed, 04 Nov 2020 00:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <21e90ddb-fe8a-c780-2741-9b7a2f7f1c9a@redhat.com>
 <alpine.DEB.2.21.2011031722100.3264@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2011031722100.3264@sstabellini-ThinkPad-T480s>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Nov 2020 09:12:43 +0100
Message-ID: <CABgObfaAH1fty0y0Z10GALnhy4kL_FqSxPZc2-=PwJgtSrOX0g@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Stefano Stabellini <sstabellini@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fca6bd05b3438b08"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fca6bd05b3438b08
Content-Type: text/plain; charset="UTF-8"

Il mer 4 nov 2020, 03:27 Stefano Stabellini <sstabellini@kernel.org> ha
scritto:

> FYI I tried to build the latest QEMU on Alpine Linux 3.12 ARM64 and I
> get:
>
>   ninja: unknown tool 'query'
>
> Even after rebuilding ninja master by hand. Any ideas? I don't know much
> about ninja.
>

Are you sure you have ninja installed and not its clone samurai (yes, I am
serious)? I have contributed query support to samurai but it hasn't made it
to a release yet.

What is the output of "ninja -t list"?

Paolo


>
> So I gave up on that and I spinned up a Debian Buster x86 container for
> this build. That one got past the "ninja: unknown tool 'query'" error.
> The build completed without problems to the end.
>
> Either way I can't reproduce the build error above.

--000000000000fca6bd05b3438b08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 4 nov 2020, 03:27 Stefano Stabellini &lt;<a hre=
f=3D"mailto:sstabellini@kernel.org">sstabellini@kernel.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">FYI I tried to build the latest=
 QEMU on Alpine Linux 3.12 ARM64 and I<br>
get:<br>
<br>
=C2=A0 ninja: unknown tool &#39;query&#39;<br>
<br>
Even after rebuilding ninja master by hand. Any ideas? I don&#39;t know muc=
h<br>
about ninja.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Are you sure you have ninja installed and not its clone samurai=
 (yes, I am serious)? I have contributed query support to samurai but it ha=
sn&#39;t made it to a release yet.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">What is the output of &quot;ninja -t list&quot;?</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
<br>
So I gave up on that and I spinned up a Debian Buster x86 container for<br>
this build. That one got past the &quot;ninja: unknown tool &#39;query&#39;=
&quot; error.<br>
The build completed without problems to the end.<br>
<br>
Either way I can&#39;t reproduce the build error above.</blockquote></div><=
/div></div>

--000000000000fca6bd05b3438b08--


