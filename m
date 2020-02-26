Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46731C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BE32072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1VqTFJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6st5-0006x3-AR
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6srE-0004aC-Kw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6srD-0003BS-7d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:19:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6srD-0003AY-0p
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nD+UerlV4t23nbd3bpwtLCTBIkmnhsu9yCbAAYrkYfs=;
 b=B1VqTFJKfdd2F5ko/3elEFO+RZ66zhkiD7ull8vNq3KEnM6P4NuROubAgGqtW4fwsRJt9y
 PxJCaBD5/q0UqUK5fvh5P2UmKieMkNSwqKbbNE5PE9cBo2BgAp3/1rJgFAxe4NMUDJqoMP
 gtGtrP07/tVgv42xtmuPbGYKGxBqhA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-GJsKWpsaO7CL_heWy6cMqw-1; Wed, 26 Feb 2020 04:19:52 -0500
X-MC-Unique: GJsKWpsaO7CL_heWy6cMqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05AD91005512;
 Wed, 26 Feb 2020 09:19:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80D84385;
 Wed, 26 Feb 2020 09:19:49 +0000 (UTC)
Date: Wed, 26 Feb 2020 10:19:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: Sudden slowdown of ARM emulation in master
Message-ID: <20200226101948.786be4b0@redhat.com>
In-Reply-To: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 00:07:55 +0100
Niek Linnenbank <nieklinnenbank@gmail.com> wrote:

> Hello Igor and Paolo,

does following hack solves issue?

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a08ab11f65..ab2448c5aa 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
         /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
            static buffer, we could size this on RESERVED_VA, on the text
            segment size of the executable, or continue to use the default.  */
-        tb_size = (unsigned long)(ram_size / 4);
+        tb_size = MAX_CODE_GEN_BUFFER_SIZE;
 #endif
     }
     if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {


> 
> Just now I was working on some small fixes for the cubieboard machine and
> rebasing my Allwinner H3 branches.
> While doing some testing, I noticed that suddenly the machines were much
> slower than before.
> I only see this happening when I rebase to this commit:
>    ca6155c0f2bd39b4b4162533be401c98bd960820 ("Merge tag 'patchew/
> 20200219160953.13771-1-imammedo@redhat.com' of
> https://github.com/patchew-project/qemu into HEAD")
> 
> Also the avocado tests I'm running started to timeout:
> 
> + AVOCADO_ALLOW_LARGE_STORAGE=yes avocado --show=app,console run -t
> machine:cubieboard tests/acceptance/boot_linux_console.py
> ...
> (1/2)
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_initrd:
> |console: Uncompressing Linux... done, booting the kernel.
> |console: Booting Linux on physical CPU 0x0
> console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1
> 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
> console: CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=50c5387d
> console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing
> instruction cache
> console: OF: fdt: Machine model: Cubietech Cubieboard
> ...
> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
> reached\n
> Original status: ERROR\n{'name':
> '1-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_initrd',
> 'logdir': '/home/me/avocado/job-results/job-2020-02-25T23.58-d43884...
> (90.41 s)
> ...
> console: random: crng init done
> /console: mount: mounting devtmpfs on /dev failed: Device or resource busy
> -console: EXT4-fs (sda): re-mounted. Opts:
> block_validity,barrier,user_xattr,acl
> /console: Starting logging: OK
> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
> reached\nOriginal status: ERROR\n{'name':
> '2-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_cubieboard_sata',
> 'logdir': '/home/fox/avocado/job-results/job-2020-02-25T23.58-d438849/...
> (90.53 s)
> RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 |
> CANCEL 0
> JOB TIME   : 181.22 s
>  ....
> 
> Have you noticed a similar performance change?
> Do you have any clue if there may be something changed here that could
> cause a slowdown?
> 
> Regards,
> Niek
> 
> 


