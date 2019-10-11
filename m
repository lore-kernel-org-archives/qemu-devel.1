Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9EEC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 05:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28332089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 05:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28332089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iInLe-0006f1-16
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 01:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iInL0-0006E7-Vp
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iInKy-0008B2-NS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:19:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iInKy-0008Ah-I3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E270318CB8E0;
 Fri, 11 Oct 2019 05:19:34 +0000 (UTC)
Received: from [10.36.116.245] (ovpn-116-245.ams2.redhat.com [10.36.116.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 967B15D6C8;
 Fri, 11 Oct 2019 05:19:30 +0000 (UTC)
Subject: Re: [PATCH v4] migration: Support gtree migration
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <157075147039.11314.1969255003096566830@37313f22b938>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <23e242c0-83d4-512e-eb42-3cf24d6c21ea@redhat.com>
Date: Fri, 11 Oct 2019 07:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <157075147039.11314.1969255003096566830@37313f22b938>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 05:19:34 +0000 (UTC)
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
Cc: eric.auger.pro@gmail.com, dgilbert@redhat.com, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 10/11/19 1:51 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191010205242.711-1-eric.auger@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #! /bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-mingw@fedora J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      block/nbd.o
>   CC      block/sheepdog.o
>   CC      block/accounting.o
> make: *** [Makefile:994: docs/interop/index.html] Error 2

This failure looks unrelated to this series; and the above script
succeeds on my side.

Best Regards

Eric
> make: *** Deleting file 'docs/interop/index.html'
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=b0665a6b133e47c781238452d53aabf1', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-f9u21j2v/src/docker-src.2019-10-10-19.48.45.2708:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=b0665a6b133e47c781238452d53aabf1
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-f9u21j2v/src'
> make: *** [docker-run-test-mingw@fedora] Error 2
> 
> real    2m25.181s
> user    0m7.455s
> 
> 
> The full log is available at
> http://patchew.org/logs/20191010205242.711-1-eric.auger@redhat.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

