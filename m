Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B813C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CD0214F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWKWCl/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CD0214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgiF-0004sP-AL
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKghL-0004RG-59
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKghH-0001wq-Hk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600774978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LdGkYtlxB0+x0l9pSZriPv65l2ooCZsx641tPhdn9SU=;
 b=TWKWCl/qwqzky6GkL2UVABB8cVAmonG6il/6Ri8dgQKJlIg0beoKmI+heBPeaRmbe1HC0o
 xiUwR8N/4vgbG7LLh1M8oTpDpY2mr0rHYt+bLqAmTSmZGfaDx2LK7DSWPCZypopzGkvZhM
 zCwtjRK2hL/281HhyAUNdYu7ZpK81bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-3XTcF9TnM2CDGss_zfd-Zg-1; Tue, 22 Sep 2020 07:42:54 -0400
X-MC-Unique: 3XTcF9TnM2CDGss_zfd-Zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9208A188C122;
 Tue, 22 Sep 2020 11:42:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C1695C1A3;
 Tue, 22 Sep 2020 11:42:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2AC61132E9A; Tue, 22 Sep 2020 13:42:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <875z8t913t.fsf@dusky.pond.sub.org>
 <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
Date: Tue, 22 Sep 2020 13:42:50 +0200
In-Reply-To: <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
 (Peter Maydell's message of "Mon, 21 Sep 2020 19:06:46 +0100")
Message-ID: <877dsmrq9x.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 4 Sep 2020 at 13:29, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Some of our documentation is auto-generated from documentation
>> > comments in the JSON schema.
>> >
>> > For Sphinx, rather than creating a file to include, the most natural
>> > way to handle this is to have a small custom Sphinx extension which
>> > processes the JSON file and inserts documentation into the rST
>> > file being processed.
>> >
>> > This is the same approach that kerneldoc and hxtool use.
>> >
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Got a pointer to "Writing Sphinx Extensions for Dummies" or similar?
>
> The upstream documentation on extending Sphinx is probably
> a good place to start; in particular the tutorials are useful:
>
> https://www.sphinx-doc.org/en/master/development/index.html

Do you think having this link in a comment could help future readers /
maintainers?

> I have also found that a fair amount of trial-and-error,
> examination of the source of Sphinx itself or of other
> extensions, and occasionally asking questions on the Sphinx
> mailing list has been necessary...
>
>> > --- /dev/null
>> > +++ b/docs/sphinx/qapidoc.py
>> > @@ -0,0 +1,504 @@
>> > +# coding=utf-8
>> > +#
>> > +# QEMU qapidoc QAPI file parsing extension
>> > +#
>> > +# Copyright (c) 2020 Linaro
>> > +#
>> > +# This work is licensed under the terms of the GNU GPLv2 or later.
>> > +# See the COPYING file in the top-level directory.
>> > +"""qapidoc is a Sphinx extension that implements the qapi-doc directive"""
>> > +
>> > +# The purpose of this extension is to read the documentation comments
>> > +# in QAPI JSON schema files, and insert them all into the current document.
>>
>> Let's drop "JSON", it's not really true.
>
> Fixed.
>
>> > +# The conf.py file must set the qapidoc_srctree config value to
>> > +# the root of the QEMU source tree.
>> > +# Each qapi-doc:: directive takes one argument which is the
>> > +# path of the .json file to process, relative to the source tree.
>>
>> Beg your pardon?  Oh, you're talking about .rst files now.  The next two
>> patches will add such files.  Perhaps something like "The qapi-doc::
>> reST directive provided by this extension takes ..."
>
> OK, how about:
>
> # The purpose of this extension is to read the documentation comments
> # in QAPI schema files, and insert them all into the current document.
> #
> # It implements one new rST directive, "qapi-doc::".
> # Each qapi-doc:: directive takes one argument, which is the
> # path of the .json file to process, relative to the source tree.
> #
> # The docs/conf.py file must set the qapidoc_srctree config value to
> # the root of the QEMU source tree.
>
> ?

Works for me with "pathname" instead of "path".  I'd also write "schema
file" instead of ".json file", but that's a matter of taste and up to
you.

>> > +# Function borrowed from pydash, which is under the MIT license
>> > +def intersperse(iterable, separator):
>> > +    """Like join, but for arbitrary iterables, notably arrays"""
>> > +    iterable = iter(iterable)
>> > +    yield next(iterable)
>> > +    for item in iterable:
>> > +        yield separator
>> > +        yield item
>>
>> What's wrong with separator.join(iterable)?
>
> It doesn't work on all the things we'd like to intersperse().
> If you try defining intersperse as
>
> def intersperse(iterable, separator):
>     separator.join(iterable)
>
> then you get an exception:
>
>   File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/../scripts/qapi/schema.py",
> line 445, in visit
>     self.base, self.local_members, self.variants)
>   File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/sphinx/qapidoc.py",
> line 314, in visit_object_type
>     [self._nodes_for_members(doc, 'Members', base, variants),
>   File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/sphinx/qapidoc.py",
> line 173, in _nodes_for_members
>     nodes.Text(', ')))
>   File "/home/petmay01/linaro/qemu-from-laptop/qemu/docs/sphinx/qapidoc.py",
> line 53, in intersperse
>     separator.join(iterable)
> TypeError: sequence item 0: expected str instance, literal found

