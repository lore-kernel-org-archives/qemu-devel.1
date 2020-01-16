Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93546C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B27C2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9t8R60G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B27C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5ja-0007J0-Jl
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1is5in-00066g-GV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1is5ij-0006Up-PR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:02:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1is5ij-0006Tm-F1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579183320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3awgH4acfbm9gZUdOshdJiJguvZHaZNJUaxxHHG6RSo=;
 b=C9t8R60GbdaIA6D03Mf/d+lrINQxugKi4uQKrJV/KA4GybM3YqDlxJUBvtslH3RUDW4NF4
 TVZ/02i84dOVZuyr9Y4M8ULyx5XOH3RI6678MMDrvxTxqgQ0LSFZIXVf34MNtuM4krDrIj
 ZhLorh5w01Nu+LVP4aaNvTNjCcBPjsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ILvfCOnhNeWlsHjlbxhP2Q-1; Thu, 16 Jan 2020 09:01:57 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325AC8017CC;
 Thu, 16 Jan 2020 14:01:56 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBE3184343;
 Thu, 16 Jan 2020 14:01:51 +0000 (UTC)
Message-ID: <9e1d489ae5974c87c6f0b238a0ce024c2f0a7bc1.camel@redhat.com>
Subject: Re: [PATCH 00/13] LUKS: encryption slot management using amend
 interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 16 Jan 2020 16:01:50 +0200
In-Reply-To: <157903659988.1076.1476571465154479908@37313f22b938>
References: <157903659988.1076.1476571465154479908@37313f22b938>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ILvfCOnhNeWlsHjlbxhP2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-01-14 at 13:16 -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200114193350.10830-1-mlevitsk@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> Not run: 301 303
> Failures: 049 300
> Failed 2 of 110 iotests
> make: *** [check-tests/check-block.sh] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 662, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=1fad358ccc2746a4b0095e3abd7d4c78', '-u', '1003', '--security-opt', 'seccomp=unconfined', '-
> -rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-
> ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-lks33yi2/src/docker-src.2020-01-14-16.05.10.20352:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-
> zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=1fad358ccc2746a4b0095e3abd7d4c78
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-lks33yi2/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    11m29.420s
> user    0m8.596s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200114193350.10830-1-mlevitsk@redhat.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

Hi, this is my fault. I made tiny change in the error message, and didn't update
the output of 300 test.

I'll fix that in next version of the patches.

Best regards,
	Maxim Levitsky


