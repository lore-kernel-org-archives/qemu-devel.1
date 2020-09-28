Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDE0C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 19:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5D220719
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebOx+hg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5D220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMyeg-0003Ez-GF
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 15:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMydA-0002hL-Jl
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 15:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMyd5-00080E-CR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 15:16:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601320565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2htF4tIUalmgiMd+fjvED40Bfau6xvMYt+YoPQciekE=;
 b=ebOx+hg4UIT9uJpYPG3DqXutenPSwW/LinamDoUpS+vKmvOsS+yxefRcRZb4q6NnUkWG4b
 sK3syuy/itFKnjAbKtaHIBEgAfpKOxqwCxGQufx5J3oriDuvthZrNTuExzA+u0Jpcr0iA6
 JzjqTvw4dgK43OE5ftioGoQCB8JantY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-5Qw13wmeNdqbktMTDE1-yQ-1; Mon, 28 Sep 2020 15:15:30 -0400
X-MC-Unique: 5Qw13wmeNdqbktMTDE1-yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C34C1084C84;
 Mon, 28 Sep 2020 19:15:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F3B95C1BD;
 Mon, 28 Sep 2020 19:15:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D1AC113865F; Mon, 28 Sep 2020 21:15:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 05/21] scripts/qapi/parser.py: improve doc comment
 indent handling
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-6-peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 21:15:27 +0200
In-Reply-To: <20200925162316.21205-6-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:00 +0100")
Message-ID: <874knhbtm8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Make the handling of indentation in doc comments more sophisticated,
> so that when we see a section like:
>
> Notes: some text
>        some more text
>           indented line 3
>
> we save it for the doc-comment processing code as:
>
> some text
> some more text
>    indented line 3
>
> and when we see a section with the heading on its own line:
>
> Notes:
>
> some text
> some more text
>    indented text
>
> we also accept that and save it in the same form.
>
> If we detect that the comment document text is not indented as much
> as we expect it to be, we throw a parse error.  (We don't complain
> about over-indented sections, because for rST this can be legitimate
> markup.)
>
> The golden reference for the doc comment text is updated to remove
> the two 'wrong' indents; these now form a test case that we correctly
> stripped leading whitespace from an indented multi-line argument
> definition.
>
> We update the documentation in docs/devel/qapi-code-gen.txt to
> describe the new indentation rules.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/qapi-code-gen.txt          | 23 +++++++
>  scripts/qapi/parser.py                | 93 +++++++++++++++++++++------
>  tests/qapi-schema/doc-bad-indent.err  |  1 +
>  tests/qapi-schema/doc-bad-indent.json |  8 +++
>  tests/qapi-schema/doc-bad-indent.out  |  0
>  tests/qapi-schema/doc-good.out        |  4 +-
>  tests/qapi-schema/meson.build         |  1 +
>  7 files changed, 109 insertions(+), 21 deletions(-)
>  create mode 100644 tests/qapi-schema/doc-bad-indent.err
>  create mode 100644 tests/qapi-schema/doc-bad-indent.json
>  create mode 100644 tests/qapi-schema/doc-bad-indent.out
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 9eede44350c..69eaffac376 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -901,6 +901,22 @@ commands and events), member (for structs and unions), branch (for
>  alternates), or value (for enums), and finally optional tagged
>  sections.
>  
> +Descriptions of arguments can span multiple lines. The description
> +text can start on the line following the '@argname:', in which case
> +it must not be indented at all. It can also start on the same line
> +as the '@argname:'. In this case if it spans multiple lines then
> +second and subsequent lines must be indented to line up with the
> +first character of the first line of the description:

Please put two spaces after sentence-ending punctuation, for local
consistency, and to keep Emacs sentence commands working.

Can touch this up in my tree, of course.

