Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD342C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806AA2075E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806AA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXX8o-0002Ok-EE
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 16:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1iXX71-0000iT-Cd
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1iXX6z-0005S0-Ua
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:02:07 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1iXX6z-0005Qn-8I
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:02:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id bo14so376523pjb.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 13:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vZCUxjUFcGZr3oT56ijEOYWDobulFCE1crA/znkeSsE=;
 b=CxN5uqiJtr/HeJ8VrayJnj0mza9iMv7ISvjOwTmHLJ3BG69VCG23j6c3TEj8hQdIbg
 SNvVf9EXFTWUR7spmEAfYZZ0Ti+MNlLIVWnUdVIE5fV1j34LFp5q5AKLOmt2eL8fvnqb
 o3N2dkogcSlu0aOgd3hgp7kfb9Q81XF4t32drRDiUzAG+vXU8HZUqk53OSHqsNWig/7s
 mG9E6ScDlQCPG2iTiSPLn3bO85WfTZfvTpXtbef5wXHtYCq46qxZhgVVklMNrJuicMcG
 8Wy/yb+Q0MVggzz74BlPdzVvZjB9b4iI1TMPOWW7nC+j/KB9BpA7/UCvX73uekNyFGld
 phNQ==
X-Gm-Message-State: APjAAAUK4QRB3E8GGse62OrQo6mnWSEYstHU5n1wTSg9oTSUQsMhOm/D
 cBGZj1jdhX7I1q3gvouofrpW9ktKWAA=
X-Google-Smtp-Source: APXvYqz16dg1kPmzQ5KeNDmxW7sLLHWClLblq9Hn1bbIWYREmyaCSxkS5gawIsAhOsyoWnerxvB3lQ==
X-Received: by 2002:a17:90a:3522:: with SMTP id
 q31mr6642850pjb.18.1574283722121; 
 Wed, 20 Nov 2019 13:02:02 -0800 (PST)
Received: from localhost ([2620:15c:2d1:100:7901:ead3:b8cd:1c59])
 by smtp.gmail.com with ESMTPSA id z23sm131108pgj.43.2019.11.20.13.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 13:02:01 -0800 (PST)
Date: Wed, 20 Nov 2019 13:02:00 -0800
From: Fangrui Song <i@maskray.me>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] configure: Use lld --image-base for --disable-pie user
 mode binaries
Message-ID: <20191120210200.hvwlfuzo2vy5d5n4@gmail.com>
References: <20191116052815.nop3xkmd4umqsdsb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191116052815.nop3xkmd4umqsdsb@google.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.65
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-11-15, Fangrui Song wrote:
>For lld, --image-base is the preferred way to set the base address.
>lld does not actually implement -Ttext-segment, but treats it as an alias for
>-Ttext. -Ttext-segment=0x60000000 combined with --no-rosegment can
>create a 1.6GB executable.
>
>Fix the problem by using --image-base for lld. GNU ld and gold will
>still get -Ttext-segment. Also delete the ld --verbose fallback introduced
>in 2013, which is no longer relevant or correct (the default linker
>script has changed).
>
>Signed-off-by: Fangrui Song <i@maskray.me>
>---
>  configure | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>
>diff --git a/configure b/configure
>index 6099be1d84..2d45af0d09 100755
>--- a/configure
>+++ b/configure
>@@ -6336,43 +6336,34 @@ fi
>
>  # Probe for the need for relocating the user-only binary.
>  if ( [ "$linux_user" = yes ] || [ "$bsd_user" = yes ] ) && [ "$pie" = no ]; then
>-  textseg_addr=
>+  image_base=
>    case "$cpu" in
>      arm | i386 | ppc* | s390* | sparc* | x86_64 | x32)
>-      # ??? Rationale for choosing this address
>-      textseg_addr=0x60000000
>+      # An arbitrary address that makes it unlikely to collide with user
>+      # programs.
>+      image_base=0x60000000
>        ;;
>      mips)
>        # A 256M aligned address, high in the address space, with enough
>        # room for the code_gen_buffer above it before the stack.
>-      textseg_addr=0x60000000
>+      image_base=0x60000000
>        ;;
>    esac
>-  if [ -n "$textseg_addr" ]; then
>+  if [ -n "$image_base" ]; then
>      cat > $TMPC <<EOF
>      int main(void) { return 0; }
>  EOF
>-    textseg_ldflags="-Wl,-Ttext-segment=$textseg_addr"
>-    if ! compile_prog "" "$textseg_ldflags"; then
>-      # In case ld does not support -Ttext-segment, edit the default linker
>-      # script via sed to set the .text start addr.  This is needed on FreeBSD
>-      # at least.
>-      if ! $ld --verbose >/dev/null 2>&1; then
>+    image_base_ldflags="-Wl,--image-base=$image_base"
>+    if ! compile_prog "" "$image_base_ldflags"; then
>+      image_base_ldflags="-Wl,-Ttext-segment=$image_base"
>+      if ! compile_prog "" "$image_base_ldflags"; then
>          error_exit \
>              "We need to link the QEMU user mode binaries at a" \
>              "specific text address. Unfortunately your linker" \
>-            "doesn't support either the -Ttext-segment option or" \
>-            "printing the default linker script with --verbose." \
>+            "supports neither --image-base nor -Ttext-segment. " \
>              "If you don't want the user mode binaries, pass the" \
>              "--disable-user option to configure."
>        fi
>-
>-      $ld --verbose | sed \
>-        -e '1,/==================================================/d' \
>-        -e '/==================================================/,$d' \
>-        -e "s/[.] = [0-9a-fx]* [+] SIZEOF_HEADERS/. = $textseg_addr + SIZEOF_HEADERS/" \
>-        -e "s/__executable_start = [0-9a-fx]*/__executable_start = $textseg_addr/" > config-host.ld
>-      textseg_ldflags="-Wl,-T../config-host.ld"
>      fi
>    fi
>  fi
>@@ -7945,7 +7936,7 @@ if test "$gprof" = "yes" ; then
>  fi
>
>  if test "$target_linux_user" = "yes" || test "$target_bsd_user" = "yes" ; then
>-  ldflags="$ldflags $textseg_ldflags"
>+  ldflags="$ldflags $image_base_ldflags"
>  fi
>
>  # Newer kernels on s390 check for an S390_PGSTE program header and
>-- 
>2.24.0
>

Ping :)

