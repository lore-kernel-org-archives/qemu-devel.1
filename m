Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1CC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13820848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPJhhkU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0Cb-0006W8-Ad
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNzsz-0005d9-GK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNzsw-00033b-Jg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMyPUG/4CU3rYJPrdP4ul+3AkQJ7UT9ui8xI9MV0SpI=;
 b=DPJhhkU7ekapQJ3uJt4y5/Y6gfmTrXaosPDSi0dfmsfs2wFL0iDpwJnnsTHMRz2MNPi7hR
 WetMs13OA9EAD1ycXNIncmniE1ZySS+LhjJ7uQ9J1LpkdXW5cp8CZiNZDZtfZE8IVhGijC
 wVMXNDfB4Hzbwd0nvF6wHdzY0+ZnQno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-qC_5oTkPMHyZz9l88z5p7w-1; Thu, 01 Oct 2020 10:48:37 -0400
X-MC-Unique: qC_5oTkPMHyZz9l88z5p7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD6061074662;
 Thu,  1 Oct 2020 14:48:36 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFC3B7D4E3;
 Thu,  1 Oct 2020 14:48:35 +0000 (UTC)
Subject: Re: [PATCH v4 04/46] qapi: modify docstrings to be sphinx-compatible
To: Markus Armbruster <armbru@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-5-jsnow@redhat.com>
 <87wo0bejmy.fsf@dusky.pond.sub.org>
 <96ba9e08-9806-baa3-62d2-2df84a666e62@redhat.com>
 <87blhm49bk.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <5f3e38fd-6d18-5d28-31cd-6c0faa8c675d@redhat.com>
Date: Thu, 1 Oct 2020 10:48:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87blhm49bk.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 10/1/20 4:52 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 9/30/20 4:47 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> I did not say "sphinx beautiful", just "sphinx compatible". They will
>>>> not throw errors when parsed and interpreted as ReST.
>>> "Bang on the keyboard until Sphinx doesn't throw errors anymore"
>>> might
>>> be good enough for a certain kind of mathematician, but a constructive
>>> solution needs a bit more direction.  Is there a specification to
>>> follow?  Other useful resources?
>>>
>>
>> I don't know if you are asking this question rhetorically, or in good faith.
> 
> I ask to make sure I understand goals and limitations of your doc string
> work in this series.
> 
> Also, even a passing to Sphinx becomes more useful when accompanied by a
> link to relevant documentation.
> 
>> Let me preface this by saying: This series, and these 119 patches, are
>> not about finding a style guide for our docstring utilization or about
>> proposing one. It is also not about rigorously adding such
>> documentation or about finding ways to meaningfully publish it with
>> e.g. Sphinx, or the styling of such pages.
>>
>> Why bother to add docstrings at all, then? Because I needed them for
>> my own sake when learning this code and I felt it would be a waste to
>> just delete them, and I am of sound mind and able body and believe
>> that some documentation was better than none. They are useful even
>> just as plaintext.
>>
>> Having said that, let's explore the actual style I tend to use.
>>
>> I mentioned before in response to a review comment that there isn't
>> really any standard for docstrings. There are a few competing
>> "styles", but none of which are able to be programmatically checked
>> and validated.
>>
>> The primary guide for docstrings is PEP 257, of which I follow some
>> but not all of the recommendations.
>>
>> https://www.python.org/dev/peps/pep-0257/
> 
> I find PEP 257 frustrating.  It leaves me with more questions than
> answers.
> 

Yeah, sorry. That's what we're dealing with. It's very open-ended.

>> In general,
>>
>> - Always use triple-double quotes (unenforced)
>> - Modules, classes, and functions should have docstrings (pylint)
>> - No empty lines before or after the docstring (unenforced)
>> - Multi-line docstrings should take the form (unenforced):
>>
>> """
>> single-line summary of function.
>>
>> Additional prose if needed describing the function.
>>
>> :param x: Input such that blah blah.
>> :raises y: When input ``x`` is unsuitable because blah blah.
>> :returns: A value that blah blah.
> 
> This paragraph is already not PEP 257.
> 

Right -- well, it isn't NOT PEP 257 either. It just suggests you have to 
describe these features, but it doesn't say HOW.

>> """
>>
>> PEP257 suggests a form where the single-line summary appears on the
>> same line as the opening triple quotes. I don't like this, and prefer
>> symmetry. PEP257 *also* suggests that writing it my way is equivalent
>> to their way, because any docstring processor should trim the first
>> line. I take this as tacit admission that my way is acceptable and has
>> merit.
> 
> I prefer the symmetric form myself.
> 
>> What about the syntax or markup inside the docstring itself? there is
>> *absolutely no standard*, but Sphinx autodoc recognizes a few field
>> lists as significant in its parsing, so I prefer using them:
> 
> Doc link?
> 

