Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32A0C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5C121E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5C121E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMMN-0006qF-1B
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvMLz-0006P9-Ci
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvMLy-00016y-9X
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvMLy-00016k-2J
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:51:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C2513DDBE
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 13:51:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A2D560605;
 Wed,  7 Aug 2019 13:51:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 14A7A113864E; Wed,  7 Aug 2019 15:51:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <dd5a7bd9-a9b6-b388-855c-36755a74fa55@redhat.com>
Date: Wed, 07 Aug 2019 15:51:32 +0200
In-Reply-To: <dd5a7bd9-a9b6-b388-855c-36755a74fa55@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 15:24:18
 +0200")
Message-ID: <87y305rsm3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 13:51:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 27/29] Include sysemu/sysemu.h a lot less
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>> recompile of some 5400 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).
>>=20
>> hw/qdev-core.h includes sysemu/sysemu.h since recent commit e965ffa70a
>> "qdev: add qdev_add_vm_change_state_handler()".  This is a bad idea:
>> hw/qdev-core.h is widely included.
>>=20
>> Move the declaration of qdev_add_vm_change_state_handler() to
>> sysemu/sysemu.h, and drop the problematic include from hw/qdev-core.h.
>>=20
>> Touching sysemu/sysemu.h now recompiles some 1800 objects.
>> qemu/uuid.h also drops from 5400 to 1800.  A few more headers show
>> smaller improvement: qemu/notify.h drops from 5600 to 5200,
>> qemu/timer.h from 5600 to 4500, and qapi/qapi-types-run-state.h from
>> 5500 to 5000.
>>=20
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
[...]
>> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
>> index e5b62dd2fc..de70b7a19a 100644
>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -5,7 +5,6 @@
>>  #include "qemu/bitmap.h"
>>  #include "qom/object.h"
>>  #include "hw/hotplug.h"
>> -#include "sysemu/sysemu.h"
>
> Another build errors on OSX:
>
> ui/cocoa.m:445:10: error: use of undeclared identifier 'cursor_hide'
>     if (!cursor_hide) {
>          ^
> ui/cocoa.m:453:10: error: use of undeclared identifier 'cursor_hide'
>     if (!cursor_hide) {
>          ^
> ui/cocoa.m:596:13: error: use of undeclared identifier 'qemu_name'
>         if (qemu_name)
>             ^
> warning: format specifies type 'char *' but the argument has type
> '<dependent type>' [-Wformat]
> ui/cocoa.m:597:75: error: use of undeclared identifier 'qemu_name'
>             [normalWindow setTitle:[NSString stringWithFormat:@"QEMU
> %s", qemu_name]];
>                                                                          ^
> ui/cocoa.m:995:13: error: use of undeclared identifier 'qemu_name'
>         if (qemu_name)
>             ^
> warning: format specifies type 'char *' but the argument has type
> '<dependent type>' [-Wformat]
> ui/cocoa.m:996:117: error: use of undeclared identifier 'qemu_name'
>             [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s
> - (Press ctrl + alt + g to release Mouse)", qemu_name]];
>
>                                             ^
> ui/cocoa.m:1013:13: error: use of undeclared identifier 'qemu_name'
>         if (qemu_name)
>             ^
> warning: format specifies type 'char *' but the argument has type
> '<dependent type>' [-Wformat]
> ui/cocoa.m:1014:75: error: use of undeclared identifier 'qemu_name'
>             [normalWindow setTitle:[NSString stringWithFormat:@"QEMU
> %s", qemu_name]];
>                                                                          =
 ^
> ui/cocoa.m:1164:5: warning: implicit declaration of function
> 'qemu_system_shutdown_request' is invalid in C99
> [-Wimplicit-function-declaration]
>     qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_UI);
>     ^
> ui/cocoa.m:1164:5: warning: this function declaration is not a prototype
> [-Wstrict-prototypes]
> make: *** [ui/cocoa.o] Error 1

Will fix, thanks!

