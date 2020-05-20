Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9848BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F79B20756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7aCrwjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F79B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNlg-0007rz-EI
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jbNkg-0007Qv-8G
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:23:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jbNkb-0005sP-H3
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589977388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGomZvcu1rumd4cnsKrBPOwz2AOUxt4zX7Zj7Er0Hfc=;
 b=e7aCrwjX/MLTTZxN1MzlgLctv8sKDhgdIBkU5X000uufzOwQZkvJidOhmp3WCO7b56k1EF
 42OcE46ikjnp0WJjPHwcmhR6k+GkGBgRuD5sjt2I00YjRLTal55HijR2lyg5linPv5A+i4
 uoDSM+4y4gOFxBXNq0Fh29H8qR+z45w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-R5yOOR7dM9mn99FyCiXLnQ-1; Wed, 20 May 2020 08:22:56 -0400
X-MC-Unique: R5yOOR7dM9mn99FyCiXLnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09B6107ACCA;
 Wed, 20 May 2020 12:22:55 +0000 (UTC)
Received: from [10.72.13.246] (ovpn-13-246.pek2.redhat.com [10.72.13.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A06135C1C8;
 Wed, 20 May 2020 12:22:52 +0000 (UTC)
Subject: Re: [PATCH 0/7] Latest COLO tree queued patches
To: "Zhang, Chen" <chen.zhang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Lukas Straub <lukasstraub2@web.de>
References: <20200519200207.17773-1-chen.zhang@intel.com>
 <158994966578.22651.9229581933394242476@45ef0f9c86ae>
 <ec2f90c69cf54bafa6558fe40b9c2202@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a23c4678-5e0d-38c6-176b-a400a2f46d06@redhat.com>
Date: Wed, 20 May 2020 20:22:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ec2f90c69cf54bafa6558fe40b9c2202@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "zhangckid@gmail.com" <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/20 下午5:07, Zhang, Chen wrote:
> It looks ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases.
> And Lukas's patch maybe touch it.
> What do we need to do?


We need first identify if those are false positives. (Which I believe 
yes, since I don't think this series have effect on the those qtests).

And maybe we can consider to avoid using coroutine .

Thanks


>
> Thanks
> Zhang Chen
>
>
>> -----Original Message-----
>> From: no-reply@patchew.org <no-reply@patchew.org>
>> Sent: Wednesday, May 20, 2020 12:41 PM
>> To: Zhang, Chen <chen.zhang@intel.com>
>> Cc: jasowang@redhat.com; Zhang, Chen <chen.zhang@intel.com>; qemu-
>> devel@nongnu.org; zhangckid@gmail.com
>> Subject: Re: [PATCH 0/7] Latest COLO tree queued patches
>>
>> Patchew URL: https://patchew.org/QEMU/20200519200207.17773-1-
>> chen.zhang@intel.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the asan build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce
>> it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> export ARCH=x86_64
>> make docker-image-fedora V=1 NETWORK=1
>> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14
>> NETWORK=1
>> === TEST SCRIPT END ===
>>
>> PASS 1 fdc-test /x86_64/fdc/cmos
>> PASS 2 fdc-test /x86_64/fdc/no_media_on_start
>> PASS 3 fdc-test /x86_64/fdc/read_without_media
>> ==6214==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 fdc-test /x86_64/fdc/media_change
>> PASS 5 fdc-test /x86_64/fdc/sense_interrupt
>> PASS 6 fdc-test /x86_64/fdc/relative_seek
>> ---
>> PASS 32 test-opts-visitor /visitor/opts/range/beyond
>> PASS 33 test-opts-visitor /visitor/opts/dict/unvisited
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-coroutine -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-coroutine"
>> ==6253==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6253==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffcb42bb000; bottom 0x7f9c45e20000; size: 0x00606e49b000
>> (414167183360)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 1 test-coroutine /basic/no-dangling-access
>> ---
>> PASS 13 test-aio /aio/event/wait/no-flush-cb
>> PASS 11 fdc-test /x86_64/fdc/read_no_dma_18
>> PASS 14 test-aio /aio/timer/schedule
>> ==6268==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 15 test-aio /aio/coroutine/queue-chaining
>> PASS 16 test-aio /aio-gsource/flush
>> PASS 17 test-aio /aio-gsource/bh/schedule
>> ---
>> PASS 27 test-aio /aio-gsource/event/wait/no-flush-cb
>> PASS 28 test-aio /aio-gsource/timer/schedule
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-aio-multithread -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-aio-multithread"
>> ==6273==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-aio-multithread /aio/multi/lifecycle
>> PASS 2 test-aio-multithread /aio/multi/schedule
>> PASS 12 fdc-test /x86_64/fdc/read_no_dma_19
>> PASS 13 fdc-test /x86_64/fdc/fuzz-registers
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/ide-test -m=quick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name="ide-test"
>> PASS 3 test-aio-multithread /aio/multi/mutex/contended
>> ==6295==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 ide-test /x86_64/ide/identify
>> ==6306==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 ide-test /x86_64/ide/flush
>> ==6312==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 ide-test /x86_64/ide/bmdma/simple_rw
>> ==6318==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 test-aio-multithread /aio/multi/mutex/handoff
>> PASS 4 ide-test /x86_64/ide/bmdma/trim
>> ==6329==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 5 test-aio-multithread /aio/multi/mutex/mcs
>> PASS 6 test-aio-multithread /aio/multi/mutex/pthread
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-throttle -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-throttle"
>> ==6341==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-throttle /throttle/leak_bucket
>> PASS 2 test-throttle /throttle/compute_wait
>> PASS 3 test-throttle /throttle/init
>> ---
>> PASS 14 test-throttle /throttle/config/max
>> PASS 15 test-throttle /throttle/config/iops_size
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-thread-pool -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl -
>> -test-name="test-thread-pool"
>> ==6345==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-thread-pool /thread-pool/submit
>> PASS 2 test-thread-pool /thread-pool/submit-aio
>> PASS 3 test-thread-pool /thread-pool/submit-co
>> ---
>> PASS 5 test-thread-pool /thread-pool/cancel
>> PASS 6 test-thread-pool /thread-pool/cancel-async
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-hbitmap -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-hbitmap"
>> ==6412==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-hbitmap /hbitmap/granularity
>> PASS 2 test-hbitmap /hbitmap/size/0
>> PASS 3 test-hbitmap /hbitmap/size/unaligned
>> ---
>> PASS 39 test-hbitmap /hbitmap/next_dirty_area/next_dirty_area_4
>> PASS 40 test-hbitmap
>> /hbitmap/next_dirty_area/next_dirty_area_after_truncate
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-bdrv-drain -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-bdrv-drain"
>> ==6423==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-bdrv-drain /bdrv-drain/nested
>> PASS 2 test-bdrv-drain /bdrv-drain/multiparent
>> PASS 3 test-bdrv-drain /bdrv-drain/set_aio_context
>> ---
>> PASS 41 test-bdrv-drain /bdrv-drain/bdrv_drop_intermediate/poll
>> PASS 42 test-bdrv-drain /bdrv-drain/replace_child/mid-drain
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-bdrv-graph-mod -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-bdrv-graph-mod"
>> ==6462==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-bdrv-graph-mod /bdrv-graph-mod/update-perm-tree
>> PASS 2 test-bdrv-graph-mod /bdrv-graph-mod/should-update-child
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-blockjob -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-blockjob"
>> ==6466==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-blockjob /blockjob/ids
>> PASS 2 test-blockjob /blockjob/cancel/created
>> PASS 3 test-blockjob /blockjob/cancel/running
>> ---
>> PASS 7 test-blockjob /blockjob/cancel/pending
>> PASS 8 test-blockjob /blockjob/cancel/concluded
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-blockjob-txn -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
>> --test-name="test-blockjob-txn"
>> ==6472==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-blockjob-txn /single/success
>> PASS 2 test-blockjob-txn /single/failure
>> PASS 3 test-blockjob-txn /single/cancel
>> ---
>> PASS 6 test-blockjob-txn /pair/cancel
>> PASS 7 test-blockjob-txn /pair/fail-cancel-race
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-block-backend -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-block-backend"
>> ==6476==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-block-backend /block-backend/drain_aio_error
>> PASS 2 test-block-backend /block-backend/drain_all_aio_error
>> ==6469==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-block-iothread -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-block-iothread"
>> ==6484==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-block-iothread /sync-op/pread
>> PASS 2 test-block-iothread /sync-op/pwrite
>> PASS 3 test-block-iothread /sync-op/load_vmstate
>> ---
>> PASS 15 test-block-iothread /propagate/diamond
>> PASS 16 test-block-iothread /propagate/mirror
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-image-locking -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-image-locking"
>> ==6504==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-image-locking /image-locking/basic
>> PASS 2 test-image-locking /image-locking/set-perm-abort
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-x86-cpuid -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-x86-cpuid"
>> ---
>> PASS 2 rcutorture /rcu/torture/10readers
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-rcu-list -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-rcu-list"
>> PASS 1 test-rcu-list /rcu/qlist/single-threaded
>> ==6568==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 test-rcu-list /rcu/qlist/short-few
>> PASS 3 test-rcu-list /rcu/qlist/long-many
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-rcu-simpleq -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl -
>> -test-name="test-rcu-simpleq"
>> PASS 1 test-rcu-simpleq /rcu/qsimpleq/single-threaded
>> PASS 2 test-rcu-simpleq /rcu/qsimpleq/short-few
>> ==6628==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 test-rcu-simpleq /rcu/qsimpleq/long-many
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-rcu-tailq -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-rcu-tailq"
>> PASS 1 test-rcu-tailq /rcu/qtailq/single-threaded
>> PASS 2 test-rcu-tailq /rcu/qtailq/short-few
>> PASS 3 test-rcu-tailq /rcu/qtailq/long-many
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-rcu-slist -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-rcu-slist"
>> ==6667==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-rcu-slist /rcu/qslist/single-threaded
>> PASS 2 test-rcu-slist /rcu/qslist/short-few
>> PASS 3 test-rcu-slist /rcu/qslist/long-many
>> ---
>> PASS 7 test-qdist /qdist/binning/expand
>> PASS 8 test-qdist /qdist/binning/shrink
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-qht -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-
>> name="test-qht"
>> ==6713==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6719==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-qht /qht/mode/default
>> PASS 2 test-qht /qht/mode/resize
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-qht-par -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-qht-par"
>> PASS 1 test-qht-par /qht/parallel/2threads-0%updates-1s
>> ==6734==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 test-qht-par /qht/parallel/2threads-20%updates-1s
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-bitops -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-
>> name="test-bitops"
>> PASS 1 test-bitops /bitops/sextract32
>> ---
>> PASS 2 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/perfectclient
>> PASS 5 ide-test /x86_64/ide/bmdma/various_prdts
>> PASS 3 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca1
>> ==6806==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6806==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fff4b19d000; bottom 0x7f1c9d1fe000; size: 0x00e2adf9f000
>> (973581447168)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 4 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodca2
>> ---
>> PASS 8 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badca3
>> PASS 9 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver1
>> PASS 10 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver2
>> ==6817==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 8 ide-test /x86_64/ide/flush/empty_drive
>> PASS 11 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver3
>> ==6822==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 9 ide-test /x86_64/ide/flush/retry_pci
>> ==6828==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 10 ide-test /x86_64/ide/flush/retry_isa
>> PASS 12 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver4
>> ==6834==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 11 ide-test /x86_64/ide/cdrom/pio
>> PASS 13 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver5
>> ==6840==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 14 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver6
>> PASS 15 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/goodserver7
>> PASS 16 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/badserver1
>> ---
>> PASS 38 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingserver
>> PASS 39 test-crypto-tlscredsx509 /qcrypto/tlscredsx509/missingclient
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-crypto-tlssession -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-crypto-tlssession"
>> ==6846==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 13 ide-test /x86_64/ide/cdrom/dma
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/ahci-test -m=quick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name="ahci-test"
>> PASS 1 test-crypto-tlssession /qcrypto/tlssession/psk
>> ==6864==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 ahci-test /x86_64/ahci/sanity
>> ==6870==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 test-crypto-tlssession /qcrypto/tlssession/basicca
>> PASS 3 test-crypto-tlssession /qcrypto/tlssession/differentca
>> PASS 2 ahci-test /x86_64/ahci/pci_spec
>> PASS 4 test-crypto-tlssession /qcrypto/tlssession/altname1
>> ==6876==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 ahci-test /x86_64/ahci/pci_enable
>> PASS 5 test-crypto-tlssession /qcrypto/tlssession/altname2
>> ==6882==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 ahci-test /x86_64/ahci/hba_spec
>> PASS 6 test-crypto-tlssession /qcrypto/tlssession/altname3
>> PASS 7 test-crypto-tlssession /qcrypto/tlssession/altname4
>> PASS 8 test-crypto-tlssession /qcrypto/tlssession/altname5
>> ==6888==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 5 ahci-test /x86_64/ahci/hba_enable
>> ==6894==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 9 test-crypto-tlssession /qcrypto/tlssession/altname6
>> PASS 6 ahci-test /x86_64/ahci/identify
>> PASS 10 test-crypto-tlssession /qcrypto/tlssession/wildcard1
>> ==6900==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 7 ahci-test /x86_64/ahci/max
>> PASS 11 test-crypto-tlssession /qcrypto/tlssession/wildcard2
>> ==6906==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 12 test-crypto-tlssession /qcrypto/tlssession/wildcard3
>> PASS 8 ahci-test /x86_64/ahci/reset
>> ==6912==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6912==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fffa5553000; bottom 0x7f9548ffe000; size: 0x006a5c555000
>> (456815628288)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 9 ahci-test /x86_64/ahci/io/pio/lba28/simple/zero
>> ==6918==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6918==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffe3b568000; bottom 0x7f7e421fe000; size: 0x007ff936a000
>> (549641953280)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 13 test-crypto-tlssession /qcrypto/tlssession/wildcard4
>> PASS 10 ahci-test /x86_64/ahci/io/pio/lba28/simple/low
>> ==6924==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 14 test-crypto-tlssession /qcrypto/tlssession/wildcard5
>> ==6924==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffcd76f6000; bottom 0x7f1a2f3fe000; size: 0x00e2a82f8000
>> (973484294144)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 11 ahci-test /x86_64/ahci/io/pio/lba28/simple/high
>> PASS 15 test-crypto-tlssession /qcrypto/tlssession/wildcard6
>> ==6930==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6930==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffcc1c1b000; bottom 0x7f10663fe000; size: 0x00ec5b81d000
>> (1015147515904)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 12 ahci-test /x86_64/ahci/io/pio/lba28/double/zero
>> PASS 16 test-crypto-tlssession /qcrypto/tlssession/cachain
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-qga -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-
>> name="test-qga"
>> ==6936==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==6936==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fffd6223000; bottom 0x7f5db9ffe000; size: 0x00a21c225000
>> (696256712704)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 13 ahci-test /x86_64/ahci/io/pio/lba28/double/low
>> ---
>> PASS 4 test-qga /qga/info
>> PASS 5 test-qga /qga/network-get-interfaces
>> PASS 6 test-qga /qga/get-vcpus
>> ==6950==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 7 test-qga /qga/get-fsinfo
>> PASS 8 test-qga /qga/get-memory-block-info
>> PASS 9 test-qga /qga/get-memory-blocks
>> ---
>> PASS 15 test-qga /qga/invalid-cmd
>> PASS 16 test-qga /qga/invalid-args
>> PASS 17 test-qga /qga/fsfreeze-status
>> ==6950==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffe002a6000; bottom 0x7fae94ffe000; size: 0x004f6b2a8000
>> (341100363776)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 14 ahci-test /x86_64/ahci/io/pio/lba28/double/high
>> ==6959==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 18 test-qga /qga/blacklist
>> PASS 19 test-qga /qga/config
>> PASS 20 test-qga /qga/guest-exec
>> PASS 21 test-qga /qga/guest-exec-invalid
>> ==6959==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fffabd5a000; bottom 0x7fdd8a9fe000; size: 0x00222135c000
>> (146586058752)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 15 ahci-test /x86_64/ahci/io/pio/lba28/long/zero
>> ---
>> PASS 24 test-qga /qga/guest-get-timezone
>> PASS 25 test-qga /qga/guest-get-users
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-timed-average -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-timed-average"
>> ==6977==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-timed-average /timed-average/average
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-util-filemonitor -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-util-filemonitor"
>> PASS 1 test-util-filemonitor /util/filemonitor
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-util-sockets -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl -
>> -test-name="test-util-sockets"
>> ==6977==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffc023f6000; bottom 0x7f8cbfffe000; size: 0x006f423f8000
>> (477852827648)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 1 test-util-sockets /util/socket/is-socket/bad
>> ---
>> PASS 1 test-io-channel-socket /io/channel/socket/ipv4-sync
>> PASS 2 test-io-channel-socket /io/channel/socket/ipv4-async
>> PASS 3 test-io-channel-socket /io/channel/socket/ipv4-fd
>> ==7005==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 test-io-channel-socket /io/channel/socket/ipv6-sync
>> PASS 5 test-io-channel-socket /io/channel/socket/ipv6-async
>> PASS 6 test-io-channel-socket /io/channel/socket/unix-sync
>> ---
>> PASS 8 test-io-channel-socket /io/channel/socket/unix-fd-pass
>> PASS 9 test-io-channel-socket /io/channel/socket/unix-listen-cleanup
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-io-channel-file -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-io-channel-file"
>> ==7005==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffd8c4e6000; bottom 0x7f1f73924000; size: 0x00de18bc2000
>> (953897721856)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 1 test-io-channel-file /io/channel/file
>> ---
>> PASS 17 ahci-test /x86_64/ahci/io/pio/lba28/long/high
>> PASS 1 test-io-channel-tls /qio/channel/tls/basic
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-io-channel-command -m=quick -k --tap < /dev/null | ./scripts/tap-
>> driver.pl --test-name="test-io-channel-command"
>> ==7073==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-io-channel-command /io/channel/command/fifo/sync
>> PASS 2 test-io-channel-command /io/channel/command/fifo/async
>> PASS 3 test-io-channel-command /io/channel/command/echo/sync
>> ---
>> PASS 17 test-crypto-pbkdf /crypto/pbkdf/nonrfc/sha384/iter1200
>> PASS 18 test-crypto-pbkdf /crypto/pbkdf/nonrfc/ripemd160/iter1200
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-crypto-ivgen -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
>> --test-name="test-crypto-ivgen"
>> ==7094==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-crypto-ivgen /crypto/ivgen/plain/1
>> PASS 2 test-crypto-ivgen /crypto/ivgen/plain/1f2e3d4c
>> PASS 3 test-crypto-ivgen /crypto/ivgen/plain/1f2e3d4c5b6a7988
>> ---
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-crypto-block -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
>> --test-name="test-crypto-block"
>> PASS 1 test-crypto-block /crypto/block/qcow
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-logging -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-logging"
>> ==7112==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-logging /logging/parse_range
>> PASS 2 test-logging /logging/parse_path
>> PASS 3 test-logging /logging/logfile_write_path
>> PASS 4 test-logging /logging/logfile_lock_path
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-replication -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --
>> test-name="test-replication"
>> ==7131==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 20 ahci-test /x86_64/ahci/io/pio/lba28/short/high
>> PASS 1 test-replication /replication/primary/read
>> ==7135==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 test-replication /replication/primary/write
>> ==7135==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffd18642000; bottom 0x7f063b9fe000; size: 0x00f6dcc44000
>> (1060265803776)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 21 ahci-test /x86_64/ahci/io/pio/lba48/simple/zero
>> ==7141==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 test-replication /replication/primary/start
>> PASS 4 test-replication /replication/primary/stop
>> PASS 5 test-replication /replication/primary/do_checkpoint
>> PASS 6 test-replication /replication/primary/get_error_all
>> ==7141==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffd2c105000; bottom 0x7f1089dfe000; size: 0x00eca2307000
>> (1016333365248)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 22 ahci-test /x86_64/ahci/io/pio/lba48/simple/low
>> ==7147==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7147==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fff3971e000; bottom 0x7f10231fe000; size: 0x00ef16520000
>> (1026871656448)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 7 test-replication /replication/secondary/read
>> PASS 23 ahci-test /x86_64/ahci/io/pio/lba48/simple/high
>> ==7153==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7153==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fff3c8b8000; bottom 0x7f9ca6dfe000; size: 0x006295aba000
>> (423417847808)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 8 test-replication /replication/secondary/write
>> PASS 24 ahci-test /x86_64/ahci/io/pio/lba48/double/zero
>> ==7159==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7159==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffe3537e000; bottom 0x7f28dd1fe000; size: 0x00d558180000
>> (916306001920)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> ==7131==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffefa2d6000; bottom 0x7f66922bd000; size: 0x009868019000
>> (654579961856)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 25 ahci-test /x86_64/ahci/io/pio/lba48/double/low
>> ==7165==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7165==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffe06811000; bottom 0x7f0f631fe000; size: 0x00eea3613000
>> (1024943271936)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 26 ahci-test /x86_64/ahci/io/pio/lba48/double/high
>> ==7199==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7199==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffdd6fa6000; bottom 0x7fb44297c000; size: 0x00499462a000
>> (316022104064)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 9 test-replication /replication/secondary/start
>> PASS 27 ahci-test /x86_64/ahci/io/pio/lba48/long/zero
>> ==7205==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7205==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffe4b5d8000; bottom 0x7f4279324000; size: 0x00bbd22b4000
>> (806684934144)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 28 ahci-test /x86_64/ahci/io/pio/lba48/long/low
>> ==7214==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7214==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffe30775000; bottom 0x7fbd51bfe000; size: 0x0040deb77000
>> (278614470656)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 29 ahci-test /x86_64/ahci/io/pio/lba48/long/high
>> PASS 10 test-replication /replication/secondary/stop
>> ==7220==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 30 ahci-test /x86_64/ahci/io/pio/lba48/short/zero
>> ==7226==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 31 ahci-test /x86_64/ahci/io/pio/lba48/short/low
>> ==7232==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 32 ahci-test /x86_64/ahci/io/pio/lba48/short/high
>> ==7238==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 33 ahci-test /x86_64/ahci/io/dma/lba28/fragmented
>> ==7244==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 34 ahci-test /x86_64/ahci/io/dma/lba28/retry
>> PASS 11 test-replication /replication/secondary/continuous_replication
>> ==7250==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 35 ahci-test /x86_64/ahci/io/dma/lba28/simple/zero
>> ==7256==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 36 ahci-test /x86_64/ahci/io/dma/lba28/simple/low
>> ==7262==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 37 ahci-test /x86_64/ahci/io/dma/lba28/simple/high
>> ==7268==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 38 ahci-test /x86_64/ahci/io/dma/lba28/double/zero
>> ==7274==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 39 ahci-test /x86_64/ahci/io/dma/lba28/double/low
>> PASS 12 test-replication /replication/secondary/do_checkpoint
>> ==7280==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 13 test-replication /replication/secondary/get_error_all
>> PASS 40 ahci-test /x86_64/ahci/io/dma/lba28/double/high
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-bufferiszero -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
>> --test-name="test-bufferiszero"
>> ==7286==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7286==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffc6f892000; bottom 0x7f1ee577b000; size: 0x00dd8a117000
>> (951504171008)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 41 ahci-test /x86_64/ahci/io/dma/lba28/long/zero
>> ==7296==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7296==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fff83d03000; bottom 0x7f7bd317b000; size: 0x0083b0b88000
>> (565605597184)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 42 ahci-test /x86_64/ahci/io/dma/lba28/long/low
>> ==7303==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7303==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffd6e5ab000; bottom 0x7f2971f7b000; size: 0x00d3fc630000
>> (910472445952)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 43 ahci-test /x86_64/ahci/io/dma/lba28/long/high
>> ==7310==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 44 ahci-test /x86_64/ahci/io/dma/lba28/short/zero
>> ==7316==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 45 ahci-test /x86_64/ahci/io/dma/lba28/short/low
>> ==7322==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 46 ahci-test /x86_64/ahci/io/dma/lba28/short/high
>> ==7328==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 47 ahci-test /x86_64/ahci/io/dma/lba48/simple/zero
>> ==7334==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 48 ahci-test /x86_64/ahci/io/dma/lba48/simple/low
>> ==7340==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 49 ahci-test /x86_64/ahci/io/dma/lba48/simple/high
>> ==7346==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 50 ahci-test /x86_64/ahci/io/dma/lba48/double/zero
>> ==7352==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 51 ahci-test /x86_64/ahci/io/dma/lba48/double/low
>> ==7358==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 52 ahci-test /x86_64/ahci/io/dma/lba48/double/high
>> ==7364==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7364==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffd207c8000; bottom 0x7f9dee123000; size: 0x005f326a5000
>> (408867721216)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 53 ahci-test /x86_64/ahci/io/dma/lba48/long/zero
>> ==7371==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7371==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fff17c40000; bottom 0x7f1c4f5fd000; size: 0x00e2c8643000
>> (974024617984)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 54 ahci-test /x86_64/ahci/io/dma/lba48/long/low
>> ==7378==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7378==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7ffd1f3a0000; bottom 0x7f88951fd000; size: 0x00748a1a3000
>> (500533178368)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 55 ahci-test /x86_64/ahci/io/dma/lba48/long/high
>> ==7385==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 56 ahci-test /x86_64/ahci/io/dma/lba48/short/zero
>> ==7391==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 57 ahci-test /x86_64/ahci/io/dma/lba48/short/low
>> ==7397==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 58 ahci-test /x86_64/ahci/io/dma/lba48/short/high
>> ==7403==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 59 ahci-test /x86_64/ahci/io/ncq/simple
>> ==7409==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 60 ahci-test /x86_64/ahci/io/ncq/retry
>> ==7415==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 61 ahci-test /x86_64/ahci/flush/simple
>> ==7421==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 62 ahci-test /x86_64/ahci/flush/retry
>> ==7427==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7433==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 63 ahci-test /x86_64/ahci/flush/migrate
>> ==7441==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7447==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 test-bufferiszero /cutils/bufferiszero
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-uuid -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl --test-
>> name="test-uuid"
>> PASS 1 test-uuid /uuid/is_null
>> ---
>> PASS 22 test-qgraph /qgraph/test_test_in_path
>> PASS 23 test-qgraph /qgraph/test_double_edge
>> PASS 64 ahci-test /x86_64/ahci/migrate/sanity
>> ==7468==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7474==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 65 ahci-test /x86_64/ahci/migrate/dma/simple
>> ==7482==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7488==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 66 ahci-test /x86_64/ahci/migrate/dma/halted
>> ==7496==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7502==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 67 ahci-test /x86_64/ahci/migrate/ncq/simple
>> ==7510==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7516==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 68 ahci-test /x86_64/ahci/migrate/ncq/halted
>> ==7524==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 69 ahci-test /x86_64/ahci/cdrom/eject
>> ==7529==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 70 ahci-test /x86_64/ahci/cdrom/dma/single
>> ==7535==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 71 ahci-test /x86_64/ahci/cdrom/dma/multi
>> ==7541==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 72 ahci-test /x86_64/ahci/cdrom/pio/single
>> ==7547==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7547==WARNING: ASan is ignoring requested __asan_handle_no_return:
>> stack top: 0x7fff4ba6a000; bottom 0x7f8c0c1fe000; size: 0x00733f86c000
>> (494987034624)
>> False positive error reports may follow
>> For details see https://github.com/google/sanitizers/issues/189
>> PASS 73 ahci-test /x86_64/ahci/cdrom/pio/multi
>> ==7553==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 74 ahci-test /x86_64/ahci/cdrom/pio/bcl
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/hd-geo-test -m=quick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name="hd-geo-test"
>> PASS 1 hd-geo-test /x86_64/hd-geo/ide/none
>> ==7567==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 hd-geo-test /x86_64/hd-geo/ide/drive/cd_0
>> ==7573==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/blank
>> ==7579==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/lba
>> ==7585==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 5 hd-geo-test /x86_64/hd-geo/ide/drive/mbr/chs
>> ==7591==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 6 hd-geo-test /x86_64/hd-geo/ide/device/mbr/blank
>> ==7597==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 7 hd-geo-test /x86_64/hd-geo/ide/device/mbr/lba
>> ==7603==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 8 hd-geo-test /x86_64/hd-geo/ide/device/mbr/chs
>> ==7609==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 9 hd-geo-test /x86_64/hd-geo/ide/device/user/chs
>> ==7614==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 10 hd-geo-test /x86_64/hd-geo/ide/device/user/chst
>> ==7620==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7624==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7628==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7632==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7636==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7640==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7644==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7648==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7651==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 11 hd-geo-test /x86_64/hd-geo/override/ide
>> ==7658==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7662==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7666==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7670==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7674==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7678==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7682==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7686==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7689==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 12 hd-geo-test /x86_64/hd-geo/override/scsi
>> ==7696==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7700==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7704==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7708==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7712==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7716==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7720==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7724==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7727==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 13 hd-geo-test /x86_64/hd-geo/override/scsi_2_controllers
>> ==7734==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7738==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7742==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7746==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7749==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 14 hd-geo-test /x86_64/hd-geo/override/virtio_blk
>> ==7756==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7760==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7763==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 15 hd-geo-test /x86_64/hd-geo/override/zero_chs
>> ==7770==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7774==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7778==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7782==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7785==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 16 hd-geo-test /x86_64/hd-geo/override/scsi_hot_unplug
>> ==7792==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7796==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7800==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7804==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> ==7807==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 17 hd-geo-test /x86_64/hd-geo/override/virtio_hot_unplug
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/boot-order-test -m=quick -k --
>> tap < /dev/null | ./scripts/tap-driver.pl --test-name="boot-order-test"
>> PASS 1 boot-order-test /x86_64/boot-order/pc
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7876==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> Using expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7882==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> Using expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7888==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.bridge'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7894==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.ipmikcs'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7900==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.cphp'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7907==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.memhp'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7913==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.numamem'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7919==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.dimmpxm'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7928==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/pc/FACP.acpihmat'
>> Looking for expected file 'tests/data/acpi/pc/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7935==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.bridge'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7941==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.mmio64'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7947==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.ipmibt'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7953==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.cphp'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7960==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.memhp'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7966==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.numamem'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7972==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.dimmpxm'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==7981==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>>
>> Looking for expected file 'tests/data/acpi/q35/FACP.acpihmat'
>> Looking for expected file 'tests/data/acpi/q35/FACP'
>> ---
>> PASS 1 i440fx-test /x86_64/i440fx/defaults
>> PASS 2 i440fx-test /x86_64/i440fx/pam
>> PASS 3 i440fx-test /x86_64/i440fx/firmware/bios
>> ==8073==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 i440fx-test /x86_64/i440fx/firmware/pflash
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/fw_cfg-test -m=quick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name="fw_cfg-test"
>> PASS 1 fw_cfg-test /x86_64/fw_cfg/signature
>> ---
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/drive_del-test -m=quick -k --tap
>> < /dev/null | ./scripts/tap-driver.pl --test-name="drive_del-test"
>> PASS 1 drive_del-test /x86_64/drive_del/without-dev
>> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
>> ==8166==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/wdt_ib700-test -m=quick -k --tap
>> < /dev/null | ./scripts/tap-driver.pl --test-name="wdt_ib700-test"
>> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
>> ---
>> PASS 1 usb-hcd-uhci-test /x86_64/uhci/pci/init
>> PASS 2 usb-hcd-uhci-test /x86_64/uhci/pci/port1
>> PASS 3 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug
>> ==8361==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 usb-hcd-uhci-test /x86_64/uhci/pci/hotplug/usb-storage
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/usb-hcd-ehci-test -m=quick -k --
>> tap < /dev/null | ./scripts/tap-driver.pl --test-name="usb-hcd-ehci-test"
>> PASS 1 usb-hcd-ehci-test /x86_64/ehci/pci/uhci-port-1
>> ---
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/usb-hcd-xhci-test -m=quick -k --
>> tap < /dev/null | ./scripts/tap-driver.pl --test-name="usb-hcd-xhci-test"
>> PASS 1 usb-hcd-xhci-test /x86_64/xhci/pci/init
>> PASS 2 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug
>> ==8379==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-uas
>> PASS 4 usb-hcd-xhci-test /x86_64/xhci/pci/hotplug/usb-ccid
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/cpu-plug-test -m=quick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name="cpu-plug-test"
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8515==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 1 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8521==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 2 vmgenid-test /x86_64/vmgenid/vmgenid/set-guid-auto
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8527==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 vmgenid-test /x86_64/vmgenid/vmgenid/query-monitor
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
>> QTEST_QEMU_IMG=qemu-img tests/qtest/tpm-crb-swtpm-test -m=quick -k
>> --tap < /dev/null | ./scripts/tap-driver.pl --test-name="tpm-crb-swtpm-test"
>> SKIP 1 tpm-crb-swtpm-test /x86_64/tpm/crb-swtpm/test # SKIP swtpm not
>> in PATH or missing --tpm2 support
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8626==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8632==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 3 migration-test /x86_64/migration/fd_proto
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8639==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8645==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 4 migration-test /x86_64/migration/validate_uuid
>> PASS 5 migration-test /x86_64/migration/validate_uuid_error
>> PASS 6 migration-test /x86_64/migration/validate_uuid_src_not_set
>> ---
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8695==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8701==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 8 migration-test /x86_64/migration/auto_converge
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8709==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8715==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 9 migration-test /x86_64/migration/postcopy/unix
>> PASS 10 migration-test /x86_64/migration/postcopy/recovery
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8744==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8750==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 11 migration-test /x86_64/migration/precopy/unix
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8758==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8764==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 12 migration-test /x86_64/migration/precopy/tcp
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8772==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8778==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> PASS 13 migration-test /x86_64/migration/xbzrle/unix
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8786==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> Could not access KVM kernel module: No such file or directory
>> qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or
>> directory
>> qemu-system-x86_64: falling back to tcg
>> ==8792==WARNING: ASan doesn't fully support makecontext/swapcontext
>> functions and may produce false positives in some cases!
>> **
>> ERROR:/tmp/qemu-test/src/tests/qtest/migration-
>> test.c:354:migrate_set_parameter_int: assertion failed: (qdict_haskey(rsp,
>> "return"))
>> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/migration-
>> test.c:354:migrate_set_parameter_int: assertion failed: (qdict_haskey(rsp,
>> "return"))
>> make: *** [/tmp/qemu-test/src/tests/Makefile.include:637: check-qtest-
>> x86_64] Error 1
>> Traceback (most recent call last):
>>    File "./tests/docker/docker.py", line 664, in <module>
>>      sys.exit(main())
>> ---
>>      raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--
>> label', 'com.qemu.instance.uuid=9886d97afe8d4a78a7773890ebff8315', '-u',
>> '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e',
>> 'TARGET_LIST=x86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=',
>> '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e',
>> 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-
>> docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-
>> acxomcm8/src/docker-src.2020-05-20-00.08.30.4230:/var/tmp/qemu:z,ro',
>> 'qemu:fedora', '/var/tmp/qemu/run', 'test-debug']' returned non-zero exit
>> status 2.
>> filter=--
>> filter=label=com.qemu.instance.uuid=9886d97afe8d4a78a7773890ebff8315
>> make[1]: *** [docker-run] Error 1
>> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-acxomcm8/src'
>> make: *** [docker-run-test-debug@fedora] Error 2
>>
>> real    32m24.023s
>> user    0m8.412s
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20200519200207.17773-1-
>> chen.zhang@intel.com/testing.asan/?type=message.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com


