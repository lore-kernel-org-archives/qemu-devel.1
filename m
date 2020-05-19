Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7BCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3626F20758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW5NrEZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3626F20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9Yz-0005Mc-FR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb9YP-0004lX-8m
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:13:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48817
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb9YO-0003Lt-EF
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589922815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Op/MI+WEDGhRGpLa7qcmJDDcXeOtGL+P9rd2Ph1HZ34=;
 b=LW5NrEZxw40JC1dwOs+2jNDQ2Z6NRT3kou6NUTn+5M15TQrQwEPkTYmaUI80Hh8CJ/vnNl
 NhHutQ1dUKyzsduVhAE7d7WlDpIdnjA1FRx5O+QUu65gyHQUzZ4mxXZ2VJK4OChUqfU4xv
 dTRCqTdedwH43XRjLg0uMD1f+w61G4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-izbndxQaOrS7t3HqxxxJtg-1; Tue, 19 May 2020 17:13:25 -0400
X-MC-Unique: izbndxQaOrS7t3HqxxxJtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67D2318FE860;
 Tue, 19 May 2020 21:13:24 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED11F101F6D8;
 Tue, 19 May 2020 21:13:20 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] iotests: add commit top->base cases to 274
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b8b80d2b-492b-4121-a6eb-8a26aa0c70d4@redhat.com>
Date: Tue, 19 May 2020 16:13:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519195501.29071-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 2:55 PM, Vladimir Sementsov-Ogievskiy wrote:
> These cases are fixed by previous patches around block_status and
> is_allocated.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/274     | 20 ++++++++++++
>   tests/qemu-iotests/274.out | 65 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 85 insertions(+)

Okay, so this test fails when applied in isolation without the rest of 
your series.

> 
> diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
> index 5d1bf34dff..e910455f13 100755
> --- a/tests/qemu-iotests/274
> +++ b/tests/qemu-iotests/274
> @@ -115,6 +115,26 @@ with iotests.FilePath('base') as base, \
>       iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
>       iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), mid)
>   
> +    iotests.log('=== Testing qemu-img commit (top -> base) ===')
> +
> +    create_chain()
> +    iotests.qemu_img_log('commit', '-b', base, top)
> +    iotests.img_info_log(base)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, base)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff), base)

So if I understand it, we are going from:

base    11111111
mid     ----
top     --------
guest   11110000

and we want to go to:

base    11110000

except that we are not properly writing the zeroes into base, because we 
grabbed the wrong status, ending up with:

base    11111111

The status of top from 1M onwards is unallocated, and if we were to 
commit to just mid, Kevin's truncate fixes solve that (we now zero out 
the tail of mid as part of resizing it to be large enough).  But you are 
instead skipping mid, and committing all the way to base.  So we need 
_something_ that can tell qemu-img commit that even though the region 
1m-2m is unallocated in top, we must behave as though the status of mid 
reports it as allocated (because when reading beyond EOF in mid, we DO 
read zero).  Since the data is allocated not in top, but acts as though 
it was allocated in mid, which is above base, then the commit operation 
has to do something to preserve that allocation.

Okay, you've convinced me we have a bug.  However, I'm still not sold 
that patches 1 and 4 are quite the right fix.  Going back to the 
original setup, unpatched qemu.git head reports:

$ ./qemu-img map --output=json top.qcow2
[{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": 
true, "offset": 327680},
{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data": 
false}]

I think what we really want is:

[{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": 
true, "offset": 327680},
{ "start": 1048576, "length": 1048576, "depth": 1, "zero": true, "data": 
false}]

because then we would be _accurately_ reporting that the zeroes that we 
read from 1m-2m come _because_ we read from mid (beyond EOF), which is 
different from our current answer that the zeroes come from top (they 
don't, because top deferred to mid).  If we fix up qemu-img map output 
to correctly report zeroes beyond EOF from the correct layer, will that 
also fix up the bug we are seeing in qemu-img commit?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


