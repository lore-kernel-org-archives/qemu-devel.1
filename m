Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA8DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038192071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKpElk06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038192071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATrW-0008Nh-7p
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATqr-0007qN-9M
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATqp-00055X-91
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598342318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4g4QghCTSoVGFSeEfNiezAujeuTLh4WIhkRcQQ4tBM=;
 b=LKpElk06+BI6oK4Re1tG71g2ANtJsM/8qvXV4Wquz1tSdZF0UWNu5LHTPkp9JXDbBpPCPR
 pjjrAAh73aWdbaEIxByish6ind9PH5NViz/8/EzqN62ITCr98kqsgVOUH4zUGWu+707CEo
 QaWOcCqrMc3wRUnBccIyFYXzWg+IcE8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-Z0DgSZK2MsqTO97qFEU-nA-1; Tue, 25 Aug 2020 03:58:32 -0400
X-MC-Unique: Z0DgSZK2MsqTO97qFEU-nA-1
Received: by mail-ed1-f69.google.com with SMTP id l10so1705565eds.18
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X4g4QghCTSoVGFSeEfNiezAujeuTLh4WIhkRcQQ4tBM=;
 b=TGFgJt3OASfA7MIaVFLUo+hiZHUYqoXRYfwWHuykm6e0GMCBiSy88nVwGwZluJicCA
 Gd5XBD1yt5Gt+MD6b4srWcIdSvviFfAbrGbukqd8bVWIXSo5hE4H4lxH9tvkz1lWuxsk
 nIhEeaEKaFCyCmUPN/kylXk+JWpHTybclcwH79JXP6EqQM96eJPnDcn+3xv2DI8gzEV+
 tUDwJCYu/UgOTET6FEWXDqpH9SjqiAbsnC++PyHjpVzMIDddujsQu2croddh8kZzVDvY
 T+qdoYwWJEKgVAaPWrnyXGGvuCYnux2gtTYMPL8CwlWdNLCS6p3ae1TtGGF2AtegK3Xj
 5kEQ==
X-Gm-Message-State: AOAM530tYJbBHl8AJdBrvFF6cJet/ggUxu4iDTVqv8lOThmqw5YMQuZq
 B+BQg4mnxf1uxrFv9xAIsd7yNhVqYeRVw+H3p1Du8pagXQjVaKdzs+1QfIEqQLuWkBbWY4IsQDA
 GGbMBTKEIsIX5Mnz6f/YfNlyx/S5ODHw=
X-Received: by 2002:a50:fb94:: with SMTP id e20mr9097386edq.103.1598342311204; 
 Tue, 25 Aug 2020 00:58:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2Owwjy12FbTfkYWCVEc96R6y97slGvjYHJL2jxClDsdO+opO6kmSAtlCv7rXq6Hv2T5KiTVUU1GAK5ZjMaAc=
X-Received: by 2002:a50:fb94:: with SMTP id e20mr9097373edq.103.1598342310962; 
 Tue, 25 Aug 2020 00:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200823225804.umk5gh6knptqo5mw@mozz.bu.edu>
In-Reply-To: <20200823225804.umk5gh6knptqo5mw@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:58:19 +0200
Message-ID: <CABgObfZtGY-TuTLXNJNU9m_yQLfE6AM-+MdfqaaRjfMcWC8+Og@mail.gmail.com>
Subject: Re: [Fwd] Issue 25164 in oss-fuzz: qemu: Fuzzing build failure
To: Alexander Bulekov <alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000acbe6d05adaf1118"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000acbe6d05adaf1118
Content-Type: text/plain; charset="UTF-8"

Il lun 24 ago 2020, 00:58 Alexander Bulekov <alxndr@bu.edu> ha scritto:

> Hi Paolo,
> Our oss-fuzz builds started failing, after the meson merge. I think I
> tracked down the issues:
> 1.) Looking at the build-log here:
>
> https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt
> The error happens at link-time. Re-running the build with V=1:
> "/usr/bin/ld" ...
> --whole-archive /usr/local/lib/clang/12.0.0/.../libclang_rt.asan-x86_64.a \
> --start-group ..... -T /src/qemu/tests/qtest/fuzz/fork_fuzz.ld  \
> -wrap qtest_inb -wrap qtest_inw ..... --end-group .....
>

I think you can put everything into a response for and include it with
@fuzz.cmd in the command line.