Hard to search for in my opinion; you want to search for "sphinx python 
domain", and then click on "field lists" on the sidebar.

https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#info-field-lists

It has a special understanding for:

param/parameter/arg/argument/key/keyword: I prefer "param" here. 
Possibly key/keyword if we use a **kwargs form with a key that we 
specially recognize, but I've not tested that yet. I know pycharm 
understands "param" in a semantic way, and that's been good enough for me.

type: Defines the type of a parameter. In my opinion, do not use this. 
Let native type hints do the lifting.

raises/raise/except/exception: I prefer "raises". "raises ErrorType 
when...." is a good sentence.

var/ivar/cvar: Describes a variable, presumably in the body of the 
function below. I've never used this, I always describe it in prose instead.

vartype: Defines a type for a variable; I would again defer to the 
native type system instead now.

returns/return: I prefer "returns" for grammatical reasons again. 
("Returns such-and-such when...")

rtype: again, type information. Don't use.

meta: For directives to sphinx, e.g. :meta private: or :meta public: to 
toggle the visibility class from its default. I don't use this.


None of these are validated or checked in any meaningful way; you can 
use arbitrarily field lists (and I do in a few places!) to define your 
own terms and so on.


(I would like to improve autodoc in the future to validate your 
docstrings such that you can enforce :param:, :raises: and :return: and 
it uses the type hints and introspection information to raise an error 
when you make an obvious mistake. I am not there yet, but I am using 
Peter Maydell's work to help inform how I might write such an extension 
to autodoc. This work is not critical, but it will likely occur 
upstream, outside of the QEMU context because I believe this is a good 
thing to do for the ecosystem in general, to allow autodoc to function 
slightly more like e.g. Doxygen does.)

>> :param x: Denotes the parameter X. Do not use type information in the
>> string, we rely on mypy for that now.
>>
>> :raises y: explains a case in which an Exception type y may be raised
>> either directly by this code or anticipated to be allowed to be raised
>> by a helper call. (There's no standard here that I am aware of. I use
>> my judgment. Always document direct raise calls, but use your judgment
>> for sub-calls.)
>>
>> :returns: explains the semantics of the return value.
>>
>> That said, literally any sphinx/ReST markup is OK as long as it passes
>> make sphinxdocs. Some sphinx markup is prohibited, like adding new
>> full-throated sections. You can use arbitrary field lists, definition
>> lists, pre-formatted text, examples, code blocks, whatever.
>>
>> In general, you are not going to find the kind of semantic validation
>> you want to ensure that the parameter names are correct, or that you
>> spelled :param: right, or that you didn't miss a parameter or an
>> exception. None of that tooling exists for Python.
>>
>> Thus, it's all rather subjective. No right answers, no validation
>> tools. Just whatever seems reasonable to a human eye until such time
>> we actually decide to pursue publishing the API docs in the
>> development manual, if indeed we ever do so at all.
>>
>> That series sounds like a great opportunity to hash this all out. That
>> is when I would like to remove --missing-docstring, too. There will
>> absolutely be a "docstring series" in the future, but I am insisting
>> stubbornly it happen after strict typing.
> 
> Okay.  Nevertheless, I'd prefer a bit more information in the commit
> message.  Here's my try:
> 
>      qapi: Modify docstrings to be sphinx-compatible
> 
>      I did not say "sphinx beautiful", just "sphinx compatible". They
>      will not throw errors when parsed and interpreted as ReST.  Finding
>      a comprehensive style guide for our docstring utilization is left
>      for another day.
> 
>      For now, use field lists recognized by Sphinx autodoc.
>      FIXME link to their documentation
> 

That I can do -- and I will double down on my IOU for a more formal 
style guide: https://gitlab.com/jsnow/qemu/-/issues/7

I didn't bother writing it in any of the commits because I felt like 
it'd get lost there and would be mostly useless; but a .rst doc inside 
the package folder would be hard to miss.

I plan to check in something like ./python/README.rst or 
./python/CODING_STYLE.rst to try and formalize a lot of what I am doing 
here, where it's going to be harder to miss.

