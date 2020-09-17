Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B8EC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46777206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYaqyLdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46777206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIy2N-0004fF-1f
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIy1C-0003xn-4E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIy1A-0003lp-8Z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600364903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=da9kbuO+Nea+BM7UE8L3P2MBYx7HUysaT9httWFl7vI=;
 b=PYaqyLdSCGXpFcoXdIrJOJA0wQXDhj5JvgZPc0ZoXf0Xczry6BdZNEZ5EUNYsU6n4qX/4k
 OjpTLLsKSn5LvWa+vPe5FCFkapi2WyMLFgqlf+UP/fxqbvPXBsPizg6D/dZoc2Wi4i6AKM
 nKdbd89QN6aGGaBY8MzSmud5pC5Fxqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-d658LRs8OyekUQvcB-UbBQ-1; Thu, 17 Sep 2020 13:48:21 -0400
X-MC-Unique: d658LRs8OyekUQvcB-UbBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38ED5839A49;
 Thu, 17 Sep 2020 17:48:20 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F7C560BEC;
 Thu, 17 Sep 2020 17:48:19 +0000 (UTC)
Subject: Re: [PATCH 10/37] qapi/common.py: delint with pylint
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-11-jsnow@redhat.com>
 <87r1r0pjza.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <eba468c3-91c3-10cb-9ef6-662468e676f7@redhat.com>
Date: Thu, 17 Sep 2020 13:48:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1r0pjza.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:15 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/common.py | 16 +++++++---------
>>   scripts/qapi/schema.py | 14 +++++++-------
>>   2 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 87d87b95e5..c665e67495 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -14,6 +14,11 @@
>>   import re
>>   
>>   
>> +EATSPACE = '\033EATSPACE.'
>> +POINTER_SUFFIX = ' *' + EATSPACE
>> +c_name_trans = str.maketrans('.-', '__')
>> +
>> +
> 
> You rename and move.  pylint gripes about the names, but it doesn't
> actually ask for the move, as far as I can tell.  Can you explain why
> you move?
> 

Preference. I like constants and globals at the top so you can audit any 
code that runs at import time in one place. Since they are externally 
visible objects, having them near other "header" style information makes 
sense to me.

>>   # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
>>   # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
>>   # ENUM24_Name -> ENUM24_NAME
>> @@ -42,9 +47,6 @@ def c_enum_const(type_name, const_name, prefix=None):
>>       return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>>   
>>   
>> -c_name_trans = str.maketrans('.-', '__')

(This one winds up being a constant, so I renamed it in my v2.)

>> -
>> -
>>   # Map @name to a valid C identifier.
>>   # If @protect, avoid returning certain ticklish identifiers (like
>>   # C keywords) by prepending 'q_'.
>> @@ -89,10 +91,6 @@ def c_name(name, protect=True):
>>       return name
>>   
>>   
>> -eatspace = '\033EATSPACE.'
>> -pointer_suffix = ' *' + eatspace
>> -
>> -
>>   class Indent:
>>       """
>>       Indent-level management.
>> @@ -135,12 +133,12 @@ def pop(self, amount: int = 4) -> int:
>>   
>>   
>>   # Generate @code with @kwds interpolated.
>> -# Obey indent_level, and strip eatspace.
>> +# Obey INDENT level, and strip EATSPACE.
> 
> Is the change to INDENT intentional?
> 

Kind of, but it's either late (should have been with the indent manager 
patch) or early (Should be with the patch that moves comments into 
docstrings.)

When this comment becomes a docstring, I use `INDENT` to indicate it as 
a proper object. This in and of itself is prescient, as we are not using 
sphinx/apidoc to generate any documentation about the QAPI package yet.

(The pending v2 uses `indent` after you pointed out that it was not a 
constant.)

>>   def cgen(code, **kwds):
>>       raw = code % kwds
>>       if INDENT:
>>           raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
>> -    return re.sub(re.escape(eatspace) + r' *', '', raw)
>> +    return re.sub(re.escape(EATSPACE) + r' *', '', raw)
>>   
>>   
>>   def mcgen(code, **kwds):
> [...]
> 