Aha.

@iterable appears to be a list of docutils.node.literal, whatever that
may be.

The doc string is confusing (I figure you borrowed the it along with the
code).  str.join() works just fine for arrays.  It's not the kind of
iterable that's the problem, it's the kind of thing the iterable yields:
str.join() wants str, we have. docutils.node.literal.

The lazy solution is to delete the confusing doc string.

Here's my attempt at a non-lazy solution:

    """Yield the members of *iterable* interspersed with *separator*."""

>> > +
>> > +class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
>> > +    """A QAPI schema visitor which generates docutils/Sphinx nodes
>> > +
>> > +    This class builds up a tree of docutils/Sphinx nodes corresponding
>> > +    to documentation for the various QAPI objects. To use it, first create
>> > +    a QAPISchemaGenRSTVisitor object, and call its visit_begin() method.
>> > +    Then you can call one of the two methods 'freeform' (to add documentation
>> > +    for a freeform documentation chunk) or 'symbol' (to add documentation
>> > +    for a QAPI symbol). These will cause the visitor to build up the
>> > +    tree of document nodes. Once you've added all the documentation
>> > +    via 'freeform' and 'symbol' method calls, you can call 'get_document_nodes'
>> > +    to get the final list of document nodes (in a form suitable for returning
>> > +    from a Sphinx directive's 'run' method).
>> > +    """
>> > +    def __init__(self, sphinx_directive):
>> > +        self._cur_doc = None
>> > +        self._sphinx_directive = sphinx_directive
>> > +        self._top_node = nodes.section()
>> > +        self._active_headings = [self._top_node]
>> > +
>> > +    def _serror(self, msg):
>> > +        """Raise an exception giving a user-friendly syntax error message"""
>> > +        file = self._cur_doc.info.fname
>> > +        line = self._cur_doc.info.line
>> > +        raise ExtensionError('%s line %d: syntax error: %s' % (file, line, msg))
>>
>> Note for later: ornate error message format, no use of QAPISourceInfo.
>>
>> > +
>
>> > +
>> > +    def _nodes_for_enum_values(self, doc, what):
>>
>> @what is only ever 'Values', isn't it?
>
> Yes. I think this was a legacy from conversion from scripts/qapi/doc.py,
> which does pass in a 'Values' string, but it does that because it shares
> code in texi_members() between enums and other things. In this code
> I chose to split that out into different functions rather than using
> one function with a member_func argument because the member vs enum
> code is different enough that it's clearer that way. But I didn't
> notice that there wasn't any longer much point in passing a 'what'
> argument.
>
> Fixed to hard-code 'Values' rather than passing it as an argument.
>
>> > +    def _nodes_for_sections(self, doc, ifcond):
>> > +        """Return doctree nodes for additional sections following arguments"""
>> > +        nodelist = []
>> > +        for section in doc.sections:
>> > +            snode = self._make_section(section.name)
>> > +            if section.name and section.name.startswith('Example'):
>> > +                snode += self._nodes_for_example(section.text)
>> > +            else:
>> > +                self._parse_text_into_node(section.text, snode)
>> > +            nodelist.append(snode)
>> > +        if ifcond:
>> > +            snode = self._make_section('If')
>> > +            snode += self._nodes_for_ifcond(ifcond, with_if=False)
>> > +            nodelist.append(snode)
>>
>> I think I'd rather have a separate _node_for_ifcond().  Not a demand.
>
> I'm not sure what you have in mind here, so I'll leave it as it is :-)

