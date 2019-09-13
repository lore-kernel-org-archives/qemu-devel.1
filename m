Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE8C4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7111A20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7111A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mjn-0001ie-CL
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8mib-0000nD-NE
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8mia-0003F3-MC
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:38:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8mia-0003Ee-H1
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:38:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6BC1305C3A4;
 Fri, 13 Sep 2019 14:38:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 176335D9E1;
 Fri, 13 Sep 2019 14:38:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0097113865F; Fri, 13 Sep 2019 16:38:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-8-armbru@redhat.com>
 <88fcdceb-85f8-ff7b-97b0-588ed45ba021@redhat.com>
Date: Fri, 13 Sep 2019 16:38:23 +0200
In-Reply-To: <88fcdceb-85f8-ff7b-97b0-588ed45ba021@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 10:28:30 -0500")
Message-ID: <8736h09s80.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 13 Sep 2019 14:38:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/16] qapi: Drop support for escape
 sequences other than \\
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
>> Since the previous commit restricted strings to printable ASCII,
>> \uXXXX's only use is obfuscation.  Drop it.
>> 
>> This leaves \\, \/, \', and \".  Since QAPI schema strings are all
>> names, and names are restricted to ASCII letters, digits, hyphen, and
>> underscore, none of them is useful.
>> 
>> The latter three have no test coverage.  Drop them.
>> 
>> Keep \\ to avoid (more) gratuitous incompatibility with JSON.
>
> We have to parse it (to get a sane error message for someone writing
> "a\b" and thinking they were getting a backspace), but we can still
> reject "a\\b" as being a non-QAPI-name.  An alternative might be to
> reject QAPI strings the moment \ is encountered (as the only possible
> use is to introduce a character that is not valid as a name), to the
> point that we could check for name validity at the time we parse strings
> rather than later on.  Up to you.

That works, too.  I chose to parse \\ to keep the language a
sub-language of JSON's (and Python's) at the lexical level: we reject
some valid JSON (and Python) such as 'a\b'.  Not treating \ special at
all would accept it, but with a different meaning.  Will be rejected at
a higher level, so it doesn't really matter.  But the reasoning involves
more than just the lexical level then.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>
>> --- a/tests/qapi-schema/escape-outside-string.err
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -tests/qapi-schema/escape-outside-string.json:3:27: Stray "\"
>
> Do we still want to test that \ is an invalid character outside of
> strings (whether or not \ is also made invalid inside strings)?

funny-char.json checks ';'.  '\' is no different.

>> +++ b/tests/qapi-schema/unknown-escape.json
>> @@ -1,3 +1,3 @@
>> -# we only recognize JSON escape sequences, plus our \' extension (no \x)
>> +# we only recognize \\
>>  # { 'command': 'foo', 'data': {} }
>>  { 'command': 'foo', 'dat\x61':{} }
>> 
>
> At any rate, this change seems reasonable.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

