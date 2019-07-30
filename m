Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5FBC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C862089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C862089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsPvQ-0003i9-Qb
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsPuy-0003IU-Qr
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsPux-0004jM-SW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hsPux-0004j5-NR
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:03:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12D2185365
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 11:03:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D402D10013A7;
 Tue, 30 Jul 2019 11:03:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 557191138619; Tue, 30 Jul 2019 13:03:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-23-armbru@redhat.com>
 <20190729200757.GJ4313@habkost.net>
Date: Tue, 30 Jul 2019 13:03:41 +0200
In-Reply-To: <20190729200757.GJ4313@habkost.net> (Eduardo Habkost's message of
 "Mon, 29 Jul 2019 17:07:57 -0300")
Message-ID: <87blxbeqcy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 30 Jul 2019 11:03:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 22/28] Include hw/boards.h a bit less
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

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jul 26, 2019 at 02:05:36PM +0200, Markus Armbruster wrote:
>> hw/boards.h pulls in almost 60 headers.  The less we include it into
>> headers, the better.  As a first step, drop superfluous inclusions,
>> and downgrade some more to what's actually needed.  Gets rid of just
>> one inclusion into a header.
>> 
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> [...]
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index c58a8e594e..2c9c93983a 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -15,7 +15,6 @@
>>  #include "qapi/qmp/qerror.h"
>>  #include "sysemu/replay.h"
>>  #include "qemu/units.h"
>> -#include "hw/boards.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qapi-visit-common.h"
>>  #include "qapi/visitor.h"
>
> This doesn't look right.  hw/core/machine.c contains the
> implementation of most functions declared at hw/boards.h, and
> surely requires struct MachineClass and struct MachineState to be
> defined.

Editing accident, reverted in the next patch.  Harmless, because we
still get it indirectly.  Will drop the hunk from this patch.  Thanks!

