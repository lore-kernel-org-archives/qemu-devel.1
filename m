Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38801C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862E5206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm+7kCIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862E5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXjN-0004ei-KZ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kNXiD-0003wa-0Z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kNXiA-00086o-Qv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:43:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601455421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/qrOz8S2rM83R1GTj+3dH/mQWOEnr1o4TyzRKs9YvE=;
 b=Dm+7kCICRxGG+Srqc2Kb+N1d79v8taWWcSnYS/SI8TgA5lQ8ixRQFcLA9dZGw0gThnMYcj
 PvwMcAmTq1mkE8mNJD9HBXUdTrNmTZwM+TxfjNq1cOj2w+yUMZHGacdhTlelqQNwT9k05j
 rNHwwr4u6IDvmVQ40Hqv8Ixam/CsNO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-OIJDRqHNM2mkn8tfjqHM6w-1; Wed, 30 Sep 2020 04:43:15 -0400
X-MC-Unique: OIJDRqHNM2mkn8tfjqHM6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FD081DE01;
 Wed, 30 Sep 2020 08:43:12 +0000 (UTC)
Received: from redhat.com (ovpn-114-69.ams2.redhat.com [10.36.114.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87ED95C1C4;
 Wed, 30 Sep 2020 08:43:03 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:43:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
Message-ID: <20200930084300.GA2264779@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
 <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
 <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org>
 <87r1qkq5wp.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87r1qkq5wp.fsf@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 10:38:30AM +0100, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
> > +Alex/Daniel
> >
> > On 9/28/20 10:33 PM, Willian Rampazzo wrote:
> >> On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> >>>
> >>> Add a test for the mipssim machine, based on the recommended
> >>> test setup from Thomas Huth:
> >>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
> >>>
> >>> The test is quick and can be run as:
> >>>
> >>>   $ avocado --show=console run -t machine:mipssim tests/acceptance/
> >>>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_mipssim_linux_console:
> >>>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 (Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
> >>>   console: Setting default memory size 0x02000000
> >>>   console: bootconsole [early0] enabled
> >>>   console: CPU revision is: 00019300 (MIPS 24Kc)
> >>>   console: FPU revision is: 00739300
> >>>   ...
> >>>   console: CPU frequency 12.00 MHz
> >>>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
> >>>   ...
> >>>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS Technologies, Inc.
> >>>   ...
> >>>   console: Welcome to Buildroot
> >>>   console: buildroot login: root
> >>>   console: # root
> >>>   console: -sh: root: not found
> >>>   console: # ping -c 3 10.0.2.2
> >>>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
> >>>   console: 64 bytes from 10.0.2.2: seq=0 ttl=255 time=48.231 ms
> >>>   console: 64 bytes from 10.0.2.2: seq=1 ttl=255 time=9.407 ms
> >>>   console: 64 bytes from 10.0.2.2: seq=2 ttl=255 time=2.298 ms
> >>>   console: --- 10.0.2.2 ping statistics ---
> >>>   console: 3 packets transmitted, 3 packets received, 0% packet loss
> >>>   PASS (7.99 s)
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> >>> ---
> >>> Cc: Thomas Huth <huth@tuxfamily.org>
> >>> ---
> >>>  MAINTAINERS                              |  1 +
> >>>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
> >>>  2 files changed, 57 insertions(+)
> >>>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 5eed1e692b4..17d8a012b0e 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
> >>>  F: include/hw/timer/mips_gictimer.h
> >>>  F: tests/acceptance/linux_ssh_mips_malta.py
> >>>  F: tests/acceptance/machine_mips_malta.py
> >>> +F: tests/acceptance/machine_mips_mipssim.py
> >>>  F: tests/tcg/mips/
> >>>  K: ^Subject:.*(?i)mips
> >>>
> >>> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptance/machine_mips_mipssim.py
> >>> new file mode 100644
> >>> index 00000000000..b2749917b08
> >>> --- /dev/null
> >>> +++ b/tests/acceptance/machine_mips_mipssim.py
> >>> @@ -0,0 +1,56 @@
> >>> +# Functional tests for the MIPS simulator (MIPSsim machine)
> >>> +#
> >>> +# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> >>> +#
> >>> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> >>> +# See the COPYING file in the top-level directory.
> >>> +#
> >>> +# SPDX-License-Identifier: GPL-2.0-or-later
> >>> +
> >>> +import os
> >>> +import logging
> >>> +import time
> >>> +
> >>> +from avocado import skipUnless
> >>> +from avocado_qemu import Test
> >>> +from avocado_qemu import exec_command_and_wait_for_pattern
> >>> +from avocado_qemu import interrupt_interactive_console_until_pattern
> >>> +from avocado_qemu import wait_for_console_pattern
> >>> +
> >>> +class MipsSimMachine(Test):
> >>> +
> >>> +    timeout = 30
> >>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> >>> +
> >>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> >>> +    def test_mipssim_linux_console(self):
> >>> +        """
> >>> +        Boots the Linux kernel and checks that the console is operational
> >>> +        :avocado: tags=arch:mipsel
> >>> +        :avocado: tags=machine:mipssim
> >>> +        :avocado: tags=device:mipsnet
> >>> +        """
> >>> +        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
> >>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
> >>> +                      'mips/mipssim/mipsel/vmlinux')
> >> 
> >> So, are you willing to maintain some images on your GitHub to avoid
> >> the image changes when they are not found?
> >
> > No, I am not willing to do that.
> >
> > But I see it pointless to have everyone (including CI) to spend 1h
> > building this image, when the sources and build recipe is available,
> > making the built image reproducible.
> 
> I agree we don't want to build from scratch each time. However as we
> move from relying on third parties (which outside of the major distros
> has proved very flaky) we are getting to the point of managing our GPL
> liabilities.

I'm wondering what the 1 hour time to build the images is
spent on, and what does the image need to actually do ?

Is it anything more than boot the kernel successfully ?

I've not tried a timed build, but surely a minimal / tiny
Linx kernel build is much less than an hour ? Combine with
a tiny C program that simply prints "OK" as /bin/init and
powers off the VM. Or we need more advanced then a minimal
busybox build.

I think it'd be great if we could self-build a minimal
kernel+init for all platforms we target, using distro
provided cross-compilers. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


