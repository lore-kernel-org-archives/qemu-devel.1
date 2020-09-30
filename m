Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C808FC4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE60206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcOEelp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE60206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfpH-00070L-A4
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNfo9-0005hq-1t
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNfo6-0001pz-7u
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:22:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601486539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXyqPTY/QndTAis7sfXLgqFAM8qKGtFjX0pqLPrrf0Q=;
 b=hcOEelp+GykZfFxHqnIrbcRMLAAwg/+swjhrzLtNzbYEbha70QUxiNepfiw+VBDb8Uii3p
 /vXJlvmwiC4fhRSfdmuWNuoZ8NDKhwfcWG+sEkSVN38IWZX9dMS9MTG59f7vIq64lJfUVG
 tRvG8ONA0/faUBP7GFSIr+xkzTAkYgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-dVvXA2AYOwSLRAaOPB5GDw-1; Wed, 30 Sep 2020 13:22:15 -0400
X-MC-Unique: dVvXA2AYOwSLRAaOPB5GDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9CC1800683;
 Wed, 30 Sep 2020 17:22:14 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6C2110013C4;
 Wed, 30 Sep 2020 17:22:13 +0000 (UTC)
Subject: Re: [PATCH v4 04/46] qapi: modify docstrings to be sphinx-compatible
To: Markus Armbruster <armbru@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-5-jsnow@redhat.com>
 <87wo0bejmy.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <96ba9e08-9806-baa3-62d2-2df84a666e62@redhat.com>
Date: Wed, 30 Sep 2020 13:22:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87wo0bejmy.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 4:47 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> I did not say "sphinx beautiful", just "sphinx compatible". They will
>> not throw errors when parsed and interpreted as ReST.
> 
> "Bang on the keyboard until Sphinx doesn't throw errors anymore" might
> be good enough for a certain kind of mathematician, but a constructive
> solution needs a bit more direction.  Is there a specification to
> follow?  Other useful resources?
> 

I don't know if you are asking this question rhetorically, or in good faith.

Let me preface this by saying: This series, and these 119 patches, are 
not about finding a style guide for our docstring utilization or about 
proposing one. It is also not about rigorously adding such documentation 
or about finding ways to meaningfully publish it with e.g. Sphinx, or 
the styling of such pages.

Why bother to add docstrings at all, then? Because I needed them for my 
own sake when learning this code and I felt it would be a waste to just 
delete them, and I am of sound mind and able body and believe that some 
documentation was better than none. They are useful even just as plaintext.

Having said that, let's explore the actual style I tend to use.

I mentioned before in response to a review comment that there isn't 
really any standard for docstrings. There are a few competing "styles", 
but none of which are able to be programmatically checked and validated.

The primary guide for docstrings is PEP 257, of which I follow some but 
not all of the recommendations.

https://www.python.org/dev/peps/pep-0257/

In general,

- Always use triple-double quotes (unenforced)
- Modules, classes, and functions should have docstrings (pylint)
- No empty lines before or after the docstring (unenforced)
- Multi-line docstrings should take the form (unenforced):

"""
single-line summary of function.

Additional prose if needed describing the function.

:param x: Input such that blah blah.
:raises y: When input ``x`` is unsuitable because blah blah.
:returns: A value that blah blah.
"""

PEP257 suggests a form where the single-line summary appears on the same 
line as the opening triple quotes. I don't like this, and prefer 
symmetry. PEP257 *also* suggests that writing it my way is equivalent to 
their way, because any docstring processor should trim the first line. I 
take this as tacit admission that my way is acceptable and has merit.

What about the syntax or markup inside the docstring itself? there is 
*absolutely no standard*, but Sphinx autodoc recognizes a few field 
lists as significant in its parsing, so I prefer using them:

:param x: Denotes the parameter X. Do not use type information in the 
string, we rely on mypy for that now.

:raises y: explains a case in which an Exception type y may be raised 
either directly by this code or anticipated to be allowed to be raised 
by a helper call. (There's no standard here that I am aware of. I use my 
judgment. Always document direct raise calls, but use your judgment for 
sub-calls.)

