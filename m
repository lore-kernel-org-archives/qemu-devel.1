Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D803C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E27321E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E27321E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMKI-0005Uy-7j
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvMJv-00054L-UA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvMJu-0008PB-Hj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvMJu-0008Ol-An
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:49:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2595300308B
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 13:49:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90CFA600CC;
 Wed,  7 Aug 2019 13:49:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD633113864E; Wed,  7 Aug 2019 15:49:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-21-armbru@redhat.com>
 <1f71990a-cc06-1b50-e138-9975e1bde9c2@redhat.com>
Date: Wed, 07 Aug 2019 15:49:18 +0200
In-Reply-To: <1f71990a-cc06-1b50-e138-9975e1bde9c2@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 15:18:20
 +0200")
Message-ID: <8736idt7a9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 07 Aug 2019 13:49:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 20/29] Include qemu/main-loop.h less
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

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> In my "build everything" tree, changing qemu/main-loop.h triggers a
>> recompile of some 5600 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
>> which in turn includes qemu/event_notifier.h, qemu/notify.h,
>> qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
>> qemu/thread.h, qemu/timer.h, and a few more.
>>=20
>> Include qemu/main-loop.h only where it's needed.  Touching it now
>> recompiles only some 1700 objects.  For block/aio.h and
>> qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
>> others, they shrink only slightly.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
[...]
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 77f5df59b0..ac18a1184a 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -5,7 +5,6 @@
>>  #include "qapi/qapi-types-run-state.h"
>>  #include "qemu/timer.h"
>>  #include "qemu/notify.h"
>> -#include "qemu/main-loop.h"
>>  #include "qemu/bitmap.h"
>>  #include "qemu/uuid.h"
>>  #include "qom/object.h"
> [...]
>
> You missed to adapt ui/cocoa.m, building fails on OSX:
>
>   OBJC    ui/cocoa.o
> ui/cocoa.m:141:19: warning: implicit declaration of function
> 'qemu_mutex_iothread_locked' is invalid in C99
> [-Wimplicit-function-declaration]
>     bool locked =3D qemu_mutex_iothread_locked();
>                   ^
> ui/cocoa.m:141:19: warning: this function declaration is not a prototype
> [-Wstrict-prototypes]
> ui/cocoa.m:143:9: warning: implicit declaration of function
> 'qemu_mutex_lock_iothread' is invalid in C99
> [-Wimplicit-function-declaration]
>         qemu_mutex_lock_iothread();
>         ^
> ui/cocoa.m:143:9: warning: this function declaration is not a prototype
> [-Wstrict-prototypes]
> ui/cocoa.m:147:9: warning: implicit declaration of function
> 'qemu_mutex_unlock_iothread' is invalid in C99
> [-Wimplicit-function-declaration]
>         qemu_mutex_unlock_iothread();
>         ^
> ui/cocoa.m:147:9: warning: this function declaration is not a prototype
> [-Wstrict-prototypes]
> ui/cocoa.m:153:19: warning: implicit declaration of function
> 'qemu_mutex_iothread_locked' is invalid in C99
> [-Wimplicit-function-declaration]
>     bool locked =3D qemu_mutex_iothread_locked();
>                   ^
> ui/cocoa.m:157:9: warning: implicit declaration of function
> 'qemu_mutex_lock_iothread' is invalid in C99
> [-Wimplicit-function-declaration]
>         qemu_mutex_lock_iothread();
>         ^
> ui/cocoa.m:161:9: warning: implicit declaration of function
> 'qemu_mutex_unlock_iothread' is invalid in C99
> [-Wimplicit-function-declaration]
>         qemu_mutex_unlock_iothread();
>         ^

Will fix, thanks!

