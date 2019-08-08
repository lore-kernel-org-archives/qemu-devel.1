Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC852171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 11:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC852171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvgj9-0002vc-TM
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 07:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvgik-0002VJ-K2
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvgij-0003yx-4j
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvgii-0003yD-Sz
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 07:36:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F6C130253EC;
 Thu,  8 Aug 2019 11:36:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 265BB1F2;
 Thu,  8 Aug 2019 11:36:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C493113864E; Thu,  8 Aug 2019 13:36:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-16-armbru@redhat.com>
 <3cec7bcc-984f-bc82-6366-d530ae48b356@redhat.com>
Date: Thu, 08 Aug 2019 13:36:28 +0200
In-Reply-To: <3cec7bcc-984f-bc82-6366-d530ae48b356@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Aug 2019 16:44:48
 +0200")
Message-ID: <87ftmbhosj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 08 Aug 2019 11:36:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 15/29] Include migration/vmstate.h less
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> In my "build everything" tree, changing migration/vmstate.h triggers a
>> recompile of some 2700 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).
>>=20
>> hw/hw.h supposedly includes it for convenience.  Several other headers
>> include it just to get VMStateDescription.  The previous commit made
>> that unnecessary.
>>=20
>> Include migration/vmstate.h only where it's still needed.  Touching it
>> now recompiles only some 1600 objects.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
[...]
>>  target/alpha/machine.c             | 1 +
>>  target/arm/machine.c               | 1 +
>>  target/cris/machine.c              | 1 +
>>  target/hppa/machine.c              | 1 +
>>  target/i386/machine.c              | 1 +
>>  target/lm32/machine.c              | 1 +
>>  target/mips/machine.c              | 1 +
>>  target/moxie/machine.c             | 1 +
>>  target/openrisc/machine.c          | 1 +
>>  target/ppc/machine.c               | 1 +
>>  target/s390x/machine.c             | 1 +
>>  target/sparc/machine.c             | 1 +
>
> target/*/machine.c are odd files... Find a common pattern is not obvious.
>
> $ git grep 'cc..vmsd =3D'
> target/arm/cpu.c:2604:    cc->vmsd =3D &vmstate_arm_cpu;
> target/i386/cpu.c:5953:    cc->vmsd =3D &vmstate_x86_cpu;
> target/lm32/cpu.c:235:    cc->vmsd =3D &vmstate_lm32_cpu;
> target/mips/cpu.c:203:    cc->vmsd =3D &vmstate_mips_cpu;
> target/moxie/cpu.c:116:    cc->vmsd =3D &vmstate_moxie_cpu;
> target/ppc/translate_init.inc.c:10597:    cc->vmsd =3D &vmstate_ppc_cpu;
> target/riscv/cpu.c:492:    cc->vmsd =3D &vmstate_riscv_cpu;
> target/s390x/cpu.c:491:    cc->vmsd =3D &vmstate_s390_cpu;
> target/sparc/cpu.c:883:    cc->vmsd =3D &vmstate_sparc_cpu;
>
> Various machine.c are not justified and could go into cpu.c.
> (Not this patch problem).
>
> However I wonder if "migration/vmstate.h" shouldn't be included in
> include/migration/cpu.h instead.

Hmm...

    $ git-grep migration/cpu
    target/alpha/machine.c:#include "migration/cpu.h"
    target/arm/machine.c:#include "migration/cpu.h"
    target/cris/machine.c:#include "migration/cpu.h"
    target/hppa/machine.c:#include "migration/cpu.h"
    target/i386/machine.c:#include "migration/cpu.h"
    target/lm32/machine.c:#include "migration/cpu.h"
    target/mips/machine.c:#include "migration/cpu.h"
    target/moxie/machine.c:#include "migration/cpu.h"
    target/openrisc/machine.c:#include "migration/cpu.h"
    target/ppc/machine.c:#include "migration/cpu.h"
    target/sparc/machine.c:#include "migration/cpu.h"

Can do.

The odd one out: target/s390x/machine.c does not include
migration/cpu.h.

>>  util/fifo8.c                       | 1 +
>>  435 files changed, 436 insertions(+), 8 deletions(-)
> [...]
>> diff --git a/target/moxie/machine.c b/target/moxie/machine.c
>> index 322a724e6f..0d6012603e 100644
>> --- a/target/moxie/machine.c
>> +++ b/target/moxie/machine.c
>> @@ -4,6 +4,7 @@
>>  #include "hw/boards.h"
>>  #include "machine.h"
>>  #include "migration/cpu.h"
>> +#include "migration/vmstate.h"
>
> Hmm this one seems to belong to target/moxie/machine.h... which happens
> to be also odd.

Yes, other targets declare vmstate_FOO_cpu in cpu.h.

>>  const VMStateDescription vmstate_moxie_cpu =3D {
>>      .name =3D "cpu",
[...]

