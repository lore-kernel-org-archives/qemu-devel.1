Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938CFC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5905520678
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAAN1sLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5905520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZFy-0001mY-Gb
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDZFL-0000y9-Lj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:20:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDZFI-0008V3-V5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599078039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL79QYx21qN4gppXt2hnNlxyyc43mk1q5mGBupbqJhM=;
 b=DAAN1sLbV7Ejrqniv/nl0JAChPq+5NVVaLdoR48yRwqFxwDpfR4X5hrx598Zo9MenylSMJ
 ZpOrqYcZtkXk6re6A9aEVoS3WgNTAAKImIvQiid9bX+ccpkPQO+c0psMkaBNhG8v0gRsUu
 Q9gZDmEsZyRuw9yAXbIx5/QLq604VVo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-wShzbiQVM7ywQaBGtzj46g-1; Wed, 02 Sep 2020 16:20:36 -0400
X-MC-Unique: wShzbiQVM7ywQaBGtzj46g-1
Received: by mail-ej1-f71.google.com with SMTP id w27so137420ejb.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 13:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kL79QYx21qN4gppXt2hnNlxyyc43mk1q5mGBupbqJhM=;
 b=suHUhzndM+2O2NMm/o+QPm7/essyxD/Y3zALwFGwg/pEdVwMdRDQ+CvotzIvWQ25q5
 t7h3aQ09W0FQrpdMN9IrEFpaa08vokpaiD7T+iNRCRUBR45U6lsHmvxN7aANRsTspgDy
 Wh1VRqBpKDKxzIC+qN3ufpStzgckBrFsaK22ZUjKBVVT7lgtdML1e7lQ5yiMsLf3qf6W
 VXIVKcUR25TCn3ZIT4zlieQs4fEwiWx6OqZI18+IwIwylRpnmoJjKryuJUdAx5x2xf1l
 D0a13uxIQOOiJmOzHIRtbno9EahD7Ms+Tpjd6uKPeQLA87WM9FMweAi6f2+G76GK5EsO
 Kwwg==
X-Gm-Message-State: AOAM532e/QuGok9F2LGy+mtJptS4MAqRTCmsbeiKL6SbZhpmTV/0+9AV
 VG2mlGLIj+7iMooATLmOe1kNPpI23AXdKJ6NQqXQ+UWZeKJEuz/mx6MyJQ0h/xevE3pu5qWJgUm
 AzJ9VrdSTncLAErct+K1DsSr2OesIHCc=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr1745311ejb.121.1599078035630; 
 Wed, 02 Sep 2020 13:20:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3WpsqnuBlsu14yLrZaJEiktwwb5cQAsqrKy83SZMD1I0L/gg8NKxBuaY+hl0T0A2Q/7fvxdHasfvbbqj7EDU=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr1745298ejb.121.1599078035399; 
 Wed, 02 Sep 2020 13:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
 <CABgObfYcaCsZNYof9nd7gzCOY_6qN5MV+xD6dw7W4D4ircsdaQ@mail.gmail.com>
 <7516c253-0448-b5cd-18a0-45caaebc1d05@ilande.co.uk>
 <0db09727-a909-71db-3628-4edb3ce87f2b@redhat.com>
 <76488c26-a3a7-be05-01ec-b29985ab29e7@ilande.co.uk>
 <25b47439-05da-5cb5-f9d8-65e453e00275@redhat.com>
 <e8a5a43c-63af-485b-39b1-9414e7a4f721@ilande.co.uk>
In-Reply-To: <e8a5a43c-63af-485b-39b1-9414e7a4f721@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Sep 2020 22:20:23 +0200
Message-ID: <CABgObfbECnVhU+R4nkREi=OqrXfdeAPcg4XrRdA_+huEh3APyw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Make QEMU installation relocatable
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000044c2ad05ae5a5ee1"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:20:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000044c2ad05ae5a5ee1
Content-Type: text/plain; charset="UTF-8"

Il mer 2 set 2020, 20:45 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> On 02/09/2020 13:16, Paolo Bonzini wrote:
>
> > On 02/09/20 13:42, Mark Cave-Ayland wrote:
> >> The main issues I can see are that the .exe files end up under
> /msys64/qemu
> >> and the ROMs end up directly under /qemu rather than in $DESTDIR/share.
> >
> > This series doesn't try to change the layout; it only makes it possible
> > to do so (because QEMU is now able to look for ROMs relative to the
> > executable).
> >
> > Just to be on the same page, how did you run "configure"?
>
> Ah okay. It was something simple like:
>
> ./configure --target-list="ppc-softmmu" --ninja=ninja
> make V=1 DESTDIR=/home/Mark/rel-qemu-git install


That msys64 in the installation prefix is strange though. Can you send the
content of meson-logs directory?

Paolo

--00000000000044c2ad05ae5a5ee1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 2 set 2020, 20:45 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 02/09/2020 13:1=
6, Paolo Bonzini wrote:<br>
<br>
&gt; On 02/09/20 13:42, Mark Cave-Ayland wrote:<br>
&gt;&gt; The main issues I can see are that the .exe files end up under /ms=
ys64/qemu<br>
&gt;&gt; and the ROMs end up directly under /qemu rather than in $DESTDIR/s=
hare.<br>
&gt; <br>
&gt; This series doesn&#39;t try to change the layout; it only makes it pos=
sible<br>
&gt; to do so (because QEMU is now able to look for ROMs relative to the<br=
>
&gt; executable).<br>
&gt; <br>
&gt; Just to be on the same page, how did you run &quot;configure&quot;?<br=
>
<br>
Ah okay. It was something simple like:<br>
<br>
./configure --target-list=3D&quot;ppc-softmmu&quot; --ninja=3Dninja<br>
make V=3D1 DESTDIR=3D/home/Mark/rel-qemu-git install</blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">That msys64 in the installa=
tion prefix is strange though. Can you send the content of meson-logs direc=
tory?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div di=
r=3D"auto"></div></div>

--00000000000044c2ad05ae5a5ee1--


