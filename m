Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD40DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF0208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9Vy-0000aZ-D0
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kI9V2-000859-It; Tue, 15 Sep 2020 07:51:52 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:32065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1kI9V0-0004x6-Ab; Tue, 15 Sep 2020 07:51:52 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 62B9A44867;
 Tue, 15 Sep 2020 13:51:41 +0200 (CEST)
Subject: Re: Potential regression in 'qemu-img convert' to LVM
To: Nir Soffer <nsoffer@redhat.com>
References: <1b7b5aa0-2ab0-75a5-68f4-01eb4684dbcb@proxmox.com>
 <CAMRbyyuLboa+XWAmboC5Q6ZQ2KoVXMKJC=r+fGiHPTMEJR8JnA@mail.gmail.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <c00f320b-4d8b-d345-acc5-ba43202a05e3@proxmox.com>
Date: Tue, 15 Sep 2020 13:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyuLboa+XWAmboC5Q6ZQ2KoVXMKJC=r+fGiHPTMEJR8JnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 07:51:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 11:08 AM, Nir Soffer wrote:
> On Mon, Sep 14, 2020 at 3:25 PM Stefan Reiter <s.reiter@proxmox.com> wrote:
>>
>> Hi list,
>>
>> following command fails since 5.1 (tested on kernel 5.4.60):
>>
>> # qemu-img convert -p -f raw -O raw /dev/zvol/pool/disk-1 /dev/vg/disk-1
>> qemu-img: error while writing at byte 2157968896: Device or resource busy
>>
>> (source is ZFS here, but doesn't matter in practice, it always fails the
>> same; offset changes slightly but consistently hovers around 2^31)
>>
>> strace shows the following:
>> fallocate(13, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2157968896,
>> 4608) = -1 EBUSY (Device or resource busy)
> 
> What is the size of the LV?
> 

Same as the source, 5GB in my test case. Created with:

# lvcreate -ay --size 5242880k --name disk-1 vg

> Does it happen if you change sparse minimum size (-S)?
> 
> For example: -S 64k
> 
>      qemu-img convert -p -f raw -O raw -S 64k /dev/zvol/pool/disk-1
> /dev/vg/disk-1
> 

Tried a few different values, always the same result: EBUSY at byte 
2157968896.

>> Other fallocate calls leading up to this work fine.
>>
>> This happens since commit edafc70c0c "qemu-img convert: Don't pre-zero
>> images", before that all fallocates happened at the start. Reverting the
>> commit and calling qemu-img exactly the same way on the same data works
>> fine.
> 
> But slowly, doing up to 100% more work for fully allocated images.
> 

Of course, I'm not saying the patch is wrong, reverting it just avoids 
triggering the bug.

>> Simply retrying the syscall on EBUSY (like EINTR) does *not* work,
>> once it fails it keeps failing with the same error.
>>
>> I couldn't find anything related to EBUSY on fallocate, and it only
>> happens on LVM targets... Any idea or pointers where to look?
> 
> Is this thin LV?
> 

No, regular LV. See command above.

> This works for us using regular LVs.
> 
> Which kernel? which distro?
> 

Reproducible on:
* PVE w/ kernel 5.4.60 (Ubuntu based)
* Manjaro w/ kernel 5.8.6

I found that it does not happen with all images, I suppose there must be 
a certain number of smaller holes for it to happen. I am using a VM 
image with a bare-bones Alpine Linux installation, but it's not an 
isolated case, we've had two people report the issue on our bug tracker: 
https://bugzilla.proxmox.com/show_bug.cgi?id=3002

Thanks,
Stefan

> Nir
> 
> 


