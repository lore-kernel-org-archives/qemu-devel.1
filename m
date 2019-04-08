Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EF5C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5619C21473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5619C21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDTWe-0003fQ-K4
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 08:37:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTTR-0001P8-JH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDTTO-00041E-II
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:34:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDTTM-0003y9-6a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80058308FE62;
	Mon,  8 Apr 2019 12:33:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C7DD600C4;
	Mon,  8 Apr 2019 12:33:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 163231138648; Mon,  8 Apr 2019 14:33:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-11-armbru@redhat.com>
	<eebcf43e-a4d3-d8b1-1611-23b665ebbe6e@gmail.com>
Date: Mon, 08 Apr 2019 14:33:57 +0200
In-Reply-To: <eebcf43e-a4d3-d8b1-1611-23b665ebbe6e@gmail.com> (Marcel
	Apfelbaum's message of "Mon, 8 Apr 2019 11:44:44 +0300")
Message-ID: <8736msr80a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 08 Apr 2019 12:33:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 10/15] vl: Make -machine $TYPE,
 help and -accel help print to stdout
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408123357.iHsdbQ8iEt_0yo8R8AglafRKjfa-TN8xX9V5xbBfuls@z>

Marcel Apfelbaum <marcel.apfelbaum@gmail.com> writes:

> Hi Markus,
>
> On 4/8/19 11:36 AM, Markus Armbruster wrote:
>> Command line help help explicitly requested by the user should be
>> printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
>> $TYPE,help and -accel help to match: use printf() instead of
>> error_printf().
>>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   vl.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index c696ad2a13..792ef36001 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>>               continue;
>>           }
>>   -        error_printf("%s.%s=%s",
>> MACHINE_GET_CLASS(machine)->name,
>> -                     prop->name, prop->type);
>> +        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
>> +                    prop->name, prop->type);
>
> Does the line above have an alignment issue?

Oops!  Will fix.

> Anyway,
>
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thank you!

