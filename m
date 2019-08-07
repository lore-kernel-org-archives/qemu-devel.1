Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FAC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2681221922
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2681221922
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvSGn-0002Nm-DG
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvSGP-0001xz-7y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvSGN-0005fy-Fh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvSGN-0005cf-AH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9D4F308212A;
 Wed,  7 Aug 2019 20:10:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81D5D5C21E;
 Wed,  7 Aug 2019 20:10:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3134113864E; Wed,  7 Aug 2019 22:10:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-27-armbru@redhat.com>
 <87ef1xhta7.fsf@linaro.org>
Date: Wed, 07 Aug 2019 22:10:17 +0200
In-Reply-To: <87ef1xhta7.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 07 Aug 2019 16:47:12 +0100")
Message-ID: <87h86srb2u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 07 Aug 2019 20:10:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 26/29] Clean up inclusion of
 sysemu/sysemu.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>> recompile of some 5400 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).
>>
>> 119 of 380 #include directives are actually superfluous.  Delete them.
>> Downgrade two more to qapi/qapi-types-run-state.h, and move one from
>> char/serial.h to char/serial.c.
>>
>> This doesn't reduce actual use much, as it's still included into
>> widely included headers.  The next commit will tackle that.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
> <snip>
>>  hw/semihosting/config.c             | 1 +
> <snip>
>>  stubs/semihost.c                    | 1 +
> <snip>
>> diff --git a/hw/semihosting/config.c b/hw/semihosting/config.c
>> index 2a8e7e1045..9807f10cb0 100644
>> --- a/hw/semihosting/config.c
>> +++ b/hw/semihosting/config.c
>> @@ -24,6 +24,7 @@
>>  #include "qemu/error-report.h"
>>  #include "hw/semihosting/semihost.h"
>>  #include "chardev/char.h"
>> +#include "sysemu/sysemu.h"
>>
>>  QemuOptsList qemu_semihosting_config_opts =3D {
>>      .name =3D "semihosting-config",
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index b8332150f1..9f3cff5fb6 100644
> <snip>
>>
>> diff --git a/stubs/semihost.c b/stubs/semihost.c
>> index 4d5b3c0653..f90589259c 100644
>> --- a/stubs/semihost.c
>> +++ b/stubs/semihost.c
>> @@ -12,6 +12,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/semihosting/semihost.h"
>> +#include "sysemu/sysemu.h"
> <snip>
>
> These additions seem out of place. If I comment them out I can still
> build fine

sysemu/sysemu.h declares qemu_semihosting_config_opts,
hw/semihosting/config.c and stubs/semihost.c define it.

Gcc warns when you do that for functions (-Wmissing-declarations
-Wmissing-prototypes), but not for variables.  I like to include the
header anyway, to make sure the compiler checks the declaration is
consistent with the definition.

>            - I think the only place that needs them is vl.c so it has a
> typedef for the semihosting configure options. Arguably the extern
> declaration could be moved into semihostings own headers to avoid
> polluting sysemu.h more than it needs to?

I'm not sure I'm following you.

What would you like me to move where?

