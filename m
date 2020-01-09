Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D820C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5A32072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUZCU7GC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5A32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipaMl-0003f9-UF
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ipaLx-0002vQ-Tk
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ipaLv-00057E-UP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:08:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ipaLv-00054G-Pu
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578586087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9n3MIJ2DeLD98iErPP6o0avcoWZGXc9nCEUOvuizaxE=;
 b=bUZCU7GC6VnzGaMyXZdSPpofR/hHDwediW/g+yRZ7YlbzTSdUKEIeGgW77Su26s13Zc/FQ
 IhCKzn17uVSZO7HhqgrM0N0pNhjaUzYH97pK6sA2l12FbivygMMEEjWTXSJV1fNfbPl9pK
 cWIVzYyjRlCZAMyfsBUhTWcCX883vl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-UbczhdzpO7SEBFja513NLQ-1; Thu, 09 Jan 2020 11:08:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19E6D19AD4E8;
 Thu,  9 Jan 2020 16:08:02 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B64D97C3E1;
 Thu,  9 Jan 2020 16:07:54 +0000 (UTC)
Subject: Re: [PATCH v12 00/13] VIRTIO-IOMMU device
To: qemu-devel@nongnu.org
References: <157858277631.10632.10417491075155237341@37313f22b938>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0701f56d-bcba-3c17-d894-f52254f06c2e@redhat.com>
Date: Thu, 9 Jan 2020 17:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <157858277631.10632.10417491075155237341@37313f22b938>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UbczhdzpO7SEBFja513NLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 mst@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 1/9/20 4:12 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200109144319.15912-1-eric.auger@redhat.com/
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
>   TEST    check-qtest-x86_64: tests/test-hmp
>   TEST    check-qtest-x86_64: tests/qos-test
> **
> ERROR:/tmp/qemu-test/src/tests/virtio-iommu-test.c:46:pci_config: assertion failed (probe_size == 0x200): (0x00000000 == 0x00000200)
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/virtio-iommu-test.c:46:pci_config: assertion failed (probe_size == 0x200): (0x00000000 == 0x00000200)

OK sorry that's because I eventually removed "virtio-iommu: Implement
probe request" patch from the sent series. I will remove that probe_size
field test on next round.

Thanks

Eric
> make: *** [check-qtest-x86_64] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    check-qtest-aarch64: tests/test-hmp
>   TEST    iotest-qcow2: 220
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=de2154161ccf4468af5ebd35cbcbdc03', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-_ap6ulch/src/docker-src.2020-01-09-10.01.05.32472:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=de2154161ccf4468af5ebd35cbcbdc03
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-_ap6ulch/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    11m50.898s
> user    0m8.023s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200109144319.15912-1-eric.auger@redhat.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


