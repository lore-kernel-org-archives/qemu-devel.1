Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2043A207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2043A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrq7-0007jp-BQ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCrhY-0006hX-Uv
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCrhX-0006Jv-QQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:46:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCrhX-0006JN-LN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:46:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0970109EFC3;
 Tue, 24 Sep 2019 20:46:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E865D9D5;
 Tue, 24 Sep 2019 20:46:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35BCC113864E; Tue, 24 Sep 2019 22:46:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 20/25] qapi: Improve reporting of missing / unknown
 definition keys
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-21-armbru@redhat.com>
 <cda1aa80-5328-3cb8-002c-efaaf7933346@redhat.com>
Date: Tue, 24 Sep 2019 22:46:18 +0200
In-Reply-To: <cda1aa80-5328-3cb8-002c-efaaf7933346@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 13:13:12 -0500")
Message-ID: <87o8z98lt1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 24 Sep 2019 20:46:23 +0000 (UTC)
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> Have check_exprs() call check_keys() later, so its error messages gain
>> an "in definition" line.
>> 
>> Both check_keys() and check_name_is_str() check the definition's name
>> is a string.  Since check_keys() now runs after check_name_is_str()
>> rather than before, its check is dead.  Bury it.  Checking values in
>> check_keys() is unclean anyway.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/scripts/qapi/common.py
>> @@ -905,8 +905,6 @@ def check_known_keys(value, info, source, required, optional):
>>  
>>  def check_keys(expr, info, meta, required, optional=[]):
>>      name = expr[meta]
>> -    if not isinstance(name, str):
>> -        raise QAPISemError(info, "'%s' key must have a string value" % meta)
>
> Should this be replaced with an assert?  But I'm also okay just dropping
> it, since our testsuite shows that we still flag the problems that this
> message was originally used for.

I'd prefer not to assert, because as of this patch, check_keys() *only*
checks keys, just like its name suggests.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

