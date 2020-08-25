Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F84C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7112076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz+VhBTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7112076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdUg-0003Pw-7w
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAdTE-0002S9-5d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAdTA-0005lF-J6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598379291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pNmg5HTWkYeFnB+TVR8Vfr6GjGJZnvx0O/STdzAz3TY=;
 b=Fz+VhBTkGfKx8aunOCIhty5JPe2qwDq/djX7gfPLqkdOWcCh5gOWEZ5Kcqbm7TI2vUQFw3
 cKLBpDcQAXhSyv2bqRgR2nTrmdicW46vJv5sOBZqL8KfwCC21puDe1lV7w7ckMF4FNCEC/
 vpZppKTzEuLZGvHXeAGKS1eri/Noy6g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-wNbY33vYM_KiMiespN7KvQ-1; Tue, 25 Aug 2020 14:14:47 -0400
X-MC-Unique: wNbY33vYM_KiMiespN7KvQ-1
Received: by mail-ed1-f71.google.com with SMTP id dd25so4941447edb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 11:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pNmg5HTWkYeFnB+TVR8Vfr6GjGJZnvx0O/STdzAz3TY=;
 b=IK7Cxx48pW72bFs/WGIBDJpP3YD3UrVE+w6QJpQGyVPNX5Qc0GIxiN+rxIUgfOPk3D
 TzkjHcqBHHSkIeawynpRePQXiSsixEVLRmyd1tv8nNlafSugFWCt58/xzxzL1CzMCsar
 uZRpri5nh8nxE+rvKsnFOj1UoZv6DhivOlhcebb0i6cK4ibhNwTD0/WcJEBHjqak1OVc
 QE+jWPBnH+AmJD9bu40In3pqIx6rKA4R7sj4yOVl08IjIlCFJPp4JIw7fSXG77HsnqVB
 OfoaRYMkB17HrU1FCMm0Dx6+iCrVEjwiJpNun+BlttVqPeUggpuimTmiKsIQI30gkQ6y
 pyoA==
X-Gm-Message-State: AOAM533cVQzKqZ3xjbv5GzoxuEyFZcM8Kfb6IrY+Gr99OllTTmGZtd8+
 x1p1j6Qnkf7HS0EIC0QrFsFIkWiNnFSuDtTNHCaPSmMiYjbnj+a5mvRQ0xhVoSwKIDu3y+d+H9o
 icd3OzPb5Fy7evoc6B9YaYplUBvSRrC4=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr2759420ejb.121.1598379286008; 
 Tue, 25 Aug 2020 11:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynKSoDVQ25uJhRm/in9g1huws2GIg1svHlDDHfwSQckF8grjJ3PWvzcjDPG5+1psHMG2053uqObGkuy9wu4W0=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr2759408ejb.121.1598379285801; 
 Tue, 25 Aug 2020 11:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
 <CABgObfbW5NMu4-NxiTNYF1NxiXt9pgyueJwv+vqdyQ5gySd+bQ@mail.gmail.com>
 <CAMxuvazbx51vcNSQfaGXhhuF-zrk6ixwhTMn2Bbfu0axQk5rww@mail.gmail.com>
In-Reply-To: <CAMxuvazbx51vcNSQfaGXhhuF-zrk6ixwhTMn2Bbfu0axQk5rww@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 20:14:33 +0200
Message-ID: <CABgObfZjZTbghnkTObB5m8CbtjeWZF0vMimEUvab9yZk_ZAWtw@mail.gmail.com>
Subject: Re: [PATCH 0/5] meson: mingw installation fixes & nsis conversion
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000008c0a2c05adb7ad14"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: sw <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c0a2c05adb7ad14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 25 ago 2020, 18:49 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
ha scritto:

> Hi
>
> On Tue, Aug 25, 2020 at 8:38 PM Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >
> > Whenever we fix these bugs I would rather avoid adding duplicates
> between options and config-host.mak, so that we can sooner or later get r=
id
> of config-host.mak.
>

Yes I was talking more of the new options but you're right there's no
duplication. Do not review patches on a phone. :-)

Paolo


