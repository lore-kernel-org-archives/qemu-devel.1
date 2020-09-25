Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7B6238E2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvsWp39g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7B6238E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrhC-0007eu-SZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrVi-0004P7-Pz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrVe-0007Ia-VS
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:27:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601054870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BCtwkZnx4eqd/fH9/p4JQhwmWhdwjUyuDSfW/AnKq4=;
 b=TvsWp39gJQ5AGPjoM4ks+bUQFhhMIbtwVFUNxEcafl07Q6nTCQp2CN0mFFf0AJMYRZKNLi
 tBIni+Vxh27D+iV9lGCG+2lZq14TcnW9ChQAuKNNbTL4csLGgqDv3qryg5cYDF51Wt5WZG
 iGN6DIdC/HmxhnlWADblJIV3VjbAfB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-ZwlUTkiJOdCdjGegpSJAng-1; Fri, 25 Sep 2020 13:27:41 -0400
X-MC-Unique: ZwlUTkiJOdCdjGegpSJAng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8351007B01;
 Fri, 25 Sep 2020 17:27:40 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A04573662;
 Fri, 25 Sep 2020 17:27:39 +0000 (UTC)
Subject: Re: Minix 1.1 with QEMU
To: Will Senn <will.senn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-discuss@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>
References: <5e534cc7-2a99-baa5-fc8f-63d0d8e85c97@gmail.com>
 <edc82d55-e5d1-abba-9a8e-7954b1dbe66e@amsat.org>
 <6ab2235a-519b-2079-34eb-2dfe3b774fe4@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <78988d07-b426-5ada-67cc-d3badc2e894d@redhat.com>
Date: Fri, 25 Sep 2020 13:27:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6ab2235a-519b-2079-34eb-2dfe3b774fe4@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 1:00 PM, Will Senn wrote:
> On 9/23/20 11:53 AM, Philippe Mathieu-Daudé wrote:
>> Hi Will,
>>
>> On 9/23/20 6:45 PM, Will Senn wrote:
>>> Long time user, first time poster :)
>>>
>>> So, I'd like to be able to run Minix 1.1 on my Macbook Pro mid-2012
>>> w/16gb RAM (MacOS 10.14.6 Mojave). Qemu will run pretty ancient OS'es
>>> such as DOS 2.0, which I use all of the time. However, I'm having some
>>> difficulty getting Minix to run. I am able to boot the first floppy, but
>>> when I change to the second floppy, the system freezes and I can't tell
>>> what is going on. Here's what I did to get this far:
>>>
>>> brew install qemu
>>>
>>> qemu-system-i386 --version
>>> QEMU emulator version 5.1.0
>>>
>>> mkdir ~/workspaces/retro-workspace/minix-1.1
>>> cd ~/workspaces/retro-workspace/minix-1.1
>>> aria2c
>>> http://download.minix3.org/previous-versions/bzipped/Intel-1.1.tar.bz2
>>> tar xvjf Intel-1.1.tar.bz2
>>> cp Intel-1.1/floppy_disk1 ./Disk01.img
>>> cp Intel-1.1/floppy_disk2 ./Disk02.img
>>> cp Intel-1.1/floppy_disk3 ./Disk03.img
>>> cp Intel-1.1/floppy_disk4 ./Disk04.img
>>>
>>>
>>> qemu-system-i386 -drive
>>> file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on
>>> \
>>>    -boot a \
>>>    -no-fd-bootchk \
>>>    -monitortelnet::2222,server,nowait  -serial mon:stdio
>>>
>>> Qemu boots to the Minix 1.1 Boot screen and says to swap to floppy 2, so
>>> in the monitor:
>>> change floppy0 Disk02.img raw
>>>
>>> I press l (el) and it scans the disk, lists the files on the disk and
>>> reports no errors, but when I press =, it does a carriage return and
>>> just sits there. I'm pretty sure this is the Minix going bye bye and not
>>> necessarily QEMU, but I'm wondering if there is a way to see what QEMU
>>> thinks it is doing or if it is what's hung? Usually, at this point,
>>> Minix reads the disk contents into a Ramdisk and boots Minix.
>>>

You can turn on tracing! See docs/devel/tracing.txt for more. You can 
also run QEMU under GDB and break on floppy functions to see what's 
going on if you are so inclined.

>>> Food for thought... Minix expects to run on an IBM PC (5150), IBM PC XT
>>> (5160), or compatible, and therefore the I/O is written for whatever
>>> floppy controller was extant at that time (I'm guessing here), so if
>>> that's different than modern day floppies, I suppose this could cause
>>> the problem I'm experiencing here. Is there a way to see the floppy
>>> controller activity in QEMU? Similarly, I gather it expects a CGA
>>> compatible monitor (EGA/VGA, etc should be fine).
>> Can you try adding '-machine isapc', which is closer to the 5150?
>>
>>> I appreciate your help on this.
>>>
>>> Minix 1.1 works 'ok' in 86Box and other IBM PC emulations, so I know the
>>> floppies are fine.
>>>
>>> Thanks!
>>>
>>> Will
>>>
>>>
>>>
>>> -- 
>>> GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF
>>>
> Phillipe,
> 
> My new incantation is:
> 
> qemu-system-i386 -machine isapc -drive 
> file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on 
> -boot a   -no-fd-bootchk   -monitor telnet::2222,server,nowait -serial 
> mon:stdio
> 
> with the same outcome :(. Thanks for the suggestion, I'll keep it in 
> mind for other projects.
> 
> Will
> 
> -- 
> GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF
> 

This isn't the first time I've seen a report of floppy disks behaving 
poorly in older operating systems.

I'm afraid I don't have the time to really investigate these issues, but 
I am happy to take patches.

--js



