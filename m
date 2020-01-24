Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5365B2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5365B2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv28Z-0000IV-Gk
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iv27l-0007zW-9f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iv27j-0005vH-3U
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:48:01 -0500
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:52396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iv27i-0005id-SD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:47:58 -0500
Received: from player778.ha.ovh.net (unknown [10.108.54.36])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0209314F6DB
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 17:47:48 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id EDC68E9FC49B;
 Fri, 24 Jan 2020 16:47:39 +0000 (UTC)
Date: Fri, 24 Jan 2020 17:47:38 +0100
From: Greg Kurz <groug@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 8/8] virtfs-proxy-helper: Convert documentation to rST
Message-ID: <20200124174738.0b2407b9@bahia.lan>
In-Reply-To: <20200124162606.8787-9-peter.maydell@linaro.org>
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-9-peter.maydell@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2284450911118203153
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -92
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvdeggdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdekmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.180.21
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 16:26:06 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The virtfs-proxy-helper documentation is currently in
> fsdev/qemu-trace-stap.texi in Texinfo format, which we
> present to the user as:
>  * a virtfs-proxy-helper manpage
>  * but not (unusually for QEMU) part of the HTML docs
> 
> Convert the documentation to rST format that lives in
> the docs/ subdirectory, and present it to the user as:
>  * a virtfs-proxy-helper manpage
>  * part of the interop/ Sphinx manual
> 
> There are minor formatting changes to suit Sphinx, but no
> content changes. In particular I've split the -u and -g
> options into each having their own description text.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Thanks !

Acked-by: Greg Kurz <groug@kaod.org>

