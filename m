Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F408C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CF920674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmJXOM5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CF920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAph-0001DO-Ra
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixAp3-0000oQ-3D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixAoz-00018g-LX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:29:32 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixAoz-00017Y-EY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:29:29 -0500
Received: by mail-oi1-x243.google.com with SMTP id l9so3660662oii.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZZwEJ4zE9aZBQ68pMmOauHQZhTmi+1iB5aNkK9/6/7E=;
 b=cmJXOM5GowL9m+C8GbGx4GbO+ug13AEMv0wHeFvCcR2KPT1rHgawUPjOXmhvgx1Cg5
 TfVSxnV+lNnwnhDB00oxn56J3qTt/HjzrOsWYfJFu9GDVTfLV7nk+F0XKbbADeYqnF62
 Jd9TDaRuLNIBK0UEreeNoqSfUm7Xxb0p3qa7ISST3Yc59Ai07vBh4jsGvN0ni8c7sHpA
 pROwnkWBXF1Uds2AlrYAgzoh7QgWDszTEYqkxNK+Sc2P3c8qQK2eRAkoa4ynnLR9YA/t
 PaYilymqj9HrFFOUnjgD4H+/Shhzn6xfZ7/X/DpIzyxWFl3JaclfsHwF31EDB6CX5Q5u
 1E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZZwEJ4zE9aZBQ68pMmOauHQZhTmi+1iB5aNkK9/6/7E=;
 b=WGLKEBLTC8BFyYMUsvxSn1k82IbWFPneV0W6PDD0kWQy0okTJjKm46+AOK+Ab4cpiR
 nIYc+OarFRllhWk1ckAlMa0k59wSULA2mf6fs1mDeNB6nISZAjUFd874rzQcvb6VY8Gq
 JGzEdyJKkgTbiWyYORFLPi4t/l5kLgGnuYrX8TuEZDEfiCuBFKxLAHuQm7kAPL5Dxtc0
 Yz1q8DdbasSg4X/R7EgBUzQCQh+WH8lreA9fsxGGl4XtWNvXwD7a3h2HQbTbWDTMrfZ3
 P13RRRTAT7q+9YAFPH6uSyu1rhwIilpBK4T8k5wYbGuX8WoSJ8vJjK4DWN4hYwZ1B9vZ
 naYg==
X-Gm-Message-State: APjAAAVaxYy2o+4pfthOBBPjB3xfNGLDpkf2cHS3eMtIgNGQTTGarqka
 i6kzYMVW1YgvXJ0/RiT3kUHTTQh0SQm0rXVbgf2w+Q==
X-Google-Smtp-Source: APXvYqw8zYfZglry4Dr6Z2tX2s7P0/kqPo4VkPx7YEfBEJL1uyHkn7OApWWkAmZYsNdl33g9OE3pJGkqF0udK8VQanc=
X-Received: by 2002:aca:7514:: with SMTP id q20mr2943068oic.48.1580394568292; 
 Thu, 30 Jan 2020 06:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20200127162514.56784-1-stefanha@redhat.com>
In-Reply-To: <20200127162514.56784-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 14:29:17 +0000
Message-ID: <CAFEAcA-yR6fEiAb9C8nts8BGu9CUE5enDVomBXnF_Pw_C88WEw@mail.gmail.com>
Subject: Re: [PATCH] docs: add virtiofsd(1) man page
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 16:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Document the virtiofsd(1) program and its command-line options.  This
> man page is a rST conversion of the original texi documentation that I
> wrote.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Based-on: 20200124162606.8787-1-peter.maydell@linaro.org
>           ("[PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-helper: convert to rST")
> ---
>  MAINTAINERS                |   1 +
>  Makefile                   |   8 ++-
>  docs/interop/conf.py       |   5 +-
>  docs/interop/index.rst     |   1 +
>  docs/interop/virtiofsd.rst | 123 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 136 insertions(+), 2 deletions(-)
>  create mode 100644 docs/interop/virtiofsd.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83fb32b860..1da0709129 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1603,6 +1603,7 @@ S: Supported
>  F: tools/virtiofsd/*
>  F: hw/virtio/vhost-user-fs*
>  F: include/hw/virtio/vhost-user-fs.h
> +F: docs/interop/virtiofsd.rst
>
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>
> diff --git a/Makefile b/Makefile
> index 539f9ef079..ecd26044bc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -348,6 +348,9 @@ DOCS=qemu-doc.html qemu-doc.txt qemu.1
>  DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-img.1
>  DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
>  DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga.8
> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> +DOCS+=$(MANUAL_BUILDDIR)/interop/virtiofsd.1
> +endif
>  DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
>  DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
> @@ -861,6 +864,9 @@ ifdef CONFIG_VIRTFS
>         $(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>         $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(DESTDIR)$(mandir)/man1"
>  endif
> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> +       $(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"

Thie first argument should be "$(MANUAL_BUILDDIR)/docs/interop/virtiofsd.1",
otherwise build-and-install for an in-source-directory build
won't work.

> +endif
>
>  install-datadir:
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"

> --- /dev/null
> +++ b/docs/interop/virtiofsd.rst
> @@ -0,0 +1,123 @@
> +QEMU virtio-fs shared file system daemon
> +========================================
> +
> +Synopsis
> +--------
> +
> +**virtiofsd** [*OPTIONS*]
> +
> +Description
> +-----------
> +
> +Share a host directory tree with a guest through a virtio-fs device.  This
> +program is a vhost-user backend that implements the virtio-fs device.  Each
> +virtio-fs device instance requires its own virtiofsd process.
> +
> +This program is designed to work with QEMU's ``--device vhost-user-fs-pci``
> +but should work with any virtual machine monitor (VMM) that supports
> +vhost-user.  See the Examples section below.
> +
> +This program must be run as the root user.  Upon startup the program will
> +switch into a new file system namespace with the shared directory tree as its
> +root.  This prevents "file system escapes" due to symlinks and other file
> +system objects that might lead to files outside the shared directory.  The
> +program also sandboxes itself using seccomp(2) to prevent ptrace(2) and other

You can mark these manpage references up with :manpage:`seccomp(2)` if
you like, though it only affects the formatting (bold in manpage, italics
in HTML), so I haven't been very consistent in using it in the manpages
I converted from texinfo.

Thanks for doing the conversion to rST format!

PS: do you (ie redhat downstream) want a macro to make it easy to
replace instances of 'qemu-system-x86_64' in the example command
lines, the way qemu-block-drivers.rst does, or do you not care
for this particular manpage? (If you do we should probably move
that to conf.py rather than proliferating it across rst files.)

thanks
-- PMM

