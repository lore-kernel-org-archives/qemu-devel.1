Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADEECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8C321929
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL8auHdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8C321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNkA9-0002De-62
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 16:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iNk9K-0000yd-GV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iNk9H-0005Xv-Kx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:56:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iNk9H-0005XL-01
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571950558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWhfP40+PlaQl+WvRMaI322yaUFZYDz7RQrGYRh8wsw=;
 b=cL8auHdVcq47//rkxaVyreTaNCbdPCjPogSTKd22mbQxmTiU6C/cru6pEdhRfOlFMmrcL3
 uDGsRnHYUDzS+Ob5fC8WQ/VRfFiHMeRCISEJRsZOSYgjEqpLiCrJxBKbMuyT1Ew9MCO7D4
 ivnsZPCRRhz8Cqw2NVjeq/SF1Y3DGws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-QCElRq3nO_G-zXZ5nMOO_g-1; Thu, 24 Oct 2019 16:55:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC57100551B;
 Thu, 24 Oct 2019 20:55:53 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 758DC5C223;
 Thu, 24 Oct 2019 20:55:52 +0000 (UTC)
Subject: Re: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
To: Laurent Vivier <laurent@vivier.eu>, Frediano Ziglio <fziglio@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-3-fziglio@redhat.com>
 <ac0dbd04-c594-0904-020c-ab6384153997@vivier.eu>
 <45775e9d-5d7d-74b4-8eee-1813b080c2da@redhat.com>
 <d9bf8d20-a873-57ec-3cc4-542c72016463@vivier.eu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <94d6ba93-da1e-1233-9ffe-d6b221a0cb90@redhat.com>
Date: Thu, 24 Oct 2019 15:55:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d9bf8d20-a873-57ec-3cc4-542c72016463@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QCElRq3nO_G-zXZ5nMOO_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 1:11 PM, Laurent Vivier wrote:
> Le 24/10/2019 =C3=A0 20:03, Eric Blake a =C3=A9crit=C2=A0:
>> On 10/24/19 12:31 PM, Laurent Vivier wrote:
>>> Le 23/10/2019 =C3=A0 14:26, Frediano Ziglio a =C3=A9crit=C2=A0:
>>>> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
>>>> ---
>>>>  =C2=A0 util/qemu-timer.c | 6 +-----
>>>>  =C2=A0 1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>
>>>>
>>>
>>> Applied to my trivial-patches branch.
>>>
>>> I've updated the patch to remove the two useless casts.
>>>
>>> Eric, if you want to add your R-b, I can add it to the queued patch.
>>
>> I don't see it queued on https://github.com/vivier/qemu/branches yet,
>=20
> Sorry, forgot to push it.
>=20
>> but if removing the two casts is the only difference from the original:
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>=20
> Added and pushed (branch trivial-patches), you can check.

Looks good.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


