Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE36C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E560920870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wisemo.com header.i=@wisemo.com header.b="KluzXE5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E560920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=wisemo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8pl-00075P-SX
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kS8hc-0006vH-L2; Mon, 12 Oct 2020 21:02:09 -0400
Received: from smtpv6n-hq2.wisemo.com ([2a01:4f0:4018::24b]:14142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kS8hZ-0000Zb-Eo; Mon, 12 Oct 2020 21:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wisemo.com;
 s=v2016; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=kujKjxitLKuE/OBp9WpPy+u2m2hupNgm2FOLYTPdInM=; 
 b=KluzXE5kROQJ/6mFTeyK56m8kEAF4Esm6nfCJfyP37e0r0xy+dhAtw0JUzLlB6G97Yvpw9ohTpAFUPPlrxQ/EEs7K9+hvsO1kWAXGZv+9NeXK2xjLg1Xdo+PKRqfI98wS7Dqsr7tO41A7yIuiASe86ky0hUr/+aH94ADo9u4sf5KIm/pAeBJ2vkRxY6Khf/udIZkHe/sXnK3zWuutGBqiUvbfy+Ic+0tk+9PaoSrq9Ik5c0lEj1lgGHh7xGvaDtbEd4lufH8A+zeU72tQzHv0x20L+P9t8Q/72t2wGRpsTCl2zcNc5YZ42EC8pbQpxKAO5Dl/pWjIEaD5okK2vRtvg==;
Received: from [2a01:4f0:4018:f0:e41b:2a9e:7230:325]
 by mailout.i.wisemo.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kS8hQ-0006Zp-2L; Tue, 13 Oct 2020 03:01:56 +0200
Subject: Re: Which qemu change corresponds to RedHat bug 1655408
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-discuss@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>
References: <2d9c8525-470f-a4e5-5d71-895046e2d782@wisemo.com>
 <653b9595-ae60-181a-2975-2e351ade9788@redhat.com>
 <43072820-c04f-b706-4b37-2d2e37e8499f@wisemo.com>
 <0c76d4c9-a203-8bc3-e367-b198efe819d9@redhat.com>
 <7d9328d2-69b6-5bb4-405d-5756e14688ec@wisemo.com>
 <7e7403a0-0491-d6c2-914b-048f48e7aecb@redhat.com>
From: Jakob Bohm <jb-gnumlists@wisemo.com>
Organization: WiseMo A/S
Message-ID: <3ffc3f6a-bbb3-68d2-6609-f979a589a997@wisemo.com>
Date: Tue, 13 Oct 2020 03:01:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <7e7403a0-0491-d6c2-914b-048f48e7aecb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f0:4018::24b;
 envelope-from=jb-gnumlists@wisemo.com; helo=smtpv6n-hq2.wisemo.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-10-12 13:47, Max Reitz wrote:
> On 09.10.20 14:55, Jakob Bohm wrote:
>> On 2020-10-09 10:48, Max Reitz wrote:
>>> On 08.10.20 18:49, Jakob Bohm wrote:
>>>> (Top posting because previous reply did so):
>>>>
>>>> If the bug was closed as "can't reproduce", why was a very similar bug
>>>> listed as fixed in RHSA-2019:2553-01 ?
>>>
>>> Hi,
>>>
>>> Which very similar bug do you mean?  I can only guess that perhaps you
>>> mean 1603104 or 1551486.
>>>
>>> Bug 1603104 was about qemu not ignoring errors when releasing file locks
>>> fails (we should ignore errors then, because they're not fatal, and we
>>> often cannot return errors, so they ended up as aborts).  (To give more
>>> context, this error generally appeared only when the storage the image
>>> is on somehow disappeared while qemu is running.  E.g. when the
>>> connection to an NFS server was lost.)
>>>
>>> Bug 1551486 entailed a bit of a rewrite of the whole locking code, which
>>> may have resulted in the bug 1655408 no longer appearing for our QE
>>> team.  But it was a different bug, as it wasn’t about any error, but
>>> just about the fact that qemu used more FDs than necessary.
>>>
>>> (Although I see 1655408 was reported for RHEL 8, whereas 1603104 and
>>> 1551486 (as part of RHSA-2019:2553) were reported for RHEL 7.  The
>>> corresponding RHEL 8 bug for those two is 1694148.)
>>>
>>> Either way, both of those bugs are fixed in 5.0.
>>>
>>>
>>> 1655408 in contrast reports an error at startup; locking itself failed.
>>>    I couldn’t reproduce it, and I still can’t; neither with the image
>>> mounted concurrently, nor with an RO NFS mount.
>>>
>>> (For example:
>>>
>>> exports:
>>> [...]/test-nfs-ro
>>> 127.0.0.1(ro,sync,no_subtree_check,fsid=0,insecure,crossmnt)
>>>
>>> $ for i in $(seq 100); do \
>>>       echo -e '\033[1m---\033[0m'; \
>>>       x86_64-softmmu/qemu-system-x86_64 \
>>>         -drive \
>>>           if=none,id=drv0,readonly=on,file=/mnt/tmp/arch.iso,format=raw \
>>>         -device ide-cd,drive=drv0 \
>>>         -enable-kvm -m 2048 -display none &; \
>>>       pid=$!; \
>>>       sleep 1; \
>>>       kill $pid; \
>>>     done
>>>
>>> (Where x86_64-softmmu/qemu-system-x86_64 is upstream 5.0.1.)
>>>
>>> All I see is something like:
>>>
>>> ---
>>> qemu-system-x86_64: terminating on signal 15 from pid 7278 (/bin/zsh)
>>> [2] 34103
>>> [3]  - 34095 terminated  x86_64-softmmu/qemu-system-x86_64 -drive
>>> -device ide-cd,drive=drv0  -m 2048
>>>
>>> So no file locking errors.)
>>>
>>
>> The error I got was specifically "Failed to lock byte 100" and VM not
>> starting.  The ISO file was on a R/W NFS3 share, but was itself R/O for
>> the user that root was mapped to by linux-nfs-server via /etc/exports
>> options, specifically the file iso file was mode 0444 in a 0755
>> directory, and the exports line was (simplified)
>>
>> /share1
>> xxxx:xxxx:xxxx:xxxx/64(ro,sync,mp,subtree_check,anonuid=1000,anongid=1000)
>>
>> where xxxx:xxxx:xxxx:xxxx/64 is the numeric IPv6 prefix of the LAN
>>
>> NFS kernel Server ran Debian Stretch kernel 4.19.0-0.bpo.8-amd64 #1 SMP
>> Debian 4.19.98-1~bpo9+1 (2020-03-09) x86_64 GNU/Linux
>>
>> NFS client mount options were:
>>
>> rw,nosuid,nodev,noatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,
>> soft,proto=tcp6,timeo=600,retrans=6,sec=sys,mountaddr=xxxx:xxxx:xxxx:xxxx:xxxx:xxff:fexx:xxxx,
>>
>> mountvers=3,mountport=45327,mountproto=udp6,local_lock=none,addr=xxxx:xxxx:xxxx:xxxx:xxxx:xxff:fexx:xxxx
> 
> I’ve tried using these settings, but still can’t reproduce the bug.
> 
> Nothing else uses the image when you try to attach it to qemu, right?
> (Your last email noted something about a loop mount, but I’m not sure
> whether that just referred to the RH Bugzilla entry.)
> 
> (local_lock=none means that all locks are relayed to the server, correct?)
> 
> Max
> 

Nothing else was supposed to access that ISO at the time, but at various 
times that ISO has been accessed by different virtualization systems for 
different virtual machines, and maybe something didn't release its own 
locks from much earlier (virtualization hosts tend to accumulate a lot 
of uptime).

Coordinating locking of shared disk images between multiple qemu
instances should ideally try to emulate what happens when a SCSI disk is
shared over a SAN (fibre channel, iSCSI, shared parallel SCSI bus etc.), 
so if a VM issues the SCSI lock management commands, they should behave 
as they would for real hardware.

My reference to loop mounts refers to the (common) scenario where
someone tries to mount a raw image file using both qemu and OS methods,
with the loop block driver being the traditional POSIX method that would
be invoked by not using the qemu NBD server.

My large batch job is still running...








Enjoy

Jakob
-- 
Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
This public discussion message is non-binding and may contain errors.
WiseMo - Remote Service Management for PCs, Phones and Embedded

