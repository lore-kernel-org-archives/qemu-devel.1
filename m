Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1FAC35246
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89112206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iedqVjn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89112206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixB3y-0003bN-M7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixB38-0002ar-Vp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixB37-0004bt-Pi
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:44:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixB37-0004aS-MT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580395444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcwkawPc0Bk8cmCdkH/Z17eGA4dxe7XPTWhkSJ6R1mM=;
 b=iedqVjn3wOaXnno5gvtBvKS0jsOd4A9SfYmQz1Wx1rwLKVmIriBIc/N9WsxfVnkETJe7TE
 B4Tr1rANofOAGG8LHQku68V0sOHcCzGhW8Zqdzm5WHek5mbiQxmUu5xUBAncD2Y3K4t6DO
 Ogt9HVsUdERF8GUl3pEDKuE0YeYuA8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Bq59QaOFNkCCbJV8fJrSXQ-1; Thu, 30 Jan 2020 09:43:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A4BC800D4C;
 Thu, 30 Jan 2020 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D49077928;
 Thu, 30 Jan 2020 14:43:49 +0000 (UTC)
Subject: Re: [RFC PATCH] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200129131920.22302-1-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <8afc6c04-f17b-27d8-968e-4d18b7ed6edb@redhat.com>
Date: Thu, 30 Jan 2020 12:43:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200129131920.22302-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Bq59QaOFNkCCbJV8fJrSXQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/29/20 11:19 AM, Thomas Huth wrote:
> Old kernels from the Meego project can be used to check that Linux
> is at least starting on these machines.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   The serial console is written to the second UART, so this needs Phil's
>   "Allow to use other serial consoles than default" patch as a prerequisite:
>   Based-on: <20200120235159.18510-5-f4bug@amsat.org>
>
>   MAINTAINERS                          |  1 +
>   tests/acceptance/machine_arm_n8x0.py | 49 ++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
>   create mode 100644 tests/acceptance/machine_arm_n8x0.py

LGTM.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddf6fe0794..560507e821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -672,6 +672,7 @@ F: hw/rtc/twl92230.c
>   F: include/hw/display/blizzard.h
>   F: include/hw/input/tsc2xxx.h
>   F: include/hw/misc/cbus.h
> +F: tests/acceptance/machine_arm_n8x0.py
>   
>   Palm
>   M: Andrzej Zaborowski <balrogg@gmail.com>
> diff --git a/tests/acceptance/machine_arm_n8x0.py b/tests/acceptance/machine_arm_n8x0.py
> new file mode 100644
> index 0000000000..e5741f2d8d
> --- /dev/null
> +++ b/tests/acceptance/machine_arm_n8x0.py
> @@ -0,0 +1,49 @@
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
> +class N8x0Machine(Test):
> +    """Boots the Linux kernel and checks that the console is operational"""
> +
> +    timeout = 90
> +
> +    def __do_test_n8x0(self):
> +        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
> +                      'meego-arm-n8x0-1.0.80.20100712.1431-'
> +                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
> +        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        self.vm.set_console(console_index=1)
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', 'printk.time=0 console=ttyS1')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'TSC2005 driver initializing')
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> +    def test_n800(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:n800
> +        """
> +        self.__do_test_n8x0()
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> +    def test_n810(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:n810
> +        """
> +        self.__do_test_n8x0()


