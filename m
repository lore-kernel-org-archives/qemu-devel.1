Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B117EC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5082084F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5082084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i81ey-00043N-Lm
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i81e3-0003b8-Rm
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i81e2-0002uO-Nl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:22:47 -0400
Received: from kerio.kamp.de ([195.62.97.192]:44196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1i81e2-0002qw-Hl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:22:46 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:22:35 +0200
Received: (qmail 40210 invoked from network); 11 Sep 2019 12:22:37 -0000
Received: from unknown (HELO ?82.141.7.8?) (pl@kamp.de@::ffff:82.141.7.8)
 by submission.kamp.de with ESMTPS (AES128-SHA encrypted) ESMTPA;
 11 Sep 2019 12:22:37 -0000
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-3-pl@kamp.de>
 <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <660efadc-760f-dda7-892d-1de9d92f202b@kamp.de>
Date: Wed, 11 Sep 2019 14:22:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e2b37e13-ef22-4a16-38e5-3866e7d5409a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: add support for
 nfs_umount
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.09.19 um 09:48 schrieb Max Reitz:
> On 10.09.19 17:41, Peter Lieven wrote:
>> libnfs recently added support for unmounting. Add support
>> in Qemu too.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/nfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 2c98508275..f39acfdb28 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -398,6 +398,9 @@ static void nfs_client_close(NFSClient *client)
>>              nfs_close(client->context, client->fh);
>>              client->fh = NULL;
>>          }
>> +#ifdef LIBNFS_FEATURE_UMOUNT
>> +        nfs_umount(client->context);
>> +#endif
>>          nfs_destroy_context(client->context);
>>          client->context = NULL;
>>      }
> I don’t understand what unmounting means in this context.  Is it just
> generic clean-up for NFSv3 (it appears that it’s a no-op for NFSv4)?


Its a call to the mount daemon on the NFSv3 server. It will effectively

cause that the connection is no longer listed when showmounts -a is issued on the server.


> Why isn’t that done by nfs_destroy_context()?


That would have been the right place, but libnfs added support for this call only recently. I think with version 4.0.0


Peter




