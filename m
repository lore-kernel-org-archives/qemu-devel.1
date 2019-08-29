Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94608C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643EA20673
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643EA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OWm-0000uG-Hu
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bo.liu@linux.alibaba.com>) id 1i3OLy-00071P-Gw
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bo.liu@linux.alibaba.com>) id 1i3OLs-0001NU-60
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:36:53 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:24035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bo.liu@linux.alibaba.com>)
 id 1i3OLr-0001IY-S2
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:36:52 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=bo.liu@linux.alibaba.com; NM=1;
 PH=DS; RN=3; SR=0; TI=SMTPD_---0TanZnyM_1567100196; 
Received: from US-160370MP2.local(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0TanZnyM_1567100196) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 30 Aug 2019 01:36:37 +0800
Date: Thu, 29 Aug 2019 10:36:35 -0700
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190829173635.exnopmkotuh5snpa@US-160370MP2.local>
References: <20190829104133.17418-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829104133.17418-1-stefanha@redhat.com>
User-Agent: NeoMutt/20180323
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH] virtiofsd: add man page
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
Reply-To: bo.liu@linux.alibaba.com
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 11:41:33AM +0100, Stefan Hajnoczi wrote:

Looks good to me, thanks for working this out.

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

thanks,
-liubo
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile                         |  7 +++
>  contrib/virtiofsd/virtiofsd.texi | 85 ++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 contrib/virtiofsd/virtiofsd.texi
> 
> diff --git a/Makefile b/Makefile
> index a3dfdd6fa8..cc18025753 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -334,6 +334,9 @@ DOCS+=docs/qemu-cpu-models.7
>  ifdef CONFIG_VIRTFS
>  DOCS+=fsdev/virtfs-proxy-helper.1
>  endif
> +ifdef CONFIG_LINUX
> +DOCS+=contrib/virtiofsd/virtiofsd.1
> +endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
>  DOCS+=scripts/qemu-trace-stap.1
>  endif
> @@ -834,6 +837,9 @@ ifdef CONFIG_VIRTFS
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
>  endif
> +ifdef CONFIG_LINUX
> +	$(INSTALL_DATA) contrib/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
> +endif
>  
>  install-datadir:
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"
> @@ -1018,6 +1024,7 @@ qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
>  qemu.1: qemu-option-trace.texi
>  qemu-img.1: qemu-img.texi qemu-option-trace.texi qemu-img-cmds.texi
>  fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
> +contrib/virtiofsd/virtiofsd.1: contrib/virtiofsd/virtiofsd.texi
>  qemu-nbd.8: qemu-nbd.texi qemu-option-trace.texi
>  qemu-ga.8: qemu-ga.texi
>  docs/qemu-block-drivers.7: docs/qemu-block-drivers.texi
> diff --git a/contrib/virtiofsd/virtiofsd.texi b/contrib/virtiofsd/virtiofsd.texi
> new file mode 100644
> index 0000000000..eec7fbf4e6
> --- /dev/null
> +++ b/contrib/virtiofsd/virtiofsd.texi
> @@ -0,0 +1,85 @@
> +@example
> +@c man begin SYNOPSIS
> +@command{virtiofsd} [OPTION] @option{--socket-path=}@var{path}|@option{--fd=}@var{fdnum} @option{-o source=}@var{path}
> +@c man end
> +@end example
> +
> +@c man begin DESCRIPTION
> +
> +Share a host directory tree with a guest through a virtio-fs device.  This
> +program is a vhost-user backend that implements the virtio-fs device.  Each
> +virtio-fs device instance requires its own virtiofsd process.
> +
> +This program is designed to work with QEMU's @code{--device vhost-user-fs-pci}
> +but should work with any virtual machine monitor (VMM) that supports
> +vhost-user.  See the EXAMPLES section below.
> +
> +This program must be run as the root user.  Upon startup the program will
> +switch into a new file system namespace with the shared directory tree as its
> +root.  This prevents "file system escapes" due to symlinks and other file
> +system objects that might lead to files outside the shared directory.  The
> +program also sandboxes itself using seccomp(2) to prevent ptrace(2) and other
> +vectors that could allow an attacker to compromise the system after gaining
> +control of the virtiofsd process.
> +
> +@c man end
> +
> +@c man begin OPTIONS
> +@table @option
> +@item -h, --help
> +Print help.
> +@item -V, --version
> +Print version.
> +@item -d, -o debug
> +Enable debug output.
> +@item --syslog
> +Print log messages to syslog instead of stderr.
> +@item -o log_level=@var{level}
> +Print only log messages matching @var{level} or more severe.  @var{level} is
> +one of @code{err}, @code{warn}, @code{info}, or @code{debug}.  The default is
> +@var{info}.
> +@item -o source=@var{path}
> +Share host directory tree located at @var{path}.  This option is required.
> +@item --socket-path=@var{path}, -o vhost_user_socket=@var{path}
> +Listen on vhost-user UNIX domain socket at @var{path}.
> +@item --fd=@var{fdnum}
> +Accept connections from vhost-user UNIX domain socket file descriptor @var{fdnum}.  The file descriptor must already be listening for connections.
> +@item --thread-pool-size=@var{num}
> +Restrict the number of worker threads per request queue to @var{num}.  The default is 64.
> +@item --cache=@code{none}|@code{auto}|@code{always}
> +Select the desired trade-off between coherency and performance.  @code{none}
> +forbids the FUSE client from caching to achieve best coherency at the cost of
> +performance.  @code{auto} acts similar to NFS with a 1 second metadata cache
> +timeout.  @code{always} sets a long cache lifetime at the expense of coherency.
> +@item --writeback
> +Enable writeback cache, allowing the FUSE client to buffer and merge write requests.
> +@end table
> +@c man end
> +
> +@c man begin EXAMPLES
> +Export @code{/var/lib/fs/vm001/} on vhost-user UNIX domain socket @code{/var/run/vm001-vhost-fs.sock}:
> +
> +@example
> +host# virtiofsd --socket-path=/var/run/vm001-vhost-fs.sock -o source=/var/lib/fs/vm001
> +host# qemu-system-x86_64 \
> +    -chardev socket,id=char0,path=/var/run/vm001-vhost-fs.sock \
> +    -device vhost-user-fs-pci,chardev=char0,tag=myfs \
> +    -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
> +    -numa node,memdev=mem \
> +    ...
> +guest# mount -t virtio_fs \
> +    -o default_permissions,allow_other,user_id=0,group_id=0,rootmode=040000,dax \
> +    myfs /mnt
> +@end example
> +@c man end
> +
> +@ignore
> +@setfilename virtiofsd
> +@settitle QEMU virtio-fs shared file system daemon
> +
> +@c man begin AUTHOR
> +Copyright (C) 2019 Red Hat, Inc.
> +This is free software; see the source for copying conditions.  There is NO
> +warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> +@c man end
> +@end ignore
> -- 
> 2.21.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs

