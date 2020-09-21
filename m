Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82228C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDFB221E2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPW6b8Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDFB221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQRT-00053r-J9
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKQDQ-0001Tq-Ru
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:07:05 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKQDO-0003TB-39
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:07:04 -0400
Received: by mail-ed1-x541.google.com with SMTP id i1so13794935edv.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 11:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GMvy+gWM6y9yIsgY3HZJtHgwt5judrIANF5jWA/zOTE=;
 b=TPW6b8WhUxchzp2GZbpx/iW95Z6DISWMRQWK49b3GuOSvICJNmunvDhupyuJrgRIjl
 NTSyEUB80isIGF9RTVQao1o23H0y4IdT+qbsna6lV0ozv9m4KCAKu493WujRsKGD5NlI
 Ceq7JnTGia8NvxRYkZ8inLSi7d1wWkovQKJRGZFTBxXXQV7VFQvN8RKHDN9IIcjB5Xgl
 o48GsgvhQFuLIdZ+TuP2Gbj9ZuBfsERNS1RshYTIeWQ3kWaErBREk8FQGoEl8YxMN5o6
 G+eE7LWqoDLeaMTd08N9mGqsBbp7XhXw7U+TwY43/J7U1NJMI12O3XEsTP9SCBFtDqv0
 UukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GMvy+gWM6y9yIsgY3HZJtHgwt5judrIANF5jWA/zOTE=;
 b=ljurYSusellflV3ZMLX0TiZY2LA9OWCl+RRwmp3TE2LfISMCW4EaIZBI/94ZSodVlB
 rnWliFlCiPATSA5uFBG19uHrPBuIPg9QSfGq4gm9kPTT1U52L+M0czwhrxb9tdT4SvuV
 oGUngIgXOeYxUmiD4y9mpyFS5YSGSEEHZxoutaI0rRyVMIU1w0WfCfjIFgQwIyG8ssb0
 y38Z2O6kYOW3MTxlIaJ+FfG3eENLydY+X+SAxgsgB8dlypqO5q0PXVb9eV7JgpizBCkW
 /V7F20Fp6WdFn6ALDEhIPGb3p4BM3FUMsQdQIC5pQYvz0SBx/4lAUMxXnfxskzpCg2hK
 dnVQ==
X-Gm-Message-State: AOAM531FNtr9G3wydpCx3gCHlSPZynTjyGOD1lE8tkkyWSHXsqYnMRkH
 8WI9Uud1IMkJDJa6KW+BVm1vs8PYbYtvrKUi5J1bsA==
X-Google-Smtp-Source: ABdhPJzVrBotfcIlVYMJRSNrc35umpZKf2jOFCV4hYn2cZR0AhipjBpAM/n0gdom8vScoFmW2Ot4ffs/Bu2RQczNbGI=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr187404edb.36.1600711617966; 
 Mon, 21 Sep 2020 11:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <875z8t913t.fsf@dusky.pond.sub.org>
In-Reply-To: <875z8t913t.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 19:06:46 +0100
Message-ID: <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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

On Fri, 4 Sep 2020 at 13:29, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Some of our documentation is auto-generated from documentation
> > comments in the JSON schema.
> >
> > For Sphinx, rather than creating a file to include, the most natural
> > way to handle this is to have a small custom Sphinx extension which
> > processes the JSON file and inserts documentation into the rST
> > file being processed.
> >
> > This is the same approach that kerneldoc and hxtool use.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Got a pointer to "Writing Sphinx Extensions for Dummies" or similar?

The upstream documentation on extending Sphinx is probably
a good place to start; in particular the tutorials are useful:

https://www.sphinx-doc.org/en/master/development/index.html

I have also found that a fair amount of trial-and-error,
examination of the source of Sphinx itself or of other
extensions, and occasionally asking questions on the Sphinx
mailing list has been necessary...

> > --- /dev/null
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -0,0 +1,504 @@
> > +# coding=utf-8
> > +#
> > +# QEMU qapidoc QAPI file parsing extension
> > +#
> > +# Copyright (c) 2020 Linaro
> > +#
> > +# This work is licensed under the terms of the GNU GPLv2 or later.
> > +# See the COPYING file in the top-level directory.
> > +"""qapidoc is a Sphinx extension that implements the qapi-doc directive"""
> > +
> > +# The purpose of this extension is to read the documentation comments
> > +# in QAPI JSON schema files, and insert them all into the current document.
>
> Let's drop "JSON", it's not really true.

Fixed.

> > +# The conf.py file must set the qapidoc_srctree config value to
> > +# the root of the QEMU source tree.
> > +# Each qapi-doc:: directive takes one argument which is the
> > +# path of the .json file to process, relative to the source tree.
>
> Beg your pardon?  Oh, you're talking about .rst files now.  The next two
> patches will add such files.  Perhaps something like "The qapi-doc::
> reST directive provided by this extension takes ..."

