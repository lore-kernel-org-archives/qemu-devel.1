Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E24C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF478207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF478207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrmN-000214-Hq
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCret-0004RJ-Vy
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCres-0004H6-Tu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCres-0004GB-Og
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:43:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4679A3090FCB;
 Tue, 24 Sep 2019 20:43:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 116A210016EB;
 Tue, 24 Sep 2019 20:43:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0678113864E; Tue, 24 Sep 2019 22:43:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 19/25] qapi: Improve reporting of invalid flags
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-20-armbru@redhat.com>
 <4d3b7c95-87dd-d41f-1ad5-ba917287a432@redhat.com>
Date: Tue, 24 Sep 2019 22:43:35 +0200
In-Reply-To: <4d3b7c95-87dd-d41f-1ad5-ba917287a432@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 13:07:22 -0500")
Message-ID: <87v9th8lxk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 24 Sep 2019 20:43:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> Split check_flags() off check_keys() and have check_exprs() call it
>> later, so its error messages gain an "in definition" line.  Tweak the
>> error messages.
>> 
>> Checking values in a function named check_keys() is unclean anyway.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                     | 22 ++++++++++++----------
>>  tests/qapi-schema/allow-preconfig-test.err |  3 ++-
>>  tests/qapi-schema/args-bad-boxed.err       |  3 ++-
>>  tests/qapi-schema/oob-test.err             |  3 ++-
>>  tests/qapi-schema/type-bypass-bad-gen.err  |  3 ++-
>>  5 files changed, 20 insertions(+), 14 deletions(-)
>> 
>
>> +
>> +def check_flags(expr, info):
>> +    for key in ['gen', 'success-response']:
>> +        if key in expr and expr[key] is not False:
>
> Is it any more pythonic and/or a micro-optimization to compress this to:
>
> if expr.get(key, False) is not False:
>
>> +            raise QAPISemError(
>> +                info, "flag '%s' may only use false value" % key)
>> +    for key in ['boxed', 'allow-oob', 'allow-preconfig']:
>> +        if key in expr and expr[key] is not True:
>
> and here too.

Will do.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

