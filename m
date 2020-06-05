Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C57C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:36:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3B32074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDiX/Wye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3B32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh6uF-0008Rf-JL
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jh6tL-00078z-IO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:35:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jh6tK-0004F5-BX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sB0i7KEIh4wgv/kT6S1E2zFFRqUl6X4DgwaGJDk8R0w=;
 b=iDiX/WyeutvdtodWvI/jEiw8Aq+DpjzEjjr/+KKB29DWNc/DTDHk9EbPHCDAZCSiwUC6Ha
 bte5/AUdLao2LyVShlNgljPsKxUgjb0lzNVqIIZOKCFrbt6lsIVOYAz/3cgFrQ2Fxc5AL3
 M4+pgwdr8NtrlJ39K6HJNoj+8kAlN8c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-9OppqKemMYiti8IIglcDuw-1; Fri, 05 Jun 2020 03:35:46 -0400
X-MC-Unique: 9OppqKemMYiti8IIglcDuw-1
Received: by mail-ej1-f72.google.com with SMTP id m19so3207152ejd.21
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sB0i7KEIh4wgv/kT6S1E2zFFRqUl6X4DgwaGJDk8R0w=;
 b=DFIddv+ppKhqbmd+Hk63JoS5on486mph5N/vntZip2uoQZ0sEHWvSCsaWnkCGPhHsf
 I1HzUjDOPh+fyhpQ76Rsz2LuOdr/jXsNvm+LhvzFwN/bV9gwXVbzTNhcJH0wPWjseS4i
 GGSYM7EXbeqyvBLIrHYGk/QCQRUZvR+vs/12vt4Jzdze2EEWCmigkh0sj3d0SYi7b581
 UWjXD+/AfsSijRKKo9AY6fDLfrikaOwu1/iwdmcAI6azsYW2DGsUoF6E4bUApq8J+3uz
 H95p/MVRNsKeZJ58J7HurEA2pIe+wiMKNWmaH7bdBYPrGwE8W6cjP7+GS5dH0RILOnyr
 mUaw==
X-Gm-Message-State: AOAM531gwhnI1ynd8jSNbZVSiKHtHVq32gyVhMorbaeBCOwqwN/CkSW6
 rhlobWtLcdzAok4TRfdKQ5DNAqYqOTZ5LkrBUMTRSXfNqv2vfREWleCI4b8fDxTYOqX5WMhHr2y
 OH2cVPvXmhnM6dF72+PtH65E5ll9BnBU=
X-Received: by 2002:a17:906:370a:: with SMTP id
 d10mr7369212ejc.433.1591342545680; 
 Fri, 05 Jun 2020 00:35:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/uvNZ1qEk59hWbZEL5aU4XjugYc3mY90A51OVWjYzky0pqGpgIEliCeCF5j9+l55rXewRtppCu+p9Vqv7tTo=
X-Received: by 2002:a17:906:370a:: with SMTP id
 d10mr7369200ejc.433.1591342545430; 
 Fri, 05 Jun 2020 00:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200604224148.2536-1-pbonzini@redhat.com>
 <20200605092814.086db16b.cohuck@redhat.com>
In-Reply-To: <20200605092814.086db16b.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jun 2020 09:35:33 +0200
Message-ID: <CABgObfZ7c4Kj5_ic+CaOGpFwAVs_i98TCV1sKGAgGh1M3aqogg@mail.gmail.com>
Subject: Re: [PATCH] linux-headers: update to Linux 5.8-rc1
To: Cornelia Huck <cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000023019305a7514fd1"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000023019305a7514fd1
Content-Type: text/plain; charset="UTF-8"

Il ven 5 giu 2020, 09:28 Cornelia Huck <cohuck@redhat.com> ha scritto:

> On Thu,  4 Jun 2020 18:41:48 -0400
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Isn't it still a bit early for -rc1? :) Probably wants a commit id...
>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  include/standard-headers/asm-x86/kvm_para.h |  17 ++-
> >  include/standard-headers/drm/drm_fourcc.h   | 140 ++++++++++++++++++--
> >  include/standard-headers/linux/ethtool.h    |  16 ++-
> >  linux-headers/asm-arm/unistd-common.h       |   1 +
> >  linux-headers/asm-arm64/mman.h              |   8 ++
> >  linux-headers/asm-generic/unistd.h          |   4 +-
> >  linux-headers/asm-mips/unistd_n32.h         |   1 +
> >  linux-headers/asm-mips/unistd_n64.h         |   1 +
> >  linux-headers/asm-mips/unistd_o32.h         |   1 +
> >  linux-headers/asm-powerpc/unistd_32.h       |   1 +
> >  linux-headers/asm-powerpc/unistd_64.h       |   1 +
> >  linux-headers/asm-s390/unistd_32.h          |   1 +
> >  linux-headers/asm-s390/unistd_64.h          |   1 +
> >  linux-headers/asm-x86/kvm.h                 |  20 ++-
> >  linux-headers/asm-x86/unistd.h              |  11 +-
> >  linux-headers/asm-x86/unistd_32.h           |   1 +
> >  linux-headers/asm-x86/unistd_64.h           |   1 +
> >  linux-headers/asm-x86/unistd_x32.h          |   1 +
> >  linux-headers/linux/kvm.h                   |  18 ++-
> >  linux-headers/linux/psp-sev.h               |   2 +
> >  20 files changed, 224 insertions(+), 23 deletions(-)
>
> There will be more (e.g. on the vfio side); anything in particular you
> need this update for?
>

I need it for nested AMD live migration and page ready interrupts
(basically the KVM bits), but I can post it again when rc1 is really done.

Paolo


>

--00000000000023019305a7514fd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 5 giu 2020, 09:28 Cornelia Huck &lt;<a href=3D"=
mailto:cohuck@redhat.com">cohuck@redhat.com</a>&gt; ha scritto:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">On Thu,=C2=A0 4 Jun 2020 18:41:48 -0400<br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
<br>
Isn&#39;t it still a bit early for -rc1? :) Probably wants a commit id...<b=
r>
<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 include/standard-headers/asm-x86/kvm_para.h |=C2=A0 17 ++-<br>
&gt;=C2=A0 include/standard-headers/drm/drm_fourcc.h=C2=A0 =C2=A0| 140 ++++=
++++++++++++++--<br>
&gt;=C2=A0 include/standard-headers/linux/ethtool.h=C2=A0 =C2=A0 |=C2=A0 16=
 ++-<br>
&gt;=C2=A0 linux-headers/asm-arm/unistd-common.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-arm64/mman.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 ++<br>
&gt;=C2=A0 linux-headers/asm-generic/unistd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 linux-headers/asm-mips/unistd_n32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-mips/unistd_n64.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-mips/unistd_o32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-powerpc/unistd_32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-powerpc/unistd_64.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-s390/unistd_32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-s390/unistd_64.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-x86/kvm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 20 ++-<br>
&gt;=C2=A0 linux-headers/asm-x86/unistd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
&gt;=C2=A0 linux-headers/asm-x86/unistd_32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-x86/unistd_64.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/asm-x86/unistd_x32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 linux-headers/linux/kvm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 ++-<br>
&gt;=C2=A0 linux-headers/linux/psp-sev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 20 files changed, 224 insertions(+), 23 deletions(-)<br>
<br>
There will be more (e.g. on the vfio side); anything in particular you<br>
need this update for?<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I need it for nested AMD live migration and page ready=
 interrupts (basically the KVM bits), but I can post it again when rc1 is r=
eally done.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
</blockquote></div></div></div>

--00000000000023019305a7514fd1--