>>
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>    scripts/qapi/gen.py    | 6 ++++--
>>>>    scripts/qapi/parser.py | 9 +++++----
>>>>    2 files changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
>>>> index ca66c82b5b8..fc19b2aeb9b 100644
>>>> --- a/scripts/qapi/gen.py
>>>> +++ b/scripts/qapi/gen.py
>>>> @@ -154,9 +154,11 @@ def _bottom(self):
>>>>      @contextmanager
>>>>    def ifcontext(ifcond, *args):
>>>> -    """A 'with' statement context manager to wrap with start_if()/end_if()
>>>> +    """
>>>> +    A 'with' statement context manager that wraps with `start_if` and `end_if`.
>>> Sadly, the fact that start_if() and end_if() are functions isn't
>>> immediately obvious anymore.
>>> I've seen :func:`start_if` elsewhere.  Is this something we should
>>> or
>>> want to use?
>>>
>>
>> We *could*.
>>
>> `start_if` relies on the default role, which I have provisionally set
>> to "any" here, so this is shorthand for :any:`start_if`.
>>
>> The :any: role means: "cross-reference any type of thing." If there is
>> not exactly one thing that matches, it results in an error during the
>> documentation build.
>>
>> I like this, because it's nice short-hand syntax that I think
>> communicates effectively to the reader that this is a symbol of some
>> kind without needing a premium of ReST-ese.
>>
>> CONSTANTS are capitalized, Classes are title cased, and functions are
>> lower_case. `lower_case` references can be assumed to be functions,
> 
> `lower_case` could also refer to an attribute, variable, or parameter.
> 

Hm. Attribute yes, actually. variable and parameter no -- sphinx does 
not presently provide syntax or roles for creating anchors to parameter 
names or variables, so they are not able to be cross-referenced.

Attributes CAN be cross-referenced, but only when they are documented.

Another style guide thing:

#: x is a number that represents "The Answer". See `Douglas Adams`_.
self.x = 42

You can use the special comment form "#:" to add a one-line description 
of an attribute that Sphinx will pick up. Sphinx skips these attributes 
otherwise. If you consider them part of the interface of the module, 
it's maybe a good idea to do this.

You can also use docstrings, but the ordering changes:

self.x = 42
"""x is a number that represents "The Answer". See `Douglas Adams`_.

I kind of like the #: form because it announces what follows, but I 
admit it's a bit of special sphinx magic.

>> but I will admit that this is not enforced or necessarily true as we
>> add more cross reference types in the future.
>>
>> (I am trying to add QMP cross-reference syntax!)
>>
>> I still prefer `start_if` to :func:`start_if` simply because it's less
>> markup and is easier to read in plaintext contexts. You're right, it
>> doesn't look like a function anymore.
> 
> Yes, :func:`start_if` is rather heavy.  I asked because I wanted to
> understand what :func: buys us.  Not meant as endorsement.
> 

It specifically targets only cross-references of that exact type. In the 
case that the :any: reference is ambiguous, :func: is the disambiguation.

> GDK-Doc seems smart enough to recognize start_if().  Sphinx isn't,
> because it's built around reST syntax.  We put our money on the Sphinx
> horse, so...
> 
>> I'm not sure if another annotations would work -- `start_if`() or
>> `start_if()`. Both seem kind of clunky to me, to be honest. Personal
>> feeling is "not really worth the hassle."
> 
> You later reported the latter works.
> 
> I prefer `start_if()` to `start_if`.  Matter of taste.
> 

Change made.

>>
>>>>    -    *args: any number of QAPIGenCCode
>>>> +    :param ifcond: List of conditionals
>>>> +    :param args: any number of `QAPIGenCCode`.
>>>>          Example::
>>>>    diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>>>> index 9d1a3e2eea9..02983979965 100644
>>>> --- a/scripts/qapi/parser.py
>>>> +++ b/scripts/qapi/parser.py
>>>> @@ -381,10 +381,11 @@ def append(self, line):
>>>>              The way that the line is dealt with depends on which
>>>> part of
>>>>            the documentation we're parsing right now:
>>>> -        * The body section: ._append_line is ._append_body_line
>>>> -        * An argument section: ._append_line is ._append_args_line
>>>> -        * A features section: ._append_line is ._append_features_line
>>>> -        * An additional section: ._append_line is ._append_various_line
>>>> +
>>>> +         * The body section: ._append_line is ._append_body_line
>>>> +         * An argument section: ._append_line is ._append_args_line
>>>> +         * A features section: ._append_line is ._append_features_line
>>>> +         * An additional section: ._append_line is ._append_various_line
>>>>            """
>>>>            line = line[1:]
>>>>            if not line:
>>> I understand why you insert a blank line (reST wants blank lines
>>> around
>>> lists), I don't understand why you indent.  Can you explain?
>>
>> I was mistaken about it needing the indent!
> 
> Easy enough to tidy up :)
> 

Already done!