> This is not adding things to config-host.mak.
>
> > For the same reason, I think all options should have a sensible default
> so that in the end it will be possible to do "meson setup". Do you think
> it's possible to extend the series in this direction?
>
> The options I added also have default values.
>
> I think trying to remove (or just move) variables would be a separate
> goal from this series. It's already not completely trivial to get the
> conversion working without regression, as you probably know :) better
> not to mix goals imho.
>
> >
> > Paolo
> >
> > Il mar 25 ago 2020, 17:04 <marcandre.lureau@redhat.com> ha scritto:
> >>
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Hi,
> >>
> >> The following patches fix installation path when cross-compiling Windo=
ws
> >> version, and move the NSIS build rule to meson.
> >>
> >> Marc-Andr=C3=A9 Lureau (5):
> >>   meson: pass confsuffix option
> >>   meson: use meson datadir instead of qemu_datadir
> >>   meson: add docdir option and pass pre-prefix qemu_docdir
> >>   meson: use meson mandir instead of qemu_mandir
> >>   meson: add NSIS building
> >>
> >>  Makefile                           | 56 -----------------------------
> >>  configure                          |  2 ++
> >>  contrib/vhost-user-gpu/meson.build |  2 +-
> >>  docs/meson.build                   |  4 +--
> >>  meson.build                        | 32 +++++++++++++++--
> >>  meson_options.txt                  |  2 ++
> >>  pc-bios/descriptors/meson.build    |  2 +-
> >>  pc-bios/keymaps/meson.build        |  6 ++--
> >>  pc-bios/meson.build                |  2 +-
> >>  scripts/nsis.sh                    | 58 +++++++++++++++++++++++++++++=
+
> >>  tools/virtiofsd/meson.build        |  2 +-
> >>  trace/meson.build                  |  2 +-
> >>  12 files changed, 101 insertions(+), 69 deletions(-)
> >>  create mode 100755 scripts/nsis.sh
> >>
> >> --
> >> 2.26.2
> >>
> >>
>
>

--0000000000008c0a2c05adb7ad14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 25 ago 2020, 18:49 Marc-Andr=C3=A9 Lureau &lt;<=
a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi<br>
<br>
On Tue, Aug 25, 2020 at 8:38 PM Paolo Bonzini &lt;<a href=3D"mailto:pbonzin=
i@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; Whenever we fix these bugs I would rather avoid adding duplicates betw=
een options and config-host.mak, so that we can sooner or later get rid of =
config-host.mak.<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Yes I was talking more of the new options but you&#39;re ri=
ght there&#39;s no duplication. Do not review patches on a phone. :-)</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
This is not adding things to config-host.mak.<br>
<br>
&gt; For the same reason, I think all options should have a sensible defaul=
t so that in the end it will be possible to do &quot;meson setup&quot;. Do =
you think it&#39;s possible to extend the series in this direction?<br>
<br>
The options I added also have default values.<br>
<br>
I think trying to remove (or just move) variables would be a separate<br>
goal from this series. It&#39;s already not completely trivial to get the<b=
r>
conversion working without regression, as you probably know :) better<br>
not to mix goals imho.<br>
<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt; Il mar 25 ago 2020, 17:04 &lt;<a href=3D"mailto:marcandre.lureau@redha=
t.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>=
&gt; ha scritto:<br>
&gt;&gt;<br>
&gt;&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.=
com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; The following patches fix installation path when cross-compiling W=
indows<br>
&gt;&gt; version, and move the NSIS build rule to meson.<br>
&gt;&gt;<br>
&gt;&gt; Marc-Andr=C3=A9 Lureau (5):<br>
&gt;&gt;=C2=A0 =C2=A0meson: pass confsuffix option<br>
&gt;&gt;=C2=A0 =C2=A0meson: use meson datadir instead of qemu_datadir<br>
&gt;&gt;=C2=A0 =C2=A0meson: add docdir option and pass pre-prefix qemu_docd=
ir<br>
&gt;&gt;=C2=A0 =C2=A0meson: use meson mandir instead of qemu_mandir<br>
&gt;&gt;=C2=A0 =C2=A0meson: add NSIS building<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 56 -------------------------=
----<br>
&gt;&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;&gt;=C2=A0 contrib/vhost-user-gpu/meson.build |=C2=A0 2 +-<br>
&gt;&gt;=C2=A0 docs/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<br>
&gt;&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 32 +++++++++++++++--<br>
&gt;&gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt;&gt;=C2=A0 pc-bios/descriptors/meson.build=C2=A0 =C2=A0 |=C2=A0 2 +-<br=
>
&gt;&gt;=C2=A0 pc-bios/keymaps/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 6 ++--<br>
&gt;&gt;=C2=A0 pc-bios/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;&gt;=C2=A0 scripts/nsis.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 58 ++++++++++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 tools/virtiofsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt;&gt;=C2=A0 trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
&gt;&gt;=C2=A0 12 files changed, 101 insertions(+), 69 deletions(-)<br>
&gt;&gt;=C2=A0 create mode 100755 scripts/nsis.sh<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.26.2<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000008c0a2c05adb7ad14--


