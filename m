Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE5C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3450A2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3450A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQMN-0004xJ-IR
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 05:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hgQJc-0003DN-Ow
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hgQJb-0000zJ-ES
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:03:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hgQJa-0000xf-5S
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:03:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E700F30C8AB4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 09:03:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70963601B6;
 Thu, 27 Jun 2019 09:03:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D85D211386A0; Thu, 27 Jun 2019 11:03:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-5-git-send-email-pbonzini@redhat.com>
Date: Thu, 27 Jun 2019 11:03:30 +0200
In-Reply-To: <1560165301-39026-5-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Mon, 10 Jun 2019 13:14:58 +0200")
Message-ID: <87sgrvh02l.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 27 Jun 2019 09:03:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/7] libvhost-user: convert to Meson
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

> Because libqemuutil.a is not converted yet, selected files have to be
> compiled twice, once with Meson and once with Makefile.objs.  Apart
> from this the conversion is straightforward.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile                            | 10 ++++------
>  Makefile.objs                       |  1 -
>  contrib/libvhost-user/Makefile.objs |  1 -
>  contrib/libvhost-user/meson.build   |  7 +++++++
>  meson.build                         |  2 ++
>  5 files changed, 13 insertions(+), 8 deletions(-)
>  delete mode 100644 contrib/libvhost-user/Makefile.objs
>  create mode 100644 contrib/libvhost-user/meson.build
>
> diff --git a/Makefile b/Makefile
> index b8f802c..6a3461e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -426,7 +426,6 @@ dummy := $(call unnest-vars,, \
>                  ivshmem-client-obj-y \
>                  ivshmem-server-obj-y \
>                  rdmacm-mux-obj-y \
> -                libvhost-user-obj-y \
>                  vhost-user-scsi-obj-y \
>                  vhost-user-blk-obj-y \
>                  vhost-user-input-obj-y \
> @@ -529,7 +528,6 @@ Makefile: $(version-obj-y)
>  # Build libraries
>  
>  libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> -libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>  
>  ######################################################################
>  
> @@ -632,21 +630,21 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  endif
> -vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
> +vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) contrib/libvhost-user/libvhost-user.a
>  	$(call LINK, $^)
> -vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libvhost-user.a
> +vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) contrib/libvhost-user/libvhost-user.a
>  	$(call LINK, $^)
>  
>  rdmacm-mux$(EXESUF): LIBS += "-libumad"
>  rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  
> -vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
> +vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) contrib/libvhost-user/libvhost-user.a
>  	$(call LINK, $^)
>  
>  ifdef CONFIG_VHOST_USER_INPUT
>  ifdef CONFIG_LINUX
> -vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) libvhost-user.a libqemuutil.a
> +vhost-user-input$(EXESUF): $(vhost-user-input-obj-y) contrib/libvhost-user/libvhost-user.a $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  
>  # build by default, do not install

This hunk is only due to the move of libvhost-user.a from the root of
the build tree to contrib/libvhost-user/.  I'm not counting it as "meson
churn".

> diff --git a/Makefile.objs b/Makefile.objs
> index c8337fa..4f2fa6a 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -116,7 +116,6 @@ qga-vss-dll-obj-y = qga/
>  elf2dmp-obj-y = contrib/elf2dmp/
>  ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
>  ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
> -libvhost-user-obj-y = contrib/libvhost-user/
>  vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
>  vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
>  vhost-user-scsi-obj-y = contrib/vhost-user-scsi/
> diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
> deleted file mode 100644
> index ef3778e..0000000
> --- a/contrib/libvhost-user/Makefile.objs
> +++ /dev/null
> @@ -1 +0,0 @@
> -libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
> diff --git a/contrib/libvhost-user/meson.build b/contrib/libvhost-user/meson.build
> new file mode 100644
> index 0000000..7ef610a
> --- /dev/null
> +++ b/contrib/libvhost-user/meson.build
> @@ -0,0 +1,7 @@
> +libvhost_user = static_library('vhost-user',
> +               [files('libvhost-user.c', 'libvhost-user-glib.c'),

These are the "selected files [that] have to be compiled twice, once
with Meson and once with Makefile.objs":

> +                meson.source_root() / 'stubs/error-printf.c',
> +                meson.source_root() / 'stubs/monitor.c',
> +                meson.source_root() / 'util/error.c',
> +                meson.source_root() / 'util/qemu-error.c',
> +                meson.source_root() / 'util/memfd.c'])

Quite okay for a PoC.

> diff --git a/meson.build b/meson.build
> index b683d70..a6748f9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -7,3 +7,5 @@ add_project_arguments(config_host['QEMU_CFLAGS'].split(),
>                        language: 'c')
>  add_project_arguments(config_host['QEMU_INCLUDES'].split(),
>                        language: 'c')
> +
> +subdir('contrib/libvhost-user')

In your cover letter, you wrote "it's a simple example of how the
current build system causes clutter in the toplevel Makefiles and how
interrelated the Makefile, Makefile.objs and contrib/*/Makefile.objs
file are even for such simple executables."  True.  Before this patch,
the logic for building libvhost-user.a is split over Makefile (two
lines), Makefile.obj (one) and contrib/libvhost-user/Makefile.objs
(one).  Afterwards, its all in one place.

