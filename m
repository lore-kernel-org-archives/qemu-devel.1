Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64AC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61E021D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61E021D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD10E-0006yc-Uv
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iD0yy-00065V-Mf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iD0yw-0000yu-3c
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:40:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iD0yv-0000yP-UX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D36410CBC4B;
 Wed, 25 Sep 2019 06:40:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB71E60C5D;
 Wed, 25 Sep 2019 06:40:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 33549113864E; Wed, 25 Sep 2019 08:40:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 03/25] qapi: New QAPISourceInfo, replacing dict
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-4-armbru@redhat.com>
 <d23eb583-4cc2-7d1b-80cc-b79bdc7282c5@redhat.com>
Date: Wed, 25 Sep 2019 08:40:52 +0200
In-Reply-To: <d23eb583-4cc2-7d1b-80cc-b79bdc7282c5@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 14:12:27 -0500")
Message-ID: <87pnjoev4b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 25 Sep 2019 06:40:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
>> We track source locations with a dict of the form
>> 
>>     {'file': FNAME, 'line': LINENO, parent': PARENT}
>> 
>> where PARENT is None for the main file, and the include directive's
>> source location for included files.
>> 
>> This is servicable enough, but the next commit will add information,
>> and that's going to come out cleaner if we turn this into a class.  So
>> do that.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>  class QAPIError(Exception):
>> -    def __init__(self, fname, line, col, incl_info, msg):
>> +    def __init__(self, info, col, msg):
>>          Exception.__init__(self)
>
> Unrelated to this patch, but I just noticed
> https://docs.quantifiedcode.com/python-anti-patterns/ today (in part
> based on my question on another patch about using 'list.get(key, False)'
> rather than 'key in list and list[key]').  In particular, I found
> https://docs.quantifiedcode.com/python-anti-patterns/correctness/missing_argument_to_super.html
> which recommends using:
>
> def __init__(...):
>     super(QAPIError, self).__init__()
>
> (because of Python 2), while other sits state that with python 3, you
> can further get away with:
>
> def __init__(...):
>     super().__init(...)
>
> Should we be switching our code base to use super() in more places,
> rather than hard-coding the parent class name?

I intend to switch to super() in a future 'bye Python 2' series.

