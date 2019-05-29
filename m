Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC3C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 22:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198802425E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 22:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198802425E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW6n7-0005id-74
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 18:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hW6lm-00050g-C9
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hW6ll-0000dS-64
	for qemu-devel@nongnu.org; Wed, 29 May 2019 18:10:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hW6li-0008T9-5o; Wed, 29 May 2019 18:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C378EC070E18;
	Wed, 29 May 2019 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A83619C70;
	Wed, 29 May 2019 22:09:16 +0000 (UTC)
Date: Thu, 30 May 2019 00:09:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190529220915.GA3471@localhost.localdomain>
References: <20190517144232.18965-1-kwolf@redhat.com>
	<20190517144232.18965-5-kwolf@redhat.com>
	<877eaf7ryl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eaf7ryl.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 29 May 2019 22:09:21 +0000 (UTC)
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

Am 24.05.2019 um 18:11 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Documentation comment follow a certain structure: First, we have a text
> > with a general description (called QAPIDoc.body). After this,
> > descriptions of the arguments follow. Finally, we have part that
> > contains various named sections.
> >
> > The code doesn't show this structure but just checks the right side
> > conditions so it happens to do the right set of things in the right
> 
> What are "side conditions"?
> 
> > phase. This is hard to follow, and adding support for documentation of
> > features would be even harder.
> >
> > This restructures the code so that the three parts are clearly
> > separated. The code becomes a bit longer, but easier to follow.
> 
> Recommend to mention that output remains unchanged.
> 
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  scripts/qapi/common.py | 107 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 83 insertions(+), 24 deletions(-)
> >
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index 71944e2e30..1d0f4847db 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -120,6 +120,27 @@ class QAPIDoc(object):
> >          def connect(self, member):
> >              self.member = member
> >  
> > +    class SymbolPart:
> > +        """
> > +        Describes which part of the documentation we're parsing right now.
> 
> So SymbolPart is a part of the documentation.  Shouldn't it be named
> DocPart then?

That's a better name. I was stuck in the old code (which was concerned
about what a symbol name means at which point) rather than thinking
about high-level concepts.

> > +
> > +        BODY means that we're ready to process freeform text into self.body. A
> 
> s/freeform/free-form/

Both are valid spellings and I generally don't expect correct spellings
to be corrected, but arguably "free-form" is more standard. I'll change
it. (If we were consistent, the method should have been named
_append_free_form rather than _append_freeform originally...)

> > +        symbol name is only allowed if no other text was parsed yet. It is
> 
> Start your sentences with a capital letter.

I would gladly correct a sentence not starting with a capital letter if
I could see any. The quoted sentence starts with a capital "A" in the
previous line.

> > +        interpreted as the symbol name that describes the currently documented
> > +        object. On getting the second symbol name, we proceed to ARGS.
> > +
> > +        ARGS means that we're parsing the arguments section. Any symbol name is
> > +        interpreted as an argument and an ArgSection is created for it.
> > +
> > +        VARIOUS is the final part where freeform sections may appear. This
> > +        includes named sections such as "Return:" as well as unnamed
> > +        paragraphs. No symbols are allowed any more in this part.
> 
> s/any more/anymore/

Again both are valid, but this time, "any more" is the more standard
spelling.

> > +        # Can't make it a subclass of Enum because of Python 2
> 
> Thanks for documenting Python 2 contortions!  Let's phrase it as a TODO
> comment.
> 
> > +        BODY = 0
> 
> Any particular reason for 0?
> 
> As far as I can tell, Python enum values commonly start with 1, to make
> them all true.

If you use enums in a boolean context, you're doing something wrong
anyway. *shrug*

I'll change it, it's consistent with real Enum classes where the values
becomes non-integer objects (which therefore evaluate as True in boolean
contexts).

> > +        ARGS = 1
> > +        VARIOUS = 2
> > +
> >      def __init__(self, parser, info):
> >          # self._parser is used to report errors with QAPIParseError.  The
> >          # resulting error position depends on the state of the parser.
> > @@ -135,6 +156,7 @@ class QAPIDoc(object):
> >          self.sections = []
> >          # the current section
> >          self._section = self.body
> > +        self._part = QAPIDoc.SymbolPart.BODY
> 
> The right hand side is tiresome, but I don't have better ideas.

This is just what Python enums look like... I could move the class
outside of QAPIDoc to save that part of the prefix, but I'd prefer not
to.

> >  
> >      def has_section(self, name):
> >          """Return True if we have a section with this name."""
> > @@ -154,37 +176,84 @@ class QAPIDoc(object):
>        def append(self, line):
>            """Parse a comment line and add it to the documentation."""
>            line = line[1:]
>            if not line:
>                self._append_freeform(line)
>                return
> 
>            if line[0] != ' ':
> >              raise QAPIParseError(self._parser, "Missing space after #")
> >          line = line[1:]
> >  
> > +        if self._part == QAPIDoc.SymbolPart.BODY:
> > +            self._append_body_line(line)
> > +        elif self._part == QAPIDoc.SymbolPart.ARGS:
> > +            self._append_args_line(line)
> > +        elif self._part == QAPIDoc.SymbolPart.VARIOUS:
> > +            self._append_various_line(line)
> > +        else:
> > +            assert False
> 
> Hmm.  As far as I can tell, this what we use ._part for.  All other
> occurences assign to it.
> 
> If you replace
> 
>     self._part = QAPIDoc.SymbolPart.BODY
> 
> by
> 
>     self._append_line = self._append_body_line
> 
> and so forth, then the whole conditional shrinks to
> 
>     self._append_line(line)
> 
> and we don't have to muck around with enums.

I could just have added a boolean that decides whether a symbol is an
argument or a feature. That would have been a minimal hack that
wouldn't involve any enums.

I intentionally decided not to do that because the whole structure of
the parser was horribly confusing to me and I felt that introducing a
clear state machine would improve its legibility a lot. I still think
that this is what it did.

If you don't like a proper state machine, I can do that bool thing. I
don't think throwing in function pointers would be very helpful for
readers, so we'd get a major code change for no gain.

Kevin

