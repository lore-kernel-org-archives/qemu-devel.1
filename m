Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DAEC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EA120825
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbyOR4F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EA120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqX4-0006Gs-9U
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAqWN-0005lx-7h
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:11:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAqWL-0005Jk-GP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598429460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KTvxsIhC+lWyCDu9oOxx4ZAbm5G7V3+K7IlNc2oXLgc=;
 b=NbyOR4F6jQvnISkbJJfxVZpIea4BzvPIEqKGhXC7iGdN0ntxY5+QhUW9Mqxng7vcrE5NxC
 iPIQSVY1hiWEYAWwZN9RXPM7G6szmzDeMAeLPtgYSENwatTUeJUnhojZlVEHdHhsYwnLfL
 ME8luQX3UYI7LKdNmcE7zWaYfAkl7WQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-axXzWpJ1NKCCEH82eDppMA-1; Wed, 26 Aug 2020 04:10:58 -0400
X-MC-Unique: axXzWpJ1NKCCEH82eDppMA-1
Received: by mail-ed1-f70.google.com with SMTP id v11so391670edr.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KTvxsIhC+lWyCDu9oOxx4ZAbm5G7V3+K7IlNc2oXLgc=;
 b=F/ZABMWdDA7paASmQeGlaPOajhIHW83OGzlQvcYvqmqWbpsArAX/xIC/EQe1s1JvFl
 bqDKlZy6qfOpgE2/gZdIRy8fEjubxmoxujV8d7VgWHLdVXYlz9Y9tP+Jj7Lnwh4gKm7p
 UnxEzqozyh24J1driNjewDoEOGuKCfzdx7dY5kiqC9uxnjp6jrQIYWJIZymMIvRv1RJV
 kH6RcR35z1PEI04ip70YFhGu69xrCLGdIQg73jtUq4o2+nCbVksGnJ6t9rQ5XpmUCMTJ
 UGegSX+8FszEfL1xEBE3AwJpXZjuqUbTAah0Tf222TAM0UN+6RrBrZzfggDvy/21CGlL
 DOGw==
X-Gm-Message-State: AOAM5302ZsNEhZdb2iJ0eUIykSxjP91x3aB4SXsEj6tPxJq+G5GUW1XC
 CNp9eBSNu/WCa3QzhSGXt7tUm4vbM220NZuc55KNXCQivJsTIUgX0QAFhqkbsBRRgv80mwH9oB3
 i1zjz8Xjbu2VYZAtaTcy+dosW1kI3UrA=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr13809003edt.76.1598429457126; 
 Wed, 26 Aug 2020 01:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJaEHPu+YPj/KMSX72wPLEG3XsjPqepSRCY8c9ajORPKdB8UoBtlkos0VwvhGTWGSYiMSDS2BMOjNN7UmIHFU=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr13808994edt.76.1598429456977; 
 Wed, 26 Aug 2020 01:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200826075705.8961-1-azoff@svenskalinuxforeningen.se>
In-Reply-To: <20200826075705.8961-1-azoff@svenskalinuxforeningen.se>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 10:10:45 +0200
Message-ID: <CABgObfaNcczE8vqW1uJ54Tz5y-gHjELtqXV3J1PjFmr5tb8K8w@mail.gmail.com>
Subject: Re: [PATCH] os-posix: Restore firmware location ../share/qemu
To: azoff@azoff.se
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fb65a305adc35b15"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Torbj=C3=B6rn_Svensson?= <azoff@svenskalinuxforeningen.se>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fb65a305adc35b15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I will post next week a patch to make all searches relative to the
executable path. I will CC you so you can test it.

Thanks!

Paolo

Il mer 26 ago 2020, 10:01 <azoff@azoff.se> ha scritto:

