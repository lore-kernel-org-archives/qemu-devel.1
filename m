Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E735C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2876208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2876208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgxuT-00021Q-9C
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 16:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51072)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgxtZ-0001SI-DZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgxtX-00044r-My
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:54:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hgxtW-000424-Ep
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:54:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C60F3087931;
 Fri, 28 Jun 2019 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-99.rdu2.redhat.com
 [10.10.123.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 333EB5D705;
 Fri, 28 Jun 2019 20:54:38 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190621060925.16214-1-crosa@redhat.com>
 <20190621060925.16214-3-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ef7f2bce-f02f-1f40-f8cf-70e129c22c28@redhat.com>
Date: Fri, 28 Jun 2019 17:54:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190621060925.16214-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 28 Jun 2019 20:54:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] Acceptance tests: add SPICE protocol
 check
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 06/21/2019 03:09 AM, Cleber Rosa wrote:
> This fires a QEMU binary with SPICE enabled, and does a basic
> handshake, doing a basic client/server interaction and protocol
> validation.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .travis.yml               |  5 +++-
>   tests/Makefile.include    |  6 +++++
>   tests/acceptance/spice.py | 54 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 64 insertions(+), 1 deletion(-)
>   create mode 100644 tests/acceptance/spice.py
>
> diff --git a/.travis.yml b/.travis.yml
> index aeb9b211cd..6c9257a459 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -231,7 +231,7 @@ matrix:
>   
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> +        - CONFIG="--python=/usr/bin/python3 --enable-spice --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>           - TEST_CMD="make check-acceptance"
>         after_failure:
>           - cat tests/results/latest/job.log
> @@ -240,6 +240,9 @@ matrix:
>             packages:
>               - python3-pip
>               - python3.5-venv
> +            - libspice-protocol-dev
> +            - libspice-server-dev
> +
>       # Using newer GCC with sanitizers
>       - addons:
>           apt:
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 4c97da2878..7fc2d28099 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1129,6 +1129,12 @@ AVOCADO_SHOW=app
>   # Additional tags that are added to each occurence of "--filter-by-tags"
>   AVOCADO_EXTRA_TAGS := ,-flaky
>   
> +# At last one test require spice to be enabled, allow it to be excluded
> +# if it's not enabled
> +ifneq ($(findstring y,"$(CONFIG_SPICE)"),y)
> +AVOCADO_EXTRA_TAGS := $(AVOCADO_EXTRA_TAGS),-spice
> +endif
> +

Cleber, what about that improvement to avocado_qemu you were developing 
to parse the configure files then expose the enabled/disabled features 
to test code? Do you still plan to push it and so this proposal is just 
temporary?

>   AVOCADO_TAGS=$(patsubst %-softmmu,--filter-by-tags=arch:%$(AVOCADO_EXTRA_TAGS), $(filter %-softmmu,$(TARGET_DIRS)))
>   
>   ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
> diff --git a/tests/acceptance/spice.py b/tests/acceptance/spice.py
> new file mode 100644
> index 0000000000..aa22b1992d
> --- /dev/null
> +++ b/tests/acceptance/spice.py
> @@ -0,0 +1,54 @@
> +# Simple functional tests for SPICE functionality
> +#
> +# Copyright (c) 2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import socket
> +import struct
> +
> +from avocado_qemu import Test
> +from avocado.utils.network import find_free_port
> +
> +
> +class Spice(Test):
> +
> +    def test_protocol(self):
> +        """
> +        :avocado: tags=quick
> +        :avocado: tags=spice
> +        """
> +        port = find_free_port(5001, 5500, sequent=False)
> +        self.vm.add_args('-nodefaults', '-S',
> +                         '-spice', 'port=%d,disable-ticketing' % port)
> +        self.vm.launch()
> +
> +        RED_MAGIC = 0x51444552
> +        MAJOR_VERSION = 0x2
> +
> +        client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +        client.connect(('127.0.0.1', port))
> +        red_link_mess = struct.pack('<10I',
> +                                    RED_MAGIC,      # magic
> +                                    MAJOR_VERSION,  # major version
> +                                    0x0,            # minor version
> +                                    0x18,           # size in bytes from here
> +                                    0x0,            # connection id
> +                                    0x1,            # channel type RED_CHANNEL_MAIN
> +                                    0x0,            # channel id
> +                                    0x0,            # number of common caps
> +                                    0x0,            # number of channel caps
> +                                    0x14)           # caps offset from size
> +        client.send(red_link_mess)
> +
> +        RED_LINK_REPLY_BASE_FMT = '<5I'  # magic, major, minor, size, error
> +        red_link_reply = client.recv(struct.calcsize(RED_LINK_REPLY_BASE_FMT))
> +        (magic, major, minor, size, error) = struct.unpack_from(RED_LINK_REPLY_BASE_FMT,
> +                                                                red_link_reply)
> +        self.assertEqual(magic, RED_MAGIC, "Mismatch of MAGIC number")
> +        self.assertEqual(major, MAJOR_VERSION, "Mismatch of major protocol version")
> +        self.assertEqual(error, 0x0, "Unexpected error reported by server")

That test case looks good to me.

- Wainer

