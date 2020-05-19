Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E8CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34E92072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dukIO9+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34E92072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbA8J-0003So-1L
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbA7b-0002Wi-3U
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbA7a-0002G2-AU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589924997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYuxmNc6NRNemLa5lQX72UyN3962WPDQJnA6AsNosVA=;
 b=dukIO9+jdNmIPg7JKMXIfJVo02SqQ+5yVfyZwYs2mn0eV9iNSI0WvodJtK8em6aUPUFieW
 tdpQnvyceVvhZJ8j1mDL32JYtXg3pW9z+8Sr5Hj+VDJ0HuM22dAvyslahgVgvQ7OV6+Dwr
 CUCcwpuAFPxETIGyJEslOfwYuyKJtmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-pEnaLDFROAK2oY1Dp-9dvQ-1; Tue, 19 May 2020 17:49:55 -0400
X-MC-Unique: pEnaLDFROAK2oY1Dp-9dvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80950872FE0;
 Tue, 19 May 2020 21:49:54 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CECDC1001B07;
 Tue, 19 May 2020 21:49:50 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] iotests: add commit top->base cases to 274
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-6-vsementsov@virtuozzo.com>
 <b8b80d2b-492b-4121-a6eb-8a26aa0c70d4@redhat.com>
 <506b90f3-2d40-168f-14f9-f5ab30c80535@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0fc27063-98de-f1db-8981-e47e07049465@redhat.com>
Date: Tue, 19 May 2020 16:49:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <506b90f3-2d40-168f-14f9-f5ab30c80535@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:21:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:25 PM, Vladimir Sementsov-Ogievskiy wrote:

>> $ ./qemu-img map --output=json top.qcow2
>> [{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": 
>> true, "offset": 327680},
>> { "start": 1048576, "length": 1048576, "depth": 0, "zero": true, 
>> "data": false}]
>>
>> I think what we really want is:
>>
>> [{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": 
>> true, "offset": 327680},
>> { "start": 1048576, "length": 1048576, "depth": 1, "zero": true, 
>> "data": false}]
>>
>> because then we would be _accurately_ reporting that the zeroes that 
>> we read from 1m-2m come _because_ we read from mid (beyond EOF), which 
>> is different from our current answer that the zeroes come from top 
>> (they don't, because top deferred to mid). 
> 
> Right. This is exactly the logic which I bring to block_status_above and 
> is_allocated_above by this series
> 
> If we fix up qemu-img map output to correctly report zeroes beyond EOF 
> from the correct layer, will that also fix up the bug we are seeing in 
> qemu-img commit?
>>
> 
> No it will not fix it, because img_map has own implementation of 
> block_status_above - get_block_status function in qemu-img.c, which goes 
> through backing chain by itself, and is used only in img_map (not in 
> img_convert). But you are right that it should be fixed too.

You are in a maze of twisty passages, all alike ;)

[Hope neither of us is eaten by a grue by the time we get this series in]

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


