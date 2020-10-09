Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD67CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060DD222BA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wisemo.com header.i=@wisemo.com header.b="Jqau0dLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060DD222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=wisemo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrx1-0006Ax-V9
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kQrvq-0005C3-EJ; Fri, 09 Oct 2020 08:55:35 -0400
Received: from smtpv6n-hq2.wisemo.com ([2a01:4f0:4018::24b]:14116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kQrvm-0003nK-HI; Fri, 09 Oct 2020 08:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wisemo.com;
 s=v2016; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=DrvXzFI1YHdgWlC3gusRgx0Xw8T3FY9WMoUFwiv5jH8=; 
 b=Jqau0dLdkkPD7o/OxzwUPTNBtVqzdDnPuOn3GgK40LIvYLi76FX8Xcw8icumewrGaeoYC9QhSMgW6V93Z9968Lb98XQBvHD61+KnQAGfXhJIiedWrDTJYp5Hv6jng8HhtriPp9dyxvAFlZJukvuNIvhgNuM7JlTTlXW59RGTxSG+O6nxoQ2axpKCL+fKIxcaXP3e1GA1FO5bEQBKr0VhppDz6oD2RowCmw7EPq50IvrgTf89dohUQxSldHXOSUAxZz5i7X1khljLvLkAweCEW3oeaVsPubbmmuaY6vSunJiRSNZ1Kk3AJnBbknO+tRhnx+NkZqttoB9IbtCdBZYHsw==;
Received: from [2a01:4f0:4018:f0:c157:9fbe:14ab:e29d]
 by mailout.i.wisemo.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kQrvc-0003Co-V2; Fri, 09 Oct 2020 14:55:20 +0200
Subject: Re: Which qemu change corresponds to RedHat bug 1655408
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-discuss@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>
References: <2d9c8525-470f-a4e5-5d71-895046e2d782@wisemo.com>
 <653b9595-ae60-181a-2975-2e351ade9788@redhat.com>
 <43072820-c04f-b706-4b37-2d2e37e8499f@wisemo.com>
 <0c76d4c9-a203-8bc3-e367-b198efe819d9@redhat.com>
From: Jakob Bohm <jb-gnumlists@wisemo.com>
Organization: WiseMo A/S
Message-ID: <7d9328d2-69b6-5bb4-405d-5756e14688ec@wisemo.com>
Date: Fri, 9 Oct 2020 14:55:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0c76d4c9-a203-8bc3-e367-b198efe819d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f0:4018::24b;
 envelope-from=jb-gnumlists@wisemo.com; helo=smtpv6n-hq2.wisemo.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.208,
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

On 2020-10-09 10:48, Max Reitz wrote:
> On 08.10.20 18:49, Jakob Bohm wrote:
>> (Top posting because previous reply did so):
>>
>> If the bug was closed as "can't reproduce", why was a very similar bug
>> listed as fixed in RHSA-2019:2553-01 ?
> 
> Hi,
> 
> Which very similar bug do you mean?  I can only guess that perhaps you
> mean 1603104 or 1551486.
> 
> Bug 1603104 was about qemu not ignoring errors when releasing file locks
> fails (we should ignore errors then, because they're not fatal, and we
> often cannot return errors, so they ended up as aborts).  (To give more
> context, this error generally appeared only when the storage the image
> is on somehow disappeared while qemu is running.  E.g. when the
> connection to an NFS server was lost.)
> 
> Bug 1551486 entailed a bit of a rewrite of the whole locking code, which
> may have resulted in the bug 1655408 no longer appearing for our QE
> team.  But it was a different bug, as it wasn’t about any error, but
> just about the fact that qemu used more FDs than necessary.
> 
> (Although I see 1655408 was reported for RHEL 8, whereas 1603104 and
> 1551486 (as part of RHSA-2019:2553) were reported for RHEL 7.  The
> corresponding RHEL 8 bug for those two is 1694148.)
> 
> Either way, both of those bugs are fixed in 5.0.
> 
> 
> 1655408 in contrast reports an error at startup; locking itself failed.
>   I couldn’t reproduce it, and I still can’t; neither with the image
> mounted concurrently, nor with an RO NFS mount.
> 
> (For example:
> 
> exports:
> [...]/test-nfs-ro
> 127.0.0.1(ro,sync,no_subtree_check,fsid=0,insecure,crossmnt)
> 
> $ for i in $(seq 100); do \
>      echo -e '\033[1m---\033[0m'; \
>      x86_64-softmmu/qemu-system-x86_64 \
>        -drive \
>          if=none,id=drv0,readonly=on,file=/mnt/tmp/arch.iso,format=raw \
>        -device ide-cd,drive=drv0 \
>        -enable-kvm -m 2048 -display none &; \
>      pid=$!; \
>      sleep 1; \
>      kill $pid; \
>    done
> 
> (Where x86_64-softmmu/qemu-system-x86_64 is upstream 5.0.1.)
> 
> All I see is something like:
> 
> ---
> qemu-system-x86_64: terminating on signal 15 from pid 7278 (/bin/zsh)
> [2] 34103
> [3]  - 34095 terminated  x86_64-softmmu/qemu-system-x86_64 -drive
> -device ide-cd,drive=drv0  -m 2048
> 
> So no file locking errors.)
> 

The error I got was specifically "Failed to lock byte 100" and VM not 
starting.  The ISO file was on a R/W NFS3 share, but was itself R/O for 
the user that root was mapped to by linux-nfs-server via /etc/exports
options, specifically the file iso file was mode 0444 in a 0755 
directory, and the exports line was (simplified)

/share1 
xxxx:xxxx:xxxx:xxxx/64(ro,sync,mp,subtree_check,anonuid=1000,anongid=1000)

where xxxx:xxxx:xxxx:xxxx/64 is the numeric IPv6 prefix of the LAN

NFS kernel Server ran Debian Stretch kernel 4.19.0-0.bpo.8-amd64 #1 SMP 
Debian 4.19.98-1~bpo9+1 (2020-03-09) x86_64 GNU/Linux

NFS client mount options were:

rw,nosuid,nodev,noatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,
soft,proto=tcp6,timeo=600,retrans=6,sec=sys,mountaddr=xxxx:xxxx:xxxx:xxxx:xxxx:xxff:fexx:xxxx,
mountvers=3,mountport=45327,mountproto=udp6,local_lock=none,addr=xxxx:xxxx:xxxx:xxxx:xxxx:xxff:fexx:xxxx

NFS client ran Debian Buster kernel 4.19.0-0.bpo.6-amd64 #1 SMP Debian
4.19.67-2+deb10u2~bpo9+1 (2019-11-12) x86_64 with Debian qemu-system-
x86 version 1:5.0-14~bpo10+1  Booting used SysV init and libvirt
was not used.

Copying the ISO to a local drive (where qemu-as-root had full 
capabilities to bypass file security) worked around the failure.

I hope these details help reproduce the bug.

And I still have no idea why qemu tried to lock bytes in a read-only raw
image file, there is no block metadata to synchronize access to (like in
qcow2), when the option explicitly said ",format=raw" to avoid attempts
to access the iso file as any of the advanced virtual disk formats.



>> On 2020-10-08 18:41, Philippe Mathieu-Daudé wrote:
>>> Hi Jakob,
>>>
>>> On 10/8/20 6:32 PM, Jakob Bohm wrote:
>>>> Red Hat bugzilla bug 1655408 against qemu is listed by Red Hat as
>>>> fixed in
>>>> April 2019, but I cannot find the corresponding change on qemu.org (the
>>>> Changelog in the wiki is not a traditional changelog and doesn't cover
>>>> bugfix releases such as 5.0.1, the git commit log is too detailed to
>>>> search, the Red Hat bugzilla and security advisory pages do not link
>>>> red hat bugs back to upstream (launchpad) bugs or git changes.
>>>>
>>>> Here is the bug title (which also affects my Debian packaged qemu 5.0):
>>>>
>>>> VM can not boot up due to "Failed to lock byte 100" if cdrom has been
>>>> mounted on the host
>>>>
>>>> Further observation:
>>>>
>>>> The basic problem is that qemu-system refuses to start with the error
>>>> message "Failed to lock byte 100" when -drive points to a read-only
>>>> ISO file.  For the reporter of the Red Hat bug, that was a mount-induced
>>>> read-only condition, in my case it is an NFS mount of a read-only
>>>> directory.
>>>>
>>>> The error message itself seams meaningless, as there is no particular
>>>> reason to request file locks on a read-only raw disk image.
> 
> Yes, there is.  We must prevent a concurrent instance from writing to
> the image[1], and so we have to signal that somehow, which we do through
> file locks.
> 
> I suppose it can be argued that if the image file itself is read-only
> (outside of qemu), there is no need for locks, because nothing could
> ever modify the image anyway.  But wouldn’t it be possible to change the
> modifications after qemu has opened the image, or to remount some RO
> filesystem R/W?
> 
> Perhaps we could automatically switch off file locks for a given image
> file when taking the first one fails, and the image is read-only.  But
> first I’d rather know what exactly is causing the error you see to appear.
> 
> [1] Technically, byte 100 is about being able to read valid data from
> the image, which is a constraint that’s only very rarely broken.  But
> still, it’s a constraint that must be signaled.  (You only see the
> failure on this byte, because the later bytes (like the one not
> preventing concurrent R/W access, 201) are not even attempted to be
> locked after the first lock fails.)
> 
> (As for other instances writing to the image, you can allow that by
> setting the share-rw=on option on the guest device.  This tells qemu
> that the guest will accept modifications from the outside.  But that
> still won’t prevent qemu from having to take a shared lock on byte 100.)
> 
> Max
> 
>>>> my qemu-system-x86_64 invocation contains the option (on one line):
>>>>
>>>> -drive if=none,id=drive-ide0-1-0,readonly=on,
>>>> file=/mnt/someshare/path/gparted-live-1.1.0-5-amd64.iso,format=raw
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1655408 has been
>>> closed due to lack of reproducer. Can you amend your information
>>> to the BZ? It will likely be re-opened. Thanks!
>>>
>>>>
>>>> Enjoy
>>>>
>>>> Jakob
>>>> -- 
>>>> Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
>>>> Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
>>>> This public discussion message is non-binding and may contain errors.
>>>> WiseMo - Remote Service Management for PCs, Phones and Embedded
>>>>
>>>
>>
>>
>> Enjoy
>>
>> Jakob
> 


Enjoy

Jakob
-- 
Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
This public discussion message is non-binding and may contain errors.
WiseMo - Remote Service Management for PCs, Phones and Embedded

