Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CA3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C04206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQcKLcpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C04206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJbM-0001pJ-9j
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiJaU-0000zt-O6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:21:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiJaT-00081G-Un
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591629681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=La700/Z4B+vzqwiuAowf909IaJMseM3Kj6xFnmdkGZo=;
 b=NQcKLcprspdkW/IWOtZdhSHrzW3oVuhXSl4Xq/6jG8OI/VLr16hsukNf3J4PYPd9NgoT+5
 zqKaweTZpETjL/Nmo44r8/wlL8Z6lfUDDuEzcQk/TbI32pZRBDfN8frDypuE8DSG31W1ol
 kog2/1H31q8lJgGN+R1kOEtKAf3g4jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-ymip1K0jNAe3kfqXCmWOWw-1; Mon, 08 Jun 2020 11:20:56 -0400
X-MC-Unique: ymip1K0jNAe3kfqXCmWOWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3E641B18BE0;
 Mon,  8 Jun 2020 15:20:54 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB4F97F4FB;
 Mon,  8 Jun 2020 15:20:53 +0000 (UTC)
Subject: Re: [PATCH v4 02/12] qcow2.py: move qcow2 format classes to separate
 module
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-3-vsementsov@virtuozzo.com>
 <bba065d2-cdd9-08f0-1e02-31f314ecfb0c@redhat.com>
 <cf264553-0a51-e7ca-3117-25d0ea690d05@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ef2dc7e1-8131-9458-4a4a-be311c472681@redhat.com>
Date: Mon, 8 Jun 2020 10:20:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cf264553-0a51-e7ca-3117-25d0ea690d05@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/20 2:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> 05.06.2020 23:14, Eric Blake wrote:
>> On 6/4/20 12:41 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> We are going to enhance qcow2 format parsing by adding more structure
>>> classes. Let's split format parsing from utility code.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---

>>> +++ b/tests/qemu-iotests/qcow2.py
>>> @@ -1,163 +1,10 @@
>>>   #!/usr/bin/env python3
>>> -
>>>   import sys
>>
>> Pre-existing: no copyright blurb on the old file...
>>
>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>> @@ -0,0 +1,157 @@
>>> +import struct
>>> +import string
>>> +
>>
>> It would be nice to fix that, and have one on the new file as well.
>>
> 
> 
> Yes, I thought about this.. But what to add? Seems OK to add Virtuozzo 
> copyright and common "This program is free software; you can redist... 
> GPL ..." header to qcow2_format.py, as we are going to rewrite and 
> improve it a lot. But what to add to qcow2.py, to the part which is kept 
> mostly unchanged?

Late answer, since I see you've already posted v5, but any file without 
an explicit header is implicitly GPLv2+ by virtue of the top-level 
LICENSE file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


