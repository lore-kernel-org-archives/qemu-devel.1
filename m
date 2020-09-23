Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9F52053B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dt0Q9/+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9F52053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8bA-0002oa-M5
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8a6-00022c-50
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8a4-0001b9-9b
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600882163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0umTsGePTo8hjaaFhMjcJDXSJ3JI4DLHuc/+JOWkp5w=;
 b=Dt0Q9/+DBhsCwgv/SUNT/lJzkvNBeBoFjewkQT4FE/guIML0Ikt7wzTD0GqY0gU/AZSRxP
 DQJn8pKOD5+8/wcaJno7Lo0HCXuk74mu6oxU0h2iBazLEbvijvpwNTYi2/6yCrkXXUIMHr
 VuCRQj0TNpUU1c/ingjfbvBHDrk9ICs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-pQM3F_2jMBeM1Bu9mus0Kw-1; Wed, 23 Sep 2020 13:29:19 -0400
X-MC-Unique: pQM3F_2jMBeM1Bu9mus0Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E9957051;
 Wed, 23 Sep 2020 17:29:18 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E0AC7368B;
 Wed, 23 Sep 2020 17:29:17 +0000 (UTC)
Subject: Re: [PATCH v2 09/38] qapi/common.py: Add indent manager
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-10-jsnow@redhat.com>
 <20200922222232.GK2044576@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <c57afb75-3db9-abec-dd21-c32f9f918104@redhat.com>
Date: Wed, 23 Sep 2020 13:29:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922222232.GK2044576@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 6:22 PM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:00:32PM -0400, John Snow wrote:
>> Code style tools really dislike the use of global keywords, because it
>> generally involves re-binding the name at runtime which can have strange
>> effects depending on when and how that global name is referenced in
>> other modules.
>>
>> Make a little indent level manager instead.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/common.py | 51 +++++++++++++++++++++++++++++-------------
>>   scripts/qapi/visit.py  |  7 +++---
>>   2 files changed, 38 insertions(+), 20 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index cee63eb95c..e0c5871b10 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -93,33 +93,52 @@ def c_name(name, protect=True):
>>   pointer_suffix = ' *' + eatspace
>>   
>>   
>> -def genindent(count):
>> -    ret = ''
>> -    for _ in range(count):
>> -        ret += ' '
>> -    return ret
>> +class Indentation:
>> +    """
>> +    Indentation level management.
>>   
>> +    :param initial: Initial number of spaces, default 0.
>> +    """
>> +    def __init__(self, initial: int = 0) -> None:
>> +        self._level = initial
>>   
>> -indent_level = 0
>> +    def __int__(self) -> int:
>> +        return self._level
>>   
>> +    def __repr__(self) -> str:
>> +        return "{}({:d})".format(type(self).__name__, self._level)
>>   
>> -def push_indent(indent_amount=4):
>> -    global indent_level
>> -    indent_level += indent_amount
>> +    def __str__(self) -> str:
>> +        """Return the current indentation as a string of spaces."""
>> +        return ' ' * self._level
>>   
>> +    def __bool__(self) -> bool:
>> +        """True when there is a non-zero indentation."""
>> +        return bool(self._level)
>>   
>> -def pop_indent(indent_amount=4):
>> -    global indent_level
>> -    indent_level -= indent_amount
>> +    def increase(self, amount: int = 4) -> int:
>> +        """Increase the indentation level by `amount`, default 4."""
>> +        self._level += amount
>> +        return self._level
>> +
>> +    def decrease(self, amount: int = 4) -> int:
>> +        """Decrease the indentation level by `amount`, default 4."""
>> +        if self._level < amount:
>> +            raise ArithmeticError(
>> +                f"Can't remove {amount:d} spaces from {self!r}")
>> +        self._level -= amount
>> +        return self._level
>> +
>> +
>> +indent = Indentation()
> 
> Personally, I would keep the push_indent(), pop_indent() API, and
> introduce an indent() function, to follow the existing API style
> of plain functions.
> 
> Something like:
> 
>    indent_prefixes = []
>    def push_indent(amount=4):
>        """Add `amount` spaces to indentation prefix"""
>        indent_prefixes.push(' '*amount)
>    def pop_indent():
>        """Revert the most recent push_indent() call"""
>        indent_prefixes.pop()
>    def indent():
>        """Return the current indentation prefix"""
>        return ''.join(indent_prefixes)
> 
> What you did is still an improvement, though, so:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 

Yeah, there's only one user right now, so ... I just kinda wanted to get 
rid of the global usage. Maybe if we make the code generator fancier 
we'll find out what form is best.

--js


