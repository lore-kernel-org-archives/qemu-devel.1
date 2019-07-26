Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C3C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69358218D3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69358218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1If-0004bb-Le
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53769)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hr1IW-0004CA-AB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hr1IV-0004mT-AB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hr1IV-0004kZ-4k
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:34:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B79FA3082212
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 14:34:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 841F06012D;
 Fri, 26 Jul 2019 14:34:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 043FA113865F; Fri, 26 Jul 2019 16:34:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-4-armbru@redhat.com>
 <293774d4-dd12-22b1-65e2-727670b49458@redhat.com>
Date: Fri, 26 Jul 2019 16:34:11 +0200
In-Reply-To: <293774d4-dd12-22b1-65e2-727670b49458@redhat.com> (Eric Blake's
 message of "Fri, 26 Jul 2019 08:53:58 -0500")
Message-ID: <87k1c46f18.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 26 Jul 2019 14:34:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/28] qapi: Split error.json off
 common.json
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

Eric Blake <eblake@redhat.com> writes:

> On 7/26/19 7:05 AM, Markus Armbruster wrote:
>> In my "build everything" tree, changing a type in qapi/common.json
>> triggers a recompile of some 3600 out of 6600 objects (not counting
>> tests and objects that don't depend on qemu/osdep.h).
>> 
>> One common dependency is QapiErrorClass: it's used only in in
>> qapi/error.h, which uses nothing else, and is widely included.
>> 
>> Move QapiErrorClass from common.json to new error.json.  Touching
>> common.json now recompiles only some 2900 objects.
>> 
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS           |  2 ++
>>  include/qapi/error.h  |  2 +-
>>  qapi/Makefile.objs    |  2 +-
>>  qapi/common.json      | 24 ------------------------
>>  qapi/error.json       | 29 +++++++++++++++++++++++++++++
>>  qapi/qapi-schema.json |  1 +
>>  6 files changed, 34 insertions(+), 26 deletions(-)
>>  create mode 100644 qapi/error.json
>
>
>> +++ b/qapi/qapi-schema.json
>> @@ -80,6 +80,7 @@
>>  # stable order, it's best to include each sub-schema just once, or
>>  # include it first right here.
>>  
>> +{ 'include': 'error.json' }
>>  { 'include': 'common.json' }
>>  { 'include': 'sockets.json' }
>>  { 'include': 'run-state.json' }
>
> Any reason why error.json is needed before common.json? But I don't see
> it as being a problem, so

The QAPI language doesn't require definition before use.  We commonly do
it anyway, because we find it easier to read.

error.json uses nothing and defines only enum QapiErrorClass, which is
implicitly used by commands that can fail.  I like to put the enum
before the first command.  Putting it before any other module is
easiest.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

