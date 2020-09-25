Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B56C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB96920936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOd+4kMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB96920936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrJ9-0004XF-03
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrIH-0003ec-EB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrIF-0005K9-Gv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:14:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601054038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K29HYaVfzjE9vYXfRT98/ShpSMbF2U5eHYCoh1zbvdw=;
 b=TOd+4kMxtH3+uIBcxMmwYokm11tDMzCSKqqk+PTZPL8oaEYBhqpayIZvKfFF2d+/2XhyUg
 JyRxWxC6Fkce/Zeg8Y8pmdTlzDscLYdcuHlnbgYUR8cTIuu7veoPWdMHu80v6yaTkGCczH
 aQAOjEXj7ToY/IrnS8iunCgKwdvcDxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Umh25DF2MxGsu7FBPS_l3g-1; Fri, 25 Sep 2020 13:13:56 -0400
X-MC-Unique: Umh25DF2MxGsu7FBPS_l3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 496011084D69;
 Fri, 25 Sep 2020 17:13:55 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9CA873667;
 Fri, 25 Sep 2020 17:13:53 +0000 (UTC)
Subject: Re: [PATCH v2 14/38] qapi/common.py: Convert comments into
 docstrings, and elaborate
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-15-jsnow@redhat.com>
 <20200923193842.GN191229@localhost.localdomain>
 <24bfc59d-e97e-e5f1-7443-c625612575fb@redhat.com>
 <20200925170209.GC402155@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <4aa4ea1d-9778-1ba1-9142-1e05b857a3b6@redhat.com>
Date: Fri, 25 Sep 2020 13:13:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925170209.GC402155@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 1:02 PM, Cleber Rosa wrote:
> On Wed, Sep 23, 2020 at 05:18:54PM -0400, John Snow wrote:
>> On 9/23/20 3:38 PM, Cleber Rosa wrote:
>>> On Tue, Sep 22, 2020 at 05:00:37PM -0400, John Snow wrote:
>>>> As docstrings, they'll show up in documentation and IDE help.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>    scripts/qapi/common.py | 51 ++++++++++++++++++++++++++++++------------
>>>>    1 file changed, 37 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>>>> index 0ce4a107e6..730283722a 100644
>>>> --- a/scripts/qapi/common.py
>>>> +++ b/scripts/qapi/common.py
>>>> @@ -20,10 +20,18 @@
>>>>    _C_NAME_TRANS = str.maketrans('.-', '__')
>>>> -# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
>>>> -# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
>>>> -# ENUM24_Name -> ENUM24_NAME
>>>>    def camel_to_upper(value: str) -> str:
>>>> +    """
>>>> +    Converts CamelCase to CAMEL_CASE.
>>>> +
>>>> +    Examples:
>>>> +      ENUMName -> ENUM_NAME
>>>> +      EnumName1 -> ENUM_NAME1
>>>> +      ENUM_NAME -> ENUM_NAME
>>>> +      ENUM_NAME1 -> ENUM_NAME1
>>>> +      ENUM_Name2 -> ENUM_NAME2
>>>> +      ENUM24_Name -> ENUM24_NAME
>>>> +    """
>>>>        c_fun_str = c_name(value, False)
>>>>        if value.isupper():
>>>>            return c_fun_str
>>>> @@ -45,21 +53,33 @@ def camel_to_upper(value: str) -> str:
>>>>    def c_enum_const(type_name: str,
>>>>                     const_name: str,
>>>>                     prefix: Optional[str] = None) -> str:
>>>> +    """
>>>> +    Generate a C enumeration constant name.
>>>> +
>>>> +    :param type_name: The name of the enumeration.
>>>> +    :param const_name: The name of this constant.
>>>> +    :param prefix: Optional, prefix that overrides the type_name.
>>>> +    """
>>>>        if prefix is not None:
>>>>            type_name = prefix
>>>>        return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>>>> -# Map @name to a valid C identifier.
>>>> -# If @protect, avoid returning certain ticklish identifiers (like
>>>> -# C keywords) by prepending 'q_'.
>>>> -#
>>>> -# Used for converting 'name' from a 'name':'type' qapi definition
>>>> -# into a generated struct member, as well as converting type names
>>>> -# into substrings of a generated C function name.
>>>> -# '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
>>>> -# protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
>>>>    def c_name(name: str, protect: bool = True) -> str:
>>>> +    """
>>>> +    Map `name` to a valid C identifier.
>>>> +
>>>> +    Used for converting 'name' from a 'name':'type' qapi definition
>>>> +    into a generated struct member, as well as converting type names
>>>> +    into substrings of a generated C function name.
>>>> +
>>>> +    '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
>>>> +    protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
>>>> +
>>>> +    :param name: The name to map.
>>>> +    :param protect: If true, avoid returning certain ticklish identifiers
>>>> +                    (like C keywords) by prepending ``q_``.
>>>> +    """
>>>>        # ANSI X3J11/88-090, 3.1.1
>>>>        c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
>>>>                         'default', 'do', 'double', 'else', 'enum', 'extern',
>>>> @@ -134,9 +154,12 @@ def decrease(self, amount: int = 4) -> int:
>>>>    indent = Indentation()
>>>> -# Generate @code with @kwds interpolated.
>>>> -# Obey indent, and strip EATSPACE.
>>>>    def cgen(code: str, **kwds: object) -> str:
>>>> +    """
>>>> +    Generate `code` with `kwds` interpolated.
>>>> +
>>>> +    Obey `indent`, and strip `EATSPACE`.
>>>> +    """
>>>
>>> This probably won't help on IDEs (never checked any), but sphinx will
>>> let you do:
>>>
>>>      """
>>>      Generate `code` with `kwds` interpolated.
>>>
>>>      Obey `indent`, and strip :data:`EATSPACE`.
>>>      """
>>>
>>> I'm not sure that a maximum level of docstring "sphinxzation" is the
>>> goal here, though.
>>>
>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>
>>
>> It isn't yet, but I intend to address that when I remove missing-docstring
>> from pylint exemptions. Do I need :data: if I set the default role to 'any'?
>>
> 
> That's a good question.  According to the docs "any" will do its best,
> so it's probably a good fallback.  I do still favor using the correct
> role from the start if I can help it.
> 
>> I'll probably try to enable sphinx at that time (and put the docs in a
>> devel/python manual?) and worry about the formatting at that point.
>>
>> --js
> 
> Nice!
> 
> - Cleber.
> 

As of v3, I started toying with this, as you can see. It is a goal of 
mine to hit full doc coverage in this package, eventually.

What I learned: you can reference data members, but only if they have a 
comment. Otherwise, they are skipped. Sphinx does not appear to offer an 
"undocumented data member" option the same way it does for "undocumented 
member".

Using the "Any" role is nice, and I prefer it. If it finds that a target 
is ambiguous (2+ references), it will throw an error and the sphinx 
build will fail. This is good enough for me: there's no reason to 
clutter the docstrings with Sphinxese if we don't have to.

I would like to try and keep these readable to humans who are just in 
emacs/vim editing code, too.

--js


