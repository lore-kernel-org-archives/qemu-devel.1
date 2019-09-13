Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F57C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F686206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F686206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mWQ-0001Nd-Ac
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8mUk-00080j-9P
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8mUj-0001CZ-Cb
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:24:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8mUj-00019Z-50
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:24:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A1BB190C01F;
 Fri, 13 Sep 2019 14:24:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67FE5D9CC;
 Fri, 13 Sep 2019 14:24:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7844D113865F; Fri, 13 Sep 2019 16:24:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-6-armbru@redhat.com>
 <16792fc8-b513-e934-7ca6-41a5cc10aac0@redhat.com>
Date: Fri, 13 Sep 2019 16:24:03 +0200
In-Reply-To: <16792fc8-b513-e934-7ca6-41a5cc10aac0@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 10:12:42 -0500")
Message-ID: <87ef0k9svw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 13 Sep 2019 14:24:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/16] tests/qapi-schema: Demonstrate
 bad reporting of funny characters
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

> On 9/10/19 1:37 AM, Markus Armbruster wrote:
>> Invalid name 'not\\possible' is reported as 'not\possible'.  Control
>> characters (quoted or not) are even more confusing.  Mark FIXME.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/qapi-schema/enum-bad-name.err  | 2 +-
>>  tests/qapi-schema/enum-bad-name.json | 3 ++-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tests/qapi-schema/enum-bad-name.err b/tests/qapi-schema/enum-bad-name.err
>> index 9c3c1002b7..26a09f84ad 100644
>> --- a/tests/qapi-schema/enum-bad-name.err
>> +++ b/tests/qapi-schema/enum-bad-name.err
>> @@ -1 +1 @@
>> -tests/qapi-schema/enum-bad-name.json:2: Member of enum 'MyEnum' uses invalid name 'not^possible'
>> +tests/qapi-schema/enum-bad-name.json:3: Member of enum 'MyEnum' uses invalid name 'not\possible'
>> diff --git a/tests/qapi-schema/enum-bad-name.json b/tests/qapi-schema/enum-bad-name.json
>> index 8506562b31..b233fdc825 100644
>> --- a/tests/qapi-schema/enum-bad-name.json
>> +++ b/tests/qapi-schema/enum-bad-name.json
>> @@ -1,2 +1,3 @@
>>  # we ensure all enum names can map to C
>> -{ 'enum': 'MyEnum', 'data': [ 'not^possible' ] }
>> +# FIXME reports 'not\posible' instead of 'not\\possible'
>
> s/posible/possible/
>
> (Is it bad when you have a typo in demonstrating that the code has a typo?)

Funny, not bad %-}

> With that fixed,
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

>> +{ 'enum': 'MyEnum', 'data': [ 'not\\possible' ] }
>> 

