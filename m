Received: from eggs.gnu.org ([2001:4830:134:3::10]:46321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dz1b9-000509-2v
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dz1b4-0000SM-J2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:21:31 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:53513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dz1b4-0000Rv-CC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:21:26 -0400
Received: by mail-wm0-f44.google.com with SMTP id q132so10951720wmd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:21:26 -0700 (PDT)
References: <20170922074659.30097-1-famz@redhat.com>
	<20170922074659.30097-7-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c054496-5c79-e56f-cd23-4f27694b2934@redhat.com>
Date: Mon, 2 Oct 2017 16:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170922074659.30097-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 06/36] docker: Enable features explicitly in
 test-full
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
List-ID: <qemu-devel.nongnu.org>

On 22/09/2017 09:46, Fam Zheng wrote:
> Also avoid "set -e".
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Message-Id: <20170907141245.31946-3-famz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

This broke docker-test-full with at least Fedora and CentOS 6 images.  I
wouldn't be surprised if some required packages do not even exist on
CentOS 6.  Should it be reverted?

Paolo

> ---
>  tests/docker/test-full | 82 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/docker/test-full b/tests/docker/test-full
> index 05f0d491d1..d71bf9d275 100755
> --- a/tests/docker/test-full
> +++ b/tests/docker/test-full
> @@ -1,8 +1,8 @@
> -#!/bin/bash -e
> +#!/bin/bash
>  #
> -# Compile all the targets.
> +# Compile all the targets with as many features enabled as possible
>  #
> -# Copyright (c) 2016 Red Hat Inc.
> +# Copyright 2016, 2017 Red Hat Inc.
>  #
>  # Authors:
>  #  Fam Zheng <famz@redhat.com>
> @@ -13,7 +13,77 @@
>  
>  . common.rc
>  
> -cd "$BUILD_DIR"
> +cd "$BUILD_DIR" || exit 1
>  
> -build_qemu
> -make check $MAKEFLAGS
> +build_qemu \
> +    --enable-attr \
> +    --enable-bluez \
> +    --enable-brlapi \
> +    --enable-bsd-user \
> +    --enable-bzip2 \
> +    --enable-cap-ng \
> +    --enable-coroutine-pool \
> +    --enable-crypto-afalg \
> +    --enable-curl \
> +    --enable-curses \
> +    --enable-debug \
> +    --enable-debug-info \
> +    --enable-debug-tcg \
> +    --enable-docs \
> +    --enable-fdt \
> +    --enable-gcrypt \
> +    --enable-glusterfs \
> +    --enable-gnutls \
> +    --enable-gprof \
> +    --enable-gtk \
> +    --enable-guest-agent \
> +    --enable-jemalloc \
> +    --enable-kvm \
> +    --enable-libiscsi \
> +    --enable-libnfs \
> +    --enable-libssh2 \
> +    --enable-libusb \
> +    --enable-linux-aio \
> +    --enable-linux-user \
> +    --enable-live-block-migration \
> +    --enable-lzo \
> +    --enable-modules \
> +    --enable-numa \
> +    --enable-opengl \
> +    --enable-pie \
> +    --enable-profiler \
> +    --enable-qom-cast-debug \
> +    --enable-rbd \
> +    --enable-rdma \
> +    --enable-replication \
> +    --enable-sdl \
> +    --enable-seccomp \
> +    --enable-smartcard \
> +    --enable-snappy \
> +    --enable-spice \
> +    --enable-stack-protector \
> +    --enable-system \
> +    --enable-tcg \
> +    --enable-tcg-interpreter \
> +    --enable-tools \
> +    --enable-tpm \
> +    --enable-trace-backend=ftrace \
> +    --enable-usb-redir \
> +    --enable-user \
> +    --enable-vde \
> +    --enable-vhost-net \
> +    --enable-vhost-scsi \
> +    --enable-vhost-user \
> +    --enable-vhost-vsock \
> +    --enable-virtfs \
> +    --enable-vnc \
> +    --enable-vnc-jpeg \
> +    --enable-vnc-png \
> +    --enable-vnc-sasl \
> +    --enable-vte \
> +    --enable-werror \
> +    --enable-xen \
> +    --enable-xen-pci-passthrough \
> +    --enable-xen-pv-domain-build \
> +    --enable-xfsctl \
> +&& make check $MAKEFLAGS
> 