OK, how about:

# The purpose of this extension is to read the documentation comments
# in QAPI schema files, and insert them all into the current document.
#
# It implements one new rST directive, "qapi-doc::".
# Each qapi-doc:: directive takes one argument, which is the
# path of the .json file to process, relative to the source tree.
#
# The docs/conf.py file must set the qapidoc_srctree config value to
# the root of the QEMU source tree.

?

> > +# Function borrowed from pydash, which is under the MIT license
> > +def intersperse(iterable, separator):
> > +    """Like join, but for arbitrary iterables, notably arrays"""
> > +    iterable = iter(iterable)
> > +    yield next(iterable)
> > +    for item in iterable:
> > +        yield separator
> > +        yield item
>
> What's wrong with separator.join(iterable)?

It doesn't work on all the things we'd like to intersperse().
If you try defining intersperse as

def intersperse(iterable, separator):
    separator.join(iterable)

then you get an exception:

  File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/../scripts/qapi/schema.py",
line 445, in visit
    self.base, self.local_members, self.variants)
  File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/sphinx/qapidoc.py",
line 314, in visit_object_type
    [self._nodes_for_members(doc, 'Members', base, variants),
  File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/sphinx/qapidoc.py",
line 173, in _nodes_for_members
    nodes.Text(', ')))
  File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/sphinx/qapidoc.py",
line 53, in intersperse
    separator.join(iterable)
TypeError: sequence item 0: expected str instance, literal found

> > +
> > +class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
> > +    """A QAPI schema visitor which generates docutils/Sphinx nodes
> > +
> > +    This class builds up a tree of docutils/Sphinx nodes corresponding
> > +    to documentation for the various QAPI objects. To use it, first create
> > +    a QAPISchemaGenRSTVisitor object, and call its visit_begin() method.
> > +    Then you can call one of the two methods 'freeform' (to add documentation
> > +    for a freeform documentation chunk) or 'symbol' (to add documentation
> > +    for a QAPI symbol). These will cause the visitor to build up the
> > +    tree of document nodes. Once you've added all the documentation
> > +    via 'freeform' and 'symbol' method calls, you can call 'get_document_nodes'
> > +    to get the final list of document nodes (in a form suitable for returning
> > +    from a Sphinx directive's 'run' method).
> > +    """
> > +    def __init__(self, sphinx_directive):
> > +        self._cur_doc = None
> > +        self._sphinx_directive = sphinx_directive
> > +        self._top_node = nodes.section()
> > +        self._active_headings = [self._top_node]
> > +
> > +    def _serror(self, msg):
> > +        """Raise an exception giving a user-friendly syntax error message"""
> > +        file = self._cur_doc.info.fname
> > +        line = self._cur_doc.info.line
> > +        raise ExtensionError('%s line %d: syntax error: %s' % (file, line, msg))
>
> Note for later: ornate error message format, no use of QAPISourceInfo.
>
> > +

> > +
> > +    def _nodes_for_enum_values(self, doc, what):
>
> @what is only ever 'Values', isn't it?

Yes. I think this was a legacy from conversion from scripts/qapi/doc.py,
which does pass in a 'Values' string, but it does that because it shares
code in texi_members() between enums and other things. In this code
I chose to split that out into different functions rather than using
one function with a member_func argument because the member vs enum
code is different enough that it's clearer that way. But I didn't
notice that there wasn't any longer much point in passing a 'what'
argument.

Fixed to hard-code 'Values' rather than passing it as an argument.

> > +    def _nodes_for_sections(self, doc, ifcond):
> > +        """Return doctree nodes for additional sections following arguments"""
> > +        nodelist = []
> > +        for section in doc.sections:
> > +            snode = self._make_section(section.name)
> > +            if section.name and section.name.startswith('Example'):
> > +                snode += self._nodes_for_example(section.text)
> > +            else:
> > +                self._parse_text_into_node(section.text, snode)
> > +            nodelist.append(snode)
> > +        if ifcond:
> > +            snode = self._make_section('If')
> > +            snode += self._nodes_for_ifcond(ifcond, with_if=False)
> > +            nodelist.append(snode)
>
> I think I'd rather have a separate _node_for_ifcond().  Not a demand.

I'm not sure what you have in mind here, so I'll leave it as it is :-)

> > +        if not nodelist:
> > +            return None
>
> Any particular reason for mapping [] to None?

I forget at this point. Probably related to the next query...

