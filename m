Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84503C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7C520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQiF3b6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7C520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05FJ-0005C7-DN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j04r8-0003Gu-7r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j04r6-0002aI-Or
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:43:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j04r6-0002YG-K9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581086619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2UTFxXL4ENISx6MqPKkVTip4U1lFhK8T7u8BMnfjvM=;
 b=AQiF3b6PBKg8LJjkj8/sod5WCpjNcSi5JgNCuKtcjRvfaLpQstwZKMElHZSkBvI8w4WhEV
 pImr/ImhPf/0/Tvmy4djYIEoWNZW8ZA3PJSZTm6nSt11gRRRwMNONlymvFsWoy3zaAVM5U
 Zn7YMaM5/3stFPOG7j+fvSF1VMgzkKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-LLSwRFmlOk-_cVZ4D2IG9w-1; Fri, 07 Feb 2020 09:43:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35E1B1081FA0;
 Fri,  7 Feb 2020 14:43:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED14D5C28C;
 Fri,  7 Feb 2020 14:43:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FBD111386A7; Fri,  7 Feb 2020 15:43:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-9-peter.maydell@linaro.org>
 <87pnequ4og.fsf@dusky.pond.sub.org>
 <20200207102433.GC6031@linux.fritz.box>
 <CAFEAcA9a8G=RQASBxQGLMBU32w+G7un-xQwOHv4y56W1TQftPQ@mail.gmail.com>
Date: Fri, 07 Feb 2020 15:43:29 +0100
In-Reply-To: <CAFEAcA9a8G=RQASBxQGLMBU32w+G7un-xQwOHv4y56W1TQftPQ@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Feb 2020 11:05:42 +0000")
Message-ID: <87zhdupiem.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LLSwRFmlOk-_cVZ4D2IG9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Feb 2020 at 10:24, Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 07.02.2020 um 10:28 hat Markus Armbruster geschrieben:
>> > Peter Maydell <peter.maydell@linaro.org> writes:
>> > > @@ -4703,7 +4703,7 @@
>> > >  #
>> > >  # Options for creating an image format on a given node.
>> > >  #
>> > > -# @driver           block driver to create the image format
>> > > +# @driver: block driver to create the image format
>> > >  #
>> > >  # Since: 2.12
>> > >  ##
>> >
>> > Loses the visual alignment.  I'm okay with that, but the folks who too=
k
>> > the trouble to align the text may have different ideas.  Cc'ing Kevin
>> > and Max.
>>
>> I think the documentation is much easier to parse visually with aligned
>> text as it makes both the option name and the whole part of the comment
>> that documents options stand out clearly.
>>
>> Of course, "It is the QEMU coding style." would trump everything, but as
>> long as there isn't a style guide that requires a wall of text without
>> spaces and alignment, I'd prefer to leave at least those aligned texts
>> in place that we have.
>
> So, the other way to handle this would be to say "the @foo: can have
> an arbitrary amount of whitespace after it", and have the doc comment
> parser strip out that many characters of extra whitespace there and
> on the subsequent lines. The downside is that then you would have no
> way of having a comment for an argument which started with rST markup
> that required leading whitespace. I think this pretty much would just
> mean that you can't start an argument description with a blockquote,
> so we don't lose much, but there is a difference currently between:
>
> @arg:    In the current parser this is a blockquote
>          Blockquote line 2
>
>       But this is a non-blockquoted line still in @arg's description
>
> and
>
> @arg: This is not blockquoted, it's just a line
>       So is this
>       and this
>
> I can make the parser work the other way if people prefer that though
> (and then the first example above would become a syntax error because
> the 3rd line would be unexpectedly de-indented).

Let me ignore rST details for a bit.

The prevailing schema style looks like this:

    # @file: Node to create the image format on
    # @size: Size of the virtual disk in bytes
    # @log-size: Log size in bytes, must be a multiple of 1 MB
    #            (default: 1 MB)
    # @block-size: Block size in bytes, must be a multiple of 1 MB and not
    #              larger than 256 MB (default: automatically choose a bloc=
k
    #              size depending on the image size)
    # @subformat: vhdx subformat (default: dynamic)
    # @block-state-zero: Force use of payload blocks of type 'ZERO'. Non-st=
andard,
    #                    but default.  Do not set to 'off' when using 'qemu=
-img
    #                    convert' with subformat=3Ddynamic.

Peter's patch converts to it.  Can't fault him for converting to the
prevailing style.

Trouble is the prevailing style is ugly, and can waste massive amounts
of screen real estate when both the identifier and the explaining text
are long.

block*.json's style looks like this:

    # @file:             Node to create the image format on
    # @size:             Size of the virtual disk in bytes
    # @log-size:         Log size in bytes, must be a multiple of 1 MB
    #                    (default: 1 MB)
    # @block-size:       Block size in bytes, must be a multiple of 1 MB an=
d not
    #                    larger than 256 MB (default: automatically choose =
a block
    #                    size depending on the image size)
    # @subformat:        vhdx subformat (default: dynamic)
    # @block-state-zero: Force use of payload blocks of type 'ZERO'. Non-st=
andard,
    #                    but default.  Do not set to 'off' when using 'qemu=
-img
    #                    convert' with subformat=3Ddynamic.

I dislike this style, too.  It's less ugly, until you add a longer
member.  Then you either accept inconsistent indentation, or reindent
all the other members.  Blech.

Here's a style I'd dislike less:

    # @file: Node to create the image format on
    #
    # @size: Size of the virtual disk in bytes
    #
    # @log-size: Log size in bytes, must be a multiple of 1 MB
    #     (default: 1 MB)
    #
    # @block-size: Block size in bytes, must be a multiple of 1 MB and not
    #     larger than 256 MB (default: automatically choose a block
    #     size depending on the image size)
    #
    # @subformat: vhdx subformat (default: dynamic)
    #
    # @block-state-zero: Force use of payload blocks of type 'ZERO'.
    #     Non-standard, but default.  Do not set to 'off' when using
    #     'qemu-img convert' with subformat=3Ddynamic.

Or maybe even

    # @file:
    # Node to create the image format on
    #
    # @size:
    # Size of the virtual disk in bytes
    #
    # @log-size:
    # Log size in bytes, must be a multiple of 1 MB (default: 1 MB)
    #
    # @block-size:
    # Block size in bytes, must be a multiple of 1 MB and not larger
    # than 256 MB (default: automatically choose a block size depending
    # on the image size)
    #
    # @subformat:
    # vhdx subformat (default: dynamic)
    #
    # @block-state-zero:
    # Force use of payload blocks of type 'ZERO'.  Non-standard, but
    # default.  Do not set to 'off' when using 'qemu-img convert' with
    # subformat=3Ddynamic.

With both these styles, member names stand out reasonably well, and I
don't have to fiddle with indentation when adding or removing members.
With the second one, I don't have to fiddle with indentation at all.

The second one might be the better fit for rST, but that's for Peter to
judge.


