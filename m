Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC00C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308B7206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308B7206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1TJ-0001LG-Ff
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq1Q5-0007ja-3S; Mon, 29 Jun 2020 17:34:29 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq1Q2-0005py-IB; Mon, 29 Jun 2020 17:34:28 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 92469BF450;
 Mon, 29 Jun 2020 21:34:23 +0000 (UTC)
Date: Mon, 29 Jun 2020 23:34:16 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] hw/block/nvme: handle transient dma errors
Message-ID: <20200629213408.qlehce2mtgqodqd6@apples.localdomain>
References: <20200629202053.1223342-1-its@irrelevant.dk>
 <159346486377.15477.6186679362319226240@d1fd068a5071>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159346486377.15477.6186679362319226240@d1fd068a5071>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, k.jensen@samsung.com, kbusch@kernel.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 29 14:07, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200629202053.1223342-1-its@irrelevant.dk/
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
> --- /tmp/qemu-test/src/tests/qemu-iotests/040.out       2020-06-29 20:12:10.000000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/040.out.bad 2020-06-29 20:58:48.288790818 +0000
> @@ -1,3 +1,5 @@
> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest
> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,path=/tmp/tmp.Jdol0fPScQ/qemu-21749-monitor.sock -mon chardev=mon,mode=control -qtest unix:path=/tmp/tmp.Jdol0fPScQ/qemu-21749-qtest.sock -accel qtest -nodefaults -display none -accel qtest


Hmm, I can't seem to reproduce this locally and the test succeeded on
the next series[1] that is based on this.

Is this a flaky test? Or a bad test runner? I'm of course worried when
a qcow2 test fails and I touch something else than the nvme device ;)


  [1]: https://patchew.org/QEMU/20200629203155.1236860-1-its@irrelevant.dk/