> +
> +# @argone:
> +# This is a two line description
> +# in the first style.
> +#
> +# @argtwo: This is a two line description
> +#          in the second style.
> +
> +The number of spaces between the ':' and the text is not significant.
> +
>  FIXME: the parser accepts these things in almost any order.
>  FIXME: union branches should be described, too.
>  
> @@ -911,6 +927,13 @@ A tagged section starts with one of the following words:
>  "Note:"/"Notes:", "Since:", "Example"/"Examples", "Returns:", "TODO:".
>  The section ends with the start of a new section.
>  
> +The text of a section can start on a new line, in
> +which case it must not be indented at all.  It can also start
> +on the same line as the 'Note:', 'Returns:', etc tag.  In this
> +case if it spans multiple lines then second and subsequent
> +lines must be indented to match the first, in the same way as
> +multiline argument descriptions.
> +
>  A 'Since: x.y.z' tagged section lists the release that introduced the
>  definition.
>  
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 04bf10db378..6c3455b41f3 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -319,17 +319,32 @@ class QAPIDoc:
>      """
>  
>      class Section:
> -        def __init__(self, name=None):
> +        def __init__(self, parser, name=None, indent=0):
> +            # parser, for error messages about indentation
> +            self._parser = parser
>              # optional section name (argument/member or section name)
>              self.name = name
>              self.text = ''
> +            # the expected indent level of the text of this section
> +            self._indent = indent
>  
>          def append(self, line):
> +            # Strip leading spaces corresponding to the expected indent level
> +            # Blank lines are always OK.
> +            if line:
> +                indent = re.match(r'\s*', line).end()
> +                if indent < self._indent:
> +                    raise QAPIParseError(
> +                        self._parser,
> +                        "unexpected de-indent (expected at least %d spaces)" %
> +                        self._indent)
> +                line = line[self._indent:]
> +
>              self.text += line.rstrip() + '\n'
>  
>      class ArgSection(Section):
> -        def __init__(self, name):
> -            super().__init__(name)
> +        def __init__(self, parser, name, indent=0):
> +            super().__init__(parser, name, indent)
>              self.member = None
>  
>          def connect(self, member):
> @@ -343,7 +358,7 @@ class QAPIDoc:
>          self._parser = parser
>          self.info = info
>          self.symbol = None
> -        self.body = QAPIDoc.Section()
> +        self.body = QAPIDoc.Section(parser)
>          # dict mapping parameter name to ArgSection
>          self.args = OrderedDict()
>          self.features = OrderedDict()
> @@ -447,8 +462,21 @@ class QAPIDoc:
>          name = line.split(' ', 1)[0]
>  
>          if name.startswith('@') and name.endswith(':'):
> -            line = line[len(name)+1:]
> -            self._start_args_section(name[1:-1])
> +            # If line is "@arg:   first line of description", find the
> +            # index of 'f', which is the indent we expect for any
> +            # following lines. We then remove the leading "@arg:" from line

PEP 8: You should use two spaces after a sentence-ending period in
multi-sentence comments, except after the final sentence.

More of the same below.  Can touch it up in my tree.

> +            # and replace it with spaces so that 'f' has the same index
> +            # as it did in the original line and can be handled the same
> +            # way we will handle following lines.
> +            indent = re.match(r'@\S*:\s*', line).end()
> +            line = line[indent:]
> +            if not line:
> +                # Line was just the "@arg:" header; following lines
> +                # are not indented
> +                indent = 0
> +            else:
> +                line = ' ' * indent + line
> +            self._start_args_section(name[1:-1], indent)
>          elif self._is_section_tag(name):
>              self._append_line = self._append_various_line
>              self._append_various_line(line)
> @@ -469,8 +497,21 @@ class QAPIDoc:
>          name = line.split(' ', 1)[0]
>  
>          if name.startswith('@') and name.endswith(':'):
> -            line = line[len(name)+1:]
> -            self._start_features_section(name[1:-1])
> +            # If line is "@arg:   first line of description", find the
> +            # index of 'f', which is the indent we expect for any
> +            # following lines. We then remove the leading "@arg:" from line
> +            # and replace it with spaces so that 'f' has the same index
> +            # as it did in the original line and can be handled the same
> +            # way we will handle following lines.
> +            indent = re.match(r'@\S*:\s*', line).end()
> +            line = line[indent:]
> +            if not line:
> +                # Line was just the "@arg:" header; following lines
> +                # are not indented
> +                indent = 0
> +            else:
> +                line = ' ' * indent + line
> +            self._start_features_section(name[1:-1], indent)
>          elif self._is_section_tag(name):
>              self._append_line = self._append_various_line
>              self._append_various_line(line)
> @@ -502,12 +543,25 @@ class QAPIDoc:
>                                   "'%s' can't follow '%s' section"
>                                   % (name, self.sections[0].name))
>          if self._is_section_tag(name):
> -            line = line[len(name)+1:]
> -            self._start_section(name[:-1])
> +            # If line is "Section:   first line of description", find the
> +            # index of 'f', which is the indent we expect for any
> +            # following lines. We then remove the leading "Section:" from line
> +            # and replace it with spaces so that 'f' has the same index
> +            # as it did in the original line and can be handled the same
> +            # way we will handle following lines.
> +            indent = re.match(r'\S*:\s*', line).end()
> +            line = line[indent:]
> +            if not line:
> +                # Line was just the "Section:" header; following lines
> +                # are not indented
> +                indent = 0
> +            else:
> +                line = ' ' * indent + line

We may want to de-triplicate.  Not today.

> +            self._start_section(name[:-1], indent)
>  
>          self._append_freeform(line)
>  
> -    def _start_symbol_section(self, symbols_dict, name):
> +    def _start_symbol_section(self, symbols_dict, name, indent):
>          # FIXME invalid names other than the empty string aren't flagged
>          if not name:
>              raise QAPIParseError(self._parser, "invalid parameter name")
> @@ -516,21 +570,21 @@ class QAPIDoc:
>                                   "'%s' parameter name duplicated" % name)
>          assert not self.sections
>          self._end_section()
> -        self._section = QAPIDoc.ArgSection(name)
> +        self._section = QAPIDoc.ArgSection(self._parser, name, indent)
>          symbols_dict[name] = self._section
>  
> -    def _start_args_section(self, name):
> -        self._start_symbol_section(self.args, name)
> +    def _start_args_section(self, name, indent):
> +        self._start_symbol_section(self.args, name, indent)
>  
> -    def _start_features_section(self, name):
> -        self._start_symbol_section(self.features, name)
> +    def _start_features_section(self, name, indent):
> +        self._start_symbol_section(self.features, name, indent)
>  
> -    def _start_section(self, name=None):
> +    def _start_section(self, name=None, indent=0):
>          if name in ('Returns', 'Since') and self.has_section(name):
>              raise QAPIParseError(self._parser,
>                                   "duplicated '%s' section" % name)
>          self._end_section()
> -        self._section = QAPIDoc.Section(name)
> +        self._section = QAPIDoc.Section(self._parser, name, indent)
>          self.sections.append(self._section)
>  
>      def _end_section(self):
> @@ -553,7 +607,8 @@ class QAPIDoc:
>      def connect_member(self, member):
>          if member.name not in self.args:
>              # Undocumented TODO outlaw
> -            self.args[member.name] = QAPIDoc.ArgSection(member.name)
> +            self.args[member.name] = QAPIDoc.ArgSection(self._parser,
> +                                                        member.name)
>          self.args[member.name].connect(member)
>  
>      def connect_feature(self, feature):
> diff --git a/tests/qapi-schema/doc-bad-indent.err b/tests/qapi-schema/doc-bad-indent.err
> new file mode 100644
> index 00000000000..67844539bd2
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-indent.err
> @@ -0,0 +1 @@
> +doc-bad-indent.json:6:1: unexpected de-indent (expected at least 4 spaces)
> diff --git a/tests/qapi-schema/doc-bad-indent.json b/tests/qapi-schema/doc-bad-indent.json
> new file mode 100644
> index 00000000000..edde8f21dc7
> --- /dev/null
> +++ b/tests/qapi-schema/doc-bad-indent.json
> @@ -0,0 +1,8 @@
> +# Multiline doc comments should have consistent indentation
> +
> +##
> +# @foo:
> +# @a: line one
> +# line two is wrongly indented
> +##
> +{ 'command': 'foo', 'data': { 'a': 'int' } }
> diff --git a/tests/qapi-schema/doc-bad-indent.out b/tests/qapi-schema/doc-bad-indent.out
> new file mode 100644
> index 00000000000..e69de29bb2d
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 9993ffcd89d..b7e3f4313da 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -159,7 +159,7 @@ doc symbol=Alternate
>  
>      arg=i
>  an integer
> -    @b is undocumented
> +@b is undocumented
>      arg=b
>  
>      feature=alt-feat
> @@ -174,7 +174,7 @@ doc symbol=cmd
>  the first argument
>      arg=arg2
>  the second
> -       argument
> +argument
>      arg=arg3
>  
>      feature=cmd-feat1
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index f1449298b07..83a0a68389b 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -53,6 +53,7 @@ schemas = [
>    'doc-bad-enum-member.json',
>    'doc-bad-event-arg.json',
>    'doc-bad-feature.json',
> +  'doc-bad-indent.json',
>    'doc-bad-section.json',
>    'doc-bad-symbol.json',
>    'doc-bad-union-member.json',

With trivial whitespace touch-ups:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


