Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C92C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7249C20872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOXwtTJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK6X-0001iQ-GW
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGK1m-0001pQ-8R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:42:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGK1j-0004IM-4f
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599734521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WzHs4HQj7jYpLZjUBz+ek9pdmj3xhNPD/92oU/mhx9E=;
 b=XOXwtTJtNmcS8s81PzxNMt5xCG3SWZjcSscqhl7BUMBEaHxLgaCf44Qs/hdDjz4FvPV5K3
 9ZJAFVIA7ebwOpkcD3YfpfCSnyTTgbz9dZqtsLYipnooqnKF+Jeb41UETMHq/CWLp3R9z4
 vKmZc/ht0mgSRoK5+JcykvQOuHM1xKA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-xsuWgJ3vPh26XzA3ddgOpg-1; Thu, 10 Sep 2020 06:41:59 -0400
X-MC-Unique: xsuWgJ3vPh26XzA3ddgOpg-1
Received: by mail-ej1-f69.google.com with SMTP id ml20so2515656ejb.23
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WzHs4HQj7jYpLZjUBz+ek9pdmj3xhNPD/92oU/mhx9E=;
 b=HZjcpxpiUqf9m146bT7XXwfZKpnGKiOYxQroEpbNfXFBCVsw6NcoVU+VgGuGSJ+ycR
 JN/awgw3bdrz1ALyaFRa0vKLAkDKsUoY+J2IdpzZxDVJjC9uE3gJ9jkbeXl6x2YfySIs
 WO7t1Ev19oWIB56RXHcGbSgLXcdNpvzvLEZwIHM8ERrDNyTxzXzl9NbLI54x8MWETeQc
 Ag/D43Xm+pjuACeaaAtx/jPqcQDP7Bp+c/DpIfTzDXeOv2ZoPyBvDqxh+h1ficd9Ejm+
 hQrty/t98qUTgz4Pb0wCmwj+/kRhexk+Bh2ZNhN96qxg2PDrgr1b7gawGFEt9k/bwFTa
 t53g==
X-Gm-Message-State: AOAM531V32fkYaiuQIZvscOlDsNin9vvt0P7kpYyjY3hg1ppA1eIlSnL
 K1jjh7r+hy7gERlixJJyXGieyzzuW6tODrUFH6id6AtO1RdU8fDJqZU5pM5WGbHTTPi21t8a5Wa
 oVvdpMM2uC/D7lc77FsyeedzYuXN6onk=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr8517640ejk.449.1599734518257; 
 Thu, 10 Sep 2020 03:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyONwPOjdw/T6uWqre8XjqCpdfsXREM0NRTca/T7jBCbeTrFZlJR7p0EFlV0GraKvwfMQu8uTtZGihMijYy2zg=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr8517610ejk.449.1599734518046; 
 Thu, 10 Sep 2020 03:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <2764135.D4k31Gy3CM@silver> <1695914.5EixHECA2G@silver>
 <20200910073710.GA1083348@redhat.com> <2421928.3WNMogbLRJ@silver>
In-Reply-To: <2421928.3WNMogbLRJ@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Sep 2020 12:41:45 +0200
Message-ID: <CABgObfabaOTqq0bEVUQ1G=QKMBq3-FpgRnH+WhLZc_mvPsCzsA@mail.gmail.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000aef7f905aef33728"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel <qemu-devel@nongnu.org>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aef7f905aef33728
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 10 set 2020, 11:32 Christian Schoenebeck <qemu_oss@crudebyte.com> ha
scritto:

> On Donnerstag, 10. September 2020 09:37:10 CEST Daniel P. Berrang=C3=A9 w=
rote:
> > I don't think we want to be adding more 3rd party deps as submodules,
> quite
> > the opposite, we want to remove more submodules we currently have.
> >
> > Bundling every important dep we use as a submodule and providing build
> > rules, means we're effectively re-inventing Homebrew / MacPorts and thi=
s
> is
> > not a sane use of our time.
>
> Well, that's actually the whole point of this thread: saving developers'
> time.
> And I think the submodule solution is the most sane one.
>

You're very welcome to do this, but what you're doing is effectively a
*distribution of QEMU* that targets the "macOS build from source" scenario,
for people that don't want to use Homebrew. It is *not* going to be used by
QEMU developers, because QEMU developers have conflicting requirements:

