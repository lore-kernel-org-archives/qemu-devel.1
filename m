Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22090C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A00520936
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Trwnizd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A00520936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiyu-00020R-Gv
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKiyB-0001Vn-Gv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKiy8-0004mo-S5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600783711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lb6w2IsG208Bt0Nf3n6W39NlWk0hwTVLtHhfKAChqks=;
 b=Trwnizd+AcdrO+eWLsmjcmsNegnsh6mpIw4pP7hVfJp+0RiOlIRpjQ2vgY3AasFAfjsC+7
 g3huc7nCXtXccZ7Nnpl5S2dSbimTzizZIL1dk1mGSOVl8xgwpab9H2xyrwrt6k65AAKRA8
 l0sFytG6u2hOjep0d2+X48TMMeNugrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-TTckVeh5PxGmR-JNm-pgdQ-1; Tue, 22 Sep 2020 10:08:27 -0400
X-MC-Unique: TTckVeh5PxGmR-JNm-pgdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA4B110BBECC;
 Tue, 22 Sep 2020 14:08:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 976F43782;
 Tue, 22 Sep 2020 14:08:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 230991132E9A; Tue, 22 Sep 2020 16:08:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 08/20] scripts/qapi/parser.py: improve doc comment
 indent handling
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-9-peter.maydell@linaro.org>
 <87wo19c3rr.fsf@dusky.pond.sub.org>
 <CAFEAcA_LEKRON2EUUCfXoAXmTGQSrqvFG_waBf1S-tsn8fJ6bA@mail.gmail.com>
 <87o8lytgoh.fsf@dusky.pond.sub.org>
 <CAFEAcA8+aPwyZEu8k8XL7F6eWvdhdP1ZZpv+6ZZXZr5vH4Lfzw@mail.gmail.com>
Date: Tue, 22 Sep 2020 16:08:24 +0200
In-Reply-To: <CAFEAcA8+aPwyZEu8k8XL7F6eWvdhdP1ZZpv+6ZZXZr5vH4Lfzw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 22 Sep 2020 12:48:13 +0100")
Message-ID: <877dslq4yv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
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

> On Tue, 22 Sep 2020 at 08:27, Markus Armbruster <armbru@redhat.com> wrote:
>> How does
>>
>>   @foo:  bar
>>          baz
>>   @frob: gnu
>>          gnat
>>
>> behave?
>
> The rST fragments would be:
>
>  bar
>  baz
>
> gnu
> gnat
>
> So you get what rST does with that. We do actually have examples
> of this in the existing QAPI doc comments. It ends up treating it
> as a definition list where the term is 'bar' and the
> definition is 'baz' (which I don't entirely understand, I was

The Perl of ASCII-based markups...

> expecting a block-quote). That renders sufficiently close to correct
> that I hadn't noticed it.

Understandable :)

> It would be a fairly small change to determine the indent level by
> looking for the first non-ws character on line 1 after the colon.
> Since we have a fair amount of this style in the code and it's
> as you say a natural-seeming thing to write that seems the best
> thing. (If you really wanted to start the option documentation with
> some rST that required an initial indent, probably because you're
> writing a literal-text Examples section, then you'd need to use the
> "nothing after the : on line 1, rST fragment begins on line 2 in
> column 0" style. Which would be the most natural way to write
> that literal text anyway.)

Agree.

> I guess at this point I'll potentially create work for myself
> by drawing your attention to the rST syntax for field lists
> and option lists:
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#field-lists
> which are kind of similar to what we're doing with @foo: stuff
> markup, and which handle indentation like this:
>
> :Hello: This field has a short field name, so aligning the field
>         body with the first line is feasible.
>
> :Number-of-African-swallows-required-to-carry-a-coconut: It would
>     be very difficult to align the field body with the left edge
>     of the first line. It may even be preferable not to begin the
>     body on the same line as the marker.
>
> The differences to what I have implemented in this series are:
>  * indent of lines 2+ is determined by the indent of line 2, not 1
>  * lines 2+ must be indented, so anything that currently uses
>    "no indent, start in column 0" would need indenting. (This would
>    be a lot of change to our current docs text.)
>  * it doesn't say in the spec, but I guess that spaces between
>    the colon and start of line 1 text are not significant.
>
> The advantage would be a bit more consistency with rST syntax
> otherwise; the disadvantage is that we have a *lot* of text
> that uses the "start in column 0" format, like this:
>
> # @QCryptoBlockOptionsBase:
> #
> # The common options that apply to all full disk
> # encryption formats
>
> and we'd need to reindent it all. My view is that trying to
> look more like rST indent isn't sufficiently useful to be
> worth having to change all that.

We use @FOO: for two distinct things:

1. Right at the beginning of a comment block, it makes the comment block
a definition doc block for symbol FOO.

2. At the beginning of an argument section, it names the argument /
member being documented.

Example:

    ##
    # @QCryptoBlockOptionsBase:                         <-- 1.
    #
    # The common options that apply to all full disk
    # encryption formats
    #
    # @format: the encryption format                    <-- 2.
    #
    # Since: 2.6
    ##

We could switch just 2. to reST field list syntax, and either keep 1. as
is, or switch it to some other reST markup that works for us.

But even if we want this, we should do it on top, to avoid complicating
and delaying this series.

>> This is something people may actually write.
>
> Indeed, they have :-)
>
> thanks
> -- PMM


