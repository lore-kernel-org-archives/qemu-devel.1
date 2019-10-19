Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F11CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 00:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C159222C2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 00:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C159222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLcQY-0000ZO-JT
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 20:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iLcPq-0000AI-Tt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 20:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iLcPo-00005w-KF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 20:16:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:12757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iLcPn-00004q-DX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 20:16:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Oct 2019 17:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,313,1566889200"; d="scan'208";a="186988831"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 18 Oct 2019 17:16:11 -0700
Date: Sat, 19 Oct 2019 08:15:56 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] migration/postcopy: enable compress during postcopy
Message-ID: <20191019001556.GA16110@richard>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <157141740394.24734.9600428911119666435@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157141740394.24734.9600428911119666435@37313f22b938>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: richardw.yang@linux.intel.com, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 09:50:05AM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20191018004850.9888-1-richardw.yang@linux.intel.com/
>
>
>
>Hi,
>
>This series failed the docker-mingw@fedora build test. Please find the testing commands and
>their output below. If you have Docker installed, you can probably reproduce it
>locally.
>
>=== TEST SCRIPT BEGIN ===
>#! /bin/bash
>export ARCH=x86_64
>make docker-image-fedora V=1 NETWORK=1
>time make docker-test-mingw@fedora J=14 NETWORK=1
>=== TEST SCRIPT END ===
>
>  CC      aarch64-softmmu/hw/timer/allwinner-a10-pit.o
>In file included from /tmp/qemu-test/src/migration/ram.c:29:
>/tmp/qemu-test/src/migration/ram.c: In function 'ram_load_postcopy':
>/tmp/qemu-test/src/migration/ram.c:4177:56: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>             void *place_dest = (void *)QEMU_ALIGN_DOWN((unsigned long)host,
>                                                        ^

Sounds should use uintptr_t.

Would change it in next version.

>/tmp/qemu-test/src/include/qemu/osdep.h:268:33: note: in definition of macro 'QEMU_ALIGN_DOWN'
> #define QEMU_ALIGN_DOWN(n, m) ((n) / (m) * (m))
>                                 ^
>cc1: all warnings being treated as errors
>make[1]: *** [/tmp/qemu-test/src/rules.mak:69: migration/ram.o] Error 1
>make[1]: *** Waiting for unfinished jobs....
>  CC      x86_64-softmmu/target/i386/arch_dump.o
>  CC      aarch64-softmmu/hw/usb/tusb6010.o
>---
>  CC      aarch64-softmmu/hw/arm/xlnx-zynqmp.o
>In file included from /tmp/qemu-test/src/migration/ram.c:29:
>/tmp/qemu-test/src/migration/ram.c: In function 'ram_load_postcopy':
>/tmp/qemu-test/src/migration/ram.c:4177:56: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>             void *place_dest = (void *)QEMU_ALIGN_DOWN((unsigned long)host,
>                                                        ^
>/tmp/qemu-test/src/include/qemu/osdep.h:268:33: note: in definition of macro 'QEMU_ALIGN_DOWN'
> #define QEMU_ALIGN_DOWN(n, m) ((n) / (m) * (m))
>                                 ^
>cc1: all warnings being treated as errors
>make[1]: *** [/tmp/qemu-test/src/rules.mak:69: migration/ram.o] Error 1
>make[1]: *** Waiting for unfinished jobs....
>make: *** [Makefile:482: aarch64-softmmu/all] Error 2
>make: *** Waiting for unfinished jobs....
>make: *** [Makefile:482: x86_64-softmmu/all] Error 2
>Traceback (most recent call last):
>  File "./tests/docker/docker.py", line 662, in <module>
>    sys.exit(main())
>---
>    raise CalledProcessError(retcode, cmd)
>subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=90570434880344249cff701baa188163', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-dh8p6f27/src/docker-src.2019-10-18-12.47.19.4164:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 2.
>filter=--filter=label=com.qemu.instance.uuid=90570434880344249cff701baa188163
>make[1]: *** [docker-run] Error 1
>make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-dh8p6f27/src'
>make: *** [docker-run-test-mingw@fedora] Error 2
>
>real    2m45.691s
>user    0m8.390s
>
>
>The full log is available at
>http://patchew.org/logs/20191018004850.9888-1-richardw.yang@linux.intel.com/testing.docker-mingw@fedora/?type=message.
>---
>Email generated automatically by Patchew [https://patchew.org/].
>Please send your feedback to patchew-devel@redhat.com

-- 
Wei Yang
Help you, Help me

