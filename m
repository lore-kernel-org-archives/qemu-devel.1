Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890AEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0385E21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gF3TMWI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0385E21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmvZ-0006sW-Um
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLmkR-0004Mi-2z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLmkP-00060N-2k
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:22:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601036564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tz7bUqhXZiFZJJAWSzsv54cMNhE/YAjUveAClphYDqI=;
 b=gF3TMWI0VQuX0w2mR0JLiiWtyKza5aM/1ZPwmgVbtr0aIrIJKsh+SaAoE2YEqMMVoZsCTw
 5D3uSYIzLYOXefdlSrMDZCU8NTOpL2OYMCMOW/lMTGEKoivHsHOD3MAjDBJLc5s5J7Uzmr
 O9nyvY52MsKClIic7HPtYNbktt+XL/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-qSoWkr7IMfmCn3mM-uLCXg-1; Fri, 25 Sep 2020 08:22:40 -0400
X-MC-Unique: qSoWkr7IMfmCn3mM-uLCXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D76A1084C96;
 Fri, 25 Sep 2020 12:22:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D6E260C15;
 Fri, 25 Sep 2020 12:22:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4C9E113865F; Fri, 25 Sep 2020 14:22:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 22/38] qapi/source.py: add type hint annotations
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-23-jsnow@redhat.com>
 <20200923223619.GV191229@localhost.localdomain>
 <0ace0c8d-0853-d078-d865-1453640b1c06@redhat.com>
Date: Fri, 25 Sep 2020 14:22:37 +0200
In-Reply-To: <0ace0c8d-0853-d078-d865-1453640b1c06@redhat.com> (John Snow's
 message of "Wed, 23 Sep 2020 19:55:50 -0400")
Message-ID: <87d02at59u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/23/20 6:36 PM, Cleber Rosa wrote:
>> On Tue, Sep 22, 2020 at 05:00:45PM -0400, John Snow wrote:
>>> Annotations do not change runtime behavior.
>>> This commit *only* adds annotations.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
[...]
>>> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
>>> index e97b9a8e15..1cc6a5b82d 100644
>>> --- a/scripts/qapi/source.py
>>> +++ b/scripts/qapi/source.py
>>> @@ -11,37 +11,42 @@
>>>     import copy
>>>   import sys
>>> +from typing import List, Optional, TypeVar
>>>     
>>>   class QAPISchemaPragma:
>>> -    def __init__(self):
>>> +    def __init__(self) -> None:
>> I don't follow the reason for typing this...
>> 
>>>           # Are documentation comments required?
>>>           self.doc_required = False
>>>           # Whitelist of commands allowed to return a non-dictionary
>>> -        self.returns_whitelist = []
>>> +        self.returns_whitelist: List[str] = []
>>>           # Whitelist of entities allowed to violate case conventions
>>> -        self.name_case_whitelist = []
>>> +        self.name_case_whitelist: List[str] = []
>>>     
>>>   class QAPISourceInfo:
>>> -    def __init__(self, fname, line, parent):
>>> +    T = TypeVar('T', bound='QAPISourceInfo')
>>> +
>>> +    def __init__(self: T, fname: str, line: int, parent: Optional[T]):
>> And not this... to tune my review approach, should I assume that
>> this
>> series intends to add complete type hints or not?
>> 
>
> This is a mypy quirk you've discovered that I've simply forgotten about.
>
> When __init__ has *no* arguments, you need to annotate its return to
> explain to mypy that you have fully typed that method. It's a sentinel 
> that says "Please type check this class!"
>
> When __init__ has some arguments, you only need to type those
> arguments and not the return type. The sentinel is not needed.
>
> __init__ *never* returns anything, so I opted to omit this useless
> annotation whenever it was possible to do so.

Worth capturing in a comment and/or commit message?


