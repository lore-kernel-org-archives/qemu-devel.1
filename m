Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E48FC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6BC217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrCGR5x4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6BC217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0QvC-0002jr-8k
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 09:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0Qu4-0001Xp-M8
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0Qu3-0008Ix-8s
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:16:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0Qu2-000875-Es
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581171369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPBnpPsMYntQGLu19K0pzvi+VO25qRDSPYoeRA99i0g=;
 b=RrCGR5x4UQ/lcbfOWTvxkQSvmg66TFLCE2T7v9nG2ksszqe7gj/aoMIs1TpP3qtBNRKrT5
 CQQHJUUO+dXJmXxFiDmWMBSCgmRm1Qc+2vJLL41hYF0wpC0bRgnmY19/XXxmaXRWeLztw8
 uIpQjl6OxbkXzn2AZcvo2cAZiV576A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-n65Wf6bAMZiw3c7GuKpgsQ-1; Sat, 08 Feb 2020 09:16:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E855108442C;
 Sat,  8 Feb 2020 14:16:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C20D5D9C9;
 Sat,  8 Feb 2020 14:15:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BBA311386A7; Sat,  8 Feb 2020 15:15:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <877e0ynxhx.fsf@dusky.pond.sub.org>
 <CAFEAcA-owBQMnvY5Asa4m4DUF-hBqRTmu8C7fktfvMRE2HZfgg@mail.gmail.com>
Date: Sat, 08 Feb 2020 15:15:58 +0100
In-Reply-To: <CAFEAcA-owBQMnvY5Asa4m4DUF-hBqRTmu8C7fktfvMRE2HZfgg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Feb 2020 17:10:23 +0000")
Message-ID: <87blq9jhb5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: n65Wf6bAMZiw3c7GuKpgsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 7 Feb 2020 at 17:00, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > This series switches all our QAPI doc comments over from
>> > texinfo format to rST.
>> >
>> > The basic approach is somewhat similar to how we deal with kerneldoc
>> > and hxtool: we have a custom Sphinx extension which is passed a
>> > filename which is the json file it should run the QAPI parser over and
>> > generate documentation for. Unlike 'kerneldoc' but somewhat like
>> > hxtool, I have chosed to generate documentation by generating a tree
>> > of docutils nodes, rather than by generating rST source that is then
>> > fed to the rST parser to generate docutils nodes.  Individual lumps of
>> > doc comment go to the rST parser, but the structured parts we render
>> > directly. This makes it easier to get the structure and heading level
>> > nesting correct.
>> >
>> > Rather than trying to exactly handle all the existing comments I have
>> > opted (as Markus suggested) to tweak them where this seemed more
>> > sensible than contorting the rST generator to deal with
>> > weirdnesses. The principal changes are:
>> >  * whitespace is now significant, and multiline definitions must have
>> >    their second and subsequent lines indented to match the first line
>> >  * general rST format markup is permitted, not just the small set of
>> >    markup the old texinfo generator handled. For most things (notably
>> >    bulleted and itemized lists) the old format is the same as rST was.
>> >  * Specific things that might trip people up:
>> >    - instead of *bold* and _italic_ rST has **bold** and *italic*
>>
>> Actually, qapi-code-gen.txt documents and doc.py implements *strong* and
>> _emphasis_.  Texinfo commonly renders them as bold and italic when the
>> output format supports that.  rST has **strong** and *emphasis*.
>>
>> Your series adjusts emphasis markup for rST [PATCH 18].  Since it
>> doesn't touch strong markup, strong silently becomes emphasis.  I guess
>> that's okay, perhaps even an improvement, but double-checking the actual
>> uses of this markup wouldn't hurt.
>
> Yeah, that would be a good plan.
>  git grep '\*[^*]*\*' qapi/*.json
> (and eyeball-filtering out the false hits) shows just one use:
>
> qapi/introspect.json:# Note: the QAPI schema is also used to help
> define *internal*
>
> I can put a patch on the end which converts that to **internal**
> once the rST generator is in use.

I wrote that one, and I think changing it from strong to emphasis is an
improvement.  Let's point to it in the commit message, and call it a
day.

>> >    - lists need a preceding and following blank line
>> >    - a lone literal '*' will need to be backslash-escaped to
>> >      avoid a rST syntax error
>> >  * the old leading '|' for example (literal text) blocks is replaced
>> >    by the standard rST '::' literal block.
>> >  * headings and subheadings must now be in a freeform documentation
>> >    comment of their own
>>
>> Can we simply use rST instead?  See my review of PATCH 18.
>
> No, we can't (see my reply to that review). In theory you could have
> the heading syntax be a rST heading, but that is not feasible to
> recognise in the Python script[*] and it gives the impression that
> it is just an inline rST heading, not something that's more complicated
> and structured.
>
> [*] You'd need to manually re-implement the weird thing rST does
> where practically any kind of underlining is valid and it figures
> out which one means which depth by looking at the usage through
> the whole document. You'd have to do bizarre stuff like running
> through the entire set of doc comments once doing no output but
> just looking at heading underline characters to guess which one
> is which depth, and then once you'd figured that out you could
> do it all over again actually generating the doc.

I understand the difficulty of parsing rST (Paolo called it "the Perl of
markup languages" for a reason).  What I don't yet understand is (1) why
we need to recognize the document structure of doc comments, and (2) why
we can do that by recognizing '=3D' markup, but ignore the native rST
document structure markup.


