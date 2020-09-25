Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF5CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7C1235F9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvR7Fdt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7C1235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpfq-0001FY-Pb
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLpcj-0007V5-9e
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLpce-000608-Mb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:26:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601047614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z0aAjiEtVKflvNPNUmcX9DtyJuRpNn//Z3u1D3l1s7c=;
 b=SvR7Fdt4VsjmeA6ayY/p13enE2KIJjsLLpV4XEFjp592z2bWgLiHuVwh4P11gdCqpS3hti
 634Qe9s/10XUchRsbZL8x87jvPNQp6287sI7sGAMnE0eYGLp9RKvaGk273zDuDHES5vs4G
 aPEsuAtJT7UJbzdWdG12UgGEruE6hEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-VpgI5QKPOgamfRnjzV-jDw-1; Fri, 25 Sep 2020 11:26:52 -0400
X-MC-Unique: VpgI5QKPOgamfRnjzV-jDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1197F807344
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:26:52 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6470F5D9F3;
 Fri, 25 Sep 2020 15:26:51 +0000 (UTC)
Subject: Re: [PATCH v3 12/47] qapi: enforce import order/styling with isort
To: Markus Armbruster <armbru@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-13-jsnow@redhat.com>
 <87imc2w6uf.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <8baab976-1dfd-a7b4-1a1e-47480cf0c4b6@redhat.com>
Date: Fri, 25 Sep 2020 11:26:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87imc2w6uf.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 5:20 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> While we're mucking around with imports, we might as well formalize the
>> style we use. Let's use isort to do it for us.
>>
>> force_sort_within_sections: Intermingles "from x" and "import x" style
>> statements, such that sorting is always performed strictly on the module
>> name itself.
>>
>> force_grid_wrap=4: Four or more imports from a single module will force
>> the one-per-line style that's more git-friendly. This will generally
>> happen for 'typing' imports.
>>
>> multi_line_output=3: Uses the one-per-line indented style for long
>> imports.
>>
>> include_trailing_comma: Adds a comma to the last import in a group,
>> which makes git conflicts nicer to deal with, generally.
>>
>> Suggested-by: Cleber Rosa <crosa@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/.isort.cfg    | 5 +++++
>>   scripts/qapi/commands.py   | 6 +-----
>>   scripts/qapi/doc.py        | 2 +-
>>   scripts/qapi/expr.py       | 4 ++--
>>   scripts/qapi/introspect.py | 3 +--
>>   scripts/qapi/main.py       | 1 -
>>   scripts/qapi/parser.py     | 2 +-
>>   scripts/qapi/schema.py     | 2 +-
>>   scripts/qapi/types.py      | 1 -
>>   9 files changed, 12 insertions(+), 14 deletions(-)
>>   create mode 100644 scripts/qapi/.isort.cfg
>>
>> diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
>> new file mode 100644
>> index 0000000000..b0aeffec26
>> --- /dev/null
>> +++ b/scripts/qapi/.isort.cfg
>> @@ -0,0 +1,5 @@
>> +[settings]
>> +force_sort_within_sections=True
>> +force_grid_wrap=4
>> +multi_line_output=3
>> +include_trailing_comma=True
>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index e1df0e341f..64ed5278f9 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -13,11 +13,7 @@
>>   See the COPYING file in the top-level directory.
>>   """
>>   
>> -from .common import (
>> -    build_params,
>> -    c_name,
>> -    mcgen,
>> -)
>> +from .common import build_params, c_name, mcgen
>>   from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
> 
> Squash this hunk into the previous commit, please.
> 

Yes, OK.

>>   
>>   
>> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
>> index b764a8ccc0..1acb773e0a 100644
>> --- a/scripts/qapi/doc.py
>> +++ b/scripts/qapi/doc.py
>> @@ -5,9 +5,9 @@
>>   """This script produces the documentation of a qapi schema in texinfo format"""
>>   
>>   import re
>> +
>>   from .gen import QAPIGenDoc, QAPISchemaVisitor
>>   
>> -
> 
> Do you delete the blank line to keep isort happy?
> 

isort offers to actually edit your files for you, it isn't just a 
checker, it actually rewrites.

By default, it leaves one space below imports. You can configure it to 
add two. I didn't really have a strong preference, so I left it at the 
default.

I'm going to leave it at the default for now, but I can change it if you 
have a preference.

> More of the same below.
> 
>>   _MSG = '''
>>   @deftypefn {type} {{}} {name}
>>   
>> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
>> index 03b31ecfc1..3e952a1462 100644
>> --- a/scripts/qapi/expr.py
>> +++ b/scripts/qapi/expr.py
>> @@ -14,12 +14,12 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2.
>>   # See the COPYING file in the top-level directory.
>>   
>> -import re
>>   from collections import OrderedDict
>> +import re
>> +
>>   from .common import c_name
>>   from .error import QAPISemError
>>   
>> -
>>   # Names must be letters, numbers, -, and _.  They must start with letter,
>>   # except for downstream extensions which must start with __RFQDN_.
>>   # Dots are only valid in the downstream extension prefix.
>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> index b036fcf9ce..2850121cbd 100644
>> --- a/scripts/qapi/introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -17,8 +17,7 @@
>>       mcgen,
>>   )
>>   from .gen import QAPISchemaMonolithicCVisitor
>> -from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
>> -                     QAPISchemaType)
>> +from .schema import QAPISchemaArrayType, QAPISchemaBuiltinType, QAPISchemaType
> 
> Line is rather long for my taste.
> 

78 chars and three names, so it didn't trigger the grid-wrap condition 
of isort.

If you have an arbitrarily smaller number you'd like to use, I can feed 
that to isort's config file. 72?

> So far, we didn't even try to have a consistent Python style in QEMU, so
> I've enforced a consistent style I like within QAPI.
> 

I am now trying!

> Having a consistent Python style in QEMU would be worth letting go of
> personal preferences.  Do you intend to pursue it?
> 

100%.

--js


