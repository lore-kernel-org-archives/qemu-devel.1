Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 18:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E5221534
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 18:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E5221534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZHhM-0007Nc-9O
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 13:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kZHgc-0006sF-2j
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 13:02:38 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:57706
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kZHgY-0008S6-I1
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 13:02:37 -0500
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kZHgf-0000Y2-3s; Sun, 01 Nov 2020 18:02:41 +0000
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1604243521.git.qemu_oss@crudebyte.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <061f1d9c-86d8-76b9-b868-59749542d9a2@ilande.co.uk>
Date: Sun, 1 Nov 2020 18:02:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1604243521.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/2] 9pfs: test suite fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/11/2020 15:12, Christian Schoenebeck wrote:

> Fixes test failures with the 9pfs 'local' tests as discussed with latest
> 9P PR. See the discussion of that PR v2 (Fri, Oct 30th) for details.
> 
> In conjunction with Peter Xu's two migration patches (fixing occasional
> lockups of migration tests) overall situation appears to be smooth now:
> https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/
> 
> v2->v3:
> 
>    - Make the two functions for creating and removing the 9pfs test directory
>      public [NEW patch 1].
> 
>    - Place the constructor and destructor functions in virtio-9p-test.c, not
>      in virtio-9p.c, because the latter location would cause the constructor
>      to be executed whenever libqos is loaded, which would break other,
>      completely unrelated tests suites that just link to libqos [patch 2].
> 
>    - Previous patch 2 (coverity fix) is already queued, no changes, hence
>      omitted in this v3.
> 
> v1->v2:
> 
>    - Added Greg's tested-by tag [patch 1].
> 
>    - Log an info-level message if mkdir() failed [patch 2].
> 
>    - Update commit log message about coverity being the reporter and
>      details of the coverity report [patch 2].
> 
> Christian Schoenebeck (2):
>    tests/9pfs: make create/remove test dir public
>    tests/9pfs: fix test dir for parallel tests
> 
>   tests/qtest/libqos/virtio-9p.c | 20 ++++++++++----------
>   tests/qtest/libqos/virtio-9p.h | 10 ++++++++++
>   tests/qtest/virtio-9p-test.c   | 12 ++++++++++++
>   3 files changed, 32 insertions(+), 10 deletions(-)

FWIW one thing I've noticed recently is that my builds for qemu-system-sparc64 have 
started giving this warning about a missing "qtest-9p-local" directory during make check:

...
...
Running test QAPI schema regression tests
Running test qtest-sparc64/endianness-test
Running test qtest-sparc64/prom-env-test
Running test qtest-sparc64/boot-serial-test
Running test qtest-sparc64/cdrom-test
Running test qtest-sparc64/device-introspect-test
Running test qtest-sparc64/machine-none-test
Running test qtest-sparc64/qmp-test
Running test qtest-sparc64/qmp-cmd-test
Running test qtest-sparc64/qom-test
Running test qtest-sparc64/test-hmp
Running test qtest-sparc64/qos-test
rm: cannot remove '/home/build/src/qemu/git/qemu/build/qtest-9p-local': No such file 
or directory
   TEST    iotest-qcow2: 001
   TEST    iotest-qcow2: 002
   TEST    iotest-qcow2: 003
   TEST    iotest-qcow2: 004
   TEST    iotest-qcow2: 005
...
...

Would this get resolved by the changes to the test directory in this patchset? The 
build is a simple configure run with "--target-list=sparc64-softmmu".


ATB,

Mark.

