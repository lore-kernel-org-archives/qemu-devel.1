Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A74C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81472089F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81472089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mtr-00017s-DH
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8mrJ-0007nD-GM
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8mrI-0007G0-DO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8mrI-0007Fk-8S
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:47:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8914C10275E2;
 Fri, 13 Sep 2019 14:47:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B795B681;
 Fri, 13 Sep 2019 14:47:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B2A8113865F; Fri, 13 Sep 2019 16:47:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-10-armbru@redhat.com>
 <24172d8b-7504-2641-d15b-277235430c6e@redhat.com>
Date: Fri, 13 Sep 2019 16:47:31 +0200
In-Reply-To: <24172d8b-7504-2641-d15b-277235430c6e@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 11:30:14 -0500")
Message-ID: <87y2ys8d8c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 13 Sep 2019 14:47:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/16] qapi: Permit alternates with just
 one branch
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
>> A union or alternate without branches makes no sense and doesn't work:
>> it can't be instantiated.  A union or alternate with just one branch
>> works, but is degenerate.  We accept the former, but reject the
>> latter.  Weird.  docs/devel/qapi-code-gen.txt doesn't mention the
>> difference.  It claims an alternate definition is "is similar to a
>> simple union type".
>> 
>> Permit degenerate alternates to make them consistent with unions.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py                  | 6 ++----
>>  tests/qapi-schema/alternate-empty.err   | 2 +-
>>  tests/qapi-schema/alternate-empty.json  | 4 ++--
>>  tests/qapi-schema/qapi-schema-test.json | 4 +++-
>>  tests/qapi-schema/qapi-schema-test.out  | 6 ++++--
>>  5 files changed, 12 insertions(+), 10 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> (Might make sense if one of the branches is conditional, where depending
> on compile-time options it could be a two-branch or a one-branch alternate)

The QAPI generator doesn't even try to reason about conditions.  It
happily lets you define a union or alternate with branches that are all
conditional, and where the conditions are all false for a particular
build configuration.  Ensuring the QAPI schema is sane for all build
configurations is the schema author's problem.

