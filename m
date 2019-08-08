Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEABC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD92C2186A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92C2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvZwF-0004hn-3T
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 00:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvZvr-0004I8-Ss
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvZvq-0002he-KQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:21:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvZvq-0002hU-D5
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:21:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F9A93CA0D;
 Thu,  8 Aug 2019 04:21:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61BDD60BE1;
 Thu,  8 Aug 2019 04:21:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEA63113864E; Thu,  8 Aug 2019 06:21:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-2-armbru@redhat.com> <87k1bphvbq.fsf@linaro.org>
 <87woforc8d.fsf@dusky.pond.sub.org> <878ss4is15.fsf@linaro.org>
Date: Thu, 08 Aug 2019 06:21:35 +0200
In-Reply-To: <878ss4is15.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 07 Aug 2019 22:28:54 +0100")
Message-ID: <87tvasl228.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 08 Aug 2019 04:21:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/29] include: Make headers more
 self-contained
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> Back in 2016, we discussed[1] rules for headers, and these were
>>>> generally liked:
>>>>
>>>> 1. Have a carefully curated header that's included everywhere first.  =
We
>>>>    got that already thanks to Peter: osdep.h.
>>>>
>>>> 2. Headers should normally include everything they need beyond osdep.h.
>>>>    If exceptions are needed for some reason, they must be documented in
>>>>    the header.  If all that's needed from a header is typedefs, put
>>>>    those into qemu/typedefs.h instead of including the header.
>>>>
>>>> 3. Cyclic inclusion is forbidden.
>>>>
>>>> This patch gets include/ closer to obeying 2.
>>>>
>>>> It's actually extracted from my "[RFC] Baby steps towards saner
>>>> headers" series[2], which demonstrates a possible path towards
>>>> checking 2 automatically.  It passes the RFC test there.
>>>>
>>>> [1] Message-ID: <87h9g8j57d.fsf@blackfin.pond.sub.org>
>>>>     https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03345.=
html
>>>> [2] Message-Id: <20190711122827.18970-1-armbru@redhat.com>
>>>>     https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg02715.=
html
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
[...]
>>>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-ma=
cros.h
>>>> index c55aa6d174..be83a833ec 100644
>>>> --- a/include/fpu/softfloat-macros.h
>>>> +++ b/include/fpu/softfloat-macros.h
>>>> @@ -82,6 +82,8 @@ this code that are retained.
>>>>  #ifndef FPU_SOFTFLOAT_MACROS_H
>>>>  #define FPU_SOFTFLOAT_MACROS_H
>>>>
>>>> +#include "fpu/softfloat.h"
>>>> +
>>>
>>> What does softfloat-macros actually need from the core softfloat API?
>>> These are lower level functions used by softfloat itself (and m68k for
>>> it's own bit fiddling).
>>
>> I extracted this patch out of "[PATCH RFC v5 0/3] Baby steps towards
>> saner headers".  PATCH 1/3 creates make target "check-source", which is
>> what I used to find headers that aren't self-contained.  In this case:
>>
>>   CC      cris-softmmu/tests/headers-tgt/include/fpu/softfloat.o
>> In file included from tests/headers-tgt/include/fpu/softfloat-macros.c:2=
1:
>> /work/armbru/qemu/include/fpu/softfloat-macros.h: In function =E2=80=98e=
stimateDiv128To64=E2=80=99:
>> /work/armbru/qemu/include/fpu/softfloat-macros.h:623:27: error: implicit=
 declaration of function =E2=80=98LIT64=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
>>   623 |     if ( b <=3D a0 ) return LIT64( 0xFFFFFFFFFFFFFFFF );
>
> The LIT64 definition should be moved to softfloat-types.h which is
> already included by softfloat.h unless we already have a QEMU expansion
> we should be using. The softfloat-macros.h can include softfloat-types.h
> as well and we should only include the full softfloat.h if they need it.
>
> Do you want me to spin up a patch?

Yes, please!

[...]

