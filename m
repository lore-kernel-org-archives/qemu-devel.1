Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,BITCOIN_SPAM_02,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD1DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E233A2245B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFFWZd52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E233A2245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXeaO-0006vC-HW
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 02:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXeYH-00060L-9Z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 02:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXeYE-0003Il-Kt
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 02:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603864992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpFNwaW3vrqdQLVQRYtTco9kxodNed3GJHQf8vN8nIA=;
 b=fFFWZd52c3nTG0wBgqvYhFWg98T/NxYfh++RLKQbC4ZL6UpL0q247YWZnsZfLRKHw8uC1p
 3TQGpVR3y+EExNXIv/hsfRDOLlT0S2C4rx81NOprR7GSgnpxT9AdX+FlZ8mvyilWZdU7Ci
 h1VOcPCp9MCE7u4OkfA/vvwAuKpelgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-nYcX5U3-PPGapnewuGGk2w-1; Wed, 28 Oct 2020 02:03:07 -0400
X-MC-Unique: nYcX5U3-PPGapnewuGGk2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EBC809DDA;
 Wed, 28 Oct 2020 06:03:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-124.ams2.redhat.com [10.36.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A37146266E;
 Wed, 28 Oct 2020 06:02:59 +0000 (UTC)
Subject: Re: [RFC PATCH v4 1/1] tests/vm: Add Haiku test based on their
 vagrant images
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201027102121.264963-1-f4bug@amsat.org>
 <20201027102121.264963-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7556a1c9-9237-779e-dc28-6b16abd7d6f5@redhat.com>
Date: Wed, 28 Oct 2020 07:02:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201027102121.264963-2-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, BITCOIN_SPAM_02=0.001,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.167, PDS_BTC_ID=0.499,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Alexander von Gluck IV <kallisti5@unixzen.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/2020 11.21, Philippe Mathieu-Daudé wrote:
> From: Alexander von Gluck IV <kallisti5@unixzen.com>
> 
> Signed-off-by: Alexander von Gluck IV <kallisti5@unixzen.com>
> [PMD: Avoid recreating the image each time]
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/keys/vagrant        |  27 +++++++++
>  tests/keys/vagrant.pub    |   1 +
>  tests/vm/Makefile.include |   3 +-
>  tests/vm/basevm.py        |   5 +-
>  tests/vm/haiku.x86_64     | 116 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 149 insertions(+), 3 deletions(-)
>  create mode 100644 tests/keys/vagrant
>  create mode 100644 tests/keys/vagrant.pub
>  create mode 100755 tests/vm/haiku.x86_64
> 
> diff --git a/tests/keys/vagrant b/tests/keys/vagrant
> new file mode 100644
> index 00000000000..7d6a083909e
> --- /dev/null
> +++ b/tests/keys/vagrant
> @@ -0,0 +1,27 @@
> +-----BEGIN RSA PRIVATE KEY-----
> +MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzI
> +w+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoP
> +kcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2
> +hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NO
> +Td0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcW
> +yLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQIBIwKCAQEA4iqWPJXtzZA68mKd
> +ELs4jJsdyky+ewdZeNds5tjcnHU5zUYE25K+ffJED9qUWICcLZDc81TGWjHyAqD1
> +Bw7XpgUwFgeUJwUlzQurAv+/ySnxiwuaGJfhFM1CaQHzfXphgVml+fZUvnJUTvzf
> +TK2Lg6EdbUE9TarUlBf/xPfuEhMSlIE5keb/Zz3/LUlRg8yDqz5w+QWVJ4utnKnK
> +iqwZN0mwpwU7YSyJhlT4YV1F3n4YjLswM5wJs2oqm0jssQu/BT0tyEXNDYBLEF4A
> +sClaWuSJ2kjq7KhrrYXzagqhnSei9ODYFShJu8UWVec3Ihb5ZXlzO6vdNQ1J9Xsf
> +4m+2ywKBgQD6qFxx/Rv9CNN96l/4rb14HKirC2o/orApiHmHDsURs5rUKDx0f9iP
> +cXN7S1uePXuJRK/5hsubaOCx3Owd2u9gD6Oq0CsMkE4CUSiJcYrMANtx54cGH7Rk
> +EjFZxK8xAv1ldELEyxrFqkbE4BKd8QOt414qjvTGyAK+OLD3M2QdCQKBgQDtx8pN
> +CAxR7yhHbIWT1AH66+XWN8bXq7l3RO/ukeaci98JfkbkxURZhtxV/HHuvUhnPLdX
> +3TwygPBYZFNo4pzVEhzWoTtnEtrFueKxyc3+LjZpuo+mBlQ6ORtfgkr9gBVphXZG
> +YEzkCD3lVdl8L4cw9BVpKrJCs1c5taGjDgdInQKBgHm/fVvv96bJxc9x1tffXAcj
> +3OVdUN0UgXNCSaf/3A/phbeBQe9xS+3mpc4r6qvx+iy69mNBeNZ0xOitIjpjBo2+
> +dBEjSBwLk5q5tJqHmy/jKMJL4n9ROlx93XS+njxgibTvU6Fp9w+NOFD/HvxB3Tcz
> +6+jJF85D5BNAG3DBMKBjAoGBAOAxZvgsKN+JuENXsST7F89Tck2iTcQIT8g5rwWC
> +P9Vt74yboe2kDT531w8+egz7nAmRBKNM751U/95P9t88EDacDI/Z2OwnuFQHCPDF
> +llYOUI+SpLJ6/vURRbHSnnn8a/XG+nzedGH5JGqEJNQsz+xT2axM0/W/CRknmGaJ
> +kda/AoGANWrLCz708y7VYgAtW2Uf1DPOIYMdvo6fxIB5i9ZfISgcJ/bbCUkFrhoH
> ++vq/5CIWxCPp0f85R4qxxQ5ihxJ0YDQT9Jpx4TMss4PSavPaBH3RXow5Ohe+bYoQ
> +NE5OgEXk2wVfZczCZpigBKbKZHNYcelXtTt/nP3rsCuGcM4h53s=
> +-----END RSA PRIVATE KEY-----
> diff --git a/tests/keys/vagrant.pub b/tests/keys/vagrant.pub
> new file mode 100644
> index 00000000000..b8d012d787f
> --- /dev/null
> +++ b/tests/keys/vagrant.pub
> @@ -0,0 +1 @@
> +ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== well-known vagrant key for qemu-test, do not use on any machine exposed to an external network
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 61f893ffdc0..e94d95ec541 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -4,7 +4,7 @@
>  
>  EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
>  
> -IMAGES := freebsd netbsd openbsd centos fedora
> +IMAGES := freebsd netbsd openbsd centos fedora haiku.x86_64
>  ifneq ($(GENISOIMAGE),)
>  IMAGES += ubuntu.i386 centos
>  ifneq ($(EFI_AARCH64),)
> @@ -41,6 +41,7 @@ endif
>  else
>  	@echo "  (install genisoimage to build centos/ubuntu images)"
>  endif
> +	@echo "  vm-build-haiku.x86_64           - Build QEMU in Haiku VM"
>  	@echo ""
>  	@echo "  vm-build-all                    - Build QEMU in all VMs"
>  	@echo "  vm-clean-all                    - Clean up VM images"
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 3fac20e929a..00f1d5ca8da 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -44,6 +44,7 @@
>      'machine'         : 'pc',
>      'guest_user'      : "qemu",
>      'guest_pass'      : "qemupass",
> +    'root_user'       : "root",
>      'root_pass'       : "qemupass",
>      'ssh_key_file'    : SSH_KEY_FILE,
>      'ssh_pub_key_file': SSH_PUB_KEY_FILE,
> @@ -245,13 +246,13 @@ def ssh(self, *cmd):
>          return self._ssh_do(self._config["guest_user"], cmd, False)
>  
>      def ssh_root(self, *cmd):
> -        return self._ssh_do("root", cmd, False)
> +        return self._ssh_do(self._config["root_user"], cmd, False)
>  
>      def ssh_check(self, *cmd):
>          self._ssh_do(self._config["guest_user"], cmd, True)
>  
>      def ssh_root_check(self, *cmd):
> -        self._ssh_do("root", cmd, True)
> +        self._ssh_do(self._config["root_user"], cmd, True)
>  
>      def build_image(self, img):
>          raise NotImplementedError
> diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
> new file mode 100755
> index 00000000000..634ef774870
> --- /dev/null
> +++ b/tests/vm/haiku.x86_64
> @@ -0,0 +1,116 @@
> +#!/usr/bin/env python3
> +#
> +# Haiku VM image
> +#
> +# Copyright 2020 Haiku, Inc.
> +#
> +# Authors:
> +#  Alexander von Gluck IV <kallisti5@unixzen.com>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import re
> +import sys
> +import time
> +import socket
> +import subprocess
> +import basevm
> +
> +VAGRANT_KEY_FILE = os.path.join(os.path.dirname(__file__),
> +    "..", "keys", "vagrant")
> +
> +VAGRANT_PUB_KEY_FILE = os.path.join(os.path.dirname(__file__),
> +    "..", "keys", "vagrant.pub")
> +
> +HAIKU_CONFIG = {
> +    'cpu'             : "max",
> +    'machine'         : 'pc',
> +    'guest_user'      : "vagrant",
> +    'guest_pass'      : "",
> +    'root_user'       : "vagrant",
> +    'root_pass'       : "",
> +    'ssh_key_file'    : VAGRANT_KEY_FILE,
> +    'ssh_pub_key_file': VAGRANT_PUB_KEY_FILE,
> +    'memory'          : "4G",
> +    'extra_args'      : [],
> +    'qemu_args'       : "-device VGA",
> +    'dns'             : "",
> +    'ssh_port'        : 0,
> +    'install_cmds'    : "",
> +    'boot_dev_type'   : "block",
> +    'ssh_timeout'     : 1,
> +}
> +
> +class HaikuVM(basevm.BaseVM):
> +    name = "haiku"
> +    arch = "x86_64"
> +
> +    link = "https://app.vagrantup.com/haiku-os/boxes/r1beta2-x86_64/versions/20200702/providers/libvirt.box"
> +    csum = "41c38b316e0cbdbc66b5dbaf3612b866700a4f35807cb1eb266a5bf83e9e68d5"
> +
> +    poweroff = "shutdown"
> +
> +    requirements = [
> +        "devel:libbz2",
> +        "devel:libcapstone",
> +        "devel:libcurl",
> +        "devel:libfdt",
> +        "devel:libgcrypt",
> +        "devel:libgl",
> +        "devel:libglib_2.0",
> +        "devel:libgnutls",
> +        "devel:libgpg_error",
> +        "devel:libintl",
> +        "devel:libjpeg",
> +        "devel:liblzo2",
> +        "devel:libncursesw",
> +        "devel:libnettle",
> +        "devel:libpixman_1",
> +        "devel:libpng16",
> +        "devel:libsdl2_2.0",
> +        "devel:libsnappy",
> +        "devel:libssh2",
> +        "devel:libtasn1",
> +        "devel:libusb_1.0",
> +        "devel:libz",
> +        "setuptools_python3"
> +    ]

When running this image, I now get:

ERROR: Cannot find Ninja

And even if I add "ninja" to the list, it fails after configuration:

make: *** No rule to make target 'qemu-img', needed by 'check-block'.  Stop.

... so this needs some more fine-tuning for the new build system?

 Thomas


