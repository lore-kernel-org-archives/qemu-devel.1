Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05EAC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7602F2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7602F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50303 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1Cf-0002Nr-K5
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iK1Au-0001Ma-BZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iK1At-0006or-9k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iK1Ar-0006oL-3l; Mon, 14 Oct 2019 10:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A1B9308624A;
 Mon, 14 Oct 2019 14:18:12 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02E2960126;
 Mon, 14 Oct 2019 14:18:11 +0000 (UTC)
Subject: Re: [PATCH 1/4] vl: Split off user_creatable_print_help()
To: Kevin Wolf <kwolf@redhat.com>
References: <20191011205551.32149-1-kwolf@redhat.com>
 <20191011205551.32149-2-kwolf@redhat.com>
 <f1b7efeb-6ce5-2943-76fc-12b6d0f09215@redhat.com>
 <20191014095525.GC7173@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c3961096-5d67-7762-7294-b91e40ea5f74@redhat.com>
Date: Mon, 14 Oct 2019 09:18:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014095525.GC7173@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 14 Oct 2019 14:18:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 4:55 AM, Kevin Wolf wrote:
> Am 11.10.2019 um 23:35 hat Eric Blake geschrieben:
>> On 10/11/19 3:55 PM, Kevin Wolf wrote:
>>> Printing help for --object is something that we don't only want in the
>>
>> s/don't/not/
> 
> Can someone send a fix for the English grammar? It's obviously broken
> and doesn't know what it wants. Actually, maybe do-support was a bad
> idea and we should just revert it and restore consistent use of proper
> verb-second word order?

Lol

> 
> (Hm, actually, since this seems to negate "only" rather than the verb,
> does "...that we want not only in..." work without patching the
> grammar?)

Yes, that formulation also works.

> 
> (Thanks for the correction.)
> 
> Kevin
> 
>>> system emulator, but also in tools that support --object. Move it into a
>>> separate function in qom/object_interfaces.c to make the code accessible
>>> for tools.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

