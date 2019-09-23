Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3427C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE6207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE6207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMnh-0004Wa-KV
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCMm0-0003e9-P2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCMlz-0004KK-FU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCMlz-0004HU-9d
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:44:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90C213082145;
 Mon, 23 Sep 2019 11:44:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC7FF5D717;
 Mon, 23 Sep 2019 11:44:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74CEC113864E; Mon, 23 Sep 2019 13:44:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/16] docs/devel/qapi-code-gen: Rewrite
 compatibility considerations
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-14-armbru@redhat.com>
 <60b61f7c-fe08-e78b-dd52-775959af99d9@redhat.com>
 <87tv9g8cf4.fsf@dusky.pond.sub.org>
 <f71d6dd3-c9f5-7b89-a536-cf7e9baaff51@redhat.com>
Date: Mon, 23 Sep 2019 13:44:49 +0200
In-Reply-To: <f71d6dd3-c9f5-7b89-a536-cf7e9baaff51@redhat.com> (Eric Blake's
 message of "Tue, 17 Sep 2019 11:11:48 -0500")
Message-ID: <87impjp77y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 23 Sep 2019 11:44:53 +0000 (UTC)
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

> On 9/13/19 10:05 AM, Markus Armbruster wrote:
>
>>>> +Any change to a command definition's 'data' or one of the types used
>>>> +there (recursively) needs to consider send direction compatibility.
>>>> +
>>>> +Any change to a command definition's 'return', an event definition's
>>>> +'data', or one of the types used there (recursively) needs to consider
>>>> +receive direction compatibility.
>>>> +
>>>> +Any change to types used in both contexts need to consider both.
>>>> +
>>>> +Members of enumeration types, complex types and alternate types may be
>>>> +reordered freely.  For enumerations and alternate types, this doesn't
>>>> +affect the wire encoding.  For complex types, this might make the
>>>> +implementation emit JSON object members in a different order, which
>>>> +the Client JSON Protocol permits.
>>>
>>> Worth mentioning that type names themselves are NOT part of the
>>> interface, and may be freely renamed?
>> 
>> Care to suggest a suitable sentence?
>
> Although member names within a type cannot be changed without affecting
> compatibility,

This part seems redundant with the previous paragraph.

>                changes to type names themselves do not affect the
> protocol.  As such, complex types may be freely renamed or refactored,

All types (enums, structs, simple & flat unions, alternates) actually,
not just complex ones (structs, unions).

> such as splitting members from one type into a common base type, as long
> as the resulting set of members remain compatible.

What does it mean for a set of members to be compatible?  We don't
actually define that...

What about:

  Since type names are not visible in the Client JSON Protocol, types
  may be freely renamed.  Even certain refactorings are invisible, such
  as splitting members from one type into a common base type.

