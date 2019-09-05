Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16387C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12BD20693
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12BD20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5oqh-0001aa-Hm
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i5ooT-0000hL-8j
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i5ooR-0004VI-I3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:16:24 -0400
Received: from kerio.kamp.de ([195.62.97.192]:45346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1i5ooR-0004To-70; Thu, 05 Sep 2019 06:16:23 -0400
X-Footer: a2FtcC5kZQ==
Received: from [172.21.12.60] ([172.21.12.60]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 5 Sep 2019 12:16:15 +0200
To: ronnie sahlberg <ronniesahlberg@gmail.com>
References: <20190903134442.15653-1-pl@kamp.de>
 <20190903145650.GO4582@localhost.localdomain>
 <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
 <20190904093459.GA21246@localhost.localdomain>
 <d3d2014b-d57e-cff1-d605-859fe94f84fc@kamp.de>
 <CAN05THRnjGZeN+gjP7PNPAZtcvaGNdZekKqr5zA7VQKJ5vbeWA@mail.gmail.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <80ebb253-c5f0-0fa9-f9b0-2372917e58e4@kamp.de>
Date: Thu, 5 Sep 2019 12:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAN05THRnjGZeN+gjP7PNPAZtcvaGNdZekKqr5zA7VQKJ5vbeWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.09.19 um 12:05 schrieb ronnie sahlberg:
> On Thu, Sep 5, 2019 at 7:43 PM Peter Lieven <pl@kamp.de> wrote:
>> Am 04.09.19 um 11:34 schrieb Kevin Wolf:
>>> Am 03.09.2019 um 21:52 hat Peter Lieven geschrieben:
>>>>> Am 03.09.2019 um 16:56 schrieb Kevin Wolf <kwolf@redhat.com>:
>>>>>
>>>>> Am 03.09.2019 um 15:44 hat Peter Lieven geschrieben:
>>>>>> libnfs recently added support for unmounting. Add support
>>>>>> in Qemu too.
>>>>>>
>>>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>>>> Looks trivial enough to review even for me. :-)
>>>>>
>>>>> Thanks, applied to the block branch.
>>>>>
>>>>> Kevin
>>>> I am not sure what the reason is, but with this patch I sometimes run
>>>> into nfs_process_read being called for a cdrom mounted from nfs after
>>>> I ejected it (and the whole nfs client context is already destroyed).
>>> Does this mean that nfs_umount() gets some response, but we don't
>>> properly wait for it? Or is some older request still in flight?
>>
>> nfs_umount itself is a sync call and should only terminate when
>>
>> the call is done. But there is an independent I/O handler in that
>>
>> function polling on the fd. (wait_for_nfs_reply in libnfs-sync.c).
>>
>> This is why I thought the right solution is to stop the Qemu I/O handler
>>
>> before calling nfs_close and nfs_umount. nfs_close also uses this
>>
>> sync I/O handler, but for some reason it seems not to make trouble.
>>
>>
>> The other solution would be to use the async versions of close and umount,
>>
>> but that would make the code in Qemu more complex.
>>
>>
> NFS umount is pretty messy so I think you should continue using the
> sync version.
> In NFSv3 (there is no mount protocol in v4)  the Mount call (fetch the
> root filehandle)
> and the Umount calls (tell server we should no longer show up in
> showexports -a output)
> are not part of the NFS protocol but a different service running on a
> separate port.
>
> This does not map well to libnfs since it is centered around a "struct
> nfs_context".
>
> To use nfs_umount() from QEMU I would suggest :
> 1, make sure all commands in flight have finished, because you will
> soon disconnect from the NFS server and will never receive any
> in-flight responses.
> 2, unregister the nfs->fh filedescriptor from your eventsystem.
> Because the fd is about to be closed so there is great chance it will
> be recycled for a completely different purpose if you open any other
> files from qemu.
>
> 3, call nfs_umount()   Internally this will close the socket to the
> NFS server, then go through thr process to open a new socket to the
> portmapper to discover the mount server, then close that socket and
> reconnect a new socket again to the mount server and perform the UMNT
> call.


What we currently do in Qemu is:


1) bdrv_drain

2) bdrv_close which in the end calls nfs_client_close from block/nfs.c.

   There we call:

   2a) nfs_close(client->fh)

   2b) aio_set_fd_handler(NULL)

   2c) nfs_destroy_context(client->context);


My first patch added a nfs_umount between 2a) and 2b) so that we have

   2a) nfs_close(client->fh)

   2b) nfs_umount(client->context)

   2c) aio_set_fd_handler(NULL)

   2d) nfs_destroy_context(client->context);


This leads to triggering to assertion for an uninitialized client->mutex which is called from an invocation

of nfs_process_read after nfs_destroy_context was called.


If I change the order as following I see no more assertions:

   2a) aio_set_fd_handler(NULL)

   2b) nfs_close(client->fh)

   2c) nfs_umount(client->context)

   2d) nfs_destroy_context(client->context);


I think we should have done this in the first place, because nfs_close (and nfs_umount) poll on the nfs_fd in parallel

if we use the sync calls.


Peter




