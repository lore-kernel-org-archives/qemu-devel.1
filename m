Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D15C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0952075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhC6w0Ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0952075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIywS-0000m3-2F
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIyu0-0007oF-Pc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:45:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIyty-0002sL-8D
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600368300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8xwtBRaKIjIp1GS3ZLMUeicq8a2gsEQJQ+2ac7cUaM=;
 b=GhC6w0UrUpfb4Oj6RXiT7xn9m4qD4rnzj1FJ8cMGD4Ww/85sWqmIcKqg8nahVKTY7UHoqG
 a6CgvLuAe/iWhTcPfWJmCDRA2bXoI5JLHqXIVQ0SW2DhyQLwNixskR4Cw5mCTeDWaPg/VI
 G2U7mbk2lcz9+XvoyWOhnaPSXSEDSz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-koTdmhZLNum-UxyLyXRbbg-1; Thu, 17 Sep 2020 14:44:56 -0400
X-MC-Unique: koTdmhZLNum-UxyLyXRbbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B019557089;
 Thu, 17 Sep 2020 18:44:55 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67ED677D85;
 Thu, 17 Sep 2020 18:44:54 +0000 (UTC)
Subject: Re: [PATCH 14/37] qapi/common.py: Move comments into docstrings
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-15-jsnow@redhat.com>
 <87d02kpizr.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <49e28f59-012c-9b7b-02b7-1854f85884b2@redhat.com>
Date: Thu, 17 Sep 2020 14:44:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87d02kpizr.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:37 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> As docstrings, they'll show up in documentation and IDE help.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/common.py | 50 ++++++++++++++++++++++++++++++------------
>>   1 file changed, 36 insertions(+), 14 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index af01348b35..38d380f0a9 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -20,10 +20,18 @@
>>   c_name_trans = str.maketrans('.-', '__')
>>   
>>   
>> -# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
>> -# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
>> -# ENUM24_Name -> ENUM24_NAME
>>   def camel_to_upper(value: str) -> str:
>> +    """
>> +    Converts CamelCase to CAMEL_CASE.
>> +
>> +    Examples:
>> +      ENUMName -> ENUM_NAME
>> +      EnumName1 -> ENUM_NAME1
>> +      ENUM_NAME -> ENUM_NAME
>> +      ENUM_NAME1 -> ENUM_NAME1
>> +      ENUM_Name2 -> ENUM_NAME2
>> +      ENUM24_Name -> ENUM24_NAME
>> +    """
>>       c_fun_str = c_name(value, False)
>>       if value.isupper():
>>           return c_fun_str
>> @@ -45,21 +53,33 @@ def camel_to_upper(value: str) -> str:
>>   def c_enum_const(type_name: str,
>>                    const_name: str,
>>                    prefix: Optional[str] = None) -> str:
>> +    """
>> +    Generate a C enumeration constant name.
>> +
>> +    :param type_name: The name of the enumeration.
>> +    :param const_name: The name of this constant.
>> +    :param prefix: Optional, prefix that overrides the type_name.
>> +    """
> 
> Not actually a move.  Suggest to retitle
> 
>      qapi/common: Turn comments in docstrings, and add more
> 

OK.

>>       if prefix is not None:
>>           type_name = prefix
>>       return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>>   
>>   
>> -# Map @name to a valid C identifier.
>> -# If @protect, avoid returning certain ticklish identifiers (like
>> -# C keywords) by prepending 'q_'.
>> -#
>> -# Used for converting 'name' from a 'name':'type' qapi definition
>> -# into a generated struct member, as well as converting type names
>> -# into substrings of a generated C function name.
>> -# '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
>> -# protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
>>   def c_name(name: str, protect: bool = True) -> str:
>> +    """
>> +    Map `name` to a valid C identifier.
>> +
>> +    Used for converting 'name' from a 'name':'type' qapi definition
>> +    into a generated struct member, as well as converting type names
>> +    into substrings of a generated C function name.
>> +
>> +    '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
>> +    protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
>> +
>> +    :param name: The name to map.
>> +    :param protect: If true, avoid returning certain ticklish identifiers
>> +                    (like C keywords) by prepending 'q_'.
>> +    """
>>       # ANSI X3J11/88-090, 3.1.1
>>       c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
>>                        'default', 'do', 'double', 'else', 'enum', 'extern',
>> @@ -135,9 +155,11 @@ def pop(self, amount: int = 4) -> int:
>>   INDENT = Indent(0)
>>   
>>   
>> -# Generate @code with @kwds interpolated.
>> -# Obey INDENT level, and strip EATSPACE.
>>   def cgen(code: str, **kwds: Union[str, int]) -> str:
>> +    """
>> +    Generate `code` with `kwds` interpolated.
>> +    Obey `INDENT`, and strip `EATSPACE`.
>> +    """
>>       raw = code % kwds
>>       if INDENT:
>>           raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
> 
> Can you point to documentation on the docstring conventions and markup
> to use?
> 

Short answer: No.

Long answer:

It's actually completely arbitrary, with major competing de-facto 
standards. Their primary function is to be stored to the __doc__ 
attribute of a module/class/method and can be displayed when using the 
interactive function help(...).

https://www.python.org/dev/peps/pep-0257/ covers docstrings only in an 
extremely broad sense. In summary, it asks:

- Use full sentences that end in periods
- Use the triple-double quote style
- multi-line docstrings should have their closing quote on a line by itself
- multi-line docstrings should use a one-sentence summary, a blank line, 
and then a more elaborate description.

It recommends you document arguments, types, return values and types, 
exceptions and so on but does not dictate a format. Two popular 
conventions are the google-style [1] and the NumPy-style [2] docstring 
formats.

I write docstrings assuming we will be using *Sphinx* as our 
documentation tool. Sphinx does not read docstrings at all by default, 
but *autodoc* does. Autodoc assumes your docstrings are written in the 
Sphinx dialect of ReST.

What you really want to look for is the "Python domain" documentation in 
Sphinx: 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html

Autodoc will annotate function/method docstrings with "py:function" or 
"py:method" as appropriate, but the actual contents of the block are 
still up to you.

For those, you want to look up the Python domain info field lists that 
are supported by Sphinx, which are here: 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#info-field-lists

Taken together with PEP 257, you generally want something like this:

"""
Function f converts uncertainty into happiness.

Function f only works on days that do not end in 'y'. Caution should be 
used when integrating this function into threaded code.

:param uncertainty: All of your doubts.
:raise RuntimeError: When it is a day ending in 'y'.
:return: Your newfound happiness.
"""

I use the single-backtick as the Sphinx-ese "default role" resolver, 
which generally should resolve to a reference to some Python entity. The 
double-backtick is used to do formatted text for things like string 
literals and so on.



Coffee break.



Having said this, I have not found any tool to date that actually 
*checks* these comments for consistency. The pycharm IDE interactively 
highlights them when it senses that you have made a mistake, but that 
cannot be worked into our CI process that I know of - it's a proprietary 
checker.

So right now, they're just plaintext that I am writing to approximate 
the Sphinx style until such time as I enable autodoc for the module and 
fine-tune the actual formatting and so on.

--js



[1] 
https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html

[2] 
https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_numpy.html#example-numpy



