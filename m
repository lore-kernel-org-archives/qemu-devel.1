Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16045C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38FD2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL60Tb/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38FD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEbM-0004sv-3J
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEZ9-0002QQ-C8
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:10:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEZ8-00038G-JG
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589465425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P/NLmMlnwnVOLWpfVAVaskG1g+WLY+R9Xa+w001WNlU=;
 b=iL60Tb/ArTqK88b20ebDUO8m66kku2iEIQZVFZscXcRdlZEqfXI7sXwQ+8BK3kw1UN6VLt
 lprvvq0qc7ARrDi6DhZ38dPbMYRGuvhzhJrM7pjakcGW9f0iJJOltKOuV95RzdYlBSwjk/
 7JegGFultxzxjUxEjqKBLPGC/JDtlD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-aGomqoUtO5a7bTHxP4VirQ-1; Thu, 14 May 2020 10:10:23 -0400
X-MC-Unique: aGomqoUtO5a7bTHxP4VirQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85C9D107ACF4;
 Thu, 14 May 2020 14:10:22 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB7105D9CA;
 Thu, 14 May 2020 14:10:21 +0000 (UTC)
Subject: Re: [PATCH v4 4/9] blockdev: Promote several bitmap functions to
 non-static
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-5-eblake@redhat.com>
 <d47772a1-7d95-74fb-4dab-fa0bad02a0cf@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <53febccd-39b7-1326-7629-57f0b41b3ffa@redhat.com>
Date: Thu, 14 May 2020 09:10:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d47772a1-7d95-74fb-4dab-fa0bad02a0cf@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 6:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.05.2020 04:16, Eric Blake wrote:
>> -        HBitmap **backup, Error **errp)
>> +BdrvDirtyBitmap *block_dirty_bitmap_merge(const char *node, const 
>> char *target,
>> +                                          
>> BlockDirtyBitmapMergeSourceList *bitmaps,
>> +                                          HBitmap **backup, Error 
>> **errp)
>>   {
>>       BlockDriverState *bs;
> 
> s/bitmaps/bms/ to match declaration and fit into 80 characters

Can do, although it has ripple effects to 5/9 (as I wanted that to be 
pure code motion).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


