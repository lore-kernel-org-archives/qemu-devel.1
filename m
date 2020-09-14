Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D11BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A032F20719
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTq8HedC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A032F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrm5-0002N1-He
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHraL-0006G0-2e
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:44:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48425
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHraI-0000VD-Hv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600101845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1zKmw+0E3h2cKjwo6J+WTjxFgqWgRNR9EXnsuUH31fg=;
 b=iTq8HedCTrTNZfQ+LmR1AZi7gYGxdYTyPb2Ps6I/8a/WA+o54Q89rtlUsK0Z8lI6ATBBeC
 eG7tjufIfvzLElCQA6xRYbwP4vVEWHe4mHMCuFT6CCTTZ2kL5UdFIFOimJngc3OOdrauuh
 gtwvMbS4IpsqJlRRboQ7fbNpsS8Kmqk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-S-ORnCTRMhWqleBwDtlipg-1; Mon, 14 Sep 2020 12:43:58 -0400
X-MC-Unique: S-ORnCTRMhWqleBwDtlipg-1
Received: by mail-ej1-f70.google.com with SMTP id b17so60383ejb.20
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 09:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1zKmw+0E3h2cKjwo6J+WTjxFgqWgRNR9EXnsuUH31fg=;
 b=ccX5MWN3kKecvtK/9ajEvOgrt4YpCseHQ2Ohv374boA3DBEs4ZQ6vWczKkXlYssIQO
 E7k4untRceFeRzXtd9TThynS0Q3bPfJupBR7BBZ2Albmw6Q6d2nUwFV8McPVqzIxJMux
 IHp+2lK/nJP74EjVAQpBdJ7Hp7ynjt83+UHdfYHHcSFckkloiY7n2UrRB3mF3ql9ZEWX
 phNyUUg8gnPG+0Sc4TYdnk9l0UPccqBA28CV21vGwmQNvuf9k68dODZufZx3sLQ4LCzy
 5vCPPmbEWZ6ZXr8809WWk4HmwYcbF6xE/LFmxFR6aV4ypf/+oL9NBB/eQaEOhxnChTZs
 5TNg==
X-Gm-Message-State: AOAM531erxN4Di/Y2bNcBGKkwRW7hsMUtxxfBS5Vn4Oh+fM9lzsNVUUD
 H8x2cqFcE6jTVHoG64Q3/LZwh1ccsQZchK8FlwmJc2Tj3oeU3c3hQHZSymMlTk6oFLmeN/b47qK
 CMdyKRwHT/d6WYb7USkgw1db4HaCJct0=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr16323217ejx.390.1600101837441; 
 Mon, 14 Sep 2020 09:43:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSyMJvVHYQqb9dvSBQsohUb7AGzVOqA5506U/fSgkhhLNyw32aqyeblc7QI0FQl+2gUMydyWN3ZrbM8CUmAQ0=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr16323197ejx.390.1600101837235; 
 Mon, 14 Sep 2020 09:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-2-richard.henderson@linaro.org>
 <d5628860-7cc3-04af-601e-3f3941791573@redhat.com>
 <2824173e-8a2d-415a-f134-5f94d57a5d43@linaro.org>
In-Reply-To: <2824173e-8a2d-415a-f134-5f94d57a5d43@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Sep 2020 18:43:45 +0200
Message-ID: <CABgObfbr=rJd400GO8Kn17p3gQWwYDd8Ph1nU-3FygAVUyFCEw@mail.gmail.com>
Subject: Re: [PATCH 01/11] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000009d04e605af48bd48"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: thuth@redhat.com, luoyonggang@gmail.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009d04e605af48bd48
Content-Type: text/plain; charset="UTF-8"

Il lun 14 set 2020, 18:23 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> Do we really need to keep testing $source/.git and $git_update?
> Surely we can accumulate git_submodules and then do (or not do) something
> with
> that at the end without all of the tests?
>

Possibly, but I don't mind going through that separately.

