Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A319720CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUBjfwWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixarO-0007PZ-T5
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 13:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixaqY-0006q7-Uc
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixaqX-0004FW-BH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:16:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixaqX-0004D8-6U
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580494608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK+euhUQo09I8h8WV16nc9uQPWfknpU25hSlqYYwpFQ=;
 b=aUBjfwWdp9/AK0sU2WZkVWecudbKvCM4gv+u4oRmSauzwVShbRgxmQ5AxWS3cqOvxkRvFA
 hrnQNZ/dCYP4i6YIfP9PDh3MoBqkdILdKZsEfcbffOrvr430g9kkist8osI3YORpJXPWOL
 TB0rNv2Rp8q63T02LsK+K1hSnhcNVUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-J_mY-WUoNoChvdPVN3WSGg-1; Fri, 31 Jan 2020 13:16:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE9E8801E67;
 Fri, 31 Jan 2020 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79490100EBA8;
 Fri, 31 Jan 2020 18:16:37 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add a test for the integratorcp arm
 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200131170233.14584-1-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <0be9d317-2d02-485d-0ce9-06e243e94355@redhat.com>
Date: Fri, 31 Jan 2020 16:16:35 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200131170233.14584-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: J_mY-WUoNoChvdPVN3WSGg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/31/20 3:02 PM, Thomas Huth wrote:
> There is a kernel and initrd available on github which we can use
> for testing this machine.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                  |  1 +
>   tests/acceptance/machine_arm_integratorcp.py | 43 ++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>   create mode 100644 tests/acceptance/machine_arm_integratorcp.py

This was piece of cake! ;)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e4976d366..6a03835037 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -599,6 +599,7 @@ S: Maintained
>   F: hw/arm/integratorcp.c
>   F: hw/misc/arm_integrator_debug.c
>   F: include/hw/misc/arm_integrator_debug.h
> +F: tests/acceptance/machine_arm_integratorcp.py
>   
>   MCIMX6UL EVK / i.MX6ul
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptance/machine_arm_integratorcp.py
> new file mode 100644
> index 0000000000..4f9ab40f2f
> --- /dev/null
> +++ b/tests/acceptance/machine_arm_integratorcp.py
> @@ -0,0 +1,43 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +
> +class IntegratorMachine(Test):
> +    """Boots the Linux kernel and checks that the console is operational"""
> +
> +    timeout = 90
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> +    def test_integratorcp(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:integratorcp
> +        """
> +        kernel_url = ('https://github.com/zayac/qemu-arm/raw/master/'
> +                      'arm-test/kernel/zImage.integrator')
> +        kernel_hash = '0d7adba893c503267c946a3cbdc63b4b54f25468'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        initrd_url = ('https://github.com/zayac/qemu-arm/raw/master/'
> +                      'arm-test/kernel/arm_root.img')
> +        initrd_hash = 'b51e4154285bf784e017a37586428332d8c7bd8b'
> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', 'printk.time=0 console=ttyAMA0')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Log in as root')


