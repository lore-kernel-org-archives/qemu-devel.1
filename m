Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CED72074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpNZeGxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZ4C-0002wo-Fi
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeZ3Z-00029g-1p
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:03:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jeZ3X-000861-Ao
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590735829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6iLFqHAo/qnpyNxIKgh8FlqBjsUDy2IkWF6BrDBzRo=;
 b=OpNZeGxyTL1DOAlmKHXZxSu8gCn/xOen+gUj1dMRG1HV9Wf+fOVJkuc42FOdwfFERtTNZI
 dXW5XDgu2JEAo7M7mP/Q6VDIGSvEoz1mOQNNGtArebYpu2B2FzAoLbqoI3VFkRy5+YWjXM
 eakRnXIdutbl+7tREbXczBsjvQfojYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-INLTVkQzPp6NruwvApUgyA-1; Fri, 29 May 2020 03:03:44 -0400
X-MC-Unique: INLTVkQzPp6NruwvApUgyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46AEA1855A0E;
 Fri, 29 May 2020 07:03:42 +0000 (UTC)
Received: from localhost (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1097799DE6;
 Fri, 29 May 2020 07:03:30 +0000 (UTC)
Date: Fri, 29 May 2020 09:03:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v2 0/4] microvm: memory config tweaks
Message-ID: <20200529090326.799f9d27@redhat.com>
In-Reply-To: <159069951375.20666.2158681200854299959@45ef0f9c86ae>
References: <20200528134035.32025-1-kraxel@redhat.com>
 <159069951375.20666.2158681200854299959@45ef0f9c86ae>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 23:43:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 13:58:35 -0700 (PDT)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/20200528134035.32025-1-kraxel@redhat.com/
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
>   CC      x86_64-softmmu/target/i386/translate.o
>   CC      aarch64-softmmu/hw/arm/omap1.o
> /tmp/qemu-test/src/hw/i386/xen/xen-hvm.c: In function 'xen_ram_init':
> /tmp/qemu-test/src/hw/i386/xen/xen-hvm.c:206:34: error: 'X86_MACHINE_MAX_RAM_BELOW_4G' undeclared (first use in this function)
>                                   X86_MACHINE_MAX_RAM_BELOW_4G,

it seems the build is still broken

>                                   ^
> /tmp/qemu-test/src/hw/i386/xen/xen-hvm.c:206:34: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [hw/i386/xen/xen-hvm.o] Error 1
>   CC      aarch64-softmmu/hw/arm/omap2.o
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/hw/arm/strongarm.o
> ---
>   CC      aarch64-softmmu/target/arm/gdbstub64.o
>   CC      aarch64-softmmu/target/arm/machine.o
>   CC      aarch64-softmmu/target/arm/arch_dump.o
> make: *** [x86_64-softmmu/all] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/target/arm/monitor.o
>   CC      aarch64-softmmu/target/arm/arm-powerctl.o
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=74ab42ef34594fdb988f724e8efaa96d', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-fky5lt0a/src/docker-src.2020-05-28-16.55.24.5056:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=74ab42ef34594fdb988f724e8efaa96d
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-fky5lt0a/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    3m8.799s
> user    0m4.488s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200528134035.32025-1-kraxel@redhat.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


