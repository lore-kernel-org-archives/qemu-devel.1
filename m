Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFEC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1972075E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIxSUZwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1972075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNQA-00038Z-95
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKNPD-0002aA-DY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:07:04 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKNP6-0001pZ-EG
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:07:03 -0400
Received: by mail-ej1-x642.google.com with SMTP id r7so18186290ejs.11
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EzBrNmX7/Hf0wq5PgA7z5ioDsM0oLZlQCZCSQrPkphw=;
 b=EIxSUZwCCgZor8MfqAb3Jl2iFGGeSqqwfwMTjBzOwFXFe4L/VANVu4RrYzXZboeYJ+
 40dyGm1JuV4lhDu1SSPmp+zjyd50RiS5AGPpjtnRKFnRtuV6Gu+8PGkXiMSgUwJoD/nX
 1TCwrZKMSzlMjZmlwU/7AN/502996NbZC/Z4F9kVfn/y7ObFVfUKLVu6naTh9D7LtSQD
 R/ElOVml2xH2okykEFyWYPUr8Q/blANAZ+LuqqjFaqh3El6ygeHCCvoPJz+jyv9Y41h3
 FQqKu8DJtaefkH434CJa3h7aQ/jxnZgPGqDw+NqKWp6O88/dEYHjMBr5pngzPgTMwgFe
 a9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EzBrNmX7/Hf0wq5PgA7z5ioDsM0oLZlQCZCSQrPkphw=;
 b=hFutYVNniVgPFnq4z3EekKOx/x1eSnjf96BwLDvCqPC6dCZsf6OfIaYZq0o0jdoHIM
 Fo1t3odQGlaP4OLF0qoA14hd67t8Z7FSUJ/kuz/IQ1yfE5Zhs3UovoQ5cJ0Jt28teu7r
 X6WRaAzj6qoTv8h6UTz7BflPcwYSzMri3DBNPt7xh0BBFAqDax/FFRZPbhrIqGUMNhJ8
 BNK115sHtsU5VK5KXTfWSTg5CHTpx3eXMQ/ZQPlJtYPX/zpvSX661lhOq88qGwZrfMKi
 DLIEFmKRwRDeUjqRm1hlZta8zjoZyPFVghERjTBxN3uybynrzGUETqyw6U7caVarXGuN
 BI0w==
X-Gm-Message-State: AOAM532a6uhXGEnS3xpio/KNJYADJdkUNNvoiFxqcfvEyegdvZgQOZfG
 IpwhWHg8T80lHxK2wDS/FbaEw0bZIim0n6J6HjRApw==
X-Google-Smtp-Source: ABdhPJwnx7gGszpAgRtKurM773dA58Zq03/Bo/wi+uYqr7+54LdTLvTE+BABqHORPCUXmBWFHgAPO9kxg58HVn0VWIY=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr49127482ejk.407.1600700814392; 
 Mon, 21 Sep 2020 08:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-9-peter.maydell@linaro.org>
 <87wo19c3rr.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo19c3rr.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 16:06:42 +0100
Message-ID: <CAFEAcA_LEKRON2EUUCfXoAXmTGQSrqvFG_waBf1S-tsn8fJ6bA@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] scripts/qapi/parser.py: improve doc comment
 indent handling
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Make the handling of indentation in doc comments more sophisticated,

> >          def append(self, line):
> > +            # Strip leading spaces corresponding to the expected indent level
> > +            # Blank lines are always OK.
> > +            if line:
> > +                spacecount = len(line) - len(line.lstrip(" "))
>
> Works, but I'd prefer
>
>                    indent = re.match(r'\s*', line).end()

OK.

> > +                if spacecount > self._indent:
> > +                    spacecount = self._indent
> > +                if spacecount < self._indent:
> > +                    raise QAPIParseError(self._parser, "unexpected de-indent")
>
> New error needs test coverage.  I append a possible test.
>
> Reporting the expected indentation might be helpful.

Fixed; new message produces reports like:
doc-bad-indent.json:6:1: unexpected de-indent (expected at least 4 spaces)

(I have not special-cased "1 spaces" -> "1 space"...)

> > +                line = line[spacecount:]
>
> If you use self._indent instead of spacecount here (which I find
> clearer), you don't need to cap spacecount at self._indent above.

Fixed.

> > +

> > @@ -460,7 +485,17 @@ class QAPIDoc:
> >
> >          if name.startswith('@') and name.endswith(':'):
> >              line = line[len(name)+1:]
> > -            self._start_features_section(name[1:-1])
> > +            if not line or line.isspace():
> > +                # Line is just the "@name:" header, no ident for following lines
>
> pycodestyle complains:
> scripts/qapi/parser.py:489:80: E501 line too long (80 > 79 characters)

Fixed.

> > +                indent = 0
> > +                line = ''
> > +            else:
> > +                # Line is "@arg: first line of description"; following
> > +                # lines should be indented by len(name) + 3, and we
> > +                # pad out this first line so it is handled the same way
> > +                indent = len(name) + 1
>
> Comment claims + 3, code uses + 1.

