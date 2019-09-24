Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1252020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1252020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrSN-0006cA-Dj
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCrII-0004Aa-8B
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCrIG-0007tq-P9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:20:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCrIG-0007te-HF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:20:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D2500300D243;
 Tue, 24 Sep 2019 20:20:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CB836046B;
 Tue, 24 Sep 2019 20:20:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4016E113864E; Tue, 24 Sep 2019 22:20:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 05/25] qapi: Clean up member name case checking
References: <20190924132830.15835-1-armbru@redhat.com>
 <20190924132830.15835-6-armbru@redhat.com>
 <67f5d0d5-b78e-b126-6fe5-4078ceed6f23@redhat.com>
Date: Tue, 24 Sep 2019 22:20:09 +0200
In-Reply-To: <67f5d0d5-b78e-b126-6fe5-4078ceed6f23@redhat.com> (Eric Blake's
 message of "Tue, 24 Sep 2019 10:07:17 -0500")
Message-ID: <87blv9a1l2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 24 Sep 2019 20:20:15 +0000 (UTC)
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/24/19 8:28 AM, Markus Armbruster wrote:
>> QAPISchemaMember.check_clash() checks for member names that map to the
>> same c_name().  Takes care of rejecting duplicate names.
>> 
>> It also checks a naming rule: no uppercase in member names.  That's a
>> rather odd place to do it.  Enforcing naming rules is
>> check_name_str()'s job.
>> 
>> qapi-code-gen.txt specifies the name case rule applies to the name as
>> it appears in the schema.  check_clash() checks c_name(name) instead.
>> No difference, as c_name() leaves alone case, but unclean.
>> 
>> Move the name case check into check_name_str(), less the c_name().
>> New argument @permit_upper suppresses it.  Pass permit_upper=True for
>> definitions (which are not members), and when the member's owner is
>> whitelisted with pragma name-case-whitelist.
>> 
>> Bonus: name-case-whitelist now applies to a union's inline base, too.
>> Update qapi/qapi-schema.json pragma to whitelist union CpuInfo instead
>> of CpuInfo's implicit base type's name q_obj_CpuInfo-base.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/qapi/qapi-schema.json
>> @@ -71,7 +71,7 @@
>>          'QapiErrorClass',           # all members, visible through errors
>>          'UuidInfo',                 # UUID, visible through query-uuid
>>          'X86CPURegister32',         # all members, visible indirectly through qom-get
>> -        'q_obj_CpuInfo-base'        # CPU, visible through query-cpu
>> +        'CpuInfo'                   # CPU, visible through query-cpu
>
> Yes, much nicer.
>
>>      ] } }
>>  
>>  # Documentation generated with qapi-gen.py is in source order, with
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index f0e7d5ad34..ed4bff4479 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -704,8 +704,8 @@ valid_name = re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
>>                          '[a-zA-Z][a-zA-Z0-9_-]*$')
>>  
>>  
>> -def check_name(info, source, name, allow_optional=False,
>> -               enum_member=False):
>> +def check_name(info, source, name,
>> +               allow_optional=False, enum_member=False, permit_upper=False):
>>      global valid_name
>>      membername = name
>>  
>> @@ -725,11 +725,14 @@ def check_name(info, source, name, allow_optional=False,
>>      if not valid_name.match(membername) or \
>>         c_name(membername, False).startswith('q_'):
>>          raise QAPISemError(info, "%s uses invalid name '%s'" % (source, name))
>> +    if not permit_upper and name.lower() != name:
>> +        raise QAPISemError(
>> +            info, "%s uses uppercase in name '%s'" % (source, name))
>>  
>>  
>>  def add_name(name, info, meta):
>>      global all_names
>> -    check_name(info, "'%s'" % meta, name)
>> +    check_name(info, "'%s'" % meta, name, permit_upper=True)
>>      # FIXME should reject names that differ only in '_' vs. '.'
>>      # vs. '-', because they're liable to clash in generated C.
>>      if name in all_names:
>> @@ -797,10 +800,12 @@ def check_type(info, source, value,
>>          raise QAPISemError(info,
>>                             "%s should be an object or type name" % source)
>>  
>> +    permit_upper = allow_dict in name_case_whitelist
>> +
>
> so allow_dict changes from a bool to a string to be looked up...
>
>>      # value is a dictionary, check that each member is okay
>>      for (key, arg) in value.items():
>>          check_name(info, "Member of %s" % source, key,
>> -                   allow_optional=True)
>> +                   allow_optional=True, permit_upper=permit_upper)
>>          if c_name(key, False) == 'u' or c_name(key, False).startswith('has_'):
>>              raise QAPISemError(info, "Member of %s uses reserved name '%s'"
>>                                 % (source, key))
>> @@ -870,7 +875,7 @@ def check_union(expr, info):
>>      else:
>>          # The object must have a string or dictionary 'base'.
>>          check_type(info, "'base' for union '%s'" % name,
>> -                   base, allow_dict=True,
>> +                   base, allow_dict=name,
>
> ...and this is an example client affected by the change.  That threw me
> for a bit, but seems to work.

I'm not proud of this interface, but I couldn't think of anything
better.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

