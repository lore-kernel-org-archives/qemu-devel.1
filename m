Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F3CC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 11:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC732087E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 11:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJFuv-0002q2-Fl
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 07:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1iJFt5-0001Ax-Ou
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 07:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1iJFs4-0000Pv-Eu
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 07:47:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:41276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1iJFs4-0000Mh-6h
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 07:47:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Oct 2019 04:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,287,1566889200"; d="scan'208";a="198967559"
Received: from lxy-dell.sh.intel.com ([10.239.159.46])
 by orsmga006.jf.intel.com with ESMTP; 12 Oct 2019 04:47:29 -0700
Message-ID: <00a6687037f90374605d8f4f69b9d2b3d614040b.camel@intel.com>
Subject: Re: [PATCH v3] target/i386: Add Snowridge-v2 (no MPX) CPU model
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: qemu-devel@nongnu.org
Date: Sat, 12 Oct 2019 19:40:30 +0800
In-Reply-To: <157087059993.19261.12706853972165466894@37313f22b938>
References: <157087059993.19261.12706853972165466894@37313f22b938>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2019-10-12 at 01:56 -0700, no-reply@patchew.org wrote:
> Patchew URL: 
> https://patchew.org/QEMU/20191012024748.127135-1-xiaoyao.li@intel.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing
> commands and
> their output below. If you have Docker installed, you can probably reproduce
> it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/change-state-handler.o
> make: *** [Makefile:994: docs/interop/index.html] Error 2
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 662, in <module>

Seems something wrong with the python script not this patch?

> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '
> --label', 'com.qemu.instance.uuid=afcfcefa439c40f9ad532249a5058f20', '-u',
> '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=',
> '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 
> 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v',
> '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> '/var/tmp/patchew-tester-tmp-rfbm0qix/src/docker-src.2019-10-12-
> 04.54.38.19439:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-
> mingw']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=afcfcefa439c40f9ad532249a5058f20
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-rfbm0qix/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
> 
> real    2m1.965s
> user    0m7.638s
> 
> 
> The full log is available at
> http://patchew.org/logs/20191012024748.127135-1-xiaoyao.li@intel.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


