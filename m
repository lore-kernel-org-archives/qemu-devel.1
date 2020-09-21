Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F69FC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA9D20735
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA9D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKFGS-0004Uq-RZ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 02:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKFFW-000457-8T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 02:24:30 -0400
Received: from mail.ispras.ru ([83.149.199.84]:34166)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKFFT-0002b6-TY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 02:24:30 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 74C6440D403E;
 Mon, 21 Sep 2020 06:24:24 +0000 (UTC)
Subject: Re: [PATCH v4 00/15] Reverse debugging
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <160006358590.31457.16757371597343007847.stgit@pasha-ThinkPad-X280>
 <ad338011-6abf-7833-6553-cf724b4fb23d@redhat.com>
 <70d75fb9-fb91-8574-2f69-f730969a61ba@ispras.ru>
Message-ID: <38bc996d-b7e6-e89e-f166-2623b0ce554e@ispras.ru>
Date: Mon, 21 Sep 2020 09:24:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <70d75fb9-fb91-8574-2f69-f730969a61ba@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 02:03:38
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

On 21.09.2020 09:03, Pavel Dovgalyuk wrote:
> On 20.09.2020 10:58, Paolo Bonzini wrote:
>> On 14/09/20 08:06, Pavel Dovgalyuk wrote:
>>> GDB remote protocol supports reverse debugging of the targets.
>>> It includes 'reverse step' and 'reverse continue' operations.
>>> The first one finds the previous step of the execution,
>>> and the second one is intended to stop at the last breakpoint that
>>> would happen when the program is executed normally.
>>>
>>> Reverse debugging is possible in the replay mode, when at least
>>> one snapshot was created at the record or replay phase.
>>> QEMU can use these snapshots for travelling back in time with GDB.
>>
>> I had queued this, it is a very nice patch series.  Unfortunately, the
>> tests failed on gitlab:
>>
>> https://gitlab.com/bonzini/qemu/-/jobs/745795080
> 
> There is a strange thing in your environment:
> 
> 15:49:41 INFO | Downloading/preparing boot image
> 15:49:42 INFO | Running '/builds/bonzini/qemu/build/qemu-img create -f 
> qcow2 -b 
> /builds/bonzini/qemu/avocado-cache/by_location/d2a8d6b607afec50de14560c064f34ffd99836b2/Fedora-Cloud-Base-31-1.9.x86_64.qcow2 
> /var/tmp/avocado_tj2janfx/avocado_job_ys7ueohj/04-tests_acceptance_boot_linux.py_BootLinuxX8664.test_pc_q35_kvm/Fedora-Cloud-Base-31-1.9.x86_64-d1ac1224.qcow2' 
> 
> 
> 
> It downloads boot image, but there is no such requirement in the test.
> And all this stuff consumes most of the time for the test.

Sorry, that was ok. It was the output from the previous test.

For reverse debugging there was a timeout on reading from the socket: 
result = self._socket.recv(REMOTE_MAX_PACKET_SIZE)

Do you have any hint how to debug such a failure in this environment?

Pavel Dovgalyuk

