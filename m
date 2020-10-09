Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F168C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F70222EB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wisemo.com header.i=@wisemo.com header.b="f19qtI9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F70222EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=wisemo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR1Ix-0001Lc-Dq
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kR1HS-0000MZ-OA; Fri, 09 Oct 2020 18:54:30 -0400
Received: from smtpv6n-hq2.wisemo.com ([2a01:4f0:4018::24b]:14098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kR1HP-0001N1-Ln; Fri, 09 Oct 2020 18:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wisemo.com;
 s=v2016; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=hotPF12czalG+XIiYAwCHY9oRKBgeOGnOLzXaYtJAbw=; 
 b=f19qtI9esRMtwf14UOGun5rNW0/dZfi+x3PpaHYy39fYBW2+F4wvPsUGmu6sAWgv+clNKK+Ec7A2SleC6De7YSjrF3ntz170Yt6tAVOK1k732uq8uWAyjHSnVbcvqfpf/HpJFtRPB3FKQr3RIlqQFOYVb08+i8Dd1lCX47mZkenZnmdCH40FXzQ13LWcyWQ41cUlBk/N7SxGf8eN9L9wC2igz9ATEIO7uhm3xjLd3Irf7P8wlo4VK/P/g1mOqAOIDCkNCh+NN7UtQ82CsW6SQ29YxWmIvXVsKfFZPwDP7cBKIq2s5MqOV6yZxXKISCL8+e7mN2W6cATnpX0t1g0Tgw==;
Received: from [2a01:4f0:4018:f0:c157:9fbe:14ab:e29d]
 by mailout.i.wisemo.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kR1HH-0004a8-J1; Sat, 10 Oct 2020 00:54:19 +0200
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
 <81886f9a-91b1-a398-b5a1-44be5bcf6eb3@redhat.com>
From: Jakob Bohm <jb-gnumlists@wisemo.com>
Organization: WiseMo A/S
Message-ID: <829eb784-76ce-7638-1380-4f718b059f92@wisemo.com>
Date: Sat, 10 Oct 2020 00:54:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <81886f9a-91b1-a398-b5a1-44be5bcf6eb3@redhat.com>
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

On 2020-10-09 15:56, Max Reitz wrote:
> On 09.10.20 14:55, Jakob Bohm wrote:
>> On 2020-10-09 10:48, Max Reitz wrote:
> 
> [...]
> 
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
>>
>>
>> NFS client ran Debian Buster kernel 4.19.0-0.bpo.6-amd64 #1 SMP Debian
>> 4.19.67-2+deb10u2~bpo9+1 (2019-11-12) x86_64 with Debian qemu-system-
>> x86 version 1:5.0-14~bpo10+1  Booting used SysV init and libvirt
>> was not used.
>>
>> Copying the ISO to a local drive (where qemu-as-root had full
>> capabilities to bypass file security) worked around the failure.
>>
>> I hope these details help reproduce the bug.
> 
> I’ll try again, thanks.
> 
> Can you perchance reproduce the bug with a more recent upstream kernel
> (e.g. 5.8)?  I seem to recall there have been some locking bugs in the
> NFS code, perhaps there was something that was fixed by now.
> 
> (Or at least 4.19.150, which seems to be the most recent 4.19.x
> according to kernel.org)
> 
>> And I still have no idea why qemu tried to lock bytes in a read-only raw
>> image file, there is no block metadata to synchronize access to (like in
>> qcow2), when the option explicitly said ",format=raw" to avoid attempts
>> to access the iso file as any of the advanced virtual disk formats.
> 
> I reasoned about that in my previous reply already, see below.  It’s
> because just because an image file is read-only when opening it doesn’t
> mean that it’s going to stay that way.
> 
> You’re correct that in the case of raw, this isn’t about metadata (as
> there isn’t any), but about guest data, which needs to be protected from
> concurrent access all the same, though.
> 
> (As for “why does qemu try to lock, when the option explicitly said
> raw”; there is a dedicated option to turn off locking, and that is
> file.locking=off.  I’m not suggesting that as a realistic work-around,
> I’m just adding that FYI in case you didn’t know and need something ASAP.)
> 
> [...]
> 
>>>>>> The error message itself seams meaningless, as there is no particular
>>>>>> reason to request file locks on a read-only raw disk image.
>>>
>>> Yes, there is.  We must prevent a concurrent instance from writing to
>>> the image[1], and so we have to signal that somehow, which we do through
>>> file locks.
>>>
>>> I suppose it can be argued that if the image file itself is read-only
>>> (outside of qemu), there is no need for locks, because nothing could
>>> ever modify the image anyway.  But wouldn’t it be possible to change the
>>> modifications after qemu has opened the image, or to remount some RO
>>> filesystem R/W?
>>>
>>> Perhaps we could automatically switch off file locks for a given image
>>> file when taking the first one fails, and the image is read-only.  But
>>> first I’d rather know what exactly is causing the error you see to
>>> appear.
>>>
>>> [1] Technically, byte 100 is about being able to read valid data from
>>> the image, which is a constraint that’s only very rarely broken.  But
>>> still, it’s a constraint that must be signaled.  (You only see the
>>> failure on this byte, because the later bytes (like the one not
>>> preventing concurrent R/W access, 201) are not even attempted to be
>>> locked after the first lock fails.)
>>>
>>> (As for other instances writing to the image, you can allow that by
>>> setting the share-rw=on option on the guest device.  This tells qemu
>>> that the guest will accept modifications from the outside.  But that
>>> still won’t prevent qemu from having to take a shared lock on byte 100.)
>>>
>>> Max
> 

Theoretically, locking on a raw file needs to be protocol-compatible 
with loop-mounting the same raw file, so if the loop driver doesn't 
probe those magic byte offsets to prevent out-of-order block writes,
then there is little point for the qemu raw driver to do so.

This applies to both the loop driver in the host kernel and the loop
driver on any other machine with file share access to the sane image
file.

As for upgrading, I will try newer kernels packaged for the Debian
version used, once the current large batch job has completed, but I 
doubt it will make much difference given the principles I just stated.



Enjoy

Jakob
-- 
Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
This public discussion message is non-binding and may contain errors.
WiseMo - Remote Service Management for PCs, Phones and Embedded

