Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7CAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666262083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666262083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrac-0006v8-K6
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrPO-0005ao-Rw
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:32:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrPM-00035C-1G
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:32:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id p185so7587955qkb.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W5vDlQkgW0x22zIQNsrYibjZRroebgqCHUKw7kVrt/g=;
 b=r+d1wCVej1bo6dFj2djiKFd5hJL85IB7LCANbCeDa/P58HT8QQ8bYSiNy0qpH3Rii2
 YU5bYumtfpyUfIgmNxAOQ5fPf1mk6H8VB8zvdD49ydXL8dHykKUPQnJLWf9YmBGeqiIR
 200tk4ph4Vp7BZ4brW6eYcrYZKET0GtseYHzw6sFjCs6kPFLIGq0K3E+i6Saryb3pB3r
 o8wvSyQcRVZ90Eu22qXU+E4udKUQgmjohjZJzfneABj4EwBUVytUioRraNZKRFVDj/Mt
 EcUhkTPw8/dxA/CZVNakFqcaAuLD0+Dpu8JlaAfyvATqXrlddJ8OOb6TNYqryri95Icx
 T9Ng==
X-Gm-Message-State: AOAM531qt3VViwYJQU3fe8W2wCWy1KZPkeWowlNFDzEoUsCu6p8WPGDX
 xTaWuyVjWY4hDNo2O1RKrILqNR9lnnSeemQQC3c=
X-Google-Smtp-Source: ABdhPJzwbQOSmC24c/Kbf36QvPtgeE2vXWcuC47SjGnUgTcBJUpZZTEbXFA4DfPLeyizlhhpHKn20nP4eDYukrcC6bY=
X-Received: by 2002:a37:498e:: with SMTP id w136mr2843257qka.187.1598909527033; 
 Mon, 31 Aug 2020 14:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153228.229185-1-thuth@redhat.com>
In-Reply-To: <20200831153228.229185-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 23:31:51 +0200
Message-ID: <CAAdtpL5vu9uO7tGiHLNTVCeZa3bw2zRE_PLn1tD=L-acMH_0Qw@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci.yml: Run check-qtest and check-unit at the end
 of the fuzzer job
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000630c3a05ae3322b8"
Received-SPF: pass client-ip=209.85.222.195;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000630c3a05ae3322b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Le lun. 31 ao=C3=BBt 2020 17:33, Thomas Huth <thuth@redhat.com> a =C3=A9cri=
t :

> The fuzzer job finishes quite early, so we can run the unit tests and
> qtests with -fsanitize=3Daddress here without extending the total test ti=
me.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.yml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 17f1f8fad9..417fda6909 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -256,13 +256,14 @@ build-oss-fuzz:
>      - mkdir build-oss-fuzz
>      - CC=3D"clang" CXX=3D"clang++" CFLAGS=3D"-fsanitize=3Daddress"
>        ./scripts/oss-fuzz/build.sh
> +    - export ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0"
>      - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type =
f
>                        | grep -v slirp); do
>          grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 ||
> continue ;
>          echo Testing ${fuzzer} ... ;
> -        ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0"
> -         "${fuzzer}" -runs=3D1000 -seed=3D1 || exit 1 ;
> +        "${fuzzer}" -runs=3D1000 -seed=3D1 || exit 1 ;
>        done
> +    - cd build-oss-fuzz && make check-qtest-i386 check-unit
>

As this does not use the fuzzer main entry point, what is the point of
running that?


>  build-tci:
>    <<: *native_build_job_definition
> --
> 2.18.2
>
>
>

--000000000000630c3a05ae3322b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Thomas,<br><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Le lun. 31 ao=C3=BBt 2020 17:33, Thomas Huth=
 &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; a =C3=A9c=
rit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">The fuzzer job finishes =
quite early, so we can run the unit tests and<br>
qtests with -fsanitize=3Daddress here without extending the total test time=
.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0.gitlab-ci.yml | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
index 17f1f8fad9..417fda6909 100644<br>
--- a/.gitlab-ci.yml<br>
+++ b/.gitlab-ci.yml<br>
@@ -256,13 +256,14 @@ build-oss-fuzz:<br>
=C2=A0 =C2=A0 =C2=A0- mkdir build-oss-fuzz<br>
=C2=A0 =C2=A0 =C2=A0- CC=3D&quot;clang&quot; CXX=3D&quot;clang++&quot; CFLA=
GS=3D&quot;-fsanitize=3Daddress&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0./scripts/oss-fuzz/build.sh<br>
+=C2=A0 =C2=A0 - export ASAN_OPTIONS=3D&quot;fast_unwind_on_malloc=3D0&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0- for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -exec=
utable -type f<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| grep -v slirp); do<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grep &quot;LLVMFuzzerTestOneInput&quot; $=
{fuzzer} &gt; /dev/null 2&gt;&amp;1 || continue ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo Testing ${fuzzer} ... ;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ASAN_OPTIONS=3D&quot;fast_unwind_on_malloc=3D0=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;${fuzzer}&quot; -runs=3D1000 -seed=
=3D1 || exit 1 ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;${fuzzer}&quot; -runs=3D1000 -seed=3D1 |=
| exit 1 ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
+=C2=A0 =C2=A0 - cd build-oss-fuzz &amp;&amp; make check-qtest-i386 check-u=
nit<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">As this does not use the fuzzer main entry point, what is the point of r=
unning that?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0build-tci:<br>
=C2=A0 =C2=A0&lt;&lt;: *native_build_job_definition<br>
-- <br>
2.18.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000630c3a05ae3322b8--

