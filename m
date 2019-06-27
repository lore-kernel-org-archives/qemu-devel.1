Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B77C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C76F204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C76F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSkn-0003z1-3d
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hgSUk-0000up-Ri
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hgSUj-0006oO-Jq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hgSUj-0006nL-Aa
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:23:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8070308A953
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 11:23:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB58360A97;
 Thu, 27 Jun 2019 11:23:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5FF2311386A0; Thu, 27 Jun 2019 13:23:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-7-git-send-email-pbonzini@redhat.com>
Date: Thu, 27 Jun 2019 13:23:00 +0200
In-Reply-To: <1560165301-39026-7-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Mon, 10 Jun 2019 13:15:00 +0200")
Message-ID: <87ef3fgtm3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 27 Jun 2019 11:23:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/7] vhost-user-scsi: convert to Meson
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

> The libiscsi pkg-config information is extracted from config-host.mak and
> used to link vhost-user-blk.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .gitignore                            | 2 +-
>  Makefile                              | 3 ---
>  Makefile.objs                         | 3 ---
>  contrib/vhost-user-scsi/Makefile.objs | 1 -
>  contrib/vhost-user-scsi/meson.build   | 3 +++
>  meson.build                           | 3 +++
>  6 files changed, 7 insertions(+), 8 deletions(-)
>  delete mode 100644 contrib/vhost-user-scsi/Makefile.objs
>  create mode 100644 contrib/vhost-user-scsi/meson.build
>
> diff --git a/.gitignore b/.gitignore
> index 20637a1..3934eff 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -63,7 +63,7 @@
>  /qemu-version.h.tmp
>  /module_block.h
>  /scsi/qemu-pr-helper
> -/vhost-user-scsi
> +/contrib/vhost-user-scsi/vhost-user-scsi
>  /contrib/vhost-user-blk/vhost-user-blk
>  /fsdev/virtfs-proxy-helper
>  *.tmp
> diff --git a/Makefile b/Makefile
> index da290fa..bff097c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -426,7 +426,6 @@ dummy := $(call unnest-vars,, \
>                  ivshmem-client-obj-y \
>                  ivshmem-server-obj-y \
>                  rdmacm-mux-obj-y \
> -                vhost-user-scsi-obj-y \
>                  vhost-user-input-obj-y \
>                  vhost-user-gpu-obj-y \
>                  qga-vss-dll-obj-y \
> @@ -629,8 +628,6 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  endif
> -vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a
> -	$(call LINK, $^)
>  
>  rdmacm-mux$(EXESUF): LIBS += "-libumad"
>  rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
> diff --git a/Makefile.objs b/Makefile.objs
> index 644e2bd..adf2f92 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -116,9 +116,6 @@ qga-vss-dll-obj-y = qga/
>  elf2dmp-obj-y = contrib/elf2dmp/
>  ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
>  ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
> -vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
> -vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
> -vhost-user-scsi-obj-y = contrib/vhost-user-scsi/

The casual reader may wonder what these variables do.  The %.o: %.c rule
in rules.mak passes $($@-cflags) to $(CC).

With meson, ...

>  rdmacm-mux-obj-y = contrib/rdmacm-mux/
>  vhost-user-input-obj-y = contrib/vhost-user-input/
>  vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
> diff --git a/contrib/vhost-user-scsi/Makefile.objs b/contrib/vhost-user-scsi/Makefile.objs
> deleted file mode 100644
> index e83a38a..0000000
> --- a/contrib/vhost-user-scsi/Makefile.objs
> +++ /dev/null
> @@ -1 +0,0 @@
> -vhost-user-scsi-obj-y = vhost-user-scsi.o
> diff --git a/contrib/vhost-user-scsi/meson.build b/contrib/vhost-user-scsi/meson.build
> new file mode 100644
> index 0000000..b80398c
> --- /dev/null
> +++ b/contrib/vhost-user-scsi/meson.build
> @@ -0,0 +1,3 @@
> +executable('vhost-user-scsi', files('vhost-user-scsi.c'),
> +           link_with: libvhost_user,
> +           dependencies: [glib, libiscsi])

... we instead name dependencies, which ...

> diff --git a/meson.build b/meson.build
> index c4cad8f..bc7fbea 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -10,6 +10,9 @@ add_project_arguments(config_host['QEMU_INCLUDES'].split(),
>  
>  glib = declare_dependency(compile_args: config_host['GLIB_CFLAGS'].split(),
>                            link_args: config_host['GLIB_LIBS'].split())
> +libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
> +                          link_args: config_host['LIBISCSI_LIBS'].split())

... we define here.  Less magical.

Note that there's also glib dependency, which works the same (see
previous patch).  With Make, we add GLib flags to QEMU_CFLAGS and LIBS,
so they get used for everything unless overridden.

>  
>  subdir('contrib/libvhost-user')
>  subdir('contrib/vhost-user-blk')
> +subdir('contrib/vhost-user-scsi')

