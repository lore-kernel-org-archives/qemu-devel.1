Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF43C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA0E206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA0E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAGV-0003U2-1L
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iUADu-00018P-J3
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iUADr-00070u-FU
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:59:16 -0500
Received: from gecko.sbs.de ([194.138.37.40]:39598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iUADr-0006y2-5Z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:59:15 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id xABDx8gP030114
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2019 14:59:08 +0100
Received: from [139.25.68.37] ([139.25.68.37])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xABDx7rA006753;
 Mon, 11 Nov 2019 14:59:07 +0100
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
Date: Mon, 11 Nov 2019 14:59:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111084327-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.40
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.11.19 14:45, Michael S. Tsirkin wrote:
> On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
>> +| Offset | Register               | Content                                              |
>> +|-------:|:-----------------------|:-----------------------------------------------------|
>> +|    00h | Vendor ID              | 1AF4h                                                |
>> +|    02h | Device ID              | 1110h                                                |
> 
> Given it's a virtio vendor ID, please reserve a device ID
> with the virtio TC.

Yeah, QEMU's IVSHMEM was always using that. I'm happy to make this 
finally official.

Jan


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