> 2.) 77afc75f69 ("oss-fuzz/build: remove LIB_FUZZING_ENGINE")
>
> On oss-fuzz, we cannot explicitly specify fsanitize=fuzzer: We have to
> leverage the $CC $CXX $CFLAGS $CXXFLAGS $LIB_FUZZING_ENGINE from
> oss-fuzz. That was the reason for the "make CONFIG_FUZZ CFLAGS" trickery
> in the original build script.
>
> Details:
>
> https://google.github.io/oss-fuzz/getting-started/new-project-guide/#Requirements
>
> To work around this, I think we can create separate configure options
> --enable-oss-fuzz and --oss-fuzz-cflags and CONFIG_OSS_FUZZ. In meson we
> create a new "source-set" specific_oss_fuzz_ss which is identical to
> specific_fuzz_ss, except it does not depend on "-fsanitize=fuzzer",
> which is specified in tests/qtest/fuzz/meson.build
>
> I've been working on patches to do (2)


Great, I can review them. Should you use $LIB_FUZZING_ENGINE directly
instead of a separate command line option?

Paolo

but I don't know how to fix (1).
> Do you have any ideas?
>
> -Alex
>
> ----- Forwarded message from ClusterFuzz-External via monorail <
> monorail+v2.382749006@chromium.org> -----
>
> Date: Sun, 23 Aug 2020 03:10:14 -0700
> From: ClusterFuzz-External via monorail <
> monorail+v2.382749006@chromium.org>
> To: alxndr@bu.edu
> Subject: Issue 25164 in oss-fuzz: qemu: Fuzzing build failure
>
> Status: New
> Owner: ----
> CC: b...@redhat.com, stefa...@redhat.com, alx...@bu.edu,
> pbonz...@redhat.com, darren.k...@oracle.com
> Labels: Proj-qemu
> Type: Build-Failure
>
> New issue 25164 by ClusterFuzz-External: qemu: Fuzzing build failure
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=25164
>
> The last 2 builds for qemu have been failing.
> Build log:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt
> Build type: fuzzing
>
> To reproduce locally, please see:
> https://google.github.io/oss-fuzz/advanced-topics/reproducing#reproducing-build-failures
>
> This bug tracker is not being monitored by OSS-Fuzz team. If you have any
> questions, please create an issue at
> https://github.com/google/oss-fuzz/issues/new.
>
> **This bug will be automatically closed within a day once it is fixed.**
>
> --
> You received this message because:
>   1. You were specifically CC'd on the issue
>
> You may adjust your notification preferences at:
> https://bugs.chromium.org/hosting/settings
>
> Reply to this email to add a comment.
>
> ----- End forwarded message -----
>
>

--000000000000acbe6d05adaf1118
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 24 ago 2020, 00:58 Alexander Bulekov &lt;<a hre=
f=3D"mailto:alxndr@bu.edu">alxndr@bu.edu</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Hi Paolo,<br>
Our oss-fuzz builds started failing, after the meson merge. I think I<br>
tracked down the issues:<br>
1.) Looking at the build-log here:<br>
<a href=3D"https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-=
1ce5-4422-b3db-ccbf83a862a0.txt" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">https://oss-fuzz-build-logs.storage.googleapis.com/log-d43d402c-1ce5-=
4422-b3db-ccbf83a862a0.txt</a><br>
The error happens at link-time. Re-running the build with V=3D1:<br>
&quot;/usr/bin/ld&quot; ...<br>
--whole-archive /usr/local/lib/clang/12.0.0/.../libclang_rt.asan-x86_64.a \=
<br>
--start-group ..... -T /src/qemu/tests/qtest/fuzz/fork_fuzz.ld=C2=A0 \<br>
-wrap qtest_inb -wrap qtest_inw ..... --end-group .....<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">I think you can put =
everything into a response for and include it with @fuzz.cmd in the command=
 line.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>2.) 77afc75f69 (&quot;oss-fuzz/build: remove LIB_FUZZING_ENGINE&quot;)<=
br>
<br>
On oss-fuzz, we cannot explicitly specify fsanitize=3Dfuzzer: We have to<br=
>
leverage the $CC $CXX $CFLAGS $CXXFLAGS $LIB_FUZZING_ENGINE from<br>
oss-fuzz. That was the reason for the &quot;make CONFIG_FUZZ CFLAGS&quot; t=
rickery<br>
in the original build script.<br>
<br>
Details:<br>
<a href=3D"https://google.github.io/oss-fuzz/getting-started/new-project-gu=
ide/#Requirements" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
google.github.io/oss-fuzz/getting-started/new-project-guide/#Requirements</=
a><br>
<br>
To work around this, I think we can create separate configure options<br>
--enable-oss-fuzz and --oss-fuzz-cflags and CONFIG_OSS_FUZZ. In meson we<br=
>
create a new &quot;source-set&quot; specific_oss_fuzz_ss which is identical=
 to<br>
