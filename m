Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A5C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E5C2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E5C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03OQ-0003B5-1A
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1k03Ni-0002jF-1n
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:41:30 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:50910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1k03Nf-000082-QV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:41:29 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 06RDdXdN005941
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2020 15:39:33 +0200
Received: from [167.87.246.21] ([167.87.246.21])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06RDdWrc023190;
 Mon, 27 Jul 2020 15:39:32 +0200
Subject: Re: [virtio-comment] Re: [RFC] ivshmem v2: Shared memory device
 specification
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <f109fe5a-92eb-e5a5-bb83-ada42b3a9b61@siemens.com>
 <20200727091802-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <85f69f31-e4c6-e7af-1fa5-90e5a2c81ae8@siemens.com>
Date: Mon, 27 Jul 2020 15:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727091802-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=194.138.37.39;
 envelope-from=jan.kiszka@siemens.com; helo=lizzard.sbs.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:39:35
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, liang yan <lyan@suse.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.07.20 15:20, Michael S. Tsirkin wrote:
> On Mon, May 25, 2020 at 09:58:28AM +0200, Jan Kiszka wrote:
>> #### Vendor Specific Capability (ID 09h)
>>
>> This capability must always be present.
>>
>> | Offset | Register            | Content                                        |
>> |-------:|:--------------------|:-----------------------------------------------|
>> |    00h | ID                  | 09h                                            |
>> |    01h | Next Capability     | Pointer to next capability or 00h              |
>> |    02h | Length              | 20h if Base Address is present, 18h otherwise  |
>> |    03h | Privileged Control  | Bit 0 (read/write): one-shot interrupt mode    |
>> |        |                     | Bits 1-7: Reserved (0 on read, writes ignored) |
>> |    04h | State Table Size    | 32-bit size of read-only State Table           |
>> |    08h | R/W Section Size    | 64-bit size of common read/write section       |
>> |    10h | Output Section Size | 64-bit size of output sections                 |
>> |    18h | Base Address        | optional: 64-bit base address of shared memory |
>>
>> All registers are read-only. Writes are ignored, except to bit 0 of
>> the Privileged Control register.
> 
> 
> Is there value in making this follow the virtio vendor-specific
> capability format? That will cost several extra bytes - do you envision
> having many of these in the config space?

Of course, this could be modeled with via virtio_pci_cap as well. Would 
add 12 unused by bytes and one type byte. If it helps to make the device 
look more virtio'ish, but I'm afraid there are more differences at PCI 
level.

I do not see a use case for having multiple of those caps above per 
device. If someone comes around with a valid use case for having 
multiple, non-consequitive shared memory regions for one device, we 
would need to add registers for them. But that would also only work for 
non-BAR regions due to limited BARs.

> Also, do we want to define an extended capability format in case this
> is a pci extended capability?
> 

What would be the practical benefit? Do you see PCIe caps that could 
become useful in virtual setups? We don't do that for regular virtio 
devices either, do we?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

