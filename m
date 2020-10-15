Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139FC2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0tPp3aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139FC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBCL-0000YM-KM
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTBBQ-00085T-Hs
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTBBO-0005Ca-CC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602798787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BARnLXs/exXZ7tn92/u9lLueEVkJ1NV00kPp7HxyW6s=;
 b=N0tPp3aPMGS68X7teakI9rLhaLBQQt0UcfHnt6XdJd4ZsR8Gf0+7dIhCrhAMbV1NTTQGCk
 fqzkEjrO2TBiM9167WGYPQkZtvdeQyDqWEn/YtkWc2HLqqaSHIJeIJynRCxyO0co0/7ByH
 PAGT8KqdyHfH5rWzDhMQ49KOFXePCPo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-v8ziUfY8M0CsY5hTTcEZgQ-1; Thu, 15 Oct 2020 17:53:03 -0400
X-MC-Unique: v8ziUfY8M0CsY5hTTcEZgQ-1
Received: by mail-ed1-f70.google.com with SMTP id h6so203268edt.12
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BARnLXs/exXZ7tn92/u9lLueEVkJ1NV00kPp7HxyW6s=;
 b=jkJfosUfyxr9qxHb8SA58GsnP/Vat9TMNdNiXVnZ6jspt6DRCyefMv0tAIdxEaTDZE
 V4UU5XDpcMeAm+CDJO1sKW2tw57AuTOr9bE7dh7RPVzop9m18tm1yTEV9dsAd7f2BUfA
 mHsM4byq5JcFSyMAo4TTDkxCziasM0eevqu5Ri/V3ZZOImGwu9D2YT6bwO1AKjCXodrZ
 BeqWmFUTzCfYrc9Ppsferu2LlCbLj+eut/AczDvgyosb7TymVqsbjsJ0075KHelGvZbL
 4pNgwYS21qnv5KQTVDlnR1dmz/gjvXjvAOazb9gnAE8tg6+aN0xqo+zaKH7lOxLyyxk9
 1etg==
X-Gm-Message-State: AOAM532o9q16oIyQN5Mgk95Mxj3KvTcafRPhW2UqG5cU6iCBuVwDMgFl
 qVgKaIY3SDvZUlI81LmgaTJ/Lu6fUMvbKC64Id+rNpVZl6rquaAl1q0EK0qxgfm1FISFbQ3eeD8
 +vhi4x1hHq1vlo0cPgxk+ZZRWgBC+0LE=
X-Received: by 2002:aa7:cd4f:: with SMTP id v15mr508625edw.243.1602798782365; 
 Thu, 15 Oct 2020 14:53:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUI7BxtXsNdzwujAV2H38P7k9Mm9u1lsh2ap/4JFt0WZciSSjNWHOOL4znDZw5TFK1PBOHZtX/D7fUcxk7esM=
X-Received: by 2002:aa7:cd4f:: with SMTP id v15mr508605edw.243.1602798782141; 
 Thu, 15 Oct 2020 14:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
In-Reply-To: <20201015201035.1964-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Oct 2020 23:52:50 +0200
Message-ID: <CABgObfYY5SPAzouBG84eVdUY5rFwknNuoMovg8VFfvXuhZOA+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fixes docs building on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000000e743c05b1bcac51"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000e743c05b1bcac51
Content-Type: text/plain; charset="UTF-8"

Looks good, apart from the CR removal patch that can simply be dropped.

Paolo

Il gio 15 ott 2020, 22:10 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> v1 - v2
> Also move the docs configure part from
> configure to meson, this also fixed the pending
> ninjatool removal caused issue that docs  can
> not be build under msys2/mingw
>
> Yonggang Luo (4):
>   docs: Fixes build docs on msys2/mingw
>   configure: the docdir option should passed to meson as is.
>   meson: Move the detection logic for sphinx to meson
>   cirrus: Enable doc build on msys2/mingw
>
>  .cirrus.yml                   |  6 +++-
>  configure                     | 62 +++--------------------------------
>  docs/conf.py                  |  2 +-
>  docs/meson.build              |  4 +--
>  docs/sphinx/kerneldoc.py      |  2 +-
>  meson.build                   | 59 +++++++++++++++++++++++++++++----
>  meson_options.txt             |  5 ++-
>  scripts/rst-sanitize.py       | 21 ++++++++++++
>  tests/qapi-schema/meson.build |  7 ++--
>  9 files changed, 95 insertions(+), 73 deletions(-)
>  create mode 100644 scripts/rst-sanitize.py
>
> --
> 2.28.0.windows.1
>
>
>

--0000000000000e743c05b1bcac51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Looks good, apart from the CR removal patch that can simp=
ly be dropped.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il g=
io 15 ott 2020, 22:10 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.=
com">luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">v1 - v2<br>
Also move the docs configure part from<br>
configure to meson, this also fixed the pending<br>
ninjatool removal caused issue that docs=C2=A0 can<br>
not be build under msys2/mingw<br>
<br>
Yonggang Luo (4):<br>
=C2=A0 docs: Fixes build docs on msys2/mingw<br>
=C2=A0 configure: the docdir option should passed to meson as is.<br>
=C2=A0 meson: Move the detection logic for sphinx to meson<br>
=C2=A0 cirrus: Enable doc build on msys2/mingw<br>
<br>
=C2=A0.cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 6 +++-<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 62 +++--------------------------------<br>
=C2=A0docs/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 2 +-<br>
=C2=A0docs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 4 +--<br>
=C2=A0docs/sphinx/kerneldoc.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 59 +++++++++++++++++++++++++++++----<br>
=C2=A0meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 5 ++-<br>
=C2=A0scripts/rst-sanitize.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 ++++++++++++<b=
r>
=C2=A0tests/qapi-schema/meson.build |=C2=A0 7 ++--<br>
=C2=A09 files changed, 95 insertions(+), 73 deletions(-)<br>
=C2=A0create mode 100644 scripts/rst-sanitize.py<br>
<br>
-- <br>
2.28.0.windows.1<br>
<br>
<br>
</blockquote></div>

--0000000000000e743c05b1bcac51--


