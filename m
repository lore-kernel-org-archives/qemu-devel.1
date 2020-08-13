Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75D42078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75D42078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6FlL-0001c1-Ot
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k6Fkb-00015y-6k
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:06:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:46848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k6FkZ-0006ic-B4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:06:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9EBE1AECD;
 Thu, 13 Aug 2020 16:07:02 +0000 (UTC)
Subject: Re: [PATCH v5 00/14] QEMU cpus.c refactoring part2
To: qemu-devel@nongnu.org
References: <159732818874.15736.6159613223332985218@66eaa9a8a123>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <543b7917-1949-9548-6648-c798efaf70ba@suse.de>
Date: Thu, 13 Aug 2020 18:06:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <159732818874.15736.6159613223332985218@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:06:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, alex.bennee@linaro.org, haxm-team@intel.com,
 mtosatti@redhat.com, armbru@redhat.com, r.bolshakov@yadro.com,
 dovgaluk@ispras.ru, wenchao.wang@intel.com, pbonzini@redhat.com,
 sunilmut@microsoft.com, rth@twiddle.net, philmd@redhat.com, colin.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any current infra work that could cause this failure?

I do not have problems when testing this set of commands locally,
for me it's all green.

Thanks,

Claudio

On 8/13/20 4:16 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200812183250.9221-1-cfontana@suse.de/
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
>   TEST    check-unit: tests/test-char
> Unexpected error in object_property_try_add() at /tmp/qemu-test/src/qom/object.c:1181:
> attempt to add duplicate property 'serial-id' to object (type 'container')
> ERROR test-char - too few tests run (expected 38, got 9)
> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....
>   TEST    check-qtest-x86_64: tests/qtest/hd-geo-test
> qemu-system-aarch64: -accel kvm: invalid accelerator kvm
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=e2cd2d5f1f1d4eb6bc6bcd79e3d16404', '-u', '1001', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-2np4x1wq/src/docker-src.2020-08-13-10.00.40.11908:/var/tmp/qemu:z,ro', 'qemu/centos7', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2.
> filter=--filter=label=com.qemu.instance.uuid=e2cd2d5f1f1d4eb6bc6bcd79e3d16404
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-2np4x1wq/src'
> make: *** [docker-run-test-quick@centos7] Error 2
> 
> real    15m49.276s
> user    0m8.608s
> 
> 
> The full log is available at
> http://patchew.org/logs/20200812183250.9221-1-cfontana@suse.de/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


