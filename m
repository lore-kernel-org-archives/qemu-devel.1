Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF073C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859662173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859662173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvh3s-0000ww-On
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvh3Q-0000YS-Md
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvh3P-0000b9-NC
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvh3P-0000ar-Fr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:57:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF46330FB8CA
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 11:57:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BA3C6D0AC;
 Thu,  8 Aug 2019 11:57:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E1D97113864E; Thu,  8 Aug 2019 13:57:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-23-armbru@redhat.com>
 <de7f547d-1c97-135f-654f-3856fa2eec2f@redhat.com>
 <20190807175708.GE4669@habkost.net>
 <647e2542-2042-26de-d768-cdf13afa0ec4@redhat.com>
 <20190807181909.GH4669@habkost.net>
Date: Thu, 08 Aug 2019 13:57:45 +0200
In-Reply-To: <20190807181909.GH4669@habkost.net> (Eduardo Habkost's message of
 "Wed, 7 Aug 2019 15:19:09 -0300")
Message-ID: <877e7nhnt2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 08 Aug 2019 11:57:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 22/29] Include hw/boards.h a bit less
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Aug 07, 2019 at 08:05:50PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 8/7/19 7:57 PM, Eduardo Habkost wrote:
>> > On Wed, Aug 07, 2019 at 07:26:56PM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> >> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> >>> hw/boards.h pulls in almost 60 headers.  The less we include it into
>> >>> headers, the better.  As a first step, drop superfluous inclusions,
>> >>> and downgrade some more to what's actually needed.  Gets rid of just
>> >>> one inclusion into a header.
>> >>>
>> >>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> >>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >>> ---
>> > [...]
>> >>> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
>> >>> index bcacdd1d8f..34a9f6f7a9 100644
>> >>> --- a/target/i386/hax-all.c
>> >>> +++ b/target/i386/hax-all.c
>> >>> @@ -33,7 +33,6 @@
>> >>>  #include "sysemu/reset.h"
>> >>>  #include "sysemu/sysemu.h"
>> >>>  #include "qemu/main-loop.h"
>> >>> -#include "hw/boards.h"
>> >>>=20=20
>> >>>  #define DEBUG_HAX 0
>> >>
>> >> include/sysemu/hax.h misses to include "hw/boards.h":
>> >=20
>> > I don't understand.  I don't see any reason for the sysemu/hax.h
>> > header to include hw/boards.h.
>>=20
>> Ah, you are right, the AccelClass is defined in include/sysemu/accel.h:
>>=20
>> typedef struct AccelClass {
>>     /*< private >*/
>>     ObjectClass parent_class;
>>     /*< public >*/
>>=20
>>     const char *name;
>>     int (*init_machine)(MachineState *ms);
>>     ...
>>=20
>> So this is where "hw/boards.h" has to be included (it is where
>> MachineState is defined).
>
> As far as I can see, accel.h doesn't need the full MachineState
> struct definition and doesn't need boards.h.  It just needs the
> MachineState typedef, which is defined at typedefs.h.
>
> hax-all.c, on the other hand, needs the full MachineState struct
> definition and is expected to include hw/boards.h.

Yes, and I'll fix it.  Thanks!

>> >> target/i386/hax-all.c: In function 'hax_accel_init':
>> >> target/i386/hax-all.c:354:26: error: dereferencing pointer to incompl=
ete
>> >> type 'MachineState {aka struct MachineState}'
>> >>      int ret =3D hax_init(ms->ram_size);