> Prior to commit 6dd2dacedd83d12328afa8559bffb2b9ec5c89ed (v5.0.0), the
> binary relative path ../share/qemu was searched for firmware, but in
> that commit, this path got lost.
>
> Consider the following use-case:
> * QEMU is built in a docker image on one system.
> * QEMU is supposed to be executed on a plethora of distributions/systems
> * QEMU is not installed system wide on the executors
> When building QEMU, the --prefix configure flag is used to generate a
> tree containing all the QEMU resources that needs to be transfered to
> the executors. The path to the root of the QEMU tree might be different
> for the different executors, therefore, the path stored in
> CONFIG_QEMU_DATADIR is likely not the right one.
> With this use-case, the only likely path is one that is expressed as
> relative to the root of the QEMU binary tree or the QEMU binary iself.
>
> Signed-off-by: Torbj=C3=B6rn Svensson <azoff@svenskalinuxforeningen.se>
> ---
>  os-posix.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/os-posix.c b/os-posix.c
> index bf98508b6d..f016ac374c 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -96,6 +96,11 @@ char *os_find_datadir(void)
>      exec_dir =3D qemu_get_exec_dir();
>      g_return_val_if_fail(exec_dir !=3D NULL, NULL);
>
> +    dir =3D g_build_filename(exec_dir, "..", "share", "qemu", NULL);
> +    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> +        return g_steal_pointer(&dir);
> +    }
> +
>      dir =3D g_build_filename(exec_dir, "pc-bios", NULL);
>      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
>          return g_steal_pointer(&dir);
> --
> 2.26.2
>
>

--000000000000fb65a305adc35b15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi, I will post next week a patch to make all searches re=
lative to the executable path. I will CC you so you can test it.<div dir=3D=
"auto"><br></div><div dir=3D"auto">Thanks!</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Il mer 26 ago 2020, 10:01  &lt;<a href=3D"mai=
lto:azoff@azoff.se">azoff@azoff.se</a>&gt; ha scritto:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">Prior to commit 6dd2dacedd83d12328afa8559bffb2b9ec5c89e=
d (v5.0.0), the<br>
binary relative path ../share/qemu was searched for firmware, but in<br>
that commit, this path got lost.<br>
<br>
Consider the following use-case:<br>
* QEMU is built in a docker image on one system.<br>
* QEMU is supposed to be executed on a plethora of distributions/systems<br=
>
* QEMU is not installed system wide on the executors<br>
When building QEMU, the --prefix configure flag is used to generate a<br>
tree containing all the QEMU resources that needs to be transfered to<br>
the executors. The path to the root of the QEMU tree might be different<br>
for the different executors, therefore, the path stored in<br>
CONFIG_QEMU_DATADIR is likely not the right one.<br>
With this use-case, the only likely path is one that is expressed as<br>
relative to the root of the QEMU binary tree or the QEMU binary iself.<br>
<br>
Signed-off-by: Torbj=C3=B6rn Svensson &lt;<a href=3D"mailto:azoff@svenskali=
nuxforeningen.se" target=3D"_blank" rel=3D"noreferrer">azoff@svenskalinuxfo=
reningen.se</a>&gt;<br>
---<br>
=C2=A0os-posix.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/os-posix.c b/os-posix.c<br>
index bf98508b6d..f016ac374c 100644<br>
--- a/os-posix.c<br>
+++ b/os-posix.c<br>
@@ -96,6 +96,11 @@ char *os_find_datadir(void)<br>
=C2=A0 =C2=A0 =C2=A0exec_dir =3D qemu_get_exec_dir();<br>
=C2=A0 =C2=A0 =C2=A0g_return_val_if_fail(exec_dir !=3D NULL, NULL);<br>
<br>
+=C2=A0 =C2=A0 dir =3D g_build_filename(exec_dir, &quot;..&quot;, &quot;sha=
re&quot;, &quot;qemu&quot;, NULL);<br>
+=C2=A0 =C2=A0 if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_steal_pointer(&amp;dir);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0dir =3D g_build_filename(exec_dir, &quot;pc-bios&quot;,=
 NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return g_steal_pointer(&amp;dir);<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div>

--000000000000fb65a305adc35b15--


