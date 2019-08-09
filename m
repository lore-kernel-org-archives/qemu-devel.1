Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A75C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 11:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648E42166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 11:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648E42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw3Oz-0005ie-JD
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 07:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hw3OK-000547-Du
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 07:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hw3OJ-0008UL-48
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 07:49:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hw3OI-0008U3-VU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 07:49:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FD8331D8B6
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 11:49:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAB796D0A2;
 Fri,  9 Aug 2019 11:48:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CBD4113864E; Fri,  9 Aug 2019 13:48:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-10-armbru@redhat.com>
 <0d4d0864-36e3-cdab-f389-ce725382175f@redhat.com>
Date: Fri, 09 Aug 2019 13:48:38 +0200
In-Reply-To: <0d4d0864-36e3-cdab-f389-ce725382175f@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 9 Aug 2019 11:58:33
 +0200")
Message-ID: <87o90ypnjd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 09 Aug 2019 11:49:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 09/29] Include
 migration/qemu-file-types.h a lot less
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

> On 8/9/19 8:46 AM, Markus Armbruster wrote:
>> In my "build everything" tree, changing migration/qemu-file-types.h
>> triggers a recompile of some 2600 out of 6600 objects (not counting
>> tests and objects that don't depend on qemu/osdep.h).
>>=20
>> The culprit is again hw/hw.h, which supposedly includes it for
>> convenience.
>>=20
>> Include migration/qemu-file-types.h only where it's needed.  Touching
>> it now recompiles less than 200 objects.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
> [...]
>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>> index d0be755c82..83c72ee18d 100644
>> --- a/hw/intc/s390_flic.c
>> +++ b/hw/intc/s390_flic.c
>> @@ -22,6 +22,7 @@
>>  #include "hw/qdev.h"
>>  #include "qapi/error.h"
>>  #include "hw/s390x/s390-virtio-ccw.h"
>> +#include "migration/qemu-file-types.h"
>>=20=20
>>  S390FLICStateClass *s390_get_flic_class(S390FLICState *fs)
>>  {
>
> I am not sure this one requires it.
> Did you edit the incorrect file? I still get:
>
> $ make docker-run-test-build@debian-s390x-cross
> [...]
> hw/intc/s390_flic_kvm.c: In function 'kvm_flic_save':
> hw/intc/s390_flic_kvm.c:395:9: error: implicit declaration of function
> 'qemu_put_be64' [-Werror=3Dimplicit-function-declaration]
>          qemu_put_be64(f, FLIC_FAILED);
>          ^~~~~~~~~~~~~

You're right.  Will fix.