specific_fuzz_ss, except it does not depend on &quot;-fsanitize=3Dfuzzer&qu=
ot;,<br>
which is specified in tests/qtest/fuzz/meson.build<br>
<br>
I&#39;ve been working on patches to do (2)</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Great, I can review them. Should you =
use $LIB_FUZZING_ENGINE directly instead of a separate command line option?=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"> but I don&#39;t know how to fix (1).<br>
Do you have any ideas?<br>
<br>
-Alex<br>
<br>
----- Forwarded message from ClusterFuzz-External via monorail &lt;<a href=
=3D"mailto:monorail%2Bv2.382749006@chromium.org" target=3D"_blank" rel=3D"n=
oreferrer">monorail+v2.382749006@chromium.org</a>&gt; -----<br>
<br>
Date: Sun, 23 Aug 2020 03:10:14 -0700<br>
From: ClusterFuzz-External via monorail &lt;<a href=3D"mailto:monorail%2Bv2=
.382749006@chromium.org" target=3D"_blank" rel=3D"noreferrer">monorail+v2.3=
82749006@chromium.org</a>&gt;<br>
To: <a href=3D"mailto:alxndr@bu.edu" target=3D"_blank" rel=3D"noreferrer">a=
lxndr@bu.edu</a><br>
Subject: Issue 25164 in oss-fuzz: qemu: Fuzzing build failure<br>
<br>
Status: New<br>
Owner: ----<br>
CC: <a href=3D"mailto:b...@redhat.com" target=3D"_blank" rel=3D"noreferrer"=
>b...@redhat.com</a>, <a href=3D"mailto:stefa...@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">stefa...@redhat.com</a>, <a href=3D"mailto:alx...@bu=
.edu" target=3D"_blank" rel=3D"noreferrer">alx...@bu.edu</a>, <a href=3D"ma=
ilto:pbonz...@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonz...@red=
hat.com</a>, <a href=3D"mailto:darren.k...@oracle.com" target=3D"_blank" re=
l=3D"noreferrer">darren.k...@oracle.com</a> <br>
Labels: Proj-qemu<br>
Type: Build-Failure<br>
<br>
New issue 25164 by ClusterFuzz-External: qemu: Fuzzing build failure<br>
<a href=3D"https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=3D25164" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://bugs.chromium.org/p/=
oss-fuzz/issues/detail?id=3D25164</a><br>
<br>
The last 2 builds for qemu have been failing.<br>
Build log: <a href=3D"https://oss-fuzz-build-logs.storage.googleapis.com/lo=
g-d43d402c-1ce5-4422-b3db-ccbf83a862a0.txt" rel=3D"noreferrer noreferrer" t=
arget=3D"_blank">https://oss-fuzz-build-logs.storage.googleapis.com/log-d43=
d402c-1ce5-4422-b3db-ccbf83a862a0.txt</a><br>
Build type: fuzzing<br>
<br>
To reproduce locally, please see: <a href=3D"https://google.github.io/oss-f=
uzz/advanced-topics/reproducing#reproducing-build-failures" rel=3D"noreferr=
er noreferrer" target=3D"_blank">https://google.github.io/oss-fuzz/advanced=
-topics/reproducing#reproducing-build-failures</a><br>
<br>
This bug tracker is not being monitored by OSS-Fuzz team. If you have any q=
uestions, please create an issue at <a href=3D"https://github.com/google/os=
s-fuzz/issues/new" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
github.com/google/oss-fuzz/issues/new</a>.<br>
<br>
**This bug will be automatically closed within a day once it is fixed.**<br=
>
<br>
-- <br>
You received this message because:<br>
=C2=A0 1. You were specifically CC&#39;d on the issue<br>
<br>
You may adjust your notification preferences at:<br>
<a href=3D"https://bugs.chromium.org/hosting/settings" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://bugs.chromium.org/hosting/settings</a><=
br>
<br>
Reply to this email to add a comment.<br>
<br>
----- End forwarded message -----<br>
<br>
</blockquote></div></div></div>

--000000000000acbe6d05adaf1118--


