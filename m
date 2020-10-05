Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17301C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E5920774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 13:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E5920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQqJ-0000xU-Qr
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kPQoF-0008Ap-5k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:45:47 -0400
Received: from mail.ispras.ru ([83.149.199.84]:45122)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kPQoA-0007Su-Ue
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 09:45:46 -0400
Received: from [10.0.35.114] (unknown [80.250.189.91])
 by mail.ispras.ru (Postfix) with ESMTPSA id CB2314089F1F;
 Mon,  5 Oct 2020 13:45:36 +0000 (UTC)
Subject: Re: [PATCH v7 00/14] Reverse debugging
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <160174516520.12451.10785284392438702137.stgit@pasha-ThinkPad-X280>
 <1d81369e-3e20-444a-1ad4-197edc0245a9@redhat.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <1c91f71b-c144-65c2-82b4-1121fa9a7c07@ispras.ru>
Date: Mon, 5 Oct 2020 16:45:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1d81369e-3e20-444a-1ad4-197edc0245a9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 09:45:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, philmd@redhat.com,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.10.2020 15:27, Paolo Bonzini wrote:
> On 03/10/20 19:12, Pavel Dovgalyuk wrote:
>> GDB remote protocol supports reverse debugging of the targets.
>> It includes 'reverse step' and 'reverse continue' operations.
>> The first one finds the previous step of the execution,
>> and the second one is intended to stop at the last breakpoint that
>> would happen when the program is executed normally.
>>
>> Reverse debugging is possible in the replay mode, when at least
>> one snapshot was created at the record or replay phase.
>> QEMU can use these snapshots for travelling back in time with GDB.
>>
>> Running the execution in replay mode allows using GDB reverse debugging
>> commands:
>>   - reverse-stepi (or rsi): Steps one instruction to the past.
>>     QEMU loads on of the prior snapshots and proceeds to the desired
>>     instruction forward. When that step is reaches, execution stops.
>>   - reverse-continue (or rc): Runs execution "backwards".
>>     QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>>     and replaying the execution. Then QEMU loads snapshots again and
>>     replays to the latest breakpoint. When there are no breakpoints in
>>     the examined section of the execution, QEMU finds one more snapshot
>>     and tries again. After the first snapshot is processed, execution
>>     stops at this snapshot.
>>
>> The set of patches include the following modifications:
>>   - gdbstub update for reverse debugging support
>>   - functions that automatically perform reverse step and reverse
>>     continue operations
>>   - hmp/qmp commands for manipulating the replay process
>>   - improvement of the snapshotting for saving the execution step
>>     in the snapshot parameters
>>   - avocado-based acceptance tests for reverse debugging
>>
>> The patches are available in the repository:
>> https://github.com/ispras/qemu/tree/rr-200901
>>
>> v7 changes:
>>   - updated snapshot info output format
>>   - fixed qcow2 snapshot-related tests
> 
> Sorry, I'm still seeing a failure
> 
> timeout 15  /home/travis/build/bonzini/qemu/build/qemu-system-aarch64 -monitor none -display none -chardev file,path=memory-replay.out,id=output -icount shift=5,rr=replay,rrfile=record.bin  -M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel memory
> 
> qemu-system-aarch64: terminating on signal 15 from pid 38312 (timeout)

That's very strange.
None of the patches affect RR for AArch64. Is this the real failure or 
just a coincidence?
I also tried running this test on my local machine and got normal 
execution time for replay:
real	0m0,968s
user	0m0,657s
sys	0m0,625s

By the way, this is an early RR test. Now we have more complex (and 
easier to reproduce) avocado-based RR tests (for aarch64 too).
I.e. record and replay in this test are divided into two "tests",
and can cause races if running in parallel for some reason.

Shouldn't we just drop this one?

> 
> https://travis-ci.com/gitlab/bonzini/qemu/jobs/395029273
> 
> Paolo
> 


