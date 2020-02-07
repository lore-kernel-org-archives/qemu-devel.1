Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD62C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB04620715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIaP9rsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB04620715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02td-0008Gt-UQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j02t4-0007pt-CM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j02t1-0002rX-SX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:37:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22401
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j02t1-0002nx-Fn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581079050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QeV/Qr2Lfj9NloxhCHxOR3x6GnZUSnUmwShjJj9Luxc=;
 b=PIaP9rsjIkv0/eP2HYG2ir3Ox7UsoAkRg8vxTDCf9tOjHUFtRYO/mdlxDvTJfdK9WFo1H8
 OdRo+5exLSqFGuK3Bpnwdr/DfACJZrcrisMJq6EtzLzx1ZRRV3x7Q24h2/y8/WJSiEmM7y
 oNqOHLMOJRDeLFMatxU7hLDCShidBQM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-_IIDsYsIPjyiOyRXE0hoeA-1; Fri, 07 Feb 2020 07:37:22 -0500
Received: by mail-ed1-f72.google.com with SMTP id l4so1753836edn.20
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 04:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gjnWxdyHAWauA/5p22pV1+Ic4L1SkSWJnNNm6Nj8qZU=;
 b=Suel/qN26U7zgzt0Ivqp7tnIrH/hdIkeWOlG44sIY70ILXc832cjcQS14IeM2VZHnj
 DWLgW+865L+TFhtFWpmXxQGV8f5mbIBS4giczUG8tRb5ODAURvY8QSMjYGjFH6K3IRm7
 qTBnvQSOL+I2eoxzLwT2Hv8y7pm76clQQ20UMzoxYpeGq6z2eaqkiqCgS0p/5kqyZBKE
 NLCvtQW29R7f3uLXnx3U8MilfH5olkVGGFNKMohb1n/TNte7Wwhpc7ck/NSBmiMH/m4A
 z3lvnFUyVGTchAKbNQuK3ZeNOgm4PCLJsJCwyOO9uXszFKFPDVNc9bD1QXptWi+liST8
 0Wlg==
X-Gm-Message-State: APjAAAWmFAstaVJknhaSGQQGZ/CS2gcGr9reb/gHDkcwEu4RvGG39LzP
 Iem91kLKrOP7R2EIueL75xvMq8TuZAc4N2qYxGqEqp9owdFRpxkhOAtuL0EfyjQL2U/dpA0src6
 gqgMuiXQdxe7j8iCUW2Fjl1sY2Rs/huU=
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr7400887edv.296.1581079041580; 
 Fri, 07 Feb 2020 04:37:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSHCrs3rLsfR0UowcM+ws5Lpx7ZVMRZxcZOllCI+ffU4TcRvTP+uIi6Xl70gyXZE+2vYWyPzPSHYFlBLUauhI=
X-Received: by 2002:aa7:ce13:: with SMTP id d19mr7400878edv.296.1581079041381; 
 Fri, 07 Feb 2020 04:37:21 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
In-Reply-To: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Feb 2020 13:37:08 +0100
Message-ID: <CABgObfYP4qYPoCVW7sq0OxoJgLUQdZATr-YfywoqM55r_bc=OA@mail.gmail.com>
Subject: Re: should we have a new 'tools' manual?
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: _IIDsYsIPjyiOyRXE0hoeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009fb16d059dfba60b"
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009fb16d059dfba60b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure. However I would keep qemu-ga in interop/.

Paolo

Il ven 7 feb 2020, 12:50 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> So far we've been converting docs to Sphinx and assigning them
> to manuals according to the division originally set out by
> Paolo on the wiki: https://wiki.qemu.org/Features/Documentation
>
>  * QEMU User-mode Emulation User's Guide (docs/user)
>  * QEMU System Emulation User's Guide (docs/system)
>  * QEMU System Emulation Management and Interoperability Guide
> (docs/interop)
>  * QEMU System Emulation Guest Hardware Specifications (docs/specs)
>  * QEMU Developer's Guide (docs/devel, not shipped to end-users)
>
> but some of our documentation has always been a bit of an awkward
> fit into this classification:
>  * qemu-img
>  * qemu-nbd
>  * virtfs-proxy-helper
> etc. I've tended to put these things into interop/.
>
> The proposal from Dan and David was that we should add a sixth
> top-level manual
>  * QEMU Tools Guide (docs/tools)
>
> which would be a more coherent place for these to live.
>
> This seems like a good idea to me -- do people agree? What's
> our definition of a "tool", or do we just know one when we see it?
> What in particular should go in tools/ ?
>
> thanks
> -- PMM
>
>

--0000000000009fb16d059dfba60b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sure. However I would keep qemu-ga in interop/.<div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 7 feb 2020, 12:50 P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">So f=
ar we&#39;ve been converting docs to Sphinx and assigning them<br>
to manuals according to the division originally set out by<br>
Paolo on the wiki: <a href=3D"https://wiki.qemu.org/Features/Documentation"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://wiki.qemu.org/Feat=
ures/Documentation</a><br>
<br>
=C2=A0* QEMU User-mode Emulation User&#39;s Guide (docs/user)<br>
=C2=A0* QEMU System Emulation User&#39;s Guide (docs/system)<br>
=C2=A0* QEMU System Emulation Management and Interoperability Guide (docs/i=
nterop)<br>
=C2=A0* QEMU System Emulation Guest Hardware Specifications (docs/specs)<br=
>
=C2=A0* QEMU Developer&#39;s Guide (docs/devel, not shipped to end-users)<b=
r>
<br>
but some of our documentation has always been a bit of an awkward<br>
fit into this classification:<br>
=C2=A0* qemu-img<br>
=C2=A0* qemu-nbd<br>
=C2=A0* virtfs-proxy-helper<br>
etc. I&#39;ve tended to put these things into interop/.<br>
<br>
The proposal from Dan and David was that we should add a sixth<br>
top-level manual<br>
=C2=A0* QEMU Tools Guide (docs/tools)<br>
<br>
which would be a more coherent place for these to live.<br>
<br>
This seems like a good idea to me -- do people agree? What&#39;s<br>
our definition of a &quot;tool&quot;, or do we just know one when we see it=
?<br>
What in particular should go in tools/ ?<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div>

--0000000000009fb16d059dfba60b--


