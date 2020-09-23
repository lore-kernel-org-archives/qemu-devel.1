Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AC3C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553E320791
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZrkUaSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553E320791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7xz-0008L8-Gw
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL7wv-0007Tn-AI
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL7wt-00051J-BN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600879734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nNq86Pb3X/ClFhTZsxCiWTHA5xb/waaIJ/AiYMo4tY=;
 b=IZrkUaSKFzI+MgNFbsFmCN0LDs/0mTJKjA76wghW3yJajVQXiSp8/gptglincAmdCjQRgi
 jx04xgaFNV5/BThXKmhwnD78RUMBB4jFVrkk5w10tRpI4u8xsJQizRPVXIw8R61q3Mtv6y
 NEC4Yr0GAsh9J3FxC4jLmYLAoQtJNxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-E5gOuLsJNJCRunGK3-xvjw-1; Wed, 23 Sep 2020 12:48:50 -0400
X-MC-Unique: E5gOuLsJNJCRunGK3-xvjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A652A186841F;
 Wed, 23 Sep 2020 16:48:49 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 365405D98D;
 Wed, 23 Sep 2020 16:48:47 +0000 (UTC)
Subject: Re: [PATCH v2 01/38] [DO-NOT-MERGE] qapi: add debugging tools
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-2-jsnow@redhat.com>
 <20200922234313.GA191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <ac911dbc-f6e8-6fff-a537-ccdaa7ed3e31@redhat.com>
Date: Wed, 23 Sep 2020 12:48:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922234313.GA191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On 9/22/20 7:43 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:24PM -0400, John Snow wrote:
>> This adds some really childishly simple debugging tools. Maybe they're
>> interesting for someone else, too?
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/debug.py | 78 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 scripts/qapi/debug.py
>>
>> diff --git a/scripts/qapi/debug.py b/scripts/qapi/debug.py
>> new file mode 100644
>> index 0000000000..bacf5ee180
>> --- /dev/null
>> +++ b/scripts/qapi/debug.py
>> @@ -0,0 +1,78 @@
>> +"""
>> +Small debugging facilities for mypy static analysis work.
>> +(C) 2020 John Snow, for Red Hat, Inc.
>> +"""
>> +
>> +import inspect
>> +import json
>> +from typing import Dict, List, Any
>> +from types import FrameType
>> +
>> +
>> +OBSERVED_TYPES: Dict[str, List[str]] = {}
>> +
>> +
>> +# You have no idea how long it took to find this return type...
>> +def caller_frame() -> FrameType:
>> +    """
>> +    Returns the stack frame of the caller's caller.
>> +    e.g. foo() -> caller() -> caller_frame() return's foo's stack frame.
>> +    """
>> +    stack = inspect.stack()
>> +    caller = stack[2].frame
>> +    if caller is None:
>> +        msg = "Python interpreter does not support stack frame inspection"
>> +        raise RuntimeError(msg)
>> +    return caller
>> +
>> +
>> +def _add_type_record(name: str, typestr: str) -> None:
>> +    seen = OBSERVED_TYPES.setdefault(name, [])
>> +    if typestr not in seen:
>> +        seen.append(typestr)
>> +
>> +
>> +def record_type(name: str, value: Any, dict_names: bool = False) -> None:
>> +    """
>> +    Record the type of a variable.
>> +
>> +    :param name: The name of the variable
>> +    :param value: The value of the variable
>> +    """
>> +    _add_type_record(name, str(type(value)))
>> +
>> +    try:
>> +        for key, subvalue in value.items():
>> +            subname = f"{name}.{key}" if dict_names else f"{name}.[dict_value]"
>> +            _add_type_record(subname, str(type(subvalue)))
>> +        return
>> +    except AttributeError:
>> +        # (Wasn't a dict or anything resembling one.)
>> +        pass
>> +
>> +    # str is iterable, but not in the way we want!
>> +    if isinstance(value, str):
>> +        return
>> +
>> +    try:
>> +        for elem in value:
>> +            _add_type_record(f"{name}.[list_elem]", str(type(elem)))
>> +    except TypeError:
>> +        # (Wasn't a list or anything else iterable.)
>> +        pass
>> +
>> +
>> +def show_types() -> None:
>> +    """
>> +    Print all of the currently known variable types to stdout.
>> +    """
>> +    print(json.dumps(OBSERVED_TYPES, indent=2))
>> +
> 
> Maybe the following will be cheaper (no json conversion):
> 
>     pprint.pprint(OBSERVED_TYPES, indent=2)
> 
> Other than that, I'd vote for including this if there's a bit more
> documentation on how to use it, or an example script.  Maybe there
> already is, and I did not get to it yet.
> 
> - Cleber.
> 

Nope, this is just a dumb script I did to observe types in flight.

There are apparently bigger, beefier tools that I don't know how to use 
yet: https://github.com/dropbox/pyannotate

I just included my own little tool as a reference thing to be archived 
on list, I have no desire to spruce it up. I'd rather spend my time 
learning pyannotate.

--js


