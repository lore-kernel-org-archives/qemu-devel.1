Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A69C32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 17:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE5B2086A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 17:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE5B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwUl7-0007xF-Fd
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 13:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hwUkh-0007S2-By
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 13:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hwUkf-0006Xk-VO
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 13:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hwUkf-0006VV-Nd
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 13:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC7CF3CA10;
 Sat, 10 Aug 2019 17:01:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BE1D17D76;
 Sat, 10 Aug 2019 17:01:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16B4A105A472; Sat, 10 Aug 2019 19:01:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
 <c3c62a6a-2471-fbd5-0deb-21968799dd42@redhat.com>
Date: Sat, 10 Aug 2019 19:01:41 +0200
In-Reply-To: <c3c62a6a-2471-fbd5-0deb-21968799dd42@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 9 Aug 2019 18:12:30
 +0200")
Message-ID: <87sgq9j6oa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 10 Aug 2019 17:01:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/29] Tame a few "touch this,
 recompile the world" headers
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus,
>
> On 8/9/19 8:46 AM, Markus Armbruster wrote:
>> We have quite a few "touch this, recompile the world" headers.  My
>> "build everything" tree has some 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).  Touching any of 54
>> headers triggers a recompile of more than half of them.
>>=20
>> This series reduces them to 46.
[...]
>> Observed patterns of #include misuse:
>>=20
>> * Copy pasta
>>=20
>>   I found and deleted quite a few #include that were almost certainly
>>   never needed.  The most likely explanation is lazy copying from a
>>   "similar" file.  My deletions produced only minor improvements,
>>   though.
>>=20
>> * "Convenience" headers
>>=20
>>   We sometimes have a header include a bunch of other headers the
>>   header itself doesn't need, so the header's users don't have to.  An
>>   extreme case is hw/hw.h: it pulls in more than 40 other headers,
>>   then declares just hw_error().  Most of its users need only a
>>   fraction of it.  PATCH 08-09,12-18 fix that, trading the very
>>   occasional convenience of not having to type a few #include
>>   directives for build speed.
>>=20
>> * "Fat" headers
>>=20
>>   Some headers provide many things to many customers.  Bad when the
>>   customers generally need only parts.  Worse when such a "fat" header
>>   pulls in loads more.  This series grapples with three instances:
>>   qapi/qapi-types-common.h (PATCH 03), hw/boards.h, which pulls in
>>   almost 70 headers (PATCH 19-23), and sysemu/sysemu.h, which pulls in
>>   more than 20 (PATCH 23-28).
>>=20
>> * Design erosion
>>=20
>>   Off-the-cuff additions to headers can erode design.  For instance,
>>   the generated trace.h were carefully designed for minimal
>>   dependencies.  We let them balloon when we added the per-vCPU
>>   tracing feature a few years later.  PATCH 07 grapples with that.
>
> What can prevent us from these misuse patterns?

Excellent question.

> Will you redo this analysis/series after each releases?

Perhaps I should first explain my analysis, i.e. where my numbers come
from, then my cleanups.

Counting #include directives is not useful by itself.  For instance,
#include "qemu/typedefs.h" occurs just once, yet almost all .o depend on
it.

Better: count the actual make dependencies.  Compiling FOO.c generates
FOO.d in addition to FOO.o.  These .d list the .h the .o depend on.  I
wrote a stupid Python program to count how many .o depend on each .h.
This identifies widely included headers.

Also useful are the .d for the .c generated by "make check-headers":
they tell us how many headers each header pulls in.  Widely included
headers that pull in lots more are particularly promising candidates for
#include cleanup.

The actual cleanup is manual work.  Getting rid of copy pasta and
"convenience" headers is pretty straightforward.  "Fat" headers and
design erosion can require more thought.  Another difficult part is
identifying how to order the cleanups for reviewability.  Testing is
straightforward, but sloooow; much world-recompiling for many, many
worlds.

I started looking into this back in 2016[1], and updated the analysis
recently[2].  I contributed a few cleanups myself, and at least Paolo
also chipped in.

I can update the analysis more frequently if that helps.  However, ...

> How to automate misuse checks?
>
> Can we report some metrics and warn if there a considerable discrepancy?

... detecting we've made things worse weeks or months after we did is
clearly suboptimal.

The actual numbers depend on build configuration.  For reproducible
numbers, we need to hold configuration constant for all developers.  I
figure our containerized builds could do that for us.

To detect metrics going south, we need a baseline, and a definition of
"south".

If we store the baseline in git and fail the test when the actual
numbers are too "south" of the baseline, patches making things a lot
worse will have to update the baseline.  This should ensure proper
scrutiny.

However, a slow slide south over multiple independent patches will=20
arbitrary blame the last one, while the others get off scot free.

I'm not sure how to best handle new headers.  Having to update the
baseline whenever you add a new header will likely add too much
friction.

Needs thought.

Perhaps we can start with fully automating the measurement part, then
passively gather data for a while to learn how the numbers change during
development.



[1] https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03271.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg06291.html

