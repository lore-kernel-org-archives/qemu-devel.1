Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C03C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3A7204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3A7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSlL-0004Dp-20
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hgSjX-0003MI-0N
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hgSjT-0004QO-1g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hgSjO-0004BD-Fn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:38:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3B53B3082E8E
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 11:38:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D49941001281;
 Thu, 27 Jun 2019 11:38:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 530EE11386A0; Thu, 27 Jun 2019 13:38:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-8-git-send-email-pbonzini@redhat.com>
Date: Thu, 27 Jun 2019 13:38:07 +0200
In-Reply-To: <1560165301-39026-8-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Mon, 10 Jun 2019 13:15:01 +0200")
Message-ID: <874l4bgsww.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 27 Jun 2019 11:38:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/7] rdmacm-mux: convert to Meson
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> We can use config-host.mak to decide whether the tool has to be built,
> apart from that the conversion is straightforward.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitignore                       | 1 +
>  Makefile                         | 5 -----
>  Makefile.objs                    | 1 -
>  contrib/rdmacm-mux/Makefile.objs | 3 ---
>  contrib/rdmacm-mux/meson.build   | 6 ++++++
>  meson.build                      | 2 ++
>  6 files changed, 9 insertions(+), 9 deletions(-)
>  delete mode 100644 contrib/rdmacm-mux/Makefile.objs
>  create mode 100644 contrib/rdmacm-mux/meson.build
>
> diff --git a/.gitignore b/.gitignore
> index 3934eff..b8d38a8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -63,6 +63,7 @@
>  /qemu-version.h.tmp
>  /module_block.h
>  /scsi/qemu-pr-helper
> +/contrib/rdmacm-mux/rdmacm-mux
>  /contrib/vhost-user-scsi/vhost-user-scsi
>  /contrib/vhost-user-blk/vhost-user-blk
>  /fsdev/virtfs-proxy-helper
> diff --git a/Makefile b/Makefile
> index bff097c..713f301 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -425,7 +425,6 @@ dummy := $(call unnest-vars,, \
>                  elf2dmp-obj-y \
>                  ivshmem-client-obj-y \
>                  ivshmem-server-obj-y \
> -                rdmacm-mux-obj-y \
>                  vhost-user-input-obj-y \
>                  vhost-user-gpu-obj-y \
>                  qga-vss-dll-obj-y \
> @@ -629,10 +628,6 @@ ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  endif
>  
> -rdmacm-mux$(EXESUF): LIBS += "-libumad"
> -rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
> -	$(call LINK, $^)
> -

Another way to pass extra flags to the compiler: target-specific
variables.  More direct than the funny variables we saw in the previous
patch.

The fine manual describes a way how to shoot yourself in the foot with
target-specific variabes.  Been there, done that, had "fun" debugging.

>  vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a
>  	$(call LINK, $^)
>  
> diff --git a/Makefile.objs b/Makefile.objs
> index adf2f92..cf02f63 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -116,7 +116,6 @@ qga-vss-dll-obj-y = qga/
>  elf2dmp-obj-y = contrib/elf2dmp/
>  ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
>  ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
> -rdmacm-mux-obj-y = contrib/rdmacm-mux/
>  vhost-user-input-obj-y = contrib/vhost-user-input/
>  vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
>  
> diff --git a/contrib/rdmacm-mux/Makefile.objs b/contrib/rdmacm-mux/Makefile.objs
> deleted file mode 100644
> index 3df744a..0000000
> --- a/contrib/rdmacm-mux/Makefile.objs
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -ifdef CONFIG_PVRDMA
> -rdmacm-mux-obj-y = main.o
> -endif
> diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
> new file mode 100644
> index 0000000..8451756
> --- /dev/null
> +++ b/contrib/rdmacm-mux/meson.build
> @@ -0,0 +1,6 @@
> +if config_host['CONFIG_PVRDMA'] == 'y'
> +  # if not found, CONFIG_PVRDMA should not be set

Our Makefiles use "either unset or 'y'" booleans pretty pervasively.  Is
it idiomatic meson?

> +  libumad = cc.find_library('ibumad', required: true)

With configure & make, we have configure check -libumad works, and make
use it.

Ignorant question: cc.find_library() looks like it checks.  Could this
replace checking in configure?

> +  executable('rdmacm-mux', files('main.c'),
> +             dependencies: [glib, libumad])
> +endif
> diff --git a/meson.build b/meson.build
> index bc7fbea..2fc6111 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1,4 +1,5 @@
>  project('qemu', 'c', meson_version: '>=0.50.999')
> +cc = meson.get_compiler('c')
>  
>  kconfig = import('unstable-kconfig')
>  config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
> @@ -14,5 +15,6 @@ libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split
>                            link_args: config_host['LIBISCSI_LIBS'].split())
>  
>  subdir('contrib/libvhost-user')
> +subdir('contrib/rdmacm-mux')
>  subdir('contrib/vhost-user-blk')
>  subdir('contrib/vhost-user-scsi')

