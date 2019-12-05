Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD6C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9545A2466F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB9NwHR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9545A2466F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxH0-0000K6-Ko
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 14:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icxFH-0007xb-BS
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icxFE-000237-Tn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:57:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icxFE-000209-Mb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575575819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8BXoMqcRNex4nEwMOTCCl3JTK5xpjUXo1GO01YnmLM=;
 b=NB9NwHR8TEXD9SyBN9E9Zhy9r17PaP/7v90kDY2vNCtTe7Z/FB+gxaSDMv8CN6DrF0GFGi
 91uQ7lfHtWTknUxx1G+BZNRVKD1xD/AWB6uxsrKYTPI1ecOhiyKrH3Yo+2LuUo7Ds8AueP
 /RArGxOoDEwDpYg67uwSzQReVr+Jd7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-4BlzGgFGPbqO1vU84Mrksw-1; Thu, 05 Dec 2019 14:56:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DA0E183B701;
 Thu,  5 Dec 2019 19:56:55 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 071936CE40;
 Thu,  5 Dec 2019 19:56:54 +0000 (UTC)
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
 <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
 <93046486-1580-14a1-520d-08abdf74da0e@virtuozzo.com>
 <443bfd26-08df-a421-fe88-71b2c068d8e4@redhat.com>
 <93aec76f-fe86-d8b9-6b7a-228149a6e0d4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a7313cf0-dbfc-7a69-0ce2-a0c49c0940a1@redhat.com>
Date: Thu, 5 Dec 2019 13:56:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <93aec76f-fe86-d8b9-6b7a-228149a6e0d4@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4BlzGgFGPbqO1vU84Mrksw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 12:09 PM, Vladimir Sementsov-Ogievskiy wrote:

>>
>> All callers of nbd_iter_channel_error() pass the address of a local_err variable, and only call this function if an error has already occurred, using this function
> 
>> to append details to that error.
> 
> Hmm, not to append details but to report the error to the magical receiving loop, which doesn't yet know about the error
> 
>> This is already implied by its name (local_err instead of the classic errp), but it is worth additionally stressing this by adding an assertion to make it part of the function contract.
> 
> 
> So, how about simply s/to append details to that error/to report that error/ ?

That should be fine.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


