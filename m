Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599442076E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 18:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWXQTS3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599442076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQacf-0007cf-75
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 14:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQabD-0006zI-5G
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQab9-000836-Jb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 14:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602181501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ne98uLzPKzhhXgXRUqC2Ijj8KBiA/uZiCD8YS7BFpE4=;
 b=bWXQTS3lsC4A0KTXiONKtAGSg0sbo2V6j8DmvxhKwU0npfkea1SDKI4eKBSdQZxmyNYuXN
 Cb0iSNXNj1JoF1WLCn64BmYg4JIzSTYz1uNCcsptx/lJfuOYd0dF+CqSeZFlsEFcRaFx9w
 yqm+kHa85hG/ImRyCFCDIOp0EWtufHg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-9_cXpq2jPwqbdFQ6O3IapQ-1; Thu, 08 Oct 2020 14:24:59 -0400
X-MC-Unique: 9_cXpq2jPwqbdFQ6O3IapQ-1
Received: by mail-ej1-f71.google.com with SMTP id ga21so2557992ejb.14
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 11:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ne98uLzPKzhhXgXRUqC2Ijj8KBiA/uZiCD8YS7BFpE4=;
 b=Nd+pdLMydbPCMD45dt0q8axPgGWo20OlIYsMclDt0tlWkYjxeai+jjHXO7UeFWj02f
 2i9ReI4VtQ6EUwPioi1wVZFSH1klA0lYebjm9rwYenGSrSwdMkesSdDxFOiKpZ9/sajB
 Y63rcBwKv/PKVfD7z6c8DIox/pg3wuYpQeyTj8YCQ4F6535U+1ILx/OwpHAbyFIZXCOP
 BzOYQlFfszdlSjLGW8qgQ5nHfwwmMP4x1Yl+sUXQkHPEolq0EDMdcCCiDI5RKE9n+Dda
 O6A8DcsqoD5TuCQ+plJm3ASy97pA8nmZ75ilL0D1ulFZMrBo7m9jsh+z8SeeY4/5aPsU
 c3vQ==
X-Gm-Message-State: AOAM532hZ2FUOI1Eujob61E9mVv1sdS1Qcj7hySdqpOzI00uLBMTrh9h
 zaRzwruoZhNuAE0YZvBK0tqRC9dMhPovyTn8hypwxHhDsPm1NLoxJCxpxCHT50r4LXaZqrJ9hCQ
 sLCdu4fMLG/rVCctsJoYSTQwGoxtkdZo=
X-Received: by 2002:aa7:d9c9:: with SMTP id v9mr10570771eds.103.1602181497857; 
 Thu, 08 Oct 2020 11:24:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLPxJJW9WnPOAtyEJN+o9vt/yMotAr6OnNLW9qJXsk2hvt5vI13W53+B9a1BN+kR1FFqT8peXEm2oN3vB63DQ=
X-Received: by 2002:aa7:d9c9:: with SMTP id v9mr10570754eds.103.1602181497639; 
 Thu, 08 Oct 2020 11:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <11ef73ff-4178-b3e8-2e49-44ff014a13ed@suse.de>
 <569520f6-adf6-6212-9625-a184bf499e24@redhat.com>
 <d21dff22-90b1-4769-0948-6bc37eaeb885@linaro.org>
 <6fe91a5a-c136-9af3-c48a-97ccdca7a543@suse.de>
 <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
In-Reply-To: <3c527b0f-afa1-4b86-4fa5-9acca2a296bd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Oct 2020 20:24:45 +0200
Message-ID: <CABgObfYWK2E8PsSFOcHpuA2vuA3HWgvtuLbrtQCWA=9=r07=5w@mail.gmail.com>
Subject: Re: does make check now require TCG? Or is it a parallelism issue?
To: Richard Henderson <richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000008773e05b12cf349"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Alex Bennee <alex.bennee@linaro.org>, Claudio Fontana <cfontana@suse.de>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000008773e05b12cf349
Content-Type: text/plain; charset="UTF-8"

Il gio 8 ott 2020, 20:05 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> Ah, TARGET_DIRS isn't being pruned anymore when a target is disabled for
> lack
> of accelerator.
>
> Paolo, side effect of 8a19980e3f ("configure: move accelerator logic to
> meson")?  I guess we should move the setting of TARGET_DIRS to meson as
> well.
>

TARGET_DIRS is pruned by Meson, I didn't add any back propagation to make
because it is not really needed; qemu-iotests only every uses the "host
architecture" QEMU binary (see tests/qemu-iotests/common.config),
check-block + --target-list has never worked.

check-tcg could use the pruned TARGET_DIRS, but it is of limited use anyway
with --disable-tcg.

At this point it may make sense to establish which config-host.mak
variables are available in the Makefile, because there's probably just a
handful. I won't have much time in the next couple of weeks though.

Paolo


> r~
>
>

--00000000000008773e05b12cf349
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 8 ott 2020, 20:05 Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ah, TARGET_DIRS isn&=
#39;t being pruned anymore when a target is disabled for lack<br>
of accelerator.<br>
<br>
Paolo, side effect of 8a19980e3f (&quot;configure: move accelerator logic t=
o<br>
meson&quot;)?=C2=A0 I guess we should move the setting of TARGET_DIRS to me=
son as well.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">TARGET_DIRS is pruned by Meson, I didn&#39;t add any back propa=
gation to make because it is not really needed; qemu-iotests only every use=
s the &quot;host architecture&quot; QEMU binary (see tests/qemu-iotests/com=
mon.config), check-block + --target-list has never worked.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><span style=3D"font-family:sans-serif">c=
heck-tcg could use the pruned TARGET_DIRS, but it is of limited use anyway =
with --disable-tcg.</span><br></div><div dir=3D"auto"><span style=3D"font-f=
amily:sans-serif"><br></span></div><div dir=3D"auto"><span style=3D"font-fa=
mily:sans-serif">At this point it may make sense to establish which config-=
host.mak variables are available in the Makefile, because there&#39;s proba=
bly just a handful. I won&#39;t have much time in the next couple of weeks =
though.</span></div><div dir=3D"auto"><span style=3D"font-family:sans-serif=
"><br></span></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000008773e05b12cf349--


