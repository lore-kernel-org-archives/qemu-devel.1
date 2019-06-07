Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67376C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 07:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEE0208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 07:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEE0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ9Ws-0003Pj-V9
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 03:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hZ9Vg-0002wc-AT
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 03:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hZ9Vf-00019Y-2y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 03:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hZ9Ve-000180-Rc; Fri, 07 Jun 2019 03:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5A093082AC3;
 Fri,  7 Jun 2019 07:41:56 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-111.ams2.redhat.com
 [10.36.117.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF5C5B6B3;
 Fri,  7 Jun 2019 07:41:45 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20190117185628.21862-1-crosa@redhat.com>
 <20190117185628.21862-16-crosa@redhat.com>
 <b235e7a9-57ad-5547-b8ca-693159820a8f@redhat.com>
 <e63a4ea3-e9ff-4920-cdfa-14bf04b5b08c@redhat.com>
 <84aa43ba-df19-51f6-e14d-fb82a7f2dfcc@redhat.com>
 <a638e504-f7ad-fa3a-f198-c3878cfc560e@redhat.com>
 <20190607032648.GA22416@habkost.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <22ba99c6-0cd0-4733-2fc9-05e5fd5bee12@redhat.com>
Date: Fri, 7 Jun 2019 09:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190607032648.GA22416@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 07 Jun 2019 07:41:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 15/18] Boot Linux Console Test: add a test
 for aarch64 + virt
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Caio Carrara <ccarrara@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/07/19 05:26, Eduardo Habkost wrote:

> Thread 4 (Thread 0x7f2e45fff700 (LWP 6461)):
> #0  0x00007f2e4ec03500 in nanosleep () at /lib64/libpthread.so.0
> #1  0x00007f2e4fb229d7 in g_usleep () at /lib64/libglib-2.0.so.0
> #2  0x0000559a4e7ca4c9 in qemu_chr_write_buffer (s=s@entry=0x559a502d0ac0, buf=buf@entry=0x7f2e45ffdd90 "7", len=1, offset=offset@entry=0x7f2e45ffdd60, write_all=true) at chardev/char.c:115
> #3  0x0000559a4e7ca78f in qemu_chr_write (s=0x559a502d0ac0, buf=buf@entry=0x7f2e45ffdd90 "7", len=len@entry=1, write_all=write_all@entry=true) at chardev/char.c:148
> #4  0x0000559a4e7cc7e2 in qemu_chr_fe_write_all (be=be@entry=0x559a504b4c50, buf=buf@entry=0x7f2e45ffdd90 "7", len=len@entry=1) at chardev/char-fe.c:53
> #5  0x0000559a4e58f320 in pl011_write (opaque=0x559a504b47d0, offset=0, value=55, size=<optimized out>) at hw/char/pl011.c:183
> #6  0x0000559a4e325121 in memory_region_write_accessor (mr=0x559a504b4ae0, addr=0, value=<optimized out>, size=2, shift=<optimized out>, mask=<optimized out>, attrs=...) at /home/ehabkost/rh/proj/virt/qemu/memory.c:503
> #7  0x0000559a4e322cd6 in access_with_adjusted_size (addr=addr@entry=0, value=value@entry=0x7f2e45ffded8, size=size@entry=2, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=access_fn@entry=
>     0x559a4e3250a0 <memory_region_write_accessor>, mr=0x559a504b4ae0, attrs=...) at /home/ehabkost/rh/proj/virt/qemu/memory.c:569
> #8  0x0000559a4e32763f in memory_region_dispatch_write (mr=mr@entry=0x559a504b4ae0, addr=addr@entry=0, data=<optimized out>, data@entry=55, size=size@entry=2, attrs=...) at /home/ehabkost/rh/proj/virt/qemu/memory.c:1497
> #9  0x0000559a4e338708 in io_writex (env=env@entry=0x559a503d5620, mmu_idx=mmu_idx@entry=1, val=val@entry=55, addr=addr@entry=18446462598867529728, retaddr=139836732143069, size=2, iotlbentry=<optimized out>, iotlbentry=<optimized out>)
>     at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cputlb.c:945
> #10 0x0000559a4e33d203 in store_helper (big_endian=false, size=2, retaddr=<optimized out>, oi=<optimized out>, val=55, addr=18446462598867529728, env=0x559a503d5620) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cputlb.c:1544
> #11 0x0000559a4e33d203 in helper_le_stw_mmu (env=0x559a503d5620, addr=18446462598867529728, val=55, oi=<optimized out>, retaddr=139836732143069) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cputlb.c:1636
> #12 0x00007f2e46bef5dd in code_gen_buffer ()
> #13 0x0000559a4e352381 in cpu_tb_exec (itb=<optimized out>, cpu=0x559a503d5620) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cpu-exec.c:171
> #14 0x0000559a4e352381 in cpu_loop_exec_tb (tb_exit=<synthetic pointer>, last_tb=<synthetic pointer>, tb=<optimized out>, cpu=0x559a503d5620) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cpu-exec.c:618
> #15 0x0000559a4e352381 in cpu_exec (cpu=cpu@entry=0x559a503cd360) at /home/ehabkost/rh/proj/virt/qemu/accel/tcg/cpu-exec.c:729
> #16 0x0000559a4e30ea0f in tcg_cpu_exec (cpu=0x559a503cd360) at /home/ehabkost/rh/proj/virt/qemu/cpus.c:1434
> #17 0x0000559a4e310b6b in qemu_tcg_cpu_thread_fn (arg=arg@entry=0x559a503cd360) at /home/ehabkost/rh/proj/virt/qemu/cpus.c:1743
> #18 0x0000559a4e83669a in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:502
> #19 0x00007f2e4ebf958e in start_thread () at /lib64/libpthread.so.0
> #20 0x00007f2e4eb266f3 in clone () at /lib64/libc.so.6

See also <https://bugzilla.redhat.com/show_bug.cgi?id=1661940>.

$ git show 6ab3fc32ea64 -- hw/char/pl011.c

Thanks
Laszlo

