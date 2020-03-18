Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C02C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939082076E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpoTCrZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939082076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEY86-0007Fa-OQ
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 08:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEY7F-0006UO-Ks
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEY7E-00058E-IM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:48:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEY7E-00051v-EH
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584535687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHQtX1ZCzhK03SuiOPTyR5JQnsIeFr58Y9nr41/GsjY=;
 b=SpoTCrZsRk0Yu7sPK79dgUXqHX0UX0qhcjxfRe98hBuaYz5AYruk9Qx84wp4HD7oDSRjbM
 5puIv0hwQVmtWkuinU3D1lhAHvtaD1jRaPS/e/1JQ57U/nJJWyagi0bwuLyPS73bLDS/Ph
 LodbtdDUOkWk4XeFmFLctDawZJk6e9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Vg701tbLMuOBxHDZj5OtMw-1; Wed, 18 Mar 2020 08:48:03 -0400
X-MC-Unique: Vg701tbLMuOBxHDZj5OtMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D71968018A4;
 Wed, 18 Mar 2020 12:48:01 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19DF019C58;
 Wed, 18 Mar 2020 12:47:53 +0000 (UTC)
Subject: Re: [PULL 00/10] Bitmaps patches
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f16cd840-b707-3090-9b22-553920c21d76@redhat.com>
Date: Wed, 18 Mar 2020 07:47:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Libvirt <libvir-list@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 9:00 AM, Peter Maydell wrote:

>>    block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty (2020-03-12 16:36:46 -0400)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> ---------------------------------------------------------------
> 
> Hi; this fails to compile with clang:
> 

As pointed out here, my recommendation is for John to send a v2 pull 
request with one more patch added:
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05969.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


