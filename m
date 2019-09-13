Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E056C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1215F20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1215F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8n92-0003Bm-7s
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8n8I-0002gt-R7
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8n8G-0007oU-LJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8n8G-0007oG-EM
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:05:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B34E910F2E81;
 Fri, 13 Sep 2019 15:05:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D7F5D717;
 Fri, 13 Sep 2019 15:05:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8719E113865F; Fri, 13 Sep 2019 17:05:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-14-armbru@redhat.com>
 <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com>
Date: Fri, 13 Sep 2019 17:05:03 +0200
In-Reply-To: <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 11:42:33 -0500")
Message-ID: <87tv9g8cf4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 13 Sep 2019 15:05:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite
 compatibility considerations
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
>> We have some compatibility advice buried in sections "Enumeration
>> types" and "Struct types".  Compatibility is actually about commands
>> and events.  It devolves to the types used there.  All kinds of types,
>> not just enumerations and structs.
>> 
>> Replace the existing advice by a new section "Compatibility
>> considerations".
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/qapi-code-gen.txt | 95 +++++++++++++++++++++++-------------
>>  1 file changed, 60 insertions(+), 35 deletions(-)
>> 
>
>> +== Compatibility considerations ==
>> +
>> +Maintaining backward compatibility at the Client JSON Protocol level
>> +while evolving the schema requires some care.  This section is about
>> +syntactic compatibility.  Necessary, but not sufficient for actual
>> +compatibility.
>
> This last sentence no verb.  Maybe:
>
> s/compatibility.  Necessary/compatibility, which is necessary/
> s/sufficient/sufficient,/

Sold.

>> +
>> +Clients send commands with argument data, and receive command
>> +responses with return data and events with event data.
>> +
>> +Adding opt-in functionality to the send direction is backwards
>> +compatible: adding commands, optional arguments, enumeration values,
>> +union and alternate branches; turning an argument type into an
>> +alternate of that type; making mandatory arguments optional.  Clients
>> +oblivious of the new functionality continue to work.
>> +
>> +Incompatible changes include removing commands, command arguments,
>> +enumeration values, union and alternate branches, adding mandatory
>> +command arguments, and making optional arguments mandatory.
>> +
>> +The specified behavior of an absent optional argument should remain
>> +the same.  With proper documentation, this policy still allows some
>> +flexibility; for example, when an optional 'buffer-size' argument is
>> +specified to default to a sensible buffer size, the actual default
>> +value can still be changed.  The specified default behavior is not the
>> +exact size of the buffer, only that the default size is sensible.
>> +
>> +Adding functionality to the receive direction is generally backwards
>> +compatible: adding events, adding return and event data members.
>> +Clients are expected to ignore the ones they don't know.
>> +
>> +Removing "unreachable" stuff like events that can't be triggered
>> +anymore, optional return or event data members that can't be sent
>> +anymore, and return or event data member (enumeration) values that
>> +can't be sent anymore makes no difference to clients, except for
>> +introspection.  The latter can conceivably confuse clients, so tread
>> +carefully.
>> +
>> +Incompatible changes include removing return and event data members.
>> +
>> +Any change to a command definition's 'data' or one of the types used
>> +there (recursively) needs to consider send direction compatibility.
>> +
>> +Any change to a command definition's 'return', an event definition's
>> +'data', or one of the types used there (recursively) needs to consider
>> +receive direction compatibility.
>> +
>> +Any change to types used in both contexts need to consider both.
>> +
>> +Members of enumeration types, complex types and alternate types may be
>> +reordered freely.  For enumerations and alternate types, this doesn't
>> +affect the wire encoding.  For complex types, this might make the
>> +implementation emit JSON object members in a different order, which
>> +the Client JSON Protocol permits.
>
> Worth mentioning that type names themselves are NOT part of the
> interface, and may be freely renamed?

Care to suggest a suitable sentence?

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

