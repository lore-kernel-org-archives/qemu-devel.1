Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7EDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DC6206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfJQdRXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DC6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixE53-0005jP-Cy
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixE4B-0005Cc-25
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixE49-0003NZ-P0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:57:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixE49-0003Mp-Kv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580407040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVGZKGLogN8F1C0+mYRbmwOVsmIdqpQXVXeJ5Nadffw=;
 b=QfJQdRXkzJ1r/Yz2hddBa5MqbNzfPa50rTaQP8Q9Vl78HuxJ88X6nTM5rm1MWcJNQE1V1t
 77EbnJvs07C4lgIeAhLDos3CDmXKuKMaqXGxurU+H6CL7lHOwqcnRi8ioyVtrNGP9xP8iN
 VVAip946QUHgME4iBZnA7cmfNCbOnrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-11jc3NiPNwaO4Z9cMe6MXw-1; Thu, 30 Jan 2020 12:57:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D208C8010D0;
 Thu, 30 Jan 2020 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55C5460C81;
 Thu, 30 Jan 2020 17:57:03 +0000 (UTC)
Subject: Re: [PATCH 0/6] tests/boot_linux_console: add extra boot acceptance
 tests
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net, philmd@redhat.com
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6fae7f3e-253b-0592-7477-7629e29822f4@redhat.com>
Date: Thu, 30 Jan 2020 15:57:02 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 11jc3NiPNwaO4Z9cMe6MXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Liam,

On 1/27/20 2:36 PM, Liam Merwick wrote:
> Add acceptance tests for the microvm machine class, PVH, and the
> new qboot BIOS.
>
> In the case of the test to boot an uncompressed kernel there didn't
> seem to be any suitable uncompressed kernel on https://archives.fedoraproject.org/
> (there is a vmlinux in kernel-debuginfo but that RPM is 575M and
> caused timeouts when populating the Avocado cache when first run)
> so I chose an RPM with kernels for Kata that is 14M.
> (there was a discussion in [1] regarding testing PVH boot but it focussed
> more around building a vmlinux binary during testing).

Yeah, my proposal [1] for building the vmlinux with PVH at test time was 
gently rejected. I was going to send a v2 where I would use a built 
kernel from somewhere. I'm glad you send this series before, so I 
discard mine in favor of yours.

>
> [ What prompted these patches was the discovery that a 'pc' guest booting an
> uncompressed kernel (PVH) with a PCI netdev hangs (before we even get guest
> console output) when bios-microvm.bin (qboot) is supplied via -bios
> (no issue when using 'q35' or 'microvm' machine classes).
>
> E.g. adding the following line to test_x86_64_pc_qboot_pvh() is enough to
> trigger a guest hang during startup:
> self.vm.add_args('-netdev', 'user,id=n1', '-device', 'virtio-net-pci,netdev=n1')
>
> I bisected that issue to 176d2cda0dee [2] in 4.1 but haven't worked out yet
> how/why the "die-id" changes impact the qboot/PVH combination
> (the boot succeeds with any subset of those boot variables).
>
> Is booting the 'pc' machine class with bios-microvm.bin something that QEMU
> officially supports or is qboot intended for microvm only? ]
>
> Each test added here adds about 1.5s to the overall runtime.
> I have run them through the Travis QEMU CI [3] and those acceptance tests pass.

Thanks for using Travis CI to check it. This way I've some minutes 
saved, otherwise I would have to test it manually. :)

>
> My modifications to test_x86_64_pc() in Patch1 will conflict with Wainer's
> patch in [4] - I'll rebase on top of that once that series is pulled and
> and apply feedback for this series, etc.

No problem, I can rebase mine patches in case this get in first.

>
> [1] https://patchew.org/QEMU/20191206140012.15517-1-wainersm@redhat.com/
> [2] 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp context")
> [3] https://travis-ci.org/merwick/qemu/jobs/641505543
> [4] https://github.com/wainersm/qemu/commit/8f705e98df90b436b0f4946331d441309c437f7b
>
>
> Liam Merwick (6):
>    tests/boot_linux_console: add microvm acceptance test
>    tests/boot_linux_console: add BIOS acceptance test
>    tests/boot_linux_console: fix extract_from_deb() comment
>    travis.yml: install rpm2cpio for acceptance tests
>    tests/boot_linux_console: add extract_from_rpm method
>    tests/boot_linux_console: add PVH acceptance tests
>
>   .travis.yml                            |  1 +
>   tests/acceptance/boot_linux_console.py | 91 +++++++++++++++++++++++++++++++---
>   2 files changed, 84 insertions(+), 8 deletions(-)
>


