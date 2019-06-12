Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE65AC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0E821019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0E821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6Be-0001i8-Vy
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6A3-0000qQ-N9
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6A2-0006Az-NM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:31:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hb6A0-00067X-Cr; Wed, 12 Jun 2019 12:31:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9947330C252E;
 Wed, 12 Jun 2019 16:31:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66297608A6;
 Wed, 12 Jun 2019 16:31:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0E87E1138648; Wed, 12 Jun 2019 18:31:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190606153803.5278-1-armbru@redhat.com>
 <20190606153803.5278-7-armbru@redhat.com>
 <2d2f4567-1b35-6586-e195-a89b398e676c@redhat.com>
Date: Wed, 12 Jun 2019 18:31:26 +0200
In-Reply-To: <2d2f4567-1b35-6586-e195-a89b398e676c@redhat.com> (Eric Blake's
 message of "Thu, 6 Jun 2019 10:54:16 -0500")
Message-ID: <877e9qwysh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 16:31:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/7] file-posix: Add dynamic-auto-read-only
 QAPI feature
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/6/19 10:38 AM, Markus Armbruster wrote:
>> From: Kevin Wolf <kwolf@redhat.com>
>> 
>> In commit 23dece19da4 ('file-posix: Make auto-read-only dynamic') ,
>> auto-read-only=on changed its behaviour in file-posix for the 4.0
>> release. This change cannot be detected through the usual mechanisms
>> like schema introspection. Add a new feature flag to the schema to
>> allow libvirt to detect the presence of the new behaviour.
>> 
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  qapi/block-core.json | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 1defcde048..f5e1ee91f9 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2859,6 +2859,15 @@
>>  #                         file is large, do not use in production.
>>  #                         (default: off) (since: 3.0)
>>  #
>> +# Features:
>> +# @dynamic-auto-read-only: If present, enabled auto-read-only means that the
>> +#                          driver will open the image read-only at first,
>> +#                          dynamically reopen the image file read-write when
>> +#                          the first writer is attached to the node and reopen
>> +#                          read-only when the last writer is detached. This
>> +#                          allows to give QEMU write permissions only on demand
>
> s/allows to give/allows giving/

Fixing, thanks!

>> +#                          when an operation actually needs write access.
>> +#
>>  # Since: 2.9
>>  ##
>>  { 'struct': 'BlockdevOptionsFile',
>> @@ -2868,7 +2877,9 @@
>>              '*aio': 'BlockdevAioOptions',
>>  	    '*drop-cache': {'type': 'bool',
>>  	                    'if': 'defined(CONFIG_LINUX)'},
>> -            '*x-check-cache-dropped': 'bool' } }
>> +            '*x-check-cache-dropped': 'bool' },
>> +  'features': [ { 'name': 'dynamic-auto-read-only',
>> +                  'if': 'defined(CONFIG_POSIX)' } ] }
>>  
>>  ##
>>  # @BlockdevOptionsNull:
>> 

