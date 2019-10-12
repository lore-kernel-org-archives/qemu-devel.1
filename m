Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D1C10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 13:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049F62089C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 13:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049F62089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJHpC-0004Rq-7I
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 09:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iJHoV-0003rv-BB
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 09:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iJHoS-0007Kw-Su
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 09:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iJHoS-0007Jj-Mi
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 09:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C7E418CB906;
 Sat, 12 Oct 2019 13:52:03 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1900D5D713;
 Sat, 12 Oct 2019 13:51:59 +0000 (UTC)
Date: Sat, 12 Oct 2019 10:51:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: sphinx-build parallel build failures (was Re: [PATCH v3]
 target/i386: Add Snowridge-v2 (no MPX) CPU model)
Message-ID: <20191012135158.GN4084@habkost.net>
References: <157087059993.19261.12706853972165466894@37313f22b938>
 <00a6687037f90374605d8f4f69b9d2b3d614040b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a6687037f90374605d8f4f69b9d2b3d614040b.camel@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Sat, 12 Oct 2019 13:52:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 12, 2019 at 07:40:30PM +0800, Xiaoyao Li wrote:
> On Sat, 2019-10-12 at 01:56 -0700, no-reply@patchew.org wrote:
> > Patchew URL: 
> > https://patchew.org/QEMU/20191012024748.127135-1-xiaoyao.li@intel.com/
> > 
> > 
> > 
> > Hi,
> > 
> > This series failed the docker-mingw@fedora build test. Please find the testing
> > commands and
> > their output below. If you have Docker installed, you can probably reproduce
> > it
> > locally.
> > 
> > === TEST SCRIPT BEGIN ===
> > #! /bin/bash
> > export ARCH=x86_64
> > make docker-image-fedora V=1 NETWORK=1
> > time make docker-test-mingw@fedora J=14 NETWORK=1
> > === TEST SCRIPT END ===
> > 
> >   CC      stubs/machine-init-done.o
> >   CC      stubs/migr-blocker.o
> >   CC      stubs/change-state-handler.o
> > make: *** [Makefile:994: docs/interop/index.html] Error 2
> > make: *** Waiting for unfinished jobs....

This looks like the sphinx-build parallel build failures I am
also seeing in my builds:
https://github.com/sphinx-doc/sphinx/issues/2946


> > Traceback (most recent call last):
> >   File "./tests/docker/docker.py", line 662, in <module>
> 
> Seems something wrong with the python script not this patch?
> 
> > ---
> >     raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '
> > --label', 'com.qemu.instance.uuid=afcfcefa439c40f9ad532249a5058f20', '-u',
> > '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=',
> > '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 
> > 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v',
> > '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> > '/var/tmp/patchew-tester-tmp-rfbm0qix/src/docker-src.2019-10-12-
> > 04.54.38.19439:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-
> > mingw']' returned non-zero exit status 2.
> > filter=--filter=label=com.qemu.instance.uuid=afcfcefa439c40f9ad532249a5058f20
> > make[1]: *** [docker-run] Error 1
> > make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-rfbm0qix/src'
> > make: *** [docker-run-test-mingw@fedora] Error 2
> > 
> > real    2m1.965s
> > user    0m7.638s
> > 
> > 
> > The full log is available at
> > http://patchew.org/logs/20191012024748.127135-1-xiaoyao.li@intel.com/testing.docker-mingw@fedora/?type=message.
> > ---
> > Email generated automatically by Patchew [https://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
> 

-- 
Eduardo

