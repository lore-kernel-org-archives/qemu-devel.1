Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97BC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 08:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4FA206F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 08:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjoNxMhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4FA206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jI7HT-0001JE-Mw
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 04:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jI7Gj-0000uj-8k
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 04:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jI7Gh-0003TF-Hm
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 04:56:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jI7Gh-0003Rf-Dy
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 04:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585385798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldZnCcsoyxoN9mtKIs30hVQ/F6Zhg9D0hsJxvh+2d+E=;
 b=bjoNxMhzFX/B0sylYjF2XTAUVxWJe2OXv15xUkq730QEnNjeBSwdN8wnvNLdacR+wFdddJ
 qwMk3yrUFFh1/Gj44XhGe2rfYqGsHlnjxGPmGWQFCAeqwCBTHM/64QRxb1tvNafSvXp3k+
 3hSqAo6t0LNIAYk2EQAuhxuS+GqgE8g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-eOTAfTM1MDqmMQs4a6cHOA-1; Sat, 28 Mar 2020 04:56:36 -0400
X-MC-Unique: eOTAfTM1MDqmMQs4a6cHOA-1
Received: by mail-ed1-f70.google.com with SMTP id b9so10357057edj.10
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 01:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U12weAAsWTckt0DFTDhGoxAqlcvXq5oI60sk0iW3ih4=;
 b=YvUIiCh8gXzUo/0jQATMGI+MVzY6bBEouO19fXUODTa6bnIu8N0Q7BjwWGewCbFi63
 CY9v85UJrYZxPmv94ZREAgN63tz+m7WgZkzYaNpNxHR4GoFysBxD0RmohcYnAswBUw3j
 Rn+8Ul2onNHBB3EcCTxU3EBabMeeCs7YbXvjaR77aWAsXsE9iV5JeH4SjzPtQHnU6E4k
 MsMkNWzazX4dqBKA23ivdpTgEmhjGb++HHGeMY8k1l56fYb6nN9JLiepe4zwfPNF7weo
 oCeq/oNs0+wnvxq+7v566bOedPF+MpquG2G5iuXi3RZc7QUZ1TWe0xUBVNnIiNR32M75
 IMcA==
X-Gm-Message-State: ANhLgQ3y96p9c7yrkmYCJaRigW/anvHg6Xdt/RWRsC/70uLPKx8C36jW
 yTaFHzApUvs/eT2fPlUDvHOvxMoGSdb9n7PqCTymyYa5a/d7P9r63BudB/gnAnf51dRrrquIbZk
 zq1VLBx7fVfqOEAm3a0FhVART7F3sHnI=
X-Received: by 2002:a50:a9a6:: with SMTP id n35mr2856754edc.57.1585385792817; 
 Sat, 28 Mar 2020 01:56:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vufqcCpoMTbg2wSTIqdZmflcbT9HYYIGw5/aqM7yhm9QerzfTx8LBdrnTcrYfV22O/fzLaGrGU7F1FbvNaAvNU=
X-Received: by 2002:a50:a9a6:: with SMTP id n35mr2856742edc.57.1585385792625; 
 Sat, 28 Mar 2020 01:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200327151841.13877-1-olaf@aepfle.de>
 <90544ada-060e-169b-c0cb-94d869070d97@redhat.com>
 <20200328070906.GA7942@aepfle.de>
In-Reply-To: <20200328070906.GA7942@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 28 Mar 2020 09:56:20 +0100
Message-ID: <CABgObfarWVeWSznkOHP-WHQMNUGMUjcO_FSLEGb6pgfb3m8YNw@mail.gmail.com>
Subject: Re: [PATCH v4] piix: fix xenfv regression,
 add compat machine xenfv-qemu4
To: Olaf Hering <olaf@aepfle.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000000713605a1e665fc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000000713605a1e665fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nope, that's fine. If you are okay I can apply them myself.

Paolo

Il sab 28 mar 2020, 08:09 Olaf Hering <olaf@aepfle.de> ha scritto:

> On Fri, Mar 27, Paolo Bonzini wrote:
>
> > Looks good, I would just do the following adjustments to have more
> > consistency between pc and xenfv machine types
>
> Do you want me to resend with this change?
>
> Olaf
>
>

--00000000000000713605a1e665fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Nope, that&#39;s fine. If you are okay I can apply them m=
yself.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 28 ma=
r 2020, 08:09 Olaf Hering &lt;<a href=3D"mailto:olaf@aepfle.de">olaf@aepfle=
.de</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, Mar=
 27, Paolo Bonzini wrote:<br>
<br>
&gt; Looks good, I would just do the following adjustments to have more<br>
&gt; consistency between pc and xenfv machine types<br>
<br>
Do you want me to resend with this change?<br>
<br>
Olaf<br>
<br>
</blockquote></div>

--00000000000000713605a1e665fc--


