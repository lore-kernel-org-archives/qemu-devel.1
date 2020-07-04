Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F86C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 07:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6AB2070B
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 07:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6AB2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrcHt-00075D-4T
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 03:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrcGo-0006ck-S9
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 03:07:30 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:54475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrcGm-0000HN-8b
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 03:07:30 -0400
Received: from [192.168.1.155] (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 8153D240004;
 Sat,  4 Jul 2020 07:07:23 +0000 (UTC)
Subject: Re: [PATCH 0/3] Add ability to choose MDIO phy number to i.MX
 processors
To: qemu-devel@nongnu.org
References: <159380905868.16530.11130859212111999060@d1fd068a5071>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <5049d9bc-5a7b-07f6-57a0-c70cf031e319@tribudubois.net>
Date: Sat, 4 Jul 2020 09:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159380905868.16530.11130859212111999060@d1fd068a5071>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=217.70.178.230; envelope-from=jcd@tribudubois.net;
 helo=relay10.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 03:07:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, peter.chubb@nicta.com.au, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set is to be applied on top of the patch serie recently 
accepted by Peter on his tree.

I guess I will have to wait a bit that his pull request is accepted in 
mainline before resubmitting my patch.

JC

Le 03/07/2020 à 22:44, no-reply@patchew.org a écrit :
> Patchew URL: https://patchew.org/QEMU/cover.1593806826.git.jcd@tribudubois.net/
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
> qemu-system-aarch64: Property '.phy-num' not found
> Broken pipe
> /tmp/qemu-test/src/tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> ERROR - too few tests run (expected 66, got 0)
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....
>    TEST    iotest-qcow2: 154
> Could not access KVM kernel module: No such file or directory
> ---
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=4a2335c3dedc4400bae7b327958dfa5a', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-9e58kfzn/src/docker-src.2020-07-03-16.29.20.28169:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=4a2335c3dedc4400bae7b327958dfa5a
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-9e58kfzn/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
> real    14m58.666s
> user    0m9.169s
>
>
> The full log is available at
> http://patchew.org/logs/cover.1593806826.git.jcd@tribudubois.net/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