:returns: explains the semantics of the return value.

That said, literally any sphinx/ReST markup is OK as long as it passes 
make sphinxdocs. Some sphinx markup is prohibited, like adding new 
full-throated sections. You can use arbitrary field lists, definition 
lists, pre-formatted text, examples, code blocks, whatever.

In general, you are not going to find the kind of semantic validation 
you want to ensure that the parameter names are correct, or that you 
spelled :param: right, or that you didn't miss a parameter or an 
exception. None of that tooling exists for Python.

Thus, it's all rather subjective. No right answers, no validation tools. 
Just whatever seems reasonable to a human eye until such time we 
actually decide to pursue publishing the API docs in the development 
manual, if indeed we ever do so at all.

That series sounds like a great opportunity to hash this all out. That 
is when I would like to remove --missing-docstring, too. There will 
absolutely be a "docstring series" in the future, but I am insisting 
stubbornly it happen after strict typing.

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/gen.py    | 6 ++++--
>>   scripts/qapi/parser.py | 9 +++++----
>>   2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>> index ca66c82b5b8..fc19b2aeb9b 100644
>> --- a/scripts/qapi/gen.py
>> +++ b/scripts/qapi/gen.py
>> @@ -154,9 +154,11 @@ def _bottom(self):
>>   
>>   @contextmanager
>>   def ifcontext(ifcond, *args):
>> -    """A 'with' statement context manager to wrap with start_if()/end_if()
>> +    """
>> +    A 'with' statement context manager that wraps with `start_if` and `end_if`.
> 
> Sadly, the fact that start_if() and end_if() are functions isn't
> immediately obvious anymore.
> 
> I've seen :func:`start_if` elsewhere.  Is this something we should or
> want to use?
> 

We *could*.

`start_if` relies on the default role, which I have provisionally set to 
"any" here, so this is shorthand for :any:`start_if`.

The :any: role means: "cross-reference any type of thing." If there is 
not exactly one thing that matches, it results in an error during the 
documentation build.

I like this, because it's nice short-hand syntax that I think 
communicates effectively to the reader that this is a symbol of some 
kind without needing a premium of ReST-ese.

CONSTANTS are capitalized, Classes are title cased, and functions are 
lower_case. `lower_case` references can be assumed to be functions, but 
I will admit that this is not enforced or necessarily true as we add 
more cross reference types in the future.

(I am trying to add QMP cross-reference syntax!)

I still prefer `start_if` to :func:`start_if` simply because it's less 
markup and is easier to read in plaintext contexts. You're right, it 
doesn't look like a function anymore.

I'm not sure if another annotations would work -- `start_if`() or 
`start_if()`. Both seem kind of clunky to me, to be honest. Personal 
feeling is "not really worth the hassle."

>>   
>> -    *args: any number of QAPIGenCCode
>> +    :param ifcond: List of conditionals
>> +    :param args: any number of `QAPIGenCCode`.
>>   
>>       Example::
>>   
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 9d1a3e2eea9..02983979965 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -381,10 +381,11 @@ def append(self, line):
>>   
>>           The way that the line is dealt with depends on which part of
>>           the documentation we're parsing right now:
>> -        * The body section: ._append_line is ._append_body_line
>> -        * An argument section: ._append_line is ._append_args_line
>> -        * A features section: ._append_line is ._append_features_line
>> -        * An additional section: ._append_line is ._append_various_line
>> +
>> +         * The body section: ._append_line is ._append_body_line
>> +         * An argument section: ._append_line is ._append_args_line
>> +         * A features section: ._append_line is ._append_features_line
>> +         * An additional section: ._append_line is ._append_various_line
>>           """
>>           line = line[1:]
>>           if not line:
> 
> I understand why you insert a blank line (reST wants blank lines around
> lists), I don't understand why you indent.  Can you explain?

I was mistaken about it needing the indent!

--js


