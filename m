Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C42122B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlZjlg72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C42122B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJTt-00051b-Ez
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBJT3-00046N-M5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBJT1-0002Bq-3f
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598540730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=47EQhujad8f/b80ZPeJgL6zxnJOQJt/5kfMmqbB6dJY=;
 b=XlZjlg72i8doxL8679pb7k1p3ghZGI8jx1X358QulxxTzrlhEJOYUhgoe6tSNBJo67oW0u
 5j5UKRurbcG7VkRx98ImLTY+aBgiXesfrspwjRcsjnlOEKmZAf6XIy2krGzqMjL9AnOnye
 inlPFxbQTBXGTlUOAlaV+Ah7GM7Lrvo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-vx4K2LHoPzSOrffijbaiKg-1; Thu, 27 Aug 2020 11:05:23 -0400
X-MC-Unique: vx4K2LHoPzSOrffijbaiKg-1
Received: by mail-ed1-f71.google.com with SMTP id w26so2056940edq.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=47EQhujad8f/b80ZPeJgL6zxnJOQJt/5kfMmqbB6dJY=;
 b=Rmrx9Vg5WvfsRx52gJr2mSDhMidf+/iIELYGS7AF6VRnaY/DajgvA40k6d6OJHfMFB
 aInBhuRxQDzl9rRlK0e+lduy9vDOgAU7qgJA2qxWhiL6Kn7g3i5HQ1Rg3YJYLcTYt+QS
 S0ex3NMTyKlQY1tBfj9gQ3nuJn7+na/l+EkNTkcnRNHqrN068I8KCQnwIMpSB3v0xLIk
 zn54MGVE/PfqSYUr3bqYhbI/4U3Mdc2AOrpSY8VeiosuJi+K9yXo0dW5XpJph4bQh/jX
 rCYgHQSrx6KfDfustHkmBmAvycWzT+Y39g32e+eAmtoSXh3YZKx0qdXpdcBoxXhK7fJR
 KZhw==
X-Gm-Message-State: AOAM53280xWXydZ08NMrNgPUddlbipXZb8+E95ZbilJF5mr0gLbGfmNu
 8ujEYxzVvKb0fIQGmQiKOVK6P8uPqqPY7UOcCMyr6Tc2Y7qAFbBvYTdMj9AEk33qOo7ZIASMCNQ
 83IvWtKTFiQ9FjIM8mbg/zaVumZZZ7Ws=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr22159335ejw.71.1598540722577; 
 Thu, 27 Aug 2020 08:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUnem/Voz4IJLOi3ejz/iTbPvBkJx0kdcXu/lXRjcFuWIUdU7xjyoodV2ksyrJar7nVJgGVHzEvtbXk2e0uMg=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr22159308ejw.71.1598540722387; 
 Thu, 27 Aug 2020 08:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142245.108147-1-stefanha@redhat.com>
In-Reply-To: <20200827142245.108147-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 17:05:10 +0200
Message-ID: <CABgObfYn4qSo7C=AfhxZ4-8ZSD=cbWSgJG_jwYOuU+Zn1wc87g@mail.gmail.com>
Subject: Re: [PATCH] meson: fix SystemTap Unknown variable "exe_name"
To: Stefan Hajnoczi <stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000ead3a505addd4356"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ead3a505addd4356
Content-Type: text/plain; charset="UTF-8"

I have sent the same patch. I CCed Peter but forgot you, sorry.

Paolo