_nodes_for_sections() is used like this:

        self._add_doc(WHAT,
                      [self._nodes_for_WHAT(doc, ...),
                       self._nodes_for_features(doc),
                       self._nodes_for_sections(doc, ifcond)])

._add_doc()'s second argument is a list of nodes for sections.

._nodes_for_WHAT() computes the nodes specific to the kind of thing
we're processing: enum, object, alternate, command, event.

._nodes_for_features() computes the nodes for the feature section.

._nodes_for_sections() computes both the nodes for additional sections
and the nodes for the ifcond section.

I'd compute the nodes for the ifcond section in their own function, to
keep .nodes_for_sections() focused on just one purpose.

>> > +        if not nodelist:
>> > +            return None
>>
>> Any particular reason for mapping [] to None?
>
> I forget at this point. Probably related to the next query...
>
>> > +        return nodelist
>> > +
>> > +    def _add_doc(self, typ, sections):
>> > +        """Add documentation for a command/object/enum...
>> > +
>> > +        We assume we're documenting the thing defined in self._cur_doc.
>> > +        typ is the type of thing being added ("Command", "Object", etc)
>> > +
>> > +        sections is a list of nodes for sections to add to the definition.
>> > +        """
>> > +
>> > +        doc = self._cur_doc
>> > +        snode = nodes.section(ids=[self._sphinx_directive.new_serialno()])
>> > +        snode += nodes.title('', '', *[nodes.literal(doc.symbol, doc.symbol),
>> > +                                       nodes.Text(' (' + typ + ')')])
>> > +        self._parse_text_into_node(doc.body.text, snode)
>> > +        for s in sections:
>> > +            if s is not None:
>> > +                snode += s
>>
>> Looks like you're flattening the two-level list the callers create,
>> e.g. ...
>>
>> > +        self._add_node_to_current_heading(snode)
>> > +
>> > +    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
>> > +        doc = self._cur_doc
>> > +        self._add_doc('Enum',
>> > +                      [self._nodes_for_enum_values(doc, 'Values'),
>> > +                       self._nodes_for_features(doc),
>> > +                       self._nodes_for_sections(doc, ifcond)])
>>
>> ... this one: [[nodes for enum values...]
>>                [nodes for features...]
>>                [nodes for sections]]
>>
>> Makes me wonder why you build two levels in the first place.
>
> This is probably just me not being a very experienced Python
> programmer. What's the syntax for passing _add_doc the single list
> which is just the concatenation of the various lists that
> the _nodes_for_* methods return ?

You could replace

                      [self._nodes_for_WHAT(doc, ...),
                       self._nodes_for_features(doc),
                       self._nodes_for_sections(doc, ifcond)])

by

                      self._nodes_for_WHAT(doc, ...)
                      + self._nodes_for_features(doc)
                      + self._nodes_for_sections(doc, ifcond)

Operator + concatenates sequences.

>> > +
>> > +        if re.match(r'=+ ', doc.body.text):
>> > +            # Section or subsection heading: must be the only thing in the block
>> > +            (heading, _, rest) = doc.body.text.partition('\n')
>> > +            if rest != '':
>> > +                raise ExtensionError('%s line %s: section or subsection heading'
>> > +                                     ' must be in its own doc comment block'
>> > +                                     % (doc.info.fname, doc.info.line))
>>
>> Same ornate error message format as above, less 'syntax error: '.
>
> Yes. I realized after sending v5 that this could be made to
> call _serror() instead of directly raising the ExtensionError.
>
>> > +        try:
>> > +            schema = QAPISchema(qapifile)
>> > +        except QAPIError as err:
>> > +            # Launder QAPI parse errors into Sphinx extension errors
>> > +            # so they are displayed nicely to the user
>> > +            raise ExtensionError(str(err))
>>
>> I expected plumbing the error location through Sphinx to the user to
>> take a bit more effort.  I'm not complaining.
>>
>> A QAPIError looks like this when converted to str:
>>
>>     In file included from ...:
>>     ...
>>     In file included from ...:
>>     FILE: In ENTITY-TYPE 'NAME':
>>     FILE:LINE: MESSAGE
>>
>> "In file" lines appear when the error is in a sub-module.
>>
>> An "In ENTITY-TYPE" line appears when the error is in an entity
>> definition.
>>
>> The other two ExtensionError() look like
>>
>>     FILE line LINE: syntax error: MESSAGE
>>
>> and
>>
>>     FILE line LINE: MESSAGE
>>
>> More ornate, less information.
>>
>> I figure more errors can get thrown by nested_parse_with_titles() (see
>> below).  How do they look like?
>
> They look like this:
>
> Warning, treated as error:
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/../qapi/block.json:15:Bullet
> list ends without a blank line; unexpected unindent.
>
> (I've just noticed that with Sphinx 1.6, which we still have
> to support, the file/line info isn't passed through, so you get:
>
> Warning, treated as error:
> /home/petmay01/linaro/qemu-from-laptop/qemu/docs/interop/qemu-qmp-ref.rst:7:Bullet
> list ends without a blank line; unexpected unindent.
>
> The plugin has code borrowed from kerneldoc.py which is
> *supposed* to handle the older API Sphinx 1.6 used, but it
> looks like it's broken. I'll have a look and see if it
> is fixable, but possibly we may have to live with people
> developing on old distros getting suboptimal errors.)

