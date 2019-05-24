Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7683C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD7920851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD7920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCyo-0005gm-82
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:23:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUCnJ-0004bs-38
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUCnH-0001hR-6O
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:11:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hUCnC-0001dC-E8; Fri, 24 May 2019 12:11:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F32F43078AC9;
	Fri, 24 May 2019 16:11:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C7BD10027BF;
	Fri, 24 May 2019 16:11:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2F0291138648; Fri, 24 May 2019 18:11:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190517144232.18965-1-kwolf@redhat.com>
	<20190517144232.18965-5-kwolf@redhat.com>
Date: Fri, 24 May 2019 18:11:30 +0200
In-Reply-To: <20190517144232.18965-5-kwolf@redhat.com> (Kevin Wolf's message
	of "Fri, 17 May 2019 16:42:30 +0200")
Message-ID: <877eaf7ryl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 24 May 2019 16:11:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/6] qapi: Disentangle QAPIDoc code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Documentation comment follow a certain structure: First, we have a text
> with a general description (called QAPIDoc.body). After this,
> descriptions of the arguments follow. Finally, we have part that
> contains various named sections.
>
> The code doesn't show this structure but just checks the right side
> conditions so it happens to do the right set of things in the right

What are "side conditions"?

> phase. This is hard to follow, and adding support for documentation of
> features would be even harder.
>
> This restructures the code so that the three parts are clearly
> separated. The code becomes a bit longer, but easier to follow.

Recommend to mention that output remains unchanged.

>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  scripts/qapi/common.py | 107 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 83 insertions(+), 24 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 71944e2e30..1d0f4847db 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -120,6 +120,27 @@ class QAPIDoc(object):
>          def connect(self, member):
>              self.member = member
>  
> +    class SymbolPart:
> +        """
> +        Describes which part of the documentation we're parsing right now.

So SymbolPart is a part of the documentation.  Shouldn't it be named
DocPart then?

> +
> +        BODY means that we're ready to process freeform text into self.body. A

s/freeform/free-form/

> +        symbol name is only allowed if no other text was parsed yet. It is

Start your sentences with a capital letter.

> +        interpreted as the symbol name that describes the currently documented
> +        object. On getting the second symbol name, we proceed to ARGS.
> +
> +        ARGS means that we're parsing the arguments section. Any symbol name is
> +        interpreted as an argument and an ArgSection is created for it.
> +
> +        VARIOUS is the final part where freeform sections may appear. This
> +        includes named sections such as "Return:" as well as unnamed
> +        paragraphs. No symbols are allowed any more in this part.

s/any more/anymore/

Suggest "Symbols are not allowed anymore".

Only expression documentation blocks have these parts.  Free-form
documentation blocks don't.  Peeking ahead at the parent class's code:
we make the complete free-form doc block a BODY part, which is okay.

> +        """

Considering the dearth of doc strings in this code, criticizing yours
makes me feel bad, but here goes anyway.  This class is not about
parsing.  Pretty much all of the doc string really belongs to the parent
class, or maybe to its .append().  It may well also belong to
qapi-code-gen.txt section "Expression documentation".

Speaking of that section: it could use some love, to put it charitably.
Mind, I'm not asking you to give it your love ;)

Let me try to write a doc string that actually belongs here:

        """
        A documentation part.

        Expression documentation blocks consist of
        * a BODY part: first line naming the expression, plus an
          optional overview
        * an ARGS part: description of each argument (for commands and
          events) or member (for structs, unions and alternates),
        * a VARIOUS part: optional tagged sections.

        Free-form documentation blocks consist only of a BODY part.
        """

Could throw in a pointer to qapi-code-gen.txt.

This loses (useful!) documentation on how we interpret "symbol names".
Should move to the code that actually deals with them.

> +        # Can't make it a subclass of Enum because of Python 2

Thanks for documenting Python 2 contortions!  Let's phrase it as a TODO
comment.

> +        BODY = 0

Any particular reason for 0?

As far as I can tell, Python enum values commonly start with 1, to make
them all true.

> +        ARGS = 1
> +        VARIOUS = 2
> +
>      def __init__(self, parser, info):
>          # self._parser is used to report errors with QAPIParseError.  The
>          # resulting error position depends on the state of the parser.
> @@ -135,6 +156,7 @@ class QAPIDoc(object):
>          self.sections = []
>          # the current section
>          self._section = self.body
> +        self._part = QAPIDoc.SymbolPart.BODY

The right hand side is tiresome, but I don't have better ideas.

>  
>      def has_section(self, name):
>          """Return True if we have a section with this name."""
> @@ -154,37 +176,84 @@ class QAPIDoc(object):
       def append(self, line):
           """Parse a comment line and add it to the documentation."""
           line = line[1:]
           if not line:
               self._append_freeform(line)
               return

           if line[0] != ' ':
>              raise QAPIParseError(self._parser, "Missing space after #")
>          line = line[1:]
>  
> +        if self._part == QAPIDoc.SymbolPart.BODY:
> +            self._append_body_line(line)
> +        elif self._part == QAPIDoc.SymbolPart.ARGS:
> +            self._append_args_line(line)
> +        elif self._part == QAPIDoc.SymbolPart.VARIOUS:
> +            self._append_various_line(line)
> +        else:
> +            assert False

