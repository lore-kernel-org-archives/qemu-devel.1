Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76ABC00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97024207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 14:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E95pyvsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97024207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKGr-0005Xa-KH
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 09:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ieKG8-00054y-5G
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ieKG6-0006eZ-NM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:43:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ieKG6-0006cI-I5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575902613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YsgLFLX+IrNzwDXPVONuzWcYZQvlbj/KtiyGrHarPc=;
 b=E95pyvskD4aSbK/IAHTN9nl6s/V6wNuEl29+p7UNTO00Ok6R+SHBTlRuwa2D90pBVNMWha
 8SJcwsp19IUw51cqeMdor/F0Ik7YgSK1F0w4b3wJcaA2jaXizxdedJIZv+zdH06+LzkleD
 Znd1pbwtC73XMq6Nb5MxOtJLcD4xfDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-FIs8MlSdNHqhAO0iGSPVog-1; Mon, 09 Dec 2019 09:43:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9E94800C7C;
 Mon,  9 Dec 2019 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-84.gru2.redhat.com
 [10.97.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F0360BE0;
 Mon,  9 Dec 2019 14:43:24 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests/acceptance: Add PVH boot test
To: Cleber Rosa <crosa@redhat.com>
References: <20191206140012.15517-1-wainersm@redhat.com>
 <20191206140012.15517-2-wainersm@redhat.com>
 <20191206165419.GC23522@dhcp-17-72.bos.redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <796713f8-1cb9-adc4-968f-e28d4d6ae23e@redhat.com>
Date: Mon, 9 Dec 2019 12:43:22 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191206165419.GC23522@dhcp-17-72.bos.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FIs8MlSdNHqhAO0iGSPVog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 wrampazz@redhat.com, philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/6/19 2:54 PM, Cleber Rosa wrote:
> On Fri, Dec 06, 2019 at 09:00:11AM -0500, Wainer dos Santos Moschetta wrote:
>> QEMU 4.0 onward is able to boot an uncompressed kernel
>> image by using the x86/HVM direct boot ABI. It needs
>> Linux >= 4.21 built with CONFIG_PVH=y.
>>
>> This introduces an acceptance test which checks an
>> uncompressed Linux kernel image boots properly.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>   tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 tests/acceptance/pvh.py
>>
>> diff --git a/tests/acceptance/pvh.py b/tests/acceptance/pvh.py
>> new file mode 100644
>> index 0000000000..c68489c273
>> --- /dev/null
>> +++ b/tests/acceptance/pvh.py
>> @@ -0,0 +1,48 @@
>> +# Copyright (c) 2019 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +"""
>> +x86/HVM direct boot acceptance tests.
>> +"""
>> +
>> +from avocado.utils.kernel import KernelBuild
>> +from avocado_qemu import Test
>> +from avocado_qemu import wait_for_console_pattern
>> +
>> +
>> +class Pvh(Test):
>> +    """
>> +    Test suite for x86/HVM direct boot feature.
>> +
>> +    :avocado: tags=slow,arch=x86_64,machine=q35
>> +    """
>> +    def test_boot_vmlinux(self):
>> +        """
>> +        Boot uncompressed kernel image.
>> +        """
>> +        # QEMU can boot a vmlinux image for kernel >= 4.21 built
>> +        # with CONFIG_PVH=y
>> +        kernel_version = '5.4.1'
>> +        kbuild = KernelBuild(kernel_version, work_dir=self.workdir)
>> +        try:
>> +            kbuild.download()
>> +            kbuild.uncompress()
>> +            kbuild.configure(targets=['defconfig', 'kvmconfig'],
>> +                             extra_configs=['CONFIG_PVH=y'])
> I'm aware of the reason why this uses APIs not fulfilled by
> tests/requirements.txt, but, for the general public reviewing/testing
> code with extra requirements, it's a good idea to bump the
> requirements to a version that fulfills the requirement, and comment
> out clearly on the temporary nature of the change (marking the patch).

Good idea, thanks for the tip.

>
> For instance, for this requirement, we could have:
>
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index a2a587223a..5498d67bc1 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,4 +1,5 @@
>   # Add Python module requirements, one per line, to be installed
>   # in the tests/venv Python virtual environment. For more info,
>   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework==72.0
> +# [REMOVE ME] use post 73.0 Avocado containing the new kernel build APIs
> +-e git+https://github.com/avocado-framework/avocado@d6fb24edcf847f09c312b55df3c674c64c79793e#egg=avocado_framework
>
> This will not only help people to test it, but should also make
> it work transparently on CI.

True. It could had helped me to check the missing packages on Travis to 
build the kernel. I'm ashamed to tell how I did it. :)

>
>> +            kbuild.build()
> As stated in my response to the cover letter, I think we need to move
> this elsewhere.  The *very* minimum is to have this in a setUp()
> method, but we should strongly consider other solutions.

On the proposed implementation the kernel is built only once and only 
for this test case. If I move the code to setUp() it will attempt to 
build the vmlinux for every case even when not needed (suppose I add a 
'boot not CONFIG_PVH vmlinux to check it properly handle error' case 
which uses distro's kernel). Unless I put a guard like 'do not build if 
already present' which IMHO is weird. In other words, IMHO setUp() 
should hold only code that is share-able across cases.

>
>> +        except:
>> +            self.cancel("Unable to build vanilla kernel %s" % kernel_version)
>> +
>> +        self.vm.set_machine('q35')
>> +        self.vm.set_console()
>> +        kernel_command_line = 'printk.time=0 console=ttyS0'
>> +        self.vm.add_args('-kernel', kbuild.vmlinux,
>> +                         '-append', kernel_command_line)
> And just for being thorough (and purist? idealistic? Utopian? :), if
> we stop and think about it, the following two lines are really what
> this test is all about.  Everything else should be the test's setup.
>
> I'm not arguing in favor of being radical and reject anything that is
> not perfect, but just reminding ourselves (myself very much included)
> of this general direction.

IMHO we should merge tests which are "good enough" then interactively 
improve them. At least they will run with some frequency and eventually 
catch regressions while infra bits are improved. Now, what's 'good 
enough' for an acceptance test? Perhaps a test that run consistently?

>
> Cheers,
> - Cleber.
>
>> +        self.vm.launch()
>> +        wait_for_console_pattern(self, 'Kernel command line: %s' %
>> +                                 kernel_command_line)
>> -- 
>> 2.21.0
>>


