Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD25C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC502311A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 21:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bymQzv01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC502311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLCSA-0002rL-VS
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 17:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLCQ3-0001JH-GA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 17:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLCQ0-0006Ic-Ca
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 17:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600896894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5yh53FmwY3+/90qA8El8PrtrMpIuHPP9WnnCmuiv/c=;
 b=bymQzv01SnPqRa0uVyUCMgE1RXYY49PqVQS09CKUo7G5S2VFa7LWqmSYnn3HfYFRBvaUJQ
 U7Q170O9ATLjFzDCsbAVo8qZ/MRzltmeZdg6/StduO4BoVIRyrwI3ox8RBv5FlDnRLmQp3
 W0qZy3V+V4qwX6Bbv03zkZKVP0w2OgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133---v4ZRZoOFq7XEz1j0J7pQ-1; Wed, 23 Sep 2020 17:34:29 -0400
X-MC-Unique: --v4ZRZoOFq7XEz1j0J7pQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9413F1017DC1;
 Wed, 23 Sep 2020 21:34:27 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DB0119D7C;
 Wed, 23 Sep 2020 21:34:26 +0000 (UTC)
Subject: Re: [PATCH v2 30/38] qapi/introspect.py: Add a typed 'extra' structure
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-31-jsnow@redhat.com>
 <20200923161306.GR3312949@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <c82b8f2a-024c-fe4c-9391-1d184a3662df@redhat.com>
Date: Wed, 23 Sep 2020 17:34:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923161306.GR3312949@habkost.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 12:13 PM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:00:53PM -0400, John Snow wrote:
>> Typing arbitrarily shaped dicts with mypy is difficult prior to Python
>> 3.8; using explicit structures is nicer.
>>
>> Since we always define an Extra type now, the return type of _make_tree
>> simplifies and always returns the tuple.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/introspect.py | 31 +++++++++++++++++++------------
>>   1 file changed, 19 insertions(+), 12 deletions(-)
>>
> 
> Here I'm confused by both the original code and the new code.
> 
> I will try to review as a refactoring of existing code, but I'll
> have suggestions for follow ups:
> 
>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> index b036fcf9ce..41ca8afc67 100644
>> --- a/scripts/qapi/introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -10,6 +10,8 @@
>>   See the COPYING file in the top-level directory.
>>   """
>>   
>> +from typing import (NamedTuple, Optional, Sequence)
>> +
>>   from .common import (
>>       c_name,
>>       gen_endif,
>> @@ -21,16 +23,21 @@
>>                        QAPISchemaType)
>>   
>>   
>> -def _make_tree(obj, ifcond, features, extra=None):
>> -    if extra is None:
>> -        extra = {}
>> -    if ifcond:
>> -        extra['if'] = ifcond
>> +class Extra(NamedTuple):
>> +    """
>> +    Extra contains data that isn't intended for output by introspection.
>> +    """
>> +    comment: Optional[str] = None
>> +    ifcond: Sequence[str] = tuple()
>> +
>> +
>> +def _make_tree(obj, ifcond, features,
>> +               extra: Optional[Extra] = None):
>> +    comment = extra.comment if extra else None
>> +    extra = Extra(comment, ifcond)
> 
> Here we have one big difference: now `extra` is being recreated,
> and all fields except `extra.comment` are being ignored.  On the
> original version, all fields in `extra` were being kept.  This
> makes the existence of the `extra` argument pointless.
> 

Yup, oops.

> If you are going through the trouble of changing the type of the
> 4rd argument to _make_tree(), this seems more obvious:
> 

Yes, agree. I came up with something similar after talking to you this 
morning.

>    diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>    index 41ca8afc672..c62af94c9ad 100644
>    --- a/scripts/qapi/introspect.py
>    +++ b/scripts/qapi/introspect.py
>    @@ -32,8 +32,7 @@ class Extra(NamedTuple):
>     
>     
>     def _make_tree(obj, ifcond, features,
>    -               extra: Optional[Extra] = None):
>    -    comment = extra.comment if extra else None
>    +               comment: Optional[str] = None):
>         extra = Extra(comment, ifcond)
>         if features:
>             obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
>    @@ -170,16 +169,16 @@ const QLitObject %(c_name)s = %(c_string)s;
>             return self._name(typ.name)
>     
>         def _gen_tree(self, name, mtype, obj, ifcond, features):
>    -        extra = None
>    +        comment = None
>             if mtype not in ('command', 'event', 'builtin', 'array'):
>                 if not self._unmask:
>                     # Output a comment to make it easy to map masked names
>                     # back to the source when reading the generated output.
>    -                extra = Extra(comment=f'"{self._name(name)}" = {name}')
>    +                comment = f'"{self._name(name)}" = {name}'
>                 name = self._name(name)
>             obj['name'] = name
>             obj['meta-type'] = mtype
>    -        self._trees.append(_make_tree(obj, ifcond, features, extra))
>    +        self._trees.append(_make_tree(obj, ifcond, features, comment))
>     
>         def _gen_member(self, member):
>             obj = {'name': member.name, 'type': self._use_type(member.type)}
> 
> I understand you're trying to just make minimal refactoring, and I
> don't think this should block your cleanup series.  So:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>

I appreciate the benefit-of-the-doubt, but I think this change is worth 
making while we're here.

> 
>>       if features:
>> -        obj['features'] = [(f.name, {'if': f.ifcond}) for f in features]
>> -    if extra:
>> -        return (obj, extra)
>> -    return obj
>> +        obj['features'] = [(f.name, Extra(None, f.ifcond)) for f in features]
>> +    return (obj, extra)
>>   
>>   
>>   def _tree_to_qlit(obj, level=0, suppress_first_indent=False):
>> @@ -40,8 +47,8 @@ def indent(level):
>>   
>>       if isinstance(obj, tuple):
>>           ifobj, extra = obj
>> -        ifcond = extra.get('if')
>> -        comment = extra.get('comment')
>> +        ifcond = extra.ifcond
>> +        comment = extra.comment
>>           ret = ''
>>           if comment:
>>               ret += indent(level) + '/* %s */\n' % comment
>> @@ -168,7 +175,7 @@ def _gen_tree(self, name, mtype, obj, ifcond, features):
>>               if not self._unmask:
>>                   # Output a comment to make it easy to map masked names
>>                   # back to the source when reading the generated output.
>> -                extra = {'comment': '"%s" = %s' % (self._name(name), name)}
>> +                extra = Extra(comment=f'"{self._name(name)}" = {name}')
>>               name = self._name(name)
>>           obj['name'] = name
>>           obj['meta-type'] = mtype
>> -- 
>> 2.26.2
>>
> 


