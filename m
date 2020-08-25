Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC666C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F682067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj6gmxw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F682067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUt4-00054Z-Vs
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAUsL-00044b-Ju
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAUsJ-00043s-Mr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598346254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kzt9sMQ2GK3B/ZPVxVobvhzRObQ2ft6dCw7yEioZdRM=;
 b=Cj6gmxw5CKnT0UUB2MBgmvzpt1DBI+oetSKcUzZG4ce2ehOcgfS7AEwlcjw9Kl+O6S3Qep
 bPup0nStrr8uVfWJc2EqEEIpNnVePk0FZIDFxLdsKNTVAXdIhGdw6XzaIFR449BZbydjYa
 dFbQ/0+zNd9yIhHTZYgTViC4+hJIowk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-s96cHMgbPL6BuZsbJQslTQ-1; Tue, 25 Aug 2020 05:04:12 -0400
X-MC-Unique: s96cHMgbPL6BuZsbJQslTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF93A801AE6;
 Tue, 25 Aug 2020 09:04:11 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FF35D9D3;
 Tue, 25 Aug 2020 09:04:10 +0000 (UTC)
Date: Tue, 25 Aug 2020 10:04:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: luoyonggang@gmail.com
Subject: Re: [PATCH 5/5] configure: replace all $PWD with $build_path that
 can handling msys2 properly
Message-ID: <20200825090407.GD107278@redhat.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
 <20200825083500.359-5-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200825083500.359-5-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 04:35:00PM +0800, luoyonggang@gmail.com wrote:

Please explain *why* the change is needed in the commit message.
ie explain what's broken with current code.

> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> ---
>  configure | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/configure b/configure
> index b8f5b81a67..a0e2b20877 100755
> --- a/configure
> +++ b/configure
> @@ -13,8 +13,13 @@ export CCACHE_RECACHE=yes
>  
>  # make source path absolute
>  source_path=$(cd "$(dirname -- "$0")"; pwd)
> +build_path=$PWD
> +if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then
> +source_path=$(cd "$(dirname -- "$0")"; pwd -W)
> +build_path=`pwd -W`

What is the -W arg - that seems to not exist in pwd that I
see, so I guess its something msys custom.

> +fi
>  
> -if test "$PWD" = "$source_path"
> +if test "$build_path" = "$source_path"
>  then
>      echo "Using './build' as the directory for build output"
>  
> @@ -346,7 +351,12 @@ ld_has() {
>      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>  }
>  
> -if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> +check_valid_build_path="[[:space:]:]"
> +if [ "$MSYSTEM" = "MINGW64" -o  "$MSYSTEM" = "MINGW32" ]; then
> +check_valid_build_path="[[:space:]]"
> +fi
> +
> +if printf %s\\n "$source_path" "$build_path" | grep -q "$check_valid_build_path";
>  then
>    error_exit "main directory cannot contain spaces nor colons"
>  fi
> @@ -942,7 +952,7 @@ Linux)
>    linux="yes"
>    linux_user="yes"
>    kvm="yes"
> -  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I$PWD/linux-headers $QEMU_INCLUDES"
> +  QEMU_INCLUDES="-isystem ${source_path}/linux-headers -I${build_path}/linux-headers $QEMU_INCLUDES"
>    libudev="yes"
>  ;;
>  esac
> @@ -4299,7 +4309,7 @@ EOF
>                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
>            fi
>            fdt_cflags="-I${source_path}/dtc/libfdt"
> -          fdt_ldflags="-L$PWD/dtc/libfdt"
> +          fdt_ldflags="-L${build_path}/dtc/libfdt"
>            fdt_libs="$fdt_libs"
>        elif test "$fdt" = "yes" ; then
>            # Not a git build & no libfdt found, prompt for system install
> @@ -5284,7 +5294,7 @@ case "$capstone" in
>      else
>        LIBCAPSTONE=libcapstone.a
>      fi
> -    capstone_libs="-L$PWD/capstone -lcapstone"
> +    capstone_libs="-L${build_path}/capstone -lcapstone"
>      capstone_cflags="-I${source_path}/capstone/include"
>      ;;
>  
> @@ -6284,8 +6294,8 @@ case "$slirp" in
>        git_submodules="${git_submodules} slirp"
>      fi
>      mkdir -p slirp
> -    slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
> -    slirp_libs="-L$PWD/slirp -lslirp"
> +    slirp_cflags="-I${source_path}/slirp/src -I${build_path}/slirp/src"
> +    slirp_libs="-L${build_path}/slirp -lslirp"
>      if test "$mingw32" = "yes" ; then
>        slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
>      fi
> @@ -8233,7 +8243,7 @@ fi
>  mv $cross config-meson.cross
>  
>  rm -rf meson-private meson-info meson-logs
> -NINJA=$PWD/ninjatool $meson setup \
> +NINJA="${build_path}/ninjatool" $meson setup \
>          --prefix "${pre_prefix}$prefix" \
>          --libdir "${pre_prefix}$libdir" \
>          --libexecdir "${pre_prefix}$libexecdir" \
> @@ -8249,11 +8259,11 @@ NINJA=$PWD/ninjatool $meson setup \
>          -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
>          -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
>          -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
> -	-Dsdl=$sdl -Dsdl_image=$sdl_image \
> -	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
> -	-Dgettext=$gettext \
> +        -Dsdl=$sdl -Dsdl_image=$sdl_image \
> +        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
> +        -Dgettext=$gettext \
>          $cross_arg \
> -        "$PWD" "$source_path"
> +        "$build_path" "$source_path"
>  
>  if test "$?" -ne 0 ; then
>      error_exit "meson setup failed"
> -- 
> 2.27.0.windows.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


