Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21158C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BF020720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDQIet5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BF020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05fe-0000vP-4R
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j05ev-0000QZ-GR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j05eu-0005qF-5t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:35:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j05eu-0005nk-14
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581089707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPPQkTCtRUKJSQf5+v3mC0gtxDV0mWLa7RSzl48dRpA=;
 b=gDQIet5mN+KYN72QkMFGRxrQ0BAU4piDhBSldKnmijWKFhYiYnkSuZstRyp5DPseK3Brci
 xvt0XHQBA5m1wIDMFXQk4fgCrm2BPmHM12QLc/vw5BCFECczik4FbiTA7FtxHm+O141jB9
 88BG4F9MNuSpu1VPO9s7ZMCw+k5bUYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-XC1-NYkYMLecGauCAz7Heg-1; Fri, 07 Feb 2020 10:35:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9A518CA244;
 Fri,  7 Feb 2020 15:35:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C3DE5DA7E;
 Fri,  7 Feb 2020 15:34:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DA1111386A7; Fri,  7 Feb 2020 16:34:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 19/29] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-20-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 16:34:54 +0100
In-Reply-To: <20200206173040.17337-20-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:30 +0000")
Message-ID: <87r1z6pg0x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: XC1-NYkYMLecGauCAz7Heg-1
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Our current QAPI doc-comment markup allows section headers
> (introduced with a leading '=3D' or '=3D=3D') anywhere in any documentati=
on
> comment.  This works for texinfo because the texi generator simply
> prints a texinfo heading directive at that point in the output
> stream.  For rST generation, since we're assembling a tree of
> docutils nodes, this is awkward because a new section implies
> starting a new section node at the top level of the tree and
> generating text into there.
>
> New section headings in the middle of the documentation of a command
> or event would be pretty nonsensical, and in fact we only ever output
> new headings using 'freeform' doc comment blocks whose only content
> is the single line of the heading, with two exceptions, which are in
> the introductory freeform-doc-block at the top of
> qapi/qapi-schema.json.
>
> Split that doc-comment up so that the heading lines are in their own
> doc-comment.  This will allow us to tighten the specification to
> insist that heading lines are always standalone, rather than
> requiring the rST document generator to look at every line in a doc
> comment block and handle headings in odd places.
>
> This change makes no difference to the generated texi.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/qapi-schema.json | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 9751b11f8f1..f7ba60a5d0b 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -1,7 +1,9 @@
>  # -*- Mode: Python -*-
>  ##
>  # =3D Introduction
> -#
> +##
> +
> +##
>  # This document describes all commands currently supported by QMP.
>  #
>  # Most of the time their usage is exactly the same as in the user Monito=
r, this
> @@ -25,9 +27,13 @@
>  #
>  # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
>  # detailed information on the Server command and response formats.
> -#
> +##
> +
> +##
>  # =3D Stability Considerations
> -#
> +##
> +
> +##
>  # The current QMP command set (described in this file) may be useful for=
 a
>  # number of use cases, however it's limited and several commands have ba=
d
>  # defined semantics, specially with regard to command completion.

I figure this is a minimally invasive patch to avoid complications in
your rST generator.  I'm afraid it sweeps the actual problem under the
rug, namely flaws in our parsing and representation of doc comments.

The doc comment parser doesn't recognize headings.  Instead, that's done
somewhere in the bowels of the Texinfo generator.  Works as long as the
input is "sane", happily generates invalid Texinfo otherwise, see
tests/qapi-schema/doc-bad-section.json.

The proper fix is to make the parser recognize headers in the places
where headers make sense, and reject them elsewhere.

But maybe we don't have to.  Do you plan to support full rST in doc
comments?  If yes, why have our own syntax for headings?  Why not leave
it to rST?  If no, do you plan to support a subset of rST?  If yes,
define it, please.  How will it be enforced?


