Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4F1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573F92225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 06:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rong8U+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573F92225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUOjj-0003NE-7f
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 02:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUOiE-0002kD-Rq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 02:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kUOiC-000531-BU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 02:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603089121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbRpHvkB0gdmX1fBttUfXW8VF2FKmIznlaLpNd52P5w=;
 b=Rong8U+BoVAFq/uaeMVzJ92CPhbsj2It/a9HwNtoTw2ecQAkOnrGBPBxLXgTengNZeNAfX
 zuZBFgzebTgx/980hc72RhRoX3+nd6RhJ1zBX62kiNXmlMfJ8hJkU89Q80m6YmTF6byYdp
 cCAMr4MX5gdWjRmh8l3pMnlf/WC9nz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-nn-G-RjqMROGPuhl7gwiPw-1; Mon, 19 Oct 2020 02:31:57 -0400
X-MC-Unique: nn-G-RjqMROGPuhl7gwiPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C5B4185A0D1;
 Mon, 19 Oct 2020 06:31:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C054260FC2;
 Mon, 19 Oct 2020 06:31:53 +0000 (UTC)
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
Date: Mon, 19 Oct 2020 08:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/2020 19.51, Philippe Mathieu-Daudé wrote:
> Hi Peter, Igor, Thomas,
> 
> On 2/28/20 5:38 PM, Peter Maydell wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Old kernels from the Meego project can be used to check that Linux
>> is at least starting on these machines.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Message-id: 20200225172501.29609-2-philmd@redhat.com
>> Message-Id: <20200129131920.22302-1-thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS                          |  1 +
>>   tests/acceptance/machine_arm_n8x0.py | 49 ++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>   create mode 100644 tests/acceptance/machine_arm_n8x0.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b66c46dcb9f..264374adbe8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -686,6 +686,7 @@ F: hw/rtc/twl92230.c
>>   F: include/hw/display/blizzard.h
>>   F: include/hw/input/tsc2xxx.h
>>   F: include/hw/misc/cbus.h
>> +F: tests/acceptance/machine_arm_n8x0.py
>>     Palm
>>   M: Andrzej Zaborowski <balrogg@gmail.com>
>> diff --git a/tests/acceptance/machine_arm_n8x0.py
>> b/tests/acceptance/machine_arm_n8x0.py
>> new file mode 100644
>> index 00000000000..e5741f2d8d1
>> --- /dev/null
>> +++ b/tests/acceptance/machine_arm_n8x0.py
>> @@ -0,0 +1,49 @@
>> +# Functional test that boots a Linux kernel and checks the console
>> +#
>> +# Copyright (c) 2020 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Thomas Huth <thuth@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import os
>> +
>> +from avocado import skipUnless
>> +from avocado_qemu import Test
>> +from avocado_qemu import wait_for_console_pattern
>> +
>> +class N8x0Machine(Test):
>> +    """Boots the Linux kernel and checks that the console is operational"""
>> +
>> +    timeout = 90
>> +
>> +    def __do_test_n8x0(self):
>> +        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
>> +                      'meego-arm-n8x0-1.0.80.20100712.1431-'
>> +                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
>> +        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> +
>> +        self.vm.set_console(console_index=1)
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-append', 'printk.time=0 console=ttyS1')
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, 'TSC2005 driver initializing')
>> +
>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>> +    def test_n800(self):
>> +        """
>> +        :avocado: tags=arch:arm
>> +        :avocado: tags=machine:n800
>> +        """
>> +        self.__do_test_n8x0()
>> +
>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>> +    def test_n810(self):
>> +        """
>> +        :avocado: tags=arch:arm
>> +        :avocado: tags=machine:n810
>> +        """
>> +        self.__do_test_n8x0()
>>
> 
> FYI this test is failing:
> 
> qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vml
> inuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 1964608,
> RAM size 0)
> 
> Alex, Thomas, can we enable AVOCADO_ALLOW_UNTRUSTED_CODE on GitLab
> to avoid such regressions?

Yes, please, if you've got some spare minutes to work on such a patch, that
would be great! ... I once already wanted to send such a patch, but IIRC
there were some other ALLOW_UNTRUSTED_CODE tests failing at that poing in
time, and I never got around to fix them...

 Thomas


