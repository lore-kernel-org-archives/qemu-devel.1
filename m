Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408B3C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 08:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7E320757
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRRr55XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7E320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kETt7-0004Ig-GW
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 04:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kETsF-00038V-VE
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 04:48:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kETsE-0001Yy-5e
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 04:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599295717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8Bas457Gz5FNZRJqpw9ZdzGpZcQ4gPZ1vXNPDBOY1s=;
 b=YRRr55XLua+W2x0dGpC94ZzgwckWV829yPv8iPYPYwyX4E2rYZFAPhyZ93DBee2aUoFLnR
 LVuew4NYqqM2pJycrbTaZeBQNla2OGytaiADTGXYNeiTIKFWYm6vMXE9gbmDtdl3gjNPXp
 mCrZmDZX4KkrYlxPxZJXsOczPZGBhkw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-jTw9CfzXNhKJdY6smU74OQ-1; Sat, 05 Sep 2020 04:48:35 -0400
X-MC-Unique: jTw9CfzXNhKJdY6smU74OQ-1
Received: by mail-ed1-f69.google.com with SMTP id r9so3138688edi.9
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 01:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i8Bas457Gz5FNZRJqpw9ZdzGpZcQ4gPZ1vXNPDBOY1s=;
 b=Vxryj8mpne0RSgEq0719lq0hpTF6l4Ud6eAe0P99f9UDdaIKAnrqtZpRYFAojrt38r
 xeSlo3wMXc7vgxnq+VsCcz1BKFf+HYsOcqELIHiS871p+hffuD4B5iMhg8L69MYkztuf
 Miabtesw/d8k/WYz6k6+1BXjyzCO5zyC0MB0vfa128boV6q0yRHcb/V6Xtgo3kfeU35A
 Ca6dvAoM6WJ7NuusLANj64KpmLx4uMxHW4Q55I0/Qgh61zq5aEm/PdjxCuQ3bOayWt9b
 UGb0fcgSE+sXESsh0SyM03cG+TQv60a9C7H8MMAbKMj0cwGz7c6EgcWWOgmaSvpm1CpF
 F+sw==
X-Gm-Message-State: AOAM532XlSEZUhNjWiGOotwZ/g2ArfMwnzUH4vCLzavnY1iIx1ozR9Td
 UMYwbW51UDKc6kc2iNAhSr2IuYep+nuSABBZjYbvF/kCqPDfIG8KjzirZRpEef/ocbbpL5f5eqH
 G0gx8nICtRh6+LufJFr8rBouk5ySICAs=
X-Received: by 2002:a50:abc3:: with SMTP id u61mr12201380edc.129.1599295713894; 
 Sat, 05 Sep 2020 01:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLmIJehgOiwhkSxv3HxhBdfpD8Y2tlS0elWD7a2X+Wn7E55ZI8J3vi2bLR5+9JFxdMeIO+cI1H3Yt4GK+MBiI=
X-Received: by 2002:a50:abc3:: with SMTP id u61mr12201368edc.129.1599295713662; 
 Sat, 05 Sep 2020 01:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200905062333.1087-1-luoyonggang@gmail.com>
 <20200905062333.1087-2-luoyonggang@gmail.com>
 <e0746ca9-87a3-4873-6b83-075a6ee90ff6@redhat.com>
In-Reply-To: <e0746ca9-87a3-4873-6b83-075a6ee90ff6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 5 Sep 2020 10:48:22 +0200
Message-ID: <CABgObfYyOZCrNCycgB-9exJhob1EwJjhN5-3g=+nUQL0y10aYQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] Revert "configure: add --ninja option"
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e779d805ae8d0ccd"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 03:25:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 qemu-devel <qemu-devel@nongnu.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e779d805ae8d0ccd
Content-Type: text/plain; charset="UTF-8"

Il sab 5 set 2020, 10:29 Thomas Huth <thuth@redhat.com> ha scritto:

> On 05/09/2020 08.23, Yonggang Luo wrote:
> > This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  configure | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
>
> Please be a little bit more descriptive in the patch description: Why do
> you have to revert this patch?
>

It shouldn't be reverted yet. The Windows issue that required the
introduction of --ninja is now fixed in upstream Meson, but we shouldn't
include the fix in the meson submodule until it's part of a released
version. We can then bump the required version (hopefully 0.55.2) and
decide whether to remove --ninja.

That said, we might also want to use ninja instead of make in the future to
build QEMU (leaving make to do the orchestration of the submodules etc.),
which would let us remove ninjatool altogether. I am not sure if that is
going to happen anytime soon, but it should be taken into account before
deciding to remove --ninja.

Paolo

>

--000000000000e779d805ae8d0ccd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 5 set 2020, 10:29 Thomas Huth &lt;<a href=3D"ma=
ilto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On 05/09/2020 08.23, Yonggang Luo wrote:<br>
&gt; This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure | 16 +---------------<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 15 deletions(-)<br>
<br>
Please be a little bit more descriptive in the patch description: Why do<br=
>
you have to revert this patch?<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">It shouldn&#39;t be reverted yet. The Windows=
 issue that required the introduction of --ninja is now fixed in upstream M=
eson, but we shouldn&#39;t include the fix in the meson submodule until it&=
#39;s part of a released version. We can then bump the required version (ho=
pefully 0.55.2) and decide whether to remove --ninja.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">That said, we might also want to use ninja in=
stead of make in the future to build QEMU (leaving make to do the orchestra=
tion of the submodules etc.), which would let us remove ninjatool altogethe=
r. I am not sure if that is going to happen anytime soon, but it should be =
taken into account before deciding to remove --ninja.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000e779d805ae8d0ccd--


