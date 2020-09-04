Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A76C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134AD20748
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134AD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE7eE-0000Ce-7y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kE7dQ-0007Yn-Gg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:03:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kE7dL-0000AA-V3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:03:52 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-3rIhK3wTN7uQrsNTMxgZqA-1; Fri, 04 Sep 2020 05:03:39 -0400
X-MC-Unique: 3rIhK3wTN7uQrsNTMxgZqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABC978712FE;
 Fri,  4 Sep 2020 09:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 341BC2D07D;
 Fri,  4 Sep 2020 09:03:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7F4B1132B59; Fri,  4 Sep 2020 11:03:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 08/20] scripts/qapi/parser.py: improve doc comment
 indent handling
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-9-peter.maydell@linaro.org>
Date: Fri, 04 Sep 2020 11:03:36 +0200
In-Reply-To: <20200810195019.25427-9-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Aug 2020 20:50:07 +0100")
Message-ID: <87wo19c3rr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
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
> The exception is that we always retain indentation as-is for Examples
> sections, because these are literal text.

Does docs/devel/qapi-code-gen.txt need an update?  Hmm, looks like you
leave it to [PATCH 15] docs/devel/qapi-code-gen.txt: Update to new rST
backend conventions.  Acceptable.  Mentioning it in the commit message
now may make sense.

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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: Update doc-good.out as per final para.
> ---
>  scripts/qapi/parser.py         | 81 +++++++++++++++++++++++++++-------
>  tests/qapi-schema/doc-good.out |  4 +-
>  2 files changed, 67 insertions(+), 18 deletions(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 7fae4478d34..d9f11eadd96 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -308,18 +308,32 @@ class QAPIDoc:
>      """
>  
>      class Section:
> -        def __init__(self, name=None):
> +        def __init__(self, parser, name=None, indent=0):
> +            # parser, for error messages about indentation
> +            self._parser = parser
>              # optional section name (argument/member or section name)
>              self.name = name
>              # the list of lines for this section
>              self.text = ''
> +            # the expected indent level of the text of this section
> +            self._indent = indent
>  
>          def append(self, line):
> +            # Strip leading spaces corresponding to the expected indent level
> +            # Blank lines are always OK.
> +            if line:
> +                spacecount = len(line) - len(line.lstrip(" "))

Works, but I'd prefer

                   indent = re.match(r'\s*', line).end()

> +                if spacecount > self._indent:
> +                    spacecount = self._indent
> +                if spacecount < self._indent:
> +                    raise QAPIParseError(self._parser, "unexpected de-indent")

New error needs test coverage.  I append a possible test.

Reporting the expected indentation might be helpful.

> +                line = line[spacecount:]

If you use self._indent instead of spacecount here (which I find
clearer), you don't need to cap spacecount at self._indent above.

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
> @@ -333,7 +347,7 @@ class QAPIDoc:
>          self._parser = parser
>          self.info = info
>          self.symbol = None
> -        self.body = QAPIDoc.Section()
> +        self.body = QAPIDoc.Section(parser)
>          # dict mapping parameter name to ArgSection
>          self.args = OrderedDict()
>          self.features = OrderedDict()
> @@ -438,7 +452,18 @@ class QAPIDoc:
>  
>          if name.startswith('@') and name.endswith(':'):
>              line = line[len(name)+1:]
> -            self._start_args_section(name[1:-1])
> +            if not line or line.isspace():
> +                # Line was just the "@arg:" header; following lines
> +                # are not indented
> +                indent = 0
> +                line = ''
> +            else:
> +                # Line is "@arg: first line of description"; following
> +                # lines should be indented by len(name) + 1, and we
> +                # pad out this first line so it is handled the same way
> +                indent = len(name) + 1
> +                line = ' ' * indent + line
> +            self._start_args_section(name[1:-1], indent)
>          elif self._is_section_tag(name):
>              self._append_line = self._append_various_line
>              self._append_various_line(line)
> @@ -460,7 +485,17 @@ class QAPIDoc:
>  
>          if name.startswith('@') and name.endswith(':'):
>              line = line[len(name)+1:]
> -            self._start_features_section(name[1:-1])
> +            if not line or line.isspace():
> +                # Line is just the "@name:" header, no ident for following lines

pycodestyle complains:
scripts/qapi/parser.py:489:80: E501 line too long (80 > 79 characters)

> +                indent = 0
> +                line = ''
> +            else:
> +                # Line is "@arg: first line of description"; following
> +                # lines should be indented by len(name) + 3, and we
> +                # pad out this first line so it is handled the same way
> +                indent = len(name) + 1

Comment claims + 3, code uses + 1.

Does this do the right thing when @arg: is followed by multiple
whitespace characters?

> +                line = ' ' * indent + line
> +            self._start_features_section(name[1:-1], indent)
>          elif self._is_section_tag(name):
>              self._append_line = self._append_various_line
>              self._append_various_line(line)
> @@ -493,11 +528,23 @@ class QAPIDoc:
>                                   % (name, self.sections[0].name))
>          if self._is_section_tag(name):
>              line = line[len(name)+1:]
> -            self._start_section(name[:-1])
> +            if not line or line.isspace():
> +                # Line is just "SectionName:", no indent for following lines
> +                indent = 0
> +                line = ''
> +            elif name.startswith("Example"):
> +                # The "Examples" section is literal-text, so preserve
> +                # all the indentation as-is
> +                indent = 0

Section "Example" is an exception.  Needs to be documented.  Do we
really need the exception?  As far as I can see, it's only ever used in
documentation of block-latency-histogram-set.

> +            else:
> +                # Line is "SectionName: some text", indent required

Same situation as above, much terser comment.

> +                indent = len(name) + 1
> +                line = ' ' * indent + line
> +            self._start_section(name[:-1], indent)
>  
>          self._append_freeform(line)
>  
> -    def _start_symbol_section(self, symbols_dict, name):
> +    def _start_symbol_section(self, symbols_dict, name, indent):
>          # FIXME invalid names other than the empty string aren't flagged
>          if not name:
>              raise QAPIParseError(self._parser, "invalid parameter name")
> @@ -506,21 +553,21 @@ class QAPIDoc:
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
> @@ -543,7 +590,7 @@ class QAPIDoc:
>      def connect_member(self, member):
>          if member.name not in self.args:
>              # Undocumented TODO outlaw
> -            self.args[member.name] = QAPIDoc.ArgSection(member.name)
> +            self.args[member.name] = QAPIDoc.ArgSection(self._parser, member.name)

pycodestyle complains:
scripts/qapi/parser.py:593:80: E501 line too long (82 > 79 characters)


>          self.args[member.name].connect(member)
>  
>      def connect_feature(self, feature):
> @@ -551,6 +598,8 @@ class QAPIDoc:
>              raise QAPISemError(feature.info,
>                                 "feature '%s' lacks documentation"
>                                 % feature.name)
> +            self.features[feature.name] = QAPIDoc.ArgSection(self._parser,
> +                                                             feature.name)

pylint points out:
scripts/qapi/parser.py:601:12: W0101: Unreachable code (unreachable)

>          self.features[feature.name].connect(feature)
>  
>      def check_expr(self, expr):
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 0ef85d959ac..bbf77b08dc3 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -158,7 +158,7 @@ doc symbol=Alternate
>  
>      arg=i
>  an integer
> -    @b is undocumented
> +@b is undocumented
>      arg=b
>  
>      feature=alt-feat
> @@ -173,7 +173,7 @@ doc symbol=cmd
>  the first argument
>      arg=arg2
>  the second
> -       argument
> +argument
>      arg=arg3
>  
>      feature=cmd-feat1


Suggested new test doc-bad-deintent.json, cribbed from your PATCH 06 of
doc-good.json:

##
# @Alternate:
# @i: an integer
# @b is undocumented
##
{ 'alternate': 'Alternate',
  'data': { 'i': 'int', 'b': 'bool' } }