> > +        return nodelist
> > +
> > +    def _add_doc(self, typ, sections):
> > +        """Add documentation for a command/object/enum...
> > +
> > +        We assume we're documenting the thing defined in self._cur_doc.
> > +        typ is the type of thing being added ("Command", "Object", etc)
> > +
> > +        sections is a list of nodes for sections to add to the definition.
> > +        """
> > +
> > +        doc = self._cur_doc
> > +        snode = nodes.section(ids=[self._sphinx_directive.new_serialno()])
> > +        snode += nodes.title('', '', *[nodes.literal(doc.symbol, doc.symbol),
> > +                                       nodes.Text(' (' + typ + ')')])
> > +        self._parse_text_into_node(doc.body.text, snode)
> > +        for s in sections:
> > +            if s is not None:
> > +                snode += s
>
> Looks like you're flattening the two-level list the callers create,
> e.g. ...
>
> > +        self._add_node_to_current_heading(snode)
> > +
> > +    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
> > +        doc = self._cur_doc
> > +        self._add_doc('Enum',
> > +                      [self._nodes_for_enum_values(doc, 'Values'),
> > +                       self._nodes_for_features(doc),
> > +                       self._nodes_for_sections(doc, ifcond)])
>
> ... this one: [[nodes for enum values...]
>                [nodes for features...]
>                [nodes for sections]]
>
> Makes me wonder why you build two levels in the first place.

This is probably just me not being a very experienced Python
programmer. What's the syntax for passing _add_doc the single list
which is just the concatenation of the various lists that
the _nodes_for_* methods return ?

> > +
> > +        if re.match(r'=+ ', doc.body.text):
> > +            # Section or subsection heading: must be the only thing in the block
> > +            (heading, _, rest) = doc.body.text.partition('\n')
> > +            if rest != '':
> > +                raise ExtensionError('%s line %s: section or subsection heading'
> > +                                     ' must be in its own doc comment block'
> > +                                     % (doc.info.fname, doc.info.line))
>
> Same ornate error message format as above, less 'syntax error: '.

Yes. I realized after sending v5 that this could be made to
call _serror() instead of directly raising the ExtensionError.

> > +        try:
> > +            schema = QAPISchema(qapifile)
> > +        except QAPIError as err:
> > +            # Launder QAPI parse errors into Sphinx extension errors
> > +            # so they are displayed nicely to the user
> > +            raise ExtensionError(str(err))
>
> I expected plumbing the error location through Sphinx to the user to
> take a bit more effort.  I'm not complaining.
>
> A QAPIError looks like this when converted to str:
>
>     In file included from ...:
>     ...
>     In file included from ...:
>     FILE: In ENTITY-TYPE 'NAME':
>     FILE:LINE: MESSAGE
>
> "In file" lines appear when the error is in a sub-module.
>
> An "In ENTITY-TYPE" line appears when the error is in an entity
> definition.
>
> The other two ExtensionError() look like
>
>     FILE line LINE: syntax error: MESSAGE
>
> and
>
>     FILE line LINE: MESSAGE
>
> More ornate, less information.
>
> I figure more errors can get thrown by nested_parse_with_titles() (see
> below).  How do they look like?

They look like this:

Warning, treated as error:
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/../qapi/block.json:15:Bullet
list ends without a blank line; unexpected unindent.

(I've just noticed that with Sphinx 1.6, which we still have
to support, the file/line info isn't passed through, so you get:

Warning, treated as error:
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/interop/qemu-qmp-ref.rst:7:Bullet
list ends without a blank line; unexpected unindent.

The plugin has code borrowed from kerneldoc.py which is
*supposed* to handle the older API Sphinx 1.6 used, but it
looks like it's broken. I'll have a look and see if it
is fixable, but possibly we may have to live with people
developing on old distros getting suboptimal errors.)

> Can we avoid the information loss?
>
> Can we make the error message format more consistent?

How do I get a QAPIError from within one of the
visit_* or freeform methods of a QAPISchemaVisitor ?
The current texinfo doc generator doesn't do anything like that.
If there's a way to get a QAPIError given
 * the 'doc' argument passed into freeform/visit*
 * the specific error message we want to emit
then we can make the errors this script itself emits
(which are just the ones about headings: wrongly-subnested
headings, and headings that aren't the only thing in their
freeform-doc block) consistent with the other QAPIError ones.
[As I mentioned in some earlier thread, we are identifying
these errors here for pragmatic "it was easy" reasons,
though you could make a case that scripts/qapi/parser.py
should be doing it.]

(Aside: what was your conclusion on the question of section
headers, anyway? I need to go back and re-read the older
threads but I think that is still an unresolved topic...)

However I suspect we can't generate QAPIErrors for errors which are
produced by Sphinx itself when it's handed invalid rST:
the API Sphinx provides us is that we can annotate the lines
of rST that we are assembling from the input files to indicate
their "true" file/line number, but we can't intercept error
messages it emits. Think of it like the C compiler -- a
preprocessor can add #line directives to pass fixed up file/line
info to the compiler, but it isn't in the loop when the compiler
actually prints out errors.

> I had to read mostly backwards to understand the code.

Yes. This seems to be the standard way to write a Sphinx extension.
(Compare the kerneldoc.py and the various example extensions
in the Sphinx docs.)

thanks
-- PMM

