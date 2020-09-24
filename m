Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E026C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0342145D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 00:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRAiky/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0342145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLFA3-0007VC-GZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 20:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLF8a-00073i-Bb
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLF8Y-0008C7-4d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 20:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600907363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPk1x2ec/qRVMx2jDvhhJe08IdfIskMuD1+5fwh95Uk=;
 b=dRAiky/D9YTNOCN6UKdlq2tt3nydRp/1VJQ7YYcO3bvtfT2JnZePIFxSXY7Pg5QJzrBjfO
 qsDsiHXUFLwFFuFCiwCjY7b+p1ls0F1oeklPlROlbUc3krY/ERKO67/RsViWg6njIwWEuc
 Txs47RS3mxfuGQr81DfZlYGLC8cUOic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-1o4OJlevPbGQXXTEdmiRjQ-1; Wed, 23 Sep 2020 20:29:20 -0400
X-MC-Unique: 1o4OJlevPbGQXXTEdmiRjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A60D425CE;
 Thu, 24 Sep 2020 00:29:19 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CCDF73682;
 Thu, 24 Sep 2020 00:29:17 +0000 (UTC)
Subject: Re: [PATCH v2 25/38] qapi/gen.py: add type hint annotations
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-26-jsnow@redhat.com>
 <20200923235122.GZ191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <1fabb4f5-ba1f-ee43-956f-aeb1225144ad@redhat.com>
Date: Wed, 23 Sep 2020 20:29:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923235122.GZ191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

On 9/23/20 7:51 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:48PM -0400, John Snow wrote:
>> Annotations do not change runtime behavior.
>> This commit *only* adds annotations.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/gen.py | 102 +++++++++++++++++++++++---------------------
>>   1 file changed, 53 insertions(+), 49 deletions(-)
>>
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index cb2b2655c3..df8cf8271c 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -17,7 +17,7 @@
>>   import errno
>>   import os
>>   import re
>> -from typing import Optional
>> +from typing import Dict, Generator, List, Optional, Tuple
>>   
>>   from .common import (
>>       c_fname,
>> @@ -32,31 +32,31 @@
>>       QAPISchemaObjectType,
>>       QAPISchemaVisitor,
>>   )
>> +from .source import QAPISourceInfo
>>   
>>   
>>   class QAPIGen:
>> -
>> -    def __init__(self, fname):
>> +    def __init__(self, fname: Optional[str]):
>>           self.fname = fname
>>           self._preamble = ''
>>           self._body = ''
>>   
>> -    def preamble_add(self, text):
>> +    def preamble_add(self, text: str) -> None:
>>           self._preamble += text
>>   
>> -    def add(self, text):
>> +    def add(self, text: str) -> None:
>>           self._body += text
>>   
>> -    def get_content(self):
>> +    def get_content(self) -> str:
>>           return self._top() + self._preamble + self._body + self._bottom()
>>   
>> -    def _top(self):
>> +    def _top(self) -> str:
>>           return ''
>>   
>> -    def _bottom(self):
>> +    def _bottom(self) -> str:
>>           return ''
>>   
>> -    def write(self, output_dir):
>> +    def write(self, output_dir: str) -> None:
>>           # Include paths starting with ../ are used to reuse modules of the main
>>           # schema in specialised schemas. Don't overwrite the files that are
>>           # already generated for the main schema.
>> @@ -81,7 +81,7 @@ def write(self, output_dir):
>>           f.close()
>>   
>>   
>> -def _wrap_ifcond(ifcond, before, after):
>> +def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
>>       if before == after:
>>           return after   # suppress empty #if ... #endif
>>   
>> @@ -121,40 +121,38 @@ def build_params(arg_type: Optional[QAPISchemaObjectType],
>>   
>>   
>>   class QAPIGenCCode(QAPIGen):
>> -
>> -    def __init__(self, fname):
>> +    def __init__(self, fname: Optional[str]):
>>           super().__init__(fname)
>> -        self._start_if = None
>> +        self._start_if: Optional[Tuple[List[str], str, str]] = None
>>   
>> -    def start_if(self, ifcond):
>> +    def start_if(self, ifcond: List[str]) -> None:
>>           assert self._start_if is None
>>           self._start_if = (ifcond, self._body, self._preamble)
>>   
>> -    def end_if(self):
>> +    def end_if(self) -> None:
>>           assert self._start_if
>>           self._wrap_ifcond()
>>           self._start_if = None
>>   
>> -    def _wrap_ifcond(self):
>> +    def _wrap_ifcond(self) -> None:
>>           self._body = _wrap_ifcond(self._start_if[0],
>>                                     self._start_if[1], self._body)
>>           self._preamble = _wrap_ifcond(self._start_if[0],
>>                                         self._start_if[2], self._preamble)
>>   
>> -    def get_content(self):
>> +    def get_content(self) -> str:
>>           assert self._start_if is None
>>           return super().get_content()
>>   
>>   
>>   class QAPIGenC(QAPIGenCCode):
>> -
>> -    def __init__(self, fname, blurb, pydoc):
>> +    def __init__(self, fname: str, blurb: str, pydoc: str):
>>           super().__init__(fname)
>>           self._blurb = blurb
>>           self._copyright = '\n * '.join(re.findall(r'^Copyright .*', pydoc,
>>                                                     re.MULTILINE))
>>   
>> -    def _top(self):
>> +    def _top(self) -> str:
>>           return mcgen('''
>>   /* AUTOMATICALLY GENERATED, DO NOT MODIFY */
>>   
>> @@ -170,7 +168,7 @@ def _top(self):
>>   ''',
>>                        blurb=self._blurb, copyright=self._copyright)
>>   
>> -    def _bottom(self):
>> +    def _bottom(self) -> str:
>>           return mcgen('''
>>   
>>   /* Dummy declaration to prevent empty .o file */
>> @@ -180,16 +178,16 @@ def _bottom(self):
>>   
>>   
>>   class QAPIGenH(QAPIGenC):
>> -
>> -    def _top(self):
>> +    def _top(self) -> str:
>>           return super()._top() + guardstart(self.fname)
>>   
>> -    def _bottom(self):
>> +    def _bottom(self) -> str:
>>           return guardend(self.fname)
>>   
>>   
>>   @contextmanager
>> -def ifcontext(ifcond, *args):
>> +def ifcontext(ifcond: List[str],
>> +              *args: QAPIGenCCode) -> Generator[None, None, None]:
> 
> IIUC, this could simply be "Iterator[None]" instead of
> "Generator[None, None, None]".
> 
> Anyway,
> 
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 

Oh, you're right! Let's do that instead.

Reference: 
https://mypy.readthedocs.io/en/stable/kinds_of_types.html#generators

Eduardo, I am making this change and keeping your R-B.

--js


