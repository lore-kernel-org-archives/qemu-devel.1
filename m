Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E77C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF9D222BE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF9D222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhHP-0003xZ-Ab
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFhGL-00033k-Ez
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFhGI-000820-OG
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iFhGI-00081c-G9
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFE493086218;
 Wed,  2 Oct 2019 16:13:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38FC1608C0;
 Wed,  2 Oct 2019 16:13:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B73BD113864A; Wed,  2 Oct 2019 18:13:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 6/7] qapi: Split up scripts/qapi/common.py
References: <20191001191514.11208-1-armbru@redhat.com>
 <20191001191514.11208-7-armbru@redhat.com>
 <f195452f-43f8-a1be-653b-e4d8d2d888e3@redhat.com>
 <87lfu3rxdv.fsf@dusky.pond.sub.org>
 <70ff7c98-1775-ad6a-e505-8f0a97210379@redhat.com>
Date: Wed, 02 Oct 2019 18:13:52 +0200
In-Reply-To: <70ff7c98-1775-ad6a-e505-8f0a97210379@redhat.com> (Eric Blake's
 message of "Wed, 2 Oct 2019 10:27:38 -0500")
Message-ID: <87v9t7qg5b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 02 Oct 2019 16:13:57 +0000 (UTC)
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

> On 10/2/19 10:16 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 10/1/19 2:15 PM, Markus Armbruster wrote:
>>>> The QAPI code generator clocks in at some 3100 SLOC in 8 source files.
>>>> Almost 60% of the code is in qapi/common.py.  Split it into more
>>>> focused modules:
>>>>
>>>> * Move QAPISchemaPragma and QAPISourceInfo to qapi/source.py.
>>>>
>>>> * Move QAPIError and its sub-classes to qapi/error.py.
>>>>
>>>> * Move QAPISchemaParser and QAPIDoc to parser.py.  Use the opportunity
>>>>     to put QAPISchemaParser first.
>>>>
>>>> * Move check_expr() & friends to qapi/expr.py.  Use the opportunity to
>>>>     put the code into a more sensible order.
>>>
>>> Code motion can be easier to review when it is 1:1 (using 'diff -u
>>> <(sed -n '/^-//p' patch) <(sed -n '/^\+//p'patch)', which is quite
>>> small if code moved wholesale).  Reordering things breaks that
>>> property.
>>
>> True.  But see below.
>
>> Perhaps a bit of shell wizardry can increase your confidence.
>>
>> Before this patch:
>>
>> 1. Split into classes and functions (crudely!):
>>
>>      $ csplit scripts/qapi/common.py '/^\(class\|def\) /' '{*}'
>>
>> 2. Rename the parts:
>>
>>      $ for i in xx*; do n=`sed -n '1s/^[a-z]* \([A-Za-z0-9_]*\).*/\1/p' $i`; [ "$n" ] && mv $i xx-$n; done
>>
>> 3. Stash them:
>>
>>      $ mkdir o
>>      $ $ mv xx* o
>>
>> After this patch:
>>
>> 1. Split:
>>
>>      $ csplit <(cat scripts/qapi/{common,source,error,parser,expr,schema,gen}.py) '/^\(class\|def\) /' '{*}'
>>
>> 2. Rename:
>>
>>      $ for i in xx*; do n=`sed -n '1s/^[a-z]* \([A-Za-z0-9_]*\).*/\1/p' $i`; [ "$n" ] && mv $i xx-$n; done
>>
>> 3. Stash & diff:
>>
>>      $ mkdir n
>>      $ mv xx* n
>>      $ diff -rup o n
>
> Slick.
>
>>
>> Output of diff appended for your reading pleasure.
>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Thanks!
>>
>>
>> diff -rup o/xx-QAPIDoc n/xx-QAPIDoc
>> --- o/xx-QAPIDoc	2019-10-02 17:02:35.984552694 +0200
>> +++ n/xx-QAPIDoc	2019-10-02 17:06:17.930607336 +0200
>> @@ -273,5 +273,31 @@ class QAPIDoc(object):
>>                   self.info,
>>                   "the following documented members are not in "
>>                   "the declaration: %s" % ", ".join(bogus))
>> +#
>> +# Check (context-free) QAPI schema expression structure
>> +#
>
> New boilerplate is obviousl
>
>> +
>> +# Names must be letters, numbers, -, and _.  They must start with letter,
>> +# except for downstream extensions which must start with __RFQDN_.
>> +# Dots are only valid in the downstream extension prefix.
>> +valid_name = re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
>> +                        '[a-zA-Z][a-zA-Z0-9_-]*$')
>>   
>
> The crude split shows that this blurb changed in relation to which
> class/def it was closest to (but you did say it was a crude split),
> which isn't fatal.
>
>>   diff -rup o/xx-QAPIGen n/xx-QAPIGen
>> --- o/xx-QAPIGen	2019-10-02 17:02:35.987552655 +0200
>> +++ n/xx-QAPIGen	2019-10-02 17:06:17.932607309 +0200
>> @@ -43,4 +43,3 @@ class QAPIGen(object):
>>           f.close()
>>     -@contextmanager
>> diff -rup o/xx-QAPIGenH n/xx-QAPIGenH
>> --- o/xx-QAPIGenH	2019-10-02 17:02:35.987552655 +0200
>> +++ n/xx-QAPIGenH	2019-10-02 17:06:17.933607296 +0200
>> @@ -7,3 +7,4 @@ class QAPIGenH(QAPIGenC):
>>           return guardend(self.fname)
>>     +@contextmanager
>
> Another victim of the crude split (this line logically begins with the
> next line in the original file(s), not the previous class/def).
>
>> diff -rup o/xx-QAPISchema n/xx-QAPISchema
>> --- o/xx-QAPISchema	2019-10-02 17:02:35.986552668 +0200
>> +++ n/xx-QAPISchema	2019-10-02 17:06:17.932607309 +0200
>> @@ -297,9 +297,26 @@ class QAPISchema(object):
>>                       visitor.visit_module(module)
>>                   entity.visit(visitor)
>>           visitor.visit_end()
>> -
>> -
>>   #
>> -# Code generation helpers
>> +# QAPI code generation
>> +#
>
> More whitespace and boilerplate.
>
>
>> +++ n/xx-QAPISchemaParser	2019-10-02 17:06:17.930607336 +0200
>> @@ -268,14 +268,3 @@ class QAPISchemaParser(object):
>>           raise QAPIParseError(self, "documentation comment must end with '##'")
>>     -#
>> -# Check (context-free) schema expression structure
>> -#
>> -
>> -# Names must be letters, numbers, -, and _.  They must start with letter,
>> -# except for downstream extensions which must start with __RFQDN_.
>> -# Dots are only valid in the downstream extension prefix.
>> -valid_name = re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
>> -                        '[a-zA-Z][a-zA-Z0-9_-]*$')
>> -
>> -
>
> We already visited this above.
>
>
>>   Only in o: xx-camel_case
>
> Interesting change, but not detrimental.

I forgot to mention I moved camel_case() to the bit bucket, because it's
unused.  I'll fix that.

> Overall, the interdiff is fairly representative of clean code motion
> in spite of any reordering.  Thanks for doing that!
>
> R-b still stands.

Thanks!

