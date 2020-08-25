Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E321AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8862071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAQYynu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8862071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATn8-00064F-En
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATkn-0003X8-AG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:52:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41510
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATkl-0004MT-MB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598341942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fl2ORnFcvbkoCXvyWPaId1VulsydZPh/fq5pHKiV2ko=;
 b=OAQYynu0Da0t79RqXG2dcStmKyTKCiPFrsLuRvDoFoFfs38lEUdMz9ij/8sDcDZCd42rcm
 CM00Cgq/r/iwvBcBFc2zcPjjrFQf9/5CFqOrNYQGHs73K6zSadWGdmzeoslIAut4NPQgkz
 MuvRzZZgtpwsxPjyLBgkYysOenIpf8A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-sPbY9E--Oz-c5_kI0iQs2Q-1; Tue, 25 Aug 2020 03:52:19 -0400
X-MC-Unique: sPbY9E--Oz-c5_kI0iQs2Q-1
Received: by mail-ed1-f70.google.com with SMTP id g20so4298727edj.15
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fl2ORnFcvbkoCXvyWPaId1VulsydZPh/fq5pHKiV2ko=;
 b=euuECP/QABSFAZ6nbQFhQ5kZjth0gE1e+WGOkqDRjrWySLgOpK0cgqEgDOgbgBYxP7
 nf586p92fzBJt/fBL+08lFCiGtMTdw/vI9ImopPNeESqhjufCh3uvdtcUuRCPJcgymIv
 08bXmdlH3PKkUKuuE5lIwvp/H01Ku1LIJssr30oWxjoo3M2f3XIql83LGJfmDa7l1Cta
 fartwbhruBQKgE9yEpPAlkxS0AIkorwW2yB+SP5+jdFALQsXTW873UV8I6uH4D8uzPnI
 ERw9/gwN+aLT59eplyI8QV/7raJXHXMjhxLG1AIxLlz+Gvb8Zn68BXf8k+aqwhn3fcIx
 OfKg==
X-Gm-Message-State: AOAM531O988sNhC+iiHpItPW08Uf7YFBrNF/ej5pcANVWwh8Uj4gXXCU
 rbXWtOJlhQL/PVlEBE9bdmMERO0iqAK1Z7bpezpe36PX29ETwR1pCJVpv5MLhru0kr7tw8DvGt5
 saLyQ+01AX8YNocmpJasvfkRRjALvO/E=
X-Received: by 2002:aa7:da8e:: with SMTP id q14mr6978435eds.359.1598341938334; 
 Tue, 25 Aug 2020 00:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqFOPl2WXnPbjpqEtEILuGfm4QdXSklGmeEPnymi2BQd0PU5mYLYDksosb0UwZSZfSjm7kIx/vWsRJ7G5wcdA=
X-Received: by 2002:aa7:da8e:: with SMTP id q14mr6978428eds.359.1598341938198; 
 Tue, 25 Aug 2020 00:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200824152430.1844159-1-laurent@vivier.eu>
In-Reply-To: <20200824152430.1844159-1-laurent@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:52:06 +0200
Message-ID: <CABgObfav9AUHaHk-gt4cscjaTJ4p-Ufoxhztfb7FKU6-sLwV6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] meson: avoid compiling qemu-keymap by default
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000074de7405adaefbfa"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000074de7405adaefbfa
Content-Type: text/plain; charset="UTF-8"

Queued, thanks.

Paolo

Il lun 24 ago 2020, 17:24 Laurent Vivier <laurent@vivier.eu> ha scritto:

> We don't need it with linux-user only build, and if xkbcommon dynamic
> library is detected it can break the build of static only binaries.
>
> So disable it if it is no explicitly asked by the user when neither
> system or tools are built.
>
> build qemu-keymap:
>   configure --disable-system --disable-tools --disable-user
> --enable-xkbcommon
>   configure --disable-system --enable-tools --disable-user
>   configure --enable-system --disable-tools --disable-user
>
> don't build qemu-keymap:
>   configure --disable-system --disable-tools --disable-user
>   configure --disable-system --disable-tools --enable-user
>
> Laurent Vivier (2):
>   meson: move xkbcommon to meson
>   meson: avoid compiling qemu-keymap by default
>
>  configure         | 29 ++++-------------------------
>  meson.build       | 16 +++++++++++-----
>  meson_options.txt |  1 +
>  ui/meson.build    |  2 +-
>  4 files changed, 17 insertions(+), 31 deletions(-)
>
> --
> 2.26.2
>
>
>

--00000000000074de7405adaefbfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-family:sans-serif">Queued, thanks.</s=
pan><div dir=3D"auto" style=3D"font-family:sans-serif"><br></div><div dir=
=3D"auto" style=3D"font-family:sans-serif">Paolo</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 24 ago 2020, =
17:24 Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivie=
r.eu</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">We don&#=
39;t need it with linux-user only build, and if xkbcommon dynamic<br>
library is detected it can break the build of static only binaries.<br>
<br>
So disable it if it is no explicitly asked by the user when neither<br>
system or tools are built.<br>
<br>
build qemu-keymap:<br>
=C2=A0 configure --disable-system --disable-tools --disable-user --enable-x=
kbcommon<br>
=C2=A0 configure --disable-system --enable-tools --disable-user<br>
=C2=A0 configure --enable-system --disable-tools --disable-user<br>
<br>
don&#39;t build qemu-keymap:<br>
=C2=A0 configure --disable-system --disable-tools --disable-user<br>
=C2=A0 configure --disable-system --disable-tools --enable-user<br>
<br>
Laurent Vivier (2):<br>
=C2=A0 meson: move xkbcommon to meson<br>
=C2=A0 meson: avoid compiling qemu-keymap by default<br>
<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 ++++-----------------=
--------<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 +++++++++++-----<br>
=C2=A0meson_options.txt |=C2=A0 1 +<br>
=C2=A0ui/meson.build=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A04 files changed, 17 insertions(+), 31 deletions(-)<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div>

--00000000000074de7405adaefbfa--


