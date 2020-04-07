Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE6C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90C720731
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds+k6u5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90C720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLobL-0001at-T5
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 09:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jLoaD-0000fp-6Z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jLoaA-0001vT-SW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:48:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jLoaA-0001tm-Mr
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586267281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABcuaxqbH4G6x6mMYuhd+ADu34PgQNjR070PllAdWUo=;
 b=ds+k6u5yK/Ek6D0nOKPxD7YdXhOO0BYxIBQN5IdU7QoL98RAQCS/Wt4GZBxzV/o1d17HEg
 VTmAwrnSKbK3AZKswi5I/r52VMUq0ilwLAhwWAoOC7IviEuokMPmswCiTWNoid0K8PCAue
 Om1HJOKNOtm5TWay6Q6Yv9b5BMrAmiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-IJUnKsKHNXiyEl5iaIfF0w-1; Tue, 07 Apr 2020 09:47:53 -0400
X-MC-Unique: IJUnKsKHNXiyEl5iaIfF0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B277685B6FC;
 Tue,  7 Apr 2020 13:47:39 +0000 (UTC)
Received: from [10.3.114.49] (ovpn-114-49.phx2.redhat.com [10.3.114.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 001844D707;
 Tue,  7 Apr 2020 13:47:32 +0000 (UTC)
Subject: Re: Function-like macro with the same name as a typedef confuses
 Coccinelle
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87k12y5by1.fsf@dusky.pond.sub.org>
 <CAFEAcA8aBjWPVH7VsicTrKce1K-sOh0Sv+Ok-75zbtsJV=OBaA@mail.gmail.com>
 <87d08q3th5.fsf@dusky.pond.sub.org> <87eeszcxt6.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <84b95ae1-04ca-9d01-f273-cf0faa459e52@redhat.com>
Date: Tue, 7 Apr 2020 08:47:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87eeszcxt6.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 6:58 AM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Thu, 2 Apr 2020 at 13:06, Markus Armbruster <armbru@redhat.com> wrote:
>>>>
>>>> I discovered that Vladimir's auto-propagated-errp.cocci leaves
>>>> hw/arm/armsse.c unchanged, even though it clearly should change it.
>>>> Running spatch with --debug prints (among lots of other things)
>>>
>>>> Clearly, Coccinelle is getting spooked to easily.
>>>
>>> Is it worth asking on the coccinelle mailing list about whether
>>> coccinelle could be made to be less picky in this area ?
>>
>> I guess we owe them the feedback.  I'll look into minimizing the
>> reproducer.
> 
> https://systeme.lip6.fr/pipermail/cocci/2020-April/007097.html

Wow - firefox refused to connect to that site until I downgraded to 
permitting TLS 1.1.  We should also tell them about their configuration 
bug in not supporting TLS 1.2 for their archives.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


