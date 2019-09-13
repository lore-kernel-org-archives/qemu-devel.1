Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D110C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B7520717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B7520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mZL-0004nW-C0
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8mYh-00045p-EJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8mYg-00066V-CN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:28:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8mYg-00066C-7W
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:28:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60167307D925;
 Fri, 13 Sep 2019 14:28:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F1C66D09D;
 Fri, 13 Sep 2019 14:28:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4F6B113865F; Fri, 13 Sep 2019 16:28:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-7-armbru@redhat.com>
 <fedc30f3-4b34-4a1d-8791-a294b9cdc646@redhat.com>
Date: Fri, 13 Sep 2019 16:28:10 +0200
In-Reply-To: <fedc30f3-4b34-4a1d-8791-a294b9cdc646@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 10:22:32 -0500")
Message-ID: <878sqs9sp1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 14:28:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/16] qapi: Restrict strings to
 printable ASCII
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
>> RFC 8259 on string contents:
>> 
>>    All Unicode characters may be placed within the quotation marks,
>>    except for the characters that MUST be escaped: quotation mark,
>>    reverse solidus, and the control characters (U+0000 through
>>    U+001F).
>> 
>> The QAPI schema parser accepts both less and more than JSON: it
>> accepts only ASCII with \u (less), and accepts control characters
>> other than LF (new line) unescaped.  How it treats unescaped non-ASCII
>> input differs between Python 2 and Python 3.
>> 
>> Make it accept strictly less: require printable ASCII.  Drop support
>> for \b, \f, \n, \r, \t.
>
> Fair enough.  It doesn't prevent QMP clients from sending strings with
> non-ASCII characters, merely that those strings will never match the
> schema because we have guaranteed our schema is limited to ASCII.  (This

Note that this only affects QMP commands, events, parameter and enum
value names, *not* non-enum string arguments.

> change means we are promising to never allow { "execute": "a\tb" } as a
> valid QMP command, for instance.)

We're not actually promising anything.  We're merely making it slightly
harder to do: need to revert this patch first.  Feels quite unlikely,
though.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> @@ -523,17 +523,7 @@ class QAPISchemaParser(object):
>>                      if ch == '\n':
>>                          raise QAPIParseError(self, 'Missing terminating "\'"')
>>                      if esc:
>> -                        if ch == 'b':
>> -                            string += '\b'
>> -                        elif ch == 'f':
>> -                            string += '\f'
>> -                        elif ch == 'n':
>> -                            string += '\n'
>
> Is it worth a comment in the code that we are specifically not parsing
> all possible JSON escapes, because of the later requirement that QAPI
> strings be limited to the subset of printable ASCII?

Can't hurt.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

