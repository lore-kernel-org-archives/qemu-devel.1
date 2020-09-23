Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB05C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4880F21BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjvnxdDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4880F21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8UC-00009e-6v
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8Sm-0007gK-7l
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8Sf-0000bj-Re
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600881704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhWXcVZ+lSSbOsqp57TDGyRW1CWe9T0G07jBsydlkKE=;
 b=EjvnxdDOX+VBM94yqTyoExBfOR8m+kxiUgS/eAttDO3GSFyGLUFZ/mqt78qKxsnF37D+DW
 XYnVLRHqVW3aHeF+8GVbTjPSAKL9f74Mh6bEVeV3B8Eilvq2fLwiorMy46EOk2suKSCger
 Jhz66VgSce3W8UuXIFJMpD+USABTg9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-50nCmOPKNpGzc-DrXiznCg-1; Wed, 23 Sep 2020 13:21:40 -0400
X-MC-Unique: 50nCmOPKNpGzc-DrXiznCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E202FD07;
 Wed, 23 Sep 2020 17:21:39 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D670B5D731;
 Wed, 23 Sep 2020 17:21:37 +0000 (UTC)
Subject: Re: [PATCH v2 05/38] qapi: Remove wildcard includes
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-6-jsnow@redhat.com>
 <20200923132735.GE191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <fcf633f4-c0f9-984b-ba84-acc14851ee72@redhat.com>
Date: Wed, 23 Sep 2020 13:21:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923132735.GE191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 9:27 AM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:28PM -0400, John Snow wrote:
>> Wildcard includes become hard to manage when refactoring and dealing
>> with circular dependencies with strictly typed mypy.
>>
>> flake8 also flags each one as a warning, as it is not smart enough to
>> know which names exist in the imported file.
>>
>> Remove them and include things explicitly by name instead.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/commands.py   |  6 +++++-
>>   scripts/qapi/events.py     |  7 ++++++-
>>   scripts/qapi/gen.py        | 12 +++++++++---
>>   scripts/qapi/introspect.py |  7 ++++++-
>>   scripts/qapi/types.py      |  8 +++++++-
>>   scripts/qapi/visit.py      | 10 +++++++++-
>>   6 files changed, 42 insertions(+), 8 deletions(-)
>>
>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>> index ce5926146a..e1df0e341f 100644
>> --- a/scripts/qapi/commands.py
>> +++ b/scripts/qapi/commands.py
>> @@ -13,7 +13,11 @@
>>   See the COPYING file in the top-level directory.
>>   """
>>   
>> -from .common import *
>> +from .common import (
>> +    build_params,
>> +    c_name,
>> +    mcgen,
>> +)
>>   from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
>>   
>>   
> 
> Is this import style being suggested or enforced by any tool?  I've
> been using isort with very good results (both as a check tool, and as
> an emacs extension).  For instance, the block about would look like:
> 
>     from .common import build_params, c_name, mcgen
>     from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
> 

Not enforced by any tool, no. Just subjective preference for 
git-friendly import lines. They conflict on rebase a lot less.

I have been using emacs sort-lines to order the names in a group.

>> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
>> index 0467272438..6b3afa14d7 100644
>> --- a/scripts/qapi/events.py
>> +++ b/scripts/qapi/events.py
>> @@ -12,7 +12,12 @@
>>   See the COPYING file in the top-level directory.
>>   """
>>   
>> -from .common import *
>> +from .common import (
>> +    build_params,
>> +    c_enum_const,
>> +    c_name,
>> +    mcgen,
>> +)
>>   from .gen import QAPISchemaModularCVisitor, ifcontext
>>   from .schema import QAPISchemaEnumMember
>>   from .types import gen_enum, gen_enum_lookup
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index 8df19a0df0..11472ba043 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -11,13 +11,19 @@
>>   # This work is licensed under the terms of the GNU GPL, version 2.
>>   # See the COPYING file in the top-level directory.
>>   
>> -
>> +from contextlib import contextmanager
>>   import errno
>>   import os
>>   import re
>> -from contextlib import contextmanager
>>   
>> -from .common import *
>> +from .common import (
>> +    c_fname,
>> +    gen_endif,
>> +    gen_if,
>> +    guardend,
>> +    guardstart,
>> +    mcgen,
>> +)
>>   from .schema import QAPISchemaVisitor
>>   
>>   
>> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> index 2a34cd1e8e..b036fcf9ce 100644
>> --- a/scripts/qapi/introspect.py
>> +++ b/scripts/qapi/introspect.py
>> @@ -10,7 +10,12 @@
>>   See the COPYING file in the top-level directory.
>>   """
>>   
>> -from .common import *
>> +from .common import (
>> +    c_name,
>> +    gen_endif,
>> +    gen_if,
>> +    mcgen,
>> +)
>>   from .gen import QAPISchemaMonolithicCVisitor
>>   from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
>>                        QAPISchemaType)
>> diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
>> index ca9a5aacb3..53b47f9e58 100644
>> --- a/scripts/qapi/types.py
>> +++ b/scripts/qapi/types.py
>> @@ -13,7 +13,13 @@
>>   # See the COPYING file in the top-level directory.
>>   """
>>   
>> -from .common import *
>> +from .common import (
>> +    c_enum_const,
>> +    c_name,
>> +    gen_endif,
>> +    gen_if,
>> +    mcgen,
>> +)
>>   from .gen import QAPISchemaModularCVisitor, ifcontext
>>   from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
>>   
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 7850f6e848..ea277e7704 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -13,7 +13,15 @@
>>   See the COPYING file in the top-level directory.
>>   """
>>   
>> -from .common import *
>> +from .common import (
>> +    c_enum_const,
>> +    c_name,
>> +    gen_endif,
>> +    gen_if,
>> +    mcgen,
>> +    pop_indent,
>> +    push_indent,
>> +)
> 
> And here, isort will add the paranthesis (it does so based on space demands):
> 
>     from .common import (c_enum_const, c_name, gen_endif, gen_if, mcgen,
>                          pop_indent, push_indent)
>     from .gen import QAPISchemaModularCVisitor, ifcontext
>     from .schema import QAPISchemaObjectType
> 
> Other than those suggestions, it LGTM.
> 

OK. We can add a check that asserts that isort(file) == file to keep our 
include regimes consistent. I'll look into the tool, but it will be 
after this marathon of a series.

Here's a gitlab issue I made on my QEMU fork to help me keep track of 
Python-related issues that I intend to use: 
https://gitlab.com/jsnow/qemu/-/issues/6

> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 

Thanks!

--js


