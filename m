Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185EBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15DD2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15DD2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59qY-0003gm-5A
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1k59pm-0003Ca-03; Mon, 10 Aug 2020 11:35:34 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:13881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s.reiter@proxmox.com>)
 id 1k59pj-00087P-Hk; Mon, 10 Aug 2020 11:35:33 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D8C684454F;
 Mon, 10 Aug 2020 17:35:23 +0200 (CEST)
Subject: Re: [PATCH for-5.1 v2 2/2] iotests: add test for unaligned
 granularity bitmap backup
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200810095523.15071-1-s.reiter@proxmox.com>
 <20200810095523.15071-2-s.reiter@proxmox.com>
 <941940d2-370d-0452-83c8-969a41f83c72@redhat.com>
From: Stefan Reiter <s.reiter@proxmox.com>
Message-ID: <71deceb2-b907-5b70-c2d9-6060698dab5e@proxmox.com>
Date: Mon, 10 Aug 2020 17:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <941940d2-370d-0452-83c8-969a41f83c72@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=s.reiter@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:35:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 5:11 PM, Max Reitz wrote:
> (Note: When submitting a patch series with multiple patches, our
> guidelines require a cover letter:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Include_a_meaningful_cover_letter
> 
> But not too important now.)
> 

Sorry, remembered for next time. Thanks for applying the patches!

> On 10.08.20 11:55, Stefan Reiter wrote:
>> Start a VM with a 4097 byte image attached, add a 4096 byte granularity
>> dirty bitmap, mark it dirty, and then do a backup.
>>
>> This used to run into an assert and fail, check that it works as
>> expected and also check the created image to ensure that misaligned
>> backups in general work correctly.
>>
>> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>> ---
>>
>> I saw Andrey's big series covering iotest 303 so I went for 304.
> 
> Works for me.
> 
>> Never submitted
>> one before so I hope that's okay, if not feel free to renumber it.
> 
> Yep, if there’s a clash I tend to just renumber it when applying it.
> 
>>   tests/qemu-iotests/304     | 68 ++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/304.out |  2 ++
>>   tests/qemu-iotests/group   |  1 +
>>   3 files changed, 71 insertions(+)
>>   create mode 100755 tests/qemu-iotests/304
>>   create mode 100644 tests/qemu-iotests/304.out
>>
>> diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
>> new file mode 100755
>> index 0000000000..9a3b0224fa
>> --- /dev/null
>> +++ b/tests/qemu-iotests/304
>> @@ -0,0 +1,68 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Tests dirty-bitmap backup with unaligned bitmap granularity
>> +#
>> +# Copyright (c) 2020 Proxmox Server Solutions
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +# owner=s.reiter@proxmox.com
>> +
>> +import iotests
>> +from iotests import qemu_img_create, qemu_img_log, file_path
>> +
>> +iotests.script_initialize(supported_fmts=['qcow2'],
>> +                          supported_protocols=['file'])
>> +
>> +test_img = file_path('test.qcow2')
>> +target_img = file_path('target.qcow2')
>> +
>> +# unaligned by one byte
>> +image_len = 4097
>> +bitmap_granularity = 4096
>> +
>> +qemu_img_create('-f', iotests.imgfmt, test_img, str(image_len))
>> +
>> +# create VM and add dirty bitmap
>> +vm = iotests.VM().add_drive(test_img)
>> +vm.launch()
>> +
>> +vm.qmp('block-dirty-bitmap-add', **{
>> +    'node': 'drive0',
>> +    'name': 'bitmap0',
>> +    'granularity': bitmap_granularity
>> +})
>> +
>> +# mark entire bitmap as dirty
>> +vm.hmp_qemu_io('drive0', 'write -P0x16 0 4096');
>> +vm.hmp_qemu_io('drive0', 'write -P0x17 4097 1');
> 
> s/4097/4096/?
> 
> (4097 works, too, because of something somewhere aligning up the 4097 to
> 512 byte sectors, I suppose, but I don’t think it’s the address you want
> here)
> 

You're right, it seems counting is hard. I'll take you up on the offer 
from your other mail, you can fix this please :)

>> +
>> +# do backup and wait for completion
>> +vm.qmp('drive-backup', **{
>> +    'device': 'drive0',
>> +    'sync': 'full',
>> +    'target': target_img,
>> +    'bitmap': 'bitmap0',
>> +    'bitmap-mode': 'on-success'
> 
> The bitmap is unnecessary, isn’t it?  I.e., if I drop the
> block-dirty-bitmap-add call and the bitmap* parameters here, I still get
> an assertion failure without patch 1.
> 
> Not that it really matters, it’s just that this makes it look like less
> of an issue than it actually is.  (Which is why I’d drop the bitmap
> stuff in case there’s no actual reason for it.)
> 

Oh my, I just realized that I misunderstood the root cause then. I mean, 
the fix is fine, I see it now, but you're right, no dirty bitmap needed 
- you can remove that as well if you want.

>> +})
>> +
>> +event = vm.event_wait(name='BLOCK_JOB_COMPLETED',
>> +                      match={'data': {'device': 'drive0'}},
>> +                      timeout=5.0)
> 
> (By the way, “vm.run_job('drive0', auto_dismiss=True)” would have worked
> as well.  But since the backup job just needs waiting for a single
> event, I suppose it doesn’t matter.  Just a hint in case you start
> writing more iotests in the future.)
> 
> Max
> 


