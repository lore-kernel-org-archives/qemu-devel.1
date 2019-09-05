Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DDDC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4A420825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4A420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5oKK-0003ho-C5
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i5oJ5-0003An-8K
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i5oJ3-0007X7-SS
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:43:58 -0400
Received: from kerio.kamp.de ([195.62.97.192]:45013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1i5oJ3-0007TU-MF; Thu, 05 Sep 2019 05:43:57 -0400
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 5 Sep 2019 11:43:45 +0200
To: Kevin Wolf <kwolf@redhat.com>
References: <20190903134442.15653-1-pl@kamp.de>
 <20190903145650.GO4582@localhost.localdomain>
 <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
 <20190904093459.GA21246@localhost.localdomain>
From: Peter Lieven <pl@kamp.de>
Message-ID: <d3d2014b-d57e-cff1-d605-859fe94f84fc@kamp.de>
Date: Thu, 5 Sep 2019 11:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904093459.GA21246@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: Re: [Qemu-devel] [PATCH] block/nfs: add support for nfs_umount
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
Cc: ronniesahlberg@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.09.19 um 11:34 schrieb Kevin Wolf:
> Am 03.09.2019 um 21:52 hat Peter Lieven geschrieben:
>>
>>> Am 03.09.2019 um 16:56 schrieb Kevin Wolf <kwolf@redhat.com>:
>>>
>>> Am 03.09.2019 um 15:44 hat Peter Lieven geschrieben:
>>>> libnfs recently added support for unmounting. Add support
>>>> in Qemu too.
>>>>
>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>> Looks trivial enough to review even for me. :-)
>>>
>>> Thanks, applied to the block branch.
>>>
>>> Kevin
>> I am not sure what the reason is, but with this patch I sometimes run
>> into nfs_process_read being called for a cdrom mounted from nfs after
>> I ejected it (and the whole nfs client context is already destroyed).
> Does this mean that nfs_umount() gets some response, but we don't
> properly wait for it? Or is some older request still in flight?


nfs_umount itself is a sync call and should only terminate when

the call is done. But there is an independent I/O handler in that

function polling on the fd. (wait_for_nfs_reply in libnfs-sync.c).

This is why I thought the right solution is to stop the Qemu I/O handler

before calling nfs_close and nfs_umount. nfs_close also uses this

sync I/O handler, but for some reason it seems not to make trouble.


The other solution would be to use the async versions of close and umount,

but that would make the code in Qemu more complex.


Peter



