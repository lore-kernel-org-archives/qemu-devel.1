Received: from eggs.gnu.org ([2001:4830:134:3::10]:54456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEzcm-000492-Sm
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEzch-000151-W7
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:29:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEzch-00013T-P1
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:29:07 -0500
Received: by mail-wr0-f193.google.com with SMTP id w95so1943300wrc.2
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:29:07 -0800 (PST)
References: <20171018082002.9406-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2529146-469b-3786-4a19-d9d89d00b8ad@redhat.com>
Date: Wed, 15 Nov 2017 16:29:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171018082002.9406-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "docker: Enable features explicitly
 in test-full"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18/10/2017 10:20, Fam Zheng wrote:
> This reverts commit 5e8a7fe673ca5949bd51939ee36faaf3b1320de8.
> 
> It's hard to get all images to have all these packages, the usual
> "FEATURES" and "require" mechanism doesn't scale with so many features.
> With that change, the test basically only works in ubuntu.
> 
> Until a better way comes up, leave the feature enabling to ./configure
> detection.
> 
> But don't remove the "-e" removal.
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-full | 79 +++-----------------------------------------------
>  1 file changed, 4 insertions(+), 75 deletions(-)
> 
> diff --git a/tests/docker/test-full b/tests/docker/test-full
> index 816d5a3eec..b4e42d25d7 100755
> --- a/tests/docker/test-full
> +++ b/tests/docker/test-full
> @@ -1,8 +1,8 @@
>  #!/bin/bash
>  #
> -# Compile all the targets with as many features enabled as possible
> +# Compile all the targets.
>  #
> -# Copyright 2016, 2017 Red Hat Inc.
> +# Copyright (c) 2016 Red Hat Inc.
>  #
>  # Authors:
>  #  Fam Zheng <famz@redhat.com>
> @@ -13,77 +13,6 @@
>  
>  . common.rc
>  
> -cd "$BUILD_DIR" || exit 1
> +cd "$BUILD_DIR"
>  
> -build_qemu \
> -    --enable-attr \
> -    --enable-bluez \
> -    --enable-brlapi \
> -    --enable-bsd-user \
> -    --enable-bzip2 \
> -    --enable-cap-ng \
> -    --enable-coroutine-pool \
> -    --enable-crypto-afalg \
> -    --enable-curl \
> -    --enable-curses \
> -    --enable-debug \
> -    --enable-debug-info \
> -    --enable-debug-tcg \
> -    --enable-docs \
> -    --enable-fdt \
> -    --enable-gcrypt \
> -    --enable-glusterfs \
> -    --enable-gnutls \
> -    --enable-gprof \
> -    --enable-gtk \
> -    --enable-guest-agent \
> -    --enable-jemalloc \
> -    --enable-kvm \
> -    --enable-libiscsi \
> -    --enable-libnfs \
> -    --enable-libssh2 \
> -    --enable-libusb \
> -    --enable-linux-aio \
> -    --enable-linux-user \
> -    --enable-live-block-migration \
> -    --enable-lzo \
> -    --enable-modules \
> -    --enable-numa \
> -    --enable-opengl \
> -    --enable-pie \
> -    --enable-profiler \
> -    --enable-qom-cast-debug \
> -    --enable-rbd \
> -    --enable-rdma \
> -    --enable-replication \
> -    --enable-sdl \
> -    --enable-seccomp \
> -    --enable-smartcard \
> -    --enable-snappy \
> -    --enable-spice \
> -    --enable-stack-protector \
> -    --enable-system \
> -    --enable-tcg \
> -    --enable-tcg-interpreter \
> -    --enable-tools \
> -    --enable-tpm \
> -    --enable-trace-backend=ftrace \
> -    --enable-usb-redir \
> -    --enable-user \
> -    --enable-vde \
> -    --enable-vhost-net \
> -    --enable-vhost-scsi \
> -    --enable-vhost-user \
> -    --enable-vhost-vsock \
> -    --enable-virtfs \
> -    --enable-vnc \
> -    --enable-vnc-jpeg \
> -    --enable-vnc-png \
> -    --enable-vnc-sasl \
> -    --enable-vte \
> -    --enable-werror \
> -    --enable-xen \
> -    --enable-xen-pci-passthrough \
> -    --enable-xen-pv-domain-build \
> -    --enable-xfsctl \
> -&& make check $MAKEFLAGS && install_qemu
> +build_qemu && make check $MAKEFLAGS && install_qemu
> 

Was this never committed?

Thanks,

Paolo