>  Makefile                             |  7 ++-
>  MAINTAINERS                          |  1 +
>  docs/interop/conf.py                 |  5 +-
>  docs/interop/index.rst               |  1 +
>  docs/interop/virtfs-proxy-helper.rst | 72 ++++++++++++++++++++++++++++
>  fsdev/virtfs-proxy-helper.texi       | 63 ------------------------
>  6 files changed, 81 insertions(+), 68 deletions(-)
>  create mode 100644 docs/interop/virtfs-proxy-helper.rst
>  delete mode 100644 fsdev/virtfs-proxy-helper.texi
> 
> diff --git a/Makefile b/Makefile
> index 5dded94bf63..e08882fd49f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -354,7 +354,7 @@ DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qe
>  DOCS+=docs/qemu-cpu-models.7
>  DOCS+=$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
> -DOCS+=fsdev/virtfs-proxy-helper.1
> +DOCS+=$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
>  endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
>  DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
> @@ -859,7 +859,7 @@ endif
>  endif
>  ifdef CONFIG_VIRTFS
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
> -	$(INSTALL_DATA) fsdev/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
> +	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
>  endif
>  
>  install-datadir:
> @@ -1051,7 +1051,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
>  	$(call build-manual,system,html)
>  
>  $(call define-manpage-rule,interop,\
> -       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1,\
> +       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-helper.1,\
>         $(SRC_PATH/qemu-img-cmds.hx))
>  
>  $(call define-manpage-rule,system,qemu-block-drivers.7)
> @@ -1078,7 +1078,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qga-qapi-doc.texi
>  
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-info.texi
>  qemu.1: qemu-option-trace.texi
> -fsdev/virtfs-proxy-helper.1: fsdev/virtfs-proxy-helper.texi
>  docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
>  
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html sphinxdocs
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54c4429069d..83fb32b8601 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1573,6 +1573,7 @@ S: Odd Fixes
>  F: hw/9pfs/
>  X: hw/9pfs/xen-9p*
>  F: fsdev/
> +F: docs/interop/virtfs-proxy-helper.rst
>  F: tests/qtest/virtio-9p-test.c
>  T: git https://github.com/gkurz/qemu.git 9p-next
>  
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index baea7fb50ee..b0f322207ca 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -24,5 +24,8 @@ man_pages = [
>      ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
>       ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
>      ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
> -     [], 1)
> +     [], 1),
> +    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
> +     u'QEMU 9p virtfs proxy filesystem helper',
> +     ['M. Mohan Kumar'], 1)
>  ]
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index d756a826b26..3b763b1eebe 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -23,3 +23,4 @@ Contents:
>     qemu-trace-stap
>     vhost-user
>     vhost-user-gpu
> +   virtfs-proxy-helper
> diff --git a/docs/interop/virtfs-proxy-helper.rst b/docs/interop/virtfs-proxy-helper.rst
> new file mode 100644
> index 00000000000..6cdeedf8e93
> --- /dev/null
> +++ b/docs/interop/virtfs-proxy-helper.rst
> @@ -0,0 +1,72 @@
> +QEMU 9p virtfs proxy filesystem helper
> +======================================
> +
> +Synopsis
> +--------
> +
> +**virtfs-proxy-helper** [*OPTIONS*]
> +
> +Description
> +-----------
> +
> +Pass-through security model in QEMU 9p server needs root privilege to do
> +few file operations (like chown, chmod to any mode/uid:gid).  There are two
> +issues in pass-through security model:
> +
> +- TOCTTOU vulnerability: Following symbolic links in the server could
> +  provide access to files beyond 9p export path.
> +
> +- Running QEMU with root privilege could be a security issue.
> +
> +To overcome above issues, following approach is used: A new filesystem
> +type 'proxy' is introduced. Proxy FS uses chroot + socket combination
> +for securing the vulnerability known with following symbolic links.
> +Intention of adding a new filesystem type is to allow qemu to run
> +in non-root mode, but doing privileged operations using socket IO.
> +
> +Proxy helper (a stand alone binary part of qemu) is invoked with
> +root privileges. Proxy helper chroots into 9p export path and creates
> +a socket pair or a named socket based on the command line parameter.
> +QEMU and proxy helper communicate using this socket. QEMU proxy fs
> +driver sends filesystem request to proxy helper and receives the
> +response from it.
> +
> +The proxy helper is designed so that it can drop root privileges except
> +for the capabilities needed for doing filesystem operations.
> +
> +Options
> +-------
> +
> +The following options are supported:
> +
> +.. program:: virtfs-proxy-helper
> +
> +.. option:: -h
> +
> +  Display help and exit
> +
> +.. option:: -p, --path PATH
> +
> +  Path to export for proxy filesystem driver
> +
> +.. option:: -f, --fd SOCKET_ID
> +
> +  Use given file descriptor as socket descriptor for communicating with
> +  qemu proxy fs drier. Usually a helper like libvirt will create
> +  socketpair and pass one of the fds as parameter to this option.
> +
> +.. option:: -s, --socket SOCKET_FILE
> +
> +  Creates named socket file for communicating with qemu proxy fs driver
> +
> +.. option:: -u, --uid UID
> +
> +  uid to give access to named socket file; used in combination with -g.
> +
> +.. option:: -g, --gid GID
> +
> +  gid to give access to named socket file; used in combination with -u.
> +
> +.. option:: -n, --nodaemon
> +
> +  Run as a normal program. By default program will run in daemon mode
> diff --git a/fsdev/virtfs-proxy-helper.texi b/fsdev/virtfs-proxy-helper.texi
> deleted file mode 100644
> index f4cbb60623b..00000000000
> --- a/fsdev/virtfs-proxy-helper.texi
> +++ /dev/null
> @@ -1,63 +0,0 @@
> -@example
> -@c man begin SYNOPSIS
> -@command{virtfs-proxy-helper} @var{options}
> -@c man end
> -@end example
> -
> -@c man begin DESCRIPTION
> -@table @description
> -Pass-through security model in QEMU 9p server needs root privilege to do
> -few file operations (like chown, chmod to any mode/uid:gid).  There are two
> -issues in pass-through security model
> -
> -1) TOCTTOU vulnerability: Following symbolic links in the server could
> -provide access to files beyond 9p export path.
> -
> -2) Running QEMU with root privilege could be a security issue.
> -
> -To overcome above issues, following approach is used: A new filesystem
> -type 'proxy' is introduced. Proxy FS uses chroot + socket combination
> -for securing the vulnerability known with following symbolic links.
> -Intention of adding a new filesystem type is to allow qemu to run
> -in non-root mode, but doing privileged operations using socket IO.
> -
> -Proxy helper(a stand alone binary part of qemu) is invoked with
> -root privileges. Proxy helper chroots into 9p export path and creates
> -a socket pair or a named socket based on the command line parameter.
> -QEMU and proxy helper communicate using this socket. QEMU proxy fs
> -driver sends filesystem request to proxy helper and receives the
> -response from it.
> -
> -The proxy helper is designed so that it can drop root privileges except
> -for the capabilities needed for doing filesystem operations.
> -
> -@end table
> -@c man end
> -
> -@c man begin OPTIONS
> -The following options are supported:
> -@table @option
> -@item -h
> -@findex -h
> -Display help and exit
> -@item -p|--path path
> -Path to export for proxy filesystem driver
> -@item -f|--fd socket-id
> -Use given file descriptor as socket descriptor for communicating with
> -qemu proxy fs drier. Usually a helper like libvirt will create
> -socketpair and pass one of the fds as parameter to -f|--fd
> -@item -s|--socket socket-file
> -Creates named socket file for communicating with qemu proxy fs driver
> -@item -u|--uid uid -g|--gid gid
> -uid:gid combination to give access to named socket file
> -@item -n|--nodaemon
> -Run as a normal program. By default program will run in daemon mode
> -@end table
> -@c man end
> -
> -@setfilename virtfs-proxy-helper
> -@settitle QEMU 9p virtfs proxy filesystem helper
> -
> -@c man begin AUTHOR
> -M. Mohan Kumar
> -@c man end