Hmm.  As far as I can tell, this what we use ._part for.  All other
occurences assign to it.

If you replace

    self._part = QAPIDoc.SymbolPart.BODY

by

    self._append_line = self._append_body_line

and so forth, then the whole conditional shrinks to

    self._append_line(line)

and we don't have to muck around with enums.

> +
> +

pycodestyle-3 gripes:

    scripts/qapi/common.py:196:5: E303 too many blank lines (2)

> +    def end_comment(self):
> +        self._end_section()
> +
> +    def _check_named_section(self, line, name):
> +        if name in ('Returns:', 'Since:',
> +                    # those are often singular or plural
> +                    'Note:', 'Notes:',
> +                    'Example:', 'Examples:',
> +                    'TODO:'):
> +            self._part = QAPIDoc.SymbolPart.VARIOUS

Hiding such a side effect in a _check_FOO() function isn't so nice, but
considering the code you're cleaning up, you got a fairly generous "not
so nice" allowance to spend.  No need to do anything.

> +            return True
> +        return False

@line is unused.

> +
> +    def _append_body_line(self, line):
> +        name = line.split(' ', 1)[0]
>          # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
>          # recognized, and get silently treated as ordinary text
> -        if self.symbol:
> -            self._append_symbol_line(line)
> -        elif not self.body.text and line.startswith('@'):
> +        if not self.symbol and not self.body.text and line.startswith('@'):
>              if not line.endswith(':'):
>                  raise QAPIParseError(self._parser, "Line should end with :")
>              self.symbol = line[1:-1]
>              # FIXME invalid names other than the empty string aren't flagged
>              if not self.symbol:
>                  raise QAPIParseError(self._parser, "Invalid name")
> +        elif self.symbol:
> +            # We already know that we document some symbol
> +            if name.startswith('@') and name.endswith(':'):
> +                self._part = QAPIDoc.SymbolPart.ARGS
> +                self._append_args_line(line)
> +            elif self.symbol and self._check_named_section(line, name):
> +                self._append_various_line(line)
> +            else:
> +                self._append_freeform(line.strip())
>          else:
> -            self._append_freeform(line)
> -
> -    def end_comment(self):
> -        self._end_section()
> +            # This is free-form documentation without a symbol
> +            self._append_freeform(line.strip())
>  
> -    def _append_symbol_line(self, line):
> +    def _append_args_line(self, line):
>          name = line.split(' ', 1)[0]
>  
>          if name.startswith('@') and name.endswith(':'):
>              line = line[len(name)+1:]
>              self._start_args_section(name[1:-1])
> -        elif name in ('Returns:', 'Since:',
> -                      # those are often singular or plural
> -                      'Note:', 'Notes:',
> -                      'Example:', 'Examples:',
> -                      'TODO:'):
> +        elif self._check_named_section(line, name):
> +            return self._append_various_line(line)

Here you return something, and...

> +        elif (self._section.text.endswith('\n\n')
> +              and line and not line[0].isspace()):
> +            self._start_section()
> +            self._part = QAPIDoc.SymbolPart.VARIOUS
> +            return self._append_various_line(line)

... also here, but ...

> +
> +        self._append_freeform(line.strip())

... not here.

> +
> +    def _append_various_line(self, line):
> +        name = line.split(' ', 1)[0]
> +
> +        if name.startswith('@') and name.endswith(':'):
> +            raise QAPIParseError(self._parser,
> +                                 "'%s' can't follow '%s' section"
> +                                 % (name, self.sections[0].name))
> +        elif self._check_named_section(line, name):
>              line = line[len(name)+1:]
>              self._start_section(name[:-1])
>  
> +        if (not self._section.name or
> +            not self._section.name.startswith('Example')):

pycodestyle-3 gripes:

    scripts/qapi/common.py:283:13: E129 visually indented line with same indent as next logical line

Fix like this:

           if (not self._section.name
                   or not self._section.name.startswith('Example')):

> +            line = line.strip()
> +
>          self._append_freeform(line)
>  
>      def _start_args_section(self, name):
> @@ -194,10 +263,7 @@ class QAPIDoc(object):
>          if name in self.args:
>              raise QAPIParseError(self._parser,
>                                   "'%s' parameter name duplicated" % name)
> -        if self.sections:
> -            raise QAPIParseError(self._parser,
> -                                 "'@%s:' can't follow '%s' section"
> -                                 % (name, self.sections[0].name))
> +        assert not self.sections
>          self._end_section()
>          self._section = QAPIDoc.ArgSection(name)
>          self.args[name] = self._section
> @@ -219,13 +285,6 @@ class QAPIDoc(object):
>              self._section = None
>  
>      def _append_freeform(self, line):
> -        in_arg = isinstance(self._section, QAPIDoc.ArgSection)
> -        if (in_arg and self._section.text.endswith('\n\n')
> -                and line and not line[0].isspace()):
> -            self._start_section()
> -        if (in_arg or not self._section.name
> -                or not self._section.name.startswith('Example')):
> -            line = line.strip()
>          match = re.match(r'(@\S+:)', line)
>          if match:
>              raise QAPIParseError(self._parser,

The patch is hard to read (not your fault).  I mostly reviewed the
result instead.