Yeah. This is because at this point 'name' is not actually just the
name "arg" but includes the leading '@' and trailing ':' so I got
confused between "we want the length of the name ("arg") plus 3"
and the expression you need to actually use. I got this right in the
comment in _append_args_line() but not in _append_features_line().
Will clarify (in both functions) to:

                # Line is "@arg: first line of description"; since 'name'
                # at this point is "@arg:" any following lines should be
                # indented by len(name) + 1. We pad out this first line
                # so it is handled the same way.

> Does this do the right thing when @arg: is followed by multiple
> whitespace characters?

The assumption is that if you added extra whitespace characters that's
because you wanted to specify a line of rST which starts with leading
spaces. So the handling here is that if you say

@foo:   bar
      baz

it's because you want the rST to be

  bar
baz

If this turns out to be invalid rST then the rST parser will
find that out later on.

As it happens I'm not sure whether there is any useful rST
syntax which has leading spaces and where you'd want to be able
to start an argument docstring with it, but it means we're
consistent with our handling of free-form doc comments, where
writing

   Foo
   bar

and writing

Foo
bar

are different things. Also with the change you suggest later
to avoid special-casing the "Examples" section then literal
text becomes an example of where it makes a difference.

> > +                line = ' ' * indent + line
> > +            self._start_features_section(name[1:-1], indent)
> >          elif self._is_section_tag(name):
> >              self._append_line = self._append_various_line
> >              self._append_various_line(line)
> > @@ -493,11 +528,23 @@ class QAPIDoc:
> >                                   % (name, self.sections[0].name))
> >          if self._is_section_tag(name):
> >              line = line[len(name)+1:]
> > -            self._start_section(name[:-1])
> > +            if not line or line.isspace():
> > +                # Line is just "SectionName:", no indent for following lines
> > +                indent = 0
> > +                line = ''
> > +            elif name.startswith("Example"):
> > +                # The "Examples" section is literal-text, so preserve
> > +                # all the indentation as-is
> > +                indent = 0
>
> Section "Example" is an exception.  Needs to be documented. Do we
> really need the exception?  As far as I can see, it's only ever used in
> documentation of block-latency-histogram-set.

Hmm, so you'd rather we changed the documentation of that
command so that instead of

# Example: remove all latency histograms:
#
# -> { "execute": "block-latency-histogram-set",
#      "arguments": { "id": "drive0" } }
# <- { "return": {} }

it would be

# Example:
# remove all latency histograms:
#
# -> { "execute": "block-latency-histogram-set",
#      "arguments": { "id": "drive0" } }
# <- { "return": {} }

and remove the special-case for "Example" so that if you did
write

Example: something on the same line
         more stuff here

it would be treated as literal text

something on the same line
more stuff here

?

Seems reasonable. (I think I put this special case in only
because I was trying to avoid changes to the existing doc
comments if it was easy to accommodate them in the parser.)
That command does seem to be the only outlier, so I've added
a patch to v6 which will fix up its documentation comment
and dropped the special casing.

> > +            else:
> > +                # Line is "SectionName: some text", indent required
>
> Same situation as above, much terser comment.

Fixed to use the expanded comment from earlier.

> > +                indent = len(name) + 1
> > +                line = ' ' * indent + line
> > +            self._start_section(name[:-1], indent)
> >
> >          self._append_freeform(line)

> > @@ -543,7 +590,7 @@ class QAPIDoc:
> >      def connect_member(self, member):
> >          if member.name not in self.args:
> >              # Undocumented TODO outlaw
> > -            self.args[member.name] = QAPIDoc.ArgSection(member.name)
> > +            self.args[member.name] = QAPIDoc.ArgSection(self._parser, member.name)
>
> pycodestyle complains:
> scripts/qapi/parser.py:593:80: E501 line too long (82 > 79 characters)

Fixed.

> >          self.args[member.name].connect(member)
> >
> >      def connect_feature(self, feature):
> > @@ -551,6 +598,8 @@ class QAPIDoc:
> >              raise QAPISemError(feature.info,
> >                                 "feature '%s' lacks documentation"
> >                                 % feature.name)
> > +            self.features[feature.name] = QAPIDoc.ArgSection(self._parser,
> > +                                                             feature.name)
>
> pylint points out:
> scripts/qapi/parser.py:601:12: W0101: Unreachable code (unreachable)
>

Yeah; this part of the patch used to be a "just update all the
callsites of QAPIDoc.ArgSection() to pass the extra argument"
hunk. It looks like your commit 8ec0e1a4e68781 removed this
callsite entirely as dead code, but I missed that in the rebase
and accidentally reintroduced the dead code. Fixed.

> Suggested new test doc-bad-deintent.json, cribbed from your PATCH 06 of
> doc-good.json:
>
> ##
> # @Alternate:
> # @i: an integer
> # @b is undocumented
> ##
> { 'alternate': 'Alternate',
>   'data': { 'i': 'int', 'b': 'bool' } }

The '@' at the front of the second line here is not relevant to
the mis-indentation and it's kind of confusing (as the correct
fix is "add a colon", not "reindent the line"), so I think I'd
rather have a test that's clearly looking at the indent:

# Multiline doc comments should have consistent indentation

##
# @foo:
# @a: line one
# line two is wrongly indented
##
{ 'command': 'foo', 'data': { 'a': 'int' } }

which expects the error:

doc-bad-indent.json:6:1: unexpected de-indent (expected at least 4 spaces)

thanks
-- PMM

