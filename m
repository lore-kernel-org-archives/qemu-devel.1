Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B6C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2750204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMLPwmQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2750204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFFK-0007eS-OZ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEFEl-0007Du-7e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:10:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kEFEj-0003kh-3P
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:10:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id z4so7452593wrr.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZQpJQVvdvL9MZGsVC4//doU5p2FSHvHYpSM+qQymIX8=;
 b=TMLPwmQufAUAMxHZrvqQ5spXVJqggzfg3PjVzctSmnPFKYIXpJ2Icp8EXwLu4TgGhk
 mkvLD46So+1U6CZdfCYBPHpnLj9Q731ahzRFuDfiSV3C0HssdVC0fzwoypXwl7R2KtSE
 Ljqj5IN4jf6dcc+IZDmDi26qpOOn47y5h2n2JSbKTe5RxNy16hBnNppf2x3RvF+Shtb0
 WUIYMZDcaIZpaKyufwCeOiT/tnQnaVyHGMYWm0LpYEqgmKh4P427uCT+cwmRAq5jEz+n
 03BGKPPKxkaYbcUJgCSMEyFQCm9CuPlUTOjlDcS6jtoY37RB+HfyeOCX0++8BJWd8U3i
 W8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZQpJQVvdvL9MZGsVC4//doU5p2FSHvHYpSM+qQymIX8=;
 b=eIZErvHDaMr/liHbFa9xlTPuUBSawRUS5wUvMjNtSrZ8rnsHEiATPyRbJRbAbtAJ+O
 LeL6X2pOQNXJ3oisTOYWQLDu1dkxTo5L8wxKonbRz/T+KKO/kxF2TzVg5EXRaDVjBAx1
 SoQDbNR/nEtgpS1eMy1oCV+Z0fOBCoX3srZkoPU9V0UJ40EHF3M54n0uT1SSqKsJp1Zg
 /BGM0lXQJX3PEcIEyDjoZRhifsf6Y7PvIysezJVyJdz8GzI5yloPee3+YUJHI8TaAzxR
 qMsRH02wBi46MsVrht+xPYJDxDN5UWQhTI441bpEqviYps3LLIjWo1NqtGqep0DV7ER/
 32xQ==
X-Gm-Message-State: AOAM533u3axXM4nVvpXmmIQIDj7gS5rSF+i75bFQh6KzcvNFVgJ1KLCl
 4FCAjrktxfIIcfaV4I/JjFrB9g==
X-Google-Smtp-Source: ABdhPJzK5qr0qSfZO4daIAkL1l+94x08FMIuJ9GQh2rEBU3IZc3/NVQmQI+nNicyUx1VcNX3SRUKig==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr9269636wrq.66.1599239450961; 
 Fri, 04 Sep 2020 10:10:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm21728774wmq.1.2020.09.04.10.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 10:10:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08DBA1FF7E;
 Fri,  4 Sep 2020 18:10:49 +0100 (BST)
References: <20200904165140.10962-1-alex.bennee@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
In-reply-to: <20200904165140.10962-1-alex.bennee@linaro.org>
Date: Fri, 04 Sep 2020 18:10:48 +0100
Message-ID: <87363x4gdj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> It's buggy and we are not sure anyone uses it.
>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

A more aggressive follow-up patch which would also solve the CI failures
across the board:

--8<---------------cut here---------------start------------->8---
configure: don't enable ppc64abi32-linux-user by default

The user can still enable this explicitly but they will get a warning
at the end of configure for their troubles. This also drops any builds
of ppc64abi32 from our CI tests.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

1 file changed, 27 insertions(+), 19 deletions(-)
configure | 46 +++++++++++++++++++++++++++-------------------

modified   configure
@@ -574,6 +574,8 @@ gettext=3D""
 bogus_os=3D"no"
 malloc_trim=3D""
=20
+deprecated_features=3D""
+
 # parse CC options first
 for opt do
   optarg=3D$(expr "x$opt" : 'x[^=3D]*=3D\(.*\)')
@@ -1769,26 +1771,25 @@ if [ "$bsd_user" =3D "yes" ]; then
     mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
=20
-if test -z "$target_list_exclude"; then
-    for config in $mak_wilds; do
-        default_target_list=3D"${default_target_list} $(basename "$config"=
 .mak)"
-    done
-else
-    exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-    for config in $mak_wilds; do
-        target=3D"$(basename "$config" .mak)"
-        exclude=3D"no"
-        for excl in $exclude_list; do
-            if test "$excl" =3D "$target"; then
-                exclude=3D"yes"
-                break;
-            fi
-        done
-        if test "$exclude" =3D "no"; then
-            default_target_list=3D"${default_target_list} $target"
+if test -z "$target_list_exclude" -a -z "$target_list"; then
+    # if the user doesn't specify anything lets skip deprecating stuff
+    target_list_exclude=3Dppc64abi32-linux-user
+fi
+
+exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')
+for config in $mak_wilds; do
+    target=3D"$(basename "$config" .mak)"
+    exclude=3D"no"
+    for excl in $exclude_list; do
+        if test "$excl" =3D "$target"; then
+            exclude=3D"yes"
+            break;
         fi
     done
-fi
+    if test "$exclude" =3D "no"; then
+        default_target_list=3D"${default_target_list} $target"
+    fi
+done
=20
 # Enumerate public trace backends for --help output
 trace_backend_list=3D$(echo $(grep -le '^PUBLIC =3D True$' "$source_path"/=
scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
@@ -7691,7 +7692,7 @@ TARGET_SYSTBL=3D""
 case "$target_name" in
   i386)
     mttcg=3D"yes"
-	gdb_xml_files=3D"i386-32bit.xml"
+    gdb_xml_files=3D"i386-32bit.xml"
     TARGET_SYSTBL_ABI=3Di386
     TARGET_SYSTBL=3Dsyscall_32.tbl
   ;;
@@ -7802,6 +7803,7 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=3Dcommon,nospu,32
     echo "TARGET_ABI32=3Dy" >> $config_target_mak
     gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml powe=
r-spe.xml power-vsx.xml"
+    deprecated_features=3D"ppc64abi32 ${deprecated_features}"
   ;;
   riscv32)
     TARGET_BASE_ARCH=3Driscv
@@ -8232,6 +8234,12 @@ fi
 touch ninjatool.stamp
 fi
=20
+if test -n "${deprecated_features}"; then
+    echo "Warning, deprecated features enabled."
+    echo "Please see docs/system/deprecated.rst"
+    echo "  features: ${deprecated_features}"
+fi
+
 # Save the configure command line for later reuse.
 cat <<EOD >config.status
 #!/bin/sh
--8<---------------cut here---------------end--------------->8---

--=20
Alex Benn=C3=A9e

