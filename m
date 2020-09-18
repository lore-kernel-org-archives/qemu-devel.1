Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D1C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF71720DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 11:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="lwW1WWb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF71720DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJEz1-0000bu-Rt
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 07:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kJEyA-0008FT-Pn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:54:26 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42482 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kJEy7-0006iK-EL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 07:54:26 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id E01845753A;
 Fri, 18 Sep 2020 11:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1600430058;
 x=1602244459; bh=lI78s2dKu7R99W0oW0YpgKxhko77kWjM5ApxPCrqLMM=; b=
 lwW1WWb4nWgOO5ElE4KbLv8k/dyZcqFufwE96+T3nVtMwQEf1wXXuT9+cByYnCgU
 C/gpWZG22NbcGjxpzzFpdGJrKHymSaxCc5W8A+Dil2zbx3XbJJN9h+5ASaDCzEga
 aKcMpwOd2puXdF8m6CPICWSLhiisu/tKWxKa2+wSjbY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZY6CnyhQQ5xD; Fri, 18 Sep 2020 14:54:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 8413C5732F;
 Fri, 18 Sep 2020 14:54:18 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Sep 2020 14:54:18 +0300
Date: Fri, 18 Sep 2020 14:54:17 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] configure: move cocoa option to Meson
Message-ID: <20200918115417.GA42655@SPB-NB-133.local>
References: <20200916081131.21775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916081131.21775-1-pbonzini@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 07:54:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 04:11:30AM -0400, Paolo Bonzini wrote:
> While detection of the framework was already there, moving
> the option allows for better error reporting.
> 
> Reported-by: Christophe de Dinechin <dinechin@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure         | 17 +++++++----------
>  meson.build       | 10 ++++++++--
>  meson_options.txt |  2 ++
>  ui/meson.build    |  2 +-
>  4 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/configure b/configure
> index d6fbadad27..b4c0e0d07c 100755
> --- a/configure
> +++ b/configure
> @@ -448,7 +448,7 @@ bsd="no"
>  linux="no"
>  solaris="no"
>  profiler="no"
> -cocoa="no"
> +cocoa="auto"
>  softmmu="yes"
>  linux_user="no"
>  bsd_user="no"
> @@ -868,7 +868,7 @@ Darwin)
>      QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
>      QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
>    fi
> -  cocoa="yes"
> +  cocoa="enabled"
>    audio_drv_list="coreaudio try-sdl"
>    audio_possible_drivers="coreaudio sdl"
>    QEMU_LDFLAGS="-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS"
> @@ -1240,10 +1240,10 @@ for opt do
>    ;;
>    --enable-profiler) profiler="yes"
>    ;;
> -  --disable-cocoa) cocoa="no"
> +  --disable-cocoa) cocoa="disabled"
>    ;;
>    --enable-cocoa)
> -      cocoa="yes" ;
> +      cocoa="enabled" ;
>        audio_drv_list="coreaudio $(echo $audio_drv_list | sed s,coreaudio,,g)"
>    ;;
>    --disable-system) softmmu="no"
> @@ -2388,8 +2388,8 @@ fi
>  # cocoa implies not SDL or GTK
>  # (the cocoa UI code currently assumes it is always the active UI
>  # and doesn't interact well with other UI frontend code)
> -if test "$cocoa" = "yes"; then
> -    if test "$sdl" = "yes"; then
> +if test "$cocoa" = "enabled"; then
> +    if test "$sdl" = "enabled"; then
>          error_exit "Cocoa and SDL UIs cannot both be enabled at once"
>      fi
>      if test "$gtk" = "yes"; then
> @@ -6622,9 +6622,6 @@ if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
>    echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
>    echo "X11_LIBS=$x11_libs" >> $config_host_mak
>  fi
> -if test "$cocoa" = "yes" ; then
> -  echo "CONFIG_COCOA=y" >> $config_host_mak
> -fi
>  if test "$iconv" = "yes" ; then
>    echo "CONFIG_ICONV=y" >> $config_host_mak
>    echo "ICONV_CFLAGS=$iconv_cflags" >> $config_host_mak
> @@ -7937,7 +7934,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
>          -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
>          -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
>  	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
> -	-Dsdl=$sdl -Dsdl_image=$sdl_image \
> +	-Dcocoa=$cocoa -Dsdl=$sdl -Dsdl_image=$sdl_image \
>  	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
>  	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
>          $cross_arg \
> diff --git a/meson.build b/meson.build
> index d3b1e5c34c..c94e92d774 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -88,7 +88,7 @@ socket = []
>  version_res = []
>  coref = []
>  iokit = []
> -cocoa = []
> +cocoa = not_found
>  hvf = []
>  if targetos == 'windows'
>    socket = cc.find_library('ws2_32')
> @@ -101,7 +101,7 @@ if targetos == 'windows'
>  elif targetos == 'darwin'
>    coref = dependency('appleframeworks', modules: 'CoreFoundation')
>    iokit = dependency('appleframeworks', modules: 'IOKit')
> -  cocoa = dependency('appleframeworks', modules: 'Cocoa')
> +  cocoa = dependency('appleframeworks', modules: 'Cocoa', required: get_option('cocoa'))
>    hvf = dependency('appleframeworks', modules: 'Hypervisor')
>  elif targetos == 'sunos'
>    socket = [cc.find_library('socket'),
> @@ -112,6 +112,11 @@ elif targetos == 'haiku'
>              cc.find_library('network'),
>              cc.find_library('bsd')]
>  endif
> +
> +if not cocoa.found() and get_option('cocoa').enabled()
> +  error('Cocoa not available on this platform')
> +endif
> +
>  # The path to glib.h is added to all compilation commands.  This was
>  # grandfathered in from the QEMU Makefiles.
>  add_project_arguments(config_host['GLIB_CFLAGS'].split(),
> @@ -461,6 +466,7 @@ endif
>  
>  # Create config-host.h
>  
> +config_host_data.set('CONFIG_COCOA', cocoa.found())
>  config_host_data.set('CONFIG_SDL', sdl.found())
>  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
>  config_host_data.set('CONFIG_VNC', vnc.found())
> diff --git a/meson_options.txt b/meson_options.txt
> index 894e006799..599af8485f 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -11,6 +11,8 @@ option('malloc_trim', type : 'feature', value : 'auto',
>  option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
>         value: 'system', description: 'choose memory allocator to use')
>  
> +option('cocoa', type : 'feature', value : 'auto',
> +       description: 'Cocoa user interface (macOS only)')
>  option('sdl', type : 'feature', value : 'auto',
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
> diff --git a/ui/meson.build b/ui/meson.build
> index dd6c110136..8a080c38e3 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -15,7 +15,7 @@ softmmu_ss.add(files(
>  
>  softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('input-linux.c'))
>  softmmu_ss.add(when: 'CONFIG_SPICE', if_true: files('spice-core.c', 'spice-input.c', 'spice-display.c'))
> -softmmu_ss.add(when: [cocoa, 'CONFIG_COCOA'], if_true: files('cocoa.m'))
> +softmmu_ss.add(when: cocoa, if_true: files('cocoa.m'))
>  
>  vnc_ss = ss.source_set()
>  vnc_ss.add(files(
> -- 
> 2.26.2
> 

Hi Paolo,

The patch looks good but can't be applied to yesterday's evening
master:

Applying: configure: move cocoa option to Meson
error: patch failed: configure:7937
error: configure: patch does not apply
error: patch failed: meson_options.txt:11
error: meson_options.txt: patch does not apply
Patch failed at 0001 configure: move cocoa option to Meson

Regards,
Roman