> and in meson.build:
> >
> > capstone = not_found
> > build_internal_capstone = false
> > if get_option('capstone') != 'no'
> >   if get_option('capstone') != 'internal'
> >     capstone = dependency('capstone',
> >                           required: get_option('capstone') == 'system',
> >                           method: 'pkg-config',
> >                           static: enable_static)
> >   endif
> >   build_internal_capstone = not capstone.found()
> > endif
> > ...
> > if build_internal_capstone
> >   ...
> >   capstone = declare_dependency(...)
> > endif
>
> This doesn't seem like it would do the right thing for capstone=auto,
> --disable-git-update, and no system library.  In that case auto should
> resolve to no.
>

Indeed, that would require some filesystem check like

fs = import('fs')
build_internal_capstone = not capstone.found() and \
  (get_option('capstone') == 'internal' or \
   fs.exists('capstone/Makefile'))

I don't think we can move this detection to meson until the definition of
> CONFIG_CAPSTONE is under control of meson.
>

Yep, that's another part that needs to be moved to meson.build in this
patch with config_host_data.set. But this patch is the right one to do this.

Paolo


> > +option('capstone', type: 'combo', value: 'auto',
> > +       choices: ['auto', 'system', 'internal', 'no'],
> > +       description: 'How to find the capstone library')
>
> I can certainly change this.  I presume this validates that the
> -Dcapstone=foo
> value passed to meson is correct?
>
>
> r~
>
>

--0000000000009d04e605af48bd48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 14 set 2020, 18:23 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferr=
er">richard.henderson@linaro.org</a>&gt; ha scritto:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">Do we really need to keep testing $source/.git and $git_u=
pdate?<br>
Surely we can accumulate git_submodules and then do (or not do) something w=
ith<br>
that at the end without all of the tests?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Possibly, but I don&#39;t mind goi=
ng through that separately.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; and in m=
eson.build:<br>
&gt; <br>
&gt; capstone =3D not_found<br>
&gt; build_internal_capstone =3D false<br>
&gt; if get_option(&#39;capstone&#39;) !=3D &#39;no&#39;<br>
&gt;=C2=A0 =C2=A0if get_option(&#39;capstone&#39;) !=3D &#39;internal&#39;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0capstone =3D dependency(&#39;capstone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0required: get_option(&#39;capstone&#39;) =3D=3D =
&#39;system&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0method: &#39;pkg-config&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0static: enable_static)<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt;=C2=A0 =C2=A0build_internal_capstone =3D not capstone.found()<br>
&gt; endif<br>
&gt; ...<br>
&gt; if build_internal_capstone<br>
&gt;=C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0capstone =3D declare_dependency(...)<br>
&gt; endif<br>
<br>
This doesn&#39;t seem like it would do the right thing for capstone=3Dauto,=
<br>
--disable-git-update, and no system library.=C2=A0 In that case auto should=
 resolve to=C2=A0no.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Indeed, that would require some filesystem check like</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">fs =3D import(&#39;fs&#39=
;)<br></div><div dir=3D"auto">build_internal_capstone =3D not capstone.foun=
d() and \</div><div dir=3D"auto">=C2=A0 (get_option(&#39;capstone&#39;) =3D=
=3D &#39;internal&#39; or \</div><div dir=3D"auto">=C2=A0 =C2=A0fs.exists(&=
#39;capstone/Makefile&#39;))</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I don&#39;t =
think we can move this detection to meson until the definition of<br>
CONFIG_CAPSTONE is under control of meson.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Yep, that&#39;s another part that=
 needs to be moved to meson.build in this patch with config_host_data.set. =
But this patch is the right one to do this.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +option(&#39;capstone&#39;, type: &#39;combo&#39;, value: &#39;auto&#3=
9;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0choices: [&#39;auto&#39;, &#39;system&#39;=
, &#39;internal&#39;, &#39;no&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;How to find the capstone=
 library&#39;)<br>
<br>
I can certainly change this.=C2=A0 I presume this validates that the -Dcaps=
tone=3Dfoo<br>
value passed to meson is correct?<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--0000000000009d04e605af48bd48--


