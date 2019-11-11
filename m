Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08224C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96AB2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbUJxozH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96AB2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9ZQ-0001fG-Uh
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iU9Xm-0001FW-5b
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iU9Xl-00062O-1Z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:15:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iU9Xk-00061z-Tp
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573478144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vd0Qxkn7t8UJ5t2Kzyf6StkXnSFRw/v/CBhkLMeUHdM=;
 b=AbUJxozHJhyrIdyGPmCPD1aMix+nrMBaNuh/V5MH1EB6ze/YDEho19XBEUfBknn9DHPe8o
 kx3eRHj3C0FMNqxueQa751wJeHJmiWaYHfXXxatPr2B1o7CnbHmobqce8cnqHuM2GpoTLG
 nrVjUjjkyntz3y4lo9aUeJv2G7b0WcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-2VvUQFb9P2C-sC3icvzNDg-1; Mon, 11 Nov 2019 08:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EBA82F61;
 Mon, 11 Nov 2019 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3312E3DA7;
 Mon, 11 Nov 2019 13:15:38 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: slirp: Remove myself as maintainer
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <759f8f44-9a01-a9f1-c7cf-65d40151a93a@web.de>
 <CAJ+F1C+tRzRXzTWE1E7Uyvz1q_XU-6i_+utD461i-WbJ+wdR2w@mail.gmail.com>
 <0f57bc71-5a71-6cbf-0ee6-6a83af049959@siemens.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c32f8dfd-6004-869b-0efe-bbd85e91d047@redhat.com>
Date: Mon, 11 Nov 2019 14:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0f57bc71-5a71-6cbf-0ee6-6a83af049959@siemens.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2VvUQFb9P2C-sC3icvzNDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/2019 08.57, Jan Kiszka wrote:
> On 27.07.19 12:00, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Sat, Jul 27, 2019 at 10:16 AM Jan Kiszka <jan.kiszka@web.de> wrote:
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> I haven't been doing anything here for a long time, nor does my git rep=
o
>>> still play a role.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> too bad, we could still use some help ;)
>>
>> thanks anyway!
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>>> ---
>>> =C2=A0 MAINTAINERS | 2 --
>>> =C2=A0 1 file changed, 2 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index d6de200453..238feb965f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2089,13 +2089,11 @@ F: include/hw/registerfields.h
>>>
>>> =C2=A0 SLIRP
>>> =C2=A0 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>> -M: Jan Kiszka <jan.kiszka@siemens.com>
>>> =C2=A0 S: Maintained
>>> =C2=A0 F: slirp/
>>> =C2=A0 F: net/slirp.c
>>> =C2=A0 F: include/net/slirp.h
>>> =C2=A0 T: git https://people.debian.org/~sthibault/qemu.git slirp
>>> -T: git git://git.kiszka.org/qemu.git queues/slirp
>>>
>>> =C2=A0 Stubs
>>> =C2=A0 M: Paolo Bonzini <pbonzini@redhat.com>
>=20
> May I point out that this one was never merged?
>=20
> Sorry, I really can't help in this area anymore.

I'm planning to send a "qtest + misc" PULL request tomorrow ... I can
add the patch there if Samuel does not have anything else pending
related to SLIRP right now...

 Thomas