I'm okay with that.

>> Can we avoid the information loss?
>>
>> Can we make the error message format more consistent?
>
> How do I get a QAPIError from within one of the
> visit_* or freeform methods of a QAPISchemaVisitor ?

The visit_ methods take an info argument.  With that:

    raise QAPISemError(info, "the error message")

QAPISchemaGenDocVisitor.freeform() lacks such an argument.  Use
doc.info.

> The current texinfo doc generator doesn't do anything like that.

None of the code generators detects any errors.

I added one to test the advice I gave above.  It doesn't get caught.
Easy enough to fix: move then gen_FOO() into main()'s try ... except.

> If there's a way to get a QAPIError given
>  * the 'doc' argument passed into freeform/visit*
>  * the specific error message we want to emit
> then we can make the errors this script itself emits
> (which are just the ones about headings: wrongly-subnested
> headings, and headings that aren't the only thing in their
> freeform-doc block) consistent with the other QAPIError ones.
> [As I mentioned in some earlier thread, we are identifying
> these errors here for pragmatic "it was easy" reasons,
> though you could make a case that scripts/qapi/parser.py
> should be doing it.]

Oh yes.

> (Aside: what was your conclusion on the question of section
> headers, anyway? I need to go back and re-read the older
> threads but I think that is still an unresolved topic...)

If I remember correctly, I disliked "[PATCH 19/29]
qapi/qapi-schema.json: Put headers in their own doc-comment blocks",
because "it sweeps the actual problem under the rug, namely flaws in our
parsing and representation of doc comments."

Our documentation has a tree structure.  Ideally, we'd represent it as a
tree.  I figure such a tree would suit you well: you could translate
more or less 1:1 to Sphinx nodes.

We currently have a two-level list instead: a list of blocks (either
definition or free-form), where each block has a list of sections (see
QAPIDoc's doc string).

My commit dcdc07a97c "qapi: Make section headings start a new doc
comment block" was a minimally invasive patch to get us closer to a
(partially flattened) tree.  Kind of collects the dirt in an (hopefully
obvious) pile next to the rug.

You could finish the job and rework the representation into a tree.
That would be lovely.  I appreciate help with cleaning up existing QAPI
messes very much, but do not feel obliged.

You could work with the two-level list as is, relying on the fact that a
'=' can only occur right at the start of a free-form block.

You could tweak the two-level list just a bit, so that the heading
becomes properly represented, and you don't have to match free-form body
section text to find it.

Does this help you along?

> However I suspect we can't generate QAPIErrors for errors which are
> produced by Sphinx itself when it's handed invalid rST:
> the API Sphinx provides us is that we can annotate the lines
> of rST that we are assembling from the input files to indicate
> their "true" file/line number, but we can't intercept error
> messages it emits. Think of it like the C compiler -- a
> preprocessor can add #line directives to pass fixed up file/line
> info to the compiler, but it isn't in the loop when the compiler
> actually prints out errors.

Perfection is not a requirement :)

Errors from TexInfo are arguably worse than that now.  They are rare,
however.  The situation will change when people use reST markup in doc
comments.

>> I had to read mostly backwards to understand the code.
>
> Yes. This seems to be the standard way to write a Sphinx extension.
> (Compare the kerneldoc.py and the various example extensions
> in the Sphinx docs.)

Mimicking existing similar extensions makes sense.


