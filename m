Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B8C433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 06:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EA123117
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 06:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsJd5691"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EA123117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA5tT-0001vX-C7
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 02:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kA5sx-0001WA-Ca
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 02:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kA5su-0006LI-Et
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 02:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598250190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1k+gsSrw1hOot6VIt+qKOyFUuI0gIp9KEQNdnhu2oM=;
 b=YsJd5691JgITOZ8xtWhyWtfD9C32SewglYFCpAt/SyMOxWfl9See5l9XMa04pde9/ffC58
 dtrXOOxpKByvRCdAszcv+Nsgv7vHHwQB02ppTnOaHkaI0WjeOfp8B8LNBzDlIVo1XRc6Mp
 TiG8IE0r9fni8NVezV4gR8GDS3RPwtM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-u_kCpbvgNry5L7KNZ2LgCw-1; Mon, 24 Aug 2020 02:23:08 -0400
X-MC-Unique: u_kCpbvgNry5L7KNZ2LgCw-1
Received: by mail-ed1-f70.google.com with SMTP id z11so2890837edj.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 23:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y1k+gsSrw1hOot6VIt+qKOyFUuI0gIp9KEQNdnhu2oM=;
 b=CMSBR2vJurJijR4E3LrOWOkcmOGkoY/1h/SGYecJzYDKtk7tf238ibF7rEtyuNS0w0
 HqaQf+0OAKyFIZOCi5t8ajyayVlPAkQeSpruxc+7k1nWAZj9F9gXwcALKvVp/bV/w7I1
 O+UUY6JWtmYp4hXe4UG72J5h+fBBhAtcVQA/PQ8hyMRGHsVHZsbTLV1L9oNQN0sUJtQZ
 uUohIK67sCpZdYTzem74UBk4+h00sLWpu5GA1coUosv/8ADA7UlM9f+q2RvTucldxIb3
 TgWLpjs4WbgNyvEO8xPrpr5S/Ovrg1uGXeHE4nJhbjKptb1JJUPmiw1h1v523TKYqEk5
 eW2w==
X-Gm-Message-State: AOAM532J33Gc7z93Cz2bi0h5OF6y2gc2zb161OG4LKJ3mN+sOn5ZP0Ir
 oqVb/YFA+NdBTRaz1gSLfyRoagD0dWkhl1l00PYHfUfHOMQqYD1BL+mb4ymFzlhKL3FnA4vdV6u
 jNp6sErlviav1kQz4I+bMKF8242CC8tQ=
X-Received: by 2002:a17:906:3390:: with SMTP id
 v16mr4032710eja.106.1598250187066; 
 Sun, 23 Aug 2020 23:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdD2rlZDaAmfGVB1H7RCyjbcgOunkTsO3FxF4+iPh203vIaiPIj1h36Sn8RT4XFgNvndcCa4NOOiq3JEB0snQ=
X-Received: by 2002:a17:906:3390:: with SMTP id
 v16mr4032687eja.106.1598250186768; 
 Sun, 23 Aug 2020 23:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200821160752.1254102-1-philmd@redhat.com>
 <20200821160752.1254102-2-philmd@redhat.com>
 <20200824052336.gt7ycmo7wf6q5e2m@sirius.home.kraxel.org>
In-Reply-To: <20200824052336.gt7ycmo7wf6q5e2m@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Aug 2020 08:22:54 +0200
Message-ID: <CABgObfYjPOZaEXCxu-8eKaNDAW=xhD+z8SwS2eJ+5wMamb629g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] meson: convert pc-bios/keymaps/Makefile
To: Gerd Hoffmann <kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a516ae05ad999e7c"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 02:23:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a516ae05ad999e7c
Content-Type: text/plain; charset="UTF-8"

I think it should just add build_by_default: false with a comment
explaining why.

Paolo

Il lun 24 ago 2020, 07:23 Gerd Hoffmann <kraxel@redhat.com> ha scritto:

> > --- a/pc-bios/meson.build
> > +++ b/pc-bios/meson.build
> > @@ -25,3 +25,4 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
> >  endif
> >
> >  subdir('descriptors')
> > +subdir('keymaps')
>
> Hmm, this hooks up the keymaps update to the default build.
> Not a good plan.  The output is not static, but defaults on
> the libxkbcommon version you have installed.  So I end up with
> a dirty tree now after each build.
>
> I guess we should either return to the traditional behavior of not
> building keymaps by default and have a "make keymaps" or similar for
> keymap updates.  Or write the generated maps to the build tree not
> the source tree.
>
> take care,
>   Gerd
>
>

--000000000000a516ae05ad999e7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I think it should just add build_by_default: false with a=
 comment explaining why.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">Il lun 24 ago 2020, 07:23 Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@=
redhat.com">kraxel@redhat.com</a>&gt; ha scritto:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">&gt; --- a/pc-bios/meson.build<br>
&gt; +++ b/pc-bios/meson.build<br>
&gt; @@ -25,3 +25,4 @@ if &#39;DECOMPRESS_EDK2_BLOBS&#39; in config_host<br=
>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 subdir(&#39;descriptors&#39;)<br>
&gt; +subdir(&#39;keymaps&#39;)<br>
<br>
Hmm, this hooks up the keymaps update to the default build.<br>
Not a good plan.=C2=A0 The output is not static, but defaults on<br>
the libxkbcommon version you have installed.=C2=A0 So I end up with<br>
a dirty tree now after each build.<br>
<br>
I guess we should either return to the traditional behavior of not<br>
building keymaps by default and have a &quot;make keymaps&quot; or similar =
for<br>
keymap updates.=C2=A0 Or write the generated maps to the build tree not<br>
the source tree.<br>
<br>
take care,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div>

--000000000000a516ae05ad999e7c--