* Not getting in the business of maintaining a distribution of all their
dependencies (glib, pixman, etc.)

* Not wanting to maintain multiple build systems

both of which are non-negotiable.

What you might do is use the configure script and the ninja backend to
build all generated sources (produced by either configure, meson or make);
then copy those generated file over to a new build directory, invoke meson
again with the xcode backend, and distribute the result so that it is ready
to build from source using xcode. The resulting distribution is not
appropriate to develop QEMU, but it would be okay to install it and even
for some simple debugging.

The above approach still doesn't solve the problem of building glib and
friends as part of the same xcode project. Perhaps this can be fixed by
patching the xcodeproj that Meson generated.

The scripts needed to do so should be relatively stable and can certainly
be included in the upstream QEMU sources. You can't expect that other
people will test them unless you also include them somehow in our CI, but
just having the scripts would be a start.

Thanks,

Paolo



> Frankly if you compile FOSS software on Mac that asks you to "just"
> install
> dependencies with Homebrew and co, it feels like you have 2 jobs: a
> software
> developer, and a distribution maintainer. The difference to the submodule
> though: a much larger amount of developers have to do that maintainer job
> (manually resolving conflicts & crashes, rollbacks, etc.).
>
> Best regards,
> Christian Schoenebeck
>
>
>

--000000000000aef7f905aef33728
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 10 set 2020, 11:32 Christian Schoenebeck &lt;<a=
 href=3D"mailto:qemu_oss@crudebyte.com" target=3D"_blank" rel=3D"noreferrer=
">qemu_oss@crudebyte.com</a>&gt; ha scritto:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">On Donnerstag, 10. September 2020 09:37:10 CEST Daniel P. Berrang=
=C3=A9 wrote:<br>
&gt; I don&#39;t think we want to be adding more 3rd party deps as submodul=
es, quite<br>
&gt; the opposite, we want to remove more submodules we currently have.<br>
&gt; <br>
&gt; Bundling every important dep we use as a submodule and providing build=
<br>
&gt; rules, means we&#39;re effectively re-inventing Homebrew / MacPorts an=
d this is<br>
&gt; not a sane use of our time.<br>
<br>
Well, that&#39;s actually the whole point of this thread: saving developers=
&#39; time. <br>
And I think the submodule solution is the most sane one.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You&#39;re very wel=
come to do this, but what you&#39;re doing is effectively a *distribution o=
f QEMU* that targets the &quot;macOS build from source&quot; scenario, for =
people that don&#39;t want to use Homebrew. It is *not* going to be used by=
 QEMU developers, because QEMU developers have conflicting requirements:</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">* Not getting in the busin=
ess of maintaining a distribution of all their dependencies (glib, pixman, =
etc.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">* Not wanting to m=
aintain multiple build systems=C2=A0</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">both of which are non-negotiable.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">What you might do is use the configure script and th=
e ninja backend to build all generated sources (produced by either configur=
e, meson or make); then copy those generated file over to a new build direc=
tory, invoke meson again with the xcode backend, and distribute the result =
so that it is ready to build from source using xcode. The resulting distrib=
ution is not appropriate to develop QEMU, but it would be okay to install i=
t and even for some simple debugging.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">The above approach still doesn&#39;t solve the problem of bui=
lding glib and friends as part of the same xcode project. Perhaps this can =
be fixed by patching the xcodeproj that Meson generated.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">The scripts needed to do so should be rela=
tively stable and can certainly be included in the upstream QEMU sources. Y=
ou can&#39;t expect that other people will test them unless you also includ=
e them somehow in our CI, but just having the scripts would be a start.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
Frankly if you compile FOSS software on Mac that asks you to &quot;just&quo=
t; install <br>
dependencies with Homebrew and co, it feels like you have 2 jobs: a softwar=
e <br>
developer, and a distribution maintainer. The difference to the submodule <=
br>
though: a much larger amount of developers have to do that maintainer job <=
br>
(manually resolving conflicts &amp; crashes, rollbacks, etc.).<br>
<br>
Best regards,<br>
Christian Schoenebeck<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000aef7f905aef33728--