Il gio 27 ago 2020, 16:23 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> The SystemTap tapset generation code used a stale variable name
> 'exe_name'. This caused the following meson error:
>
>   Unknown variable "exe_name"
>
> The variable should be exe['name']. This fixes ./configure
> --enable-trace-backend=dtrace with SystemTap.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  meson.build | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index f0fe5f8799..f2aa5a7700 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1029,14 +1029,14 @@ foreach target : target_dirs
>
>      if 'CONFIG_TRACE_SYSTEMTAP' in config_host
>        foreach stp: [
> -        {'ext': '.stp-build', 'fmt': 'stap', 'bin':
> meson.current_build_dir() / exe_name, 'install': false},
> -        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') /
> get_option('bindir') / exe_name, 'install': true},
> +        {'ext': '.stp-build', 'fmt': 'stap', 'bin':
> meson.current_build_dir() / exe['name'], 'install': false},
> +        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') /
> get_option('bindir') / exe['name'], 'install': true},
>          {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '',
> 'install': true},
>          {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install':
> true},
>        ]
> -        custom_target(exe_name + stp['ext'],
> +        custom_target(exe['name'] + stp['ext'],
>                        input: trace_events_all,
> -                      output: exe_name + stp['ext'],
> +                      output: exe['name'] + stp['ext'],
>                        capture: true,
>                        install: stp['install'],
>                        install_dir: config_host['qemu_datadir'] /
> '../systemtap/tapset',
> --
> 2.26.2
>
>

--000000000000ead3a505addd4356
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I have sent the same patch. I CCed Peter but forgot you, =
sorry.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 27 ag=
o 2020, 16:23 Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">st=
efanha@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">The SystemTap tapset generation code used a stale variable name<br>
&#39;exe_name&#39;. This caused the following meson error:<br>
<br>
=C2=A0 Unknown variable &quot;exe_name&quot;<br>
<br>
The variable should be exe[&#39;name&#39;]. This fixes ./configure<br>
--enable-trace-backend=3Ddtrace with SystemTap.<br>
<br>
Reported-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index f0fe5f8799..f2aa5a7700 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1029,14 +1029,14 @@ foreach target : target_dirs<br>
<br>
=C2=A0 =C2=A0 =C2=A0if &#39;CONFIG_TRACE_SYSTEMTAP&#39; in config_host<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0foreach stp: [<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&#39;ext&#39;: &#39;.stp-build&#39;, &#39;fmt=
&#39;: &#39;stap&#39;, &#39;bin&#39;: meson.current_build_dir() / exe_name,=
 &#39;install&#39;: false},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&#39;ext&#39;: &#39;.stp&#39;, &#39;fmt&#39;:=
 &#39;stap&#39;, &#39;bin&#39;: get_option(&#39;prefix&#39;) / get_option(&=
#39;bindir&#39;) / exe_name, &#39;install&#39;: true},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&#39;ext&#39;: &#39;.stp-build&#39;, &#39;fmt=
&#39;: &#39;stap&#39;, &#39;bin&#39;: meson.current_build_dir() / exe[&#39;=
name&#39;], &#39;install&#39;: false},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&#39;ext&#39;: &#39;.stp&#39;, &#39;fmt&#39;:=
 &#39;stap&#39;, &#39;bin&#39;: get_option(&#39;prefix&#39;) / get_option(&=
#39;bindir&#39;) / exe[&#39;name&#39;], &#39;install&#39;: true},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&#39;ext&#39;: &#39;-simpletrace.stp&#39=
;, &#39;fmt&#39;: &#39;simpletrace-stap&#39;, &#39;bin&#39;: &#39;&#39;, &#=
39;install&#39;: true},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&#39;ext&#39;: &#39;-log.stp&#39;, &#39;=
fmt&#39;: &#39;log-stap&#39;, &#39;bin&#39;: &#39;&#39;, &#39;install&#39;:=
 true},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 custom_target(exe_name + stp[&#39;ext&#39;],<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 custom_target(exe[&#39;name&#39;] + stp[&#39;e=
xt&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0input: trace_events_all,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 output: exe_name + stp[&#39;ext&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 output: exe[&#39;name&#39;] + stp[&#39;ext&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0capture: true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0install: stp[&#39;install&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0install_dir: config_host[&#39;qemu_datadir&#39;] / &#39;../system=
tap/tapset&#39;,<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div>

--000000000000ead3a505addd4356--


