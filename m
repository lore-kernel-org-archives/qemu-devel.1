Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B8C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FA820863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FA820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KcO-00083s-Gj
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peff@peff.net>) id 1i7KbT-00071m-0D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peff@peff.net>) id 1i7KbR-0004sY-V9
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:25:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:35592)
 by eggs.gnu.org with smtp (Exim 4.71) (envelope-from <peff@peff.net>)
 id 1i7KbR-0004sM-RQ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:25:13 -0400
Received: (qmail 19340 invoked by uid 109); 9 Sep 2019 14:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 14:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9034 invoked by uid 111); 9 Sep 2019 14:27:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS;
 Mon, 09 Sep 2019 10:27:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2019 10:25:12 -0400
From: Jeff King <peff@peff.net>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190909142511.GA20726@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
 <4642438.ai5u8AxThJ@silver> <1897173.eDCz7oYxVq@silver>
 <305577c2-709a-b632-4056-6582771176ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <305577c2-709a-b632-4056-6582771176ac@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 104.130.231.41
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: berrange@redhat.com, stefanha@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, antonios.motakis@huawei.com,
 git@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 09, 2019 at 09:05:45AM -0500, Eric Blake wrote:

> > But as you can already read from the manual, the overall behaviour of git 
> > regarding a separate "From:" line in the email body was intended solely for 
> > the use case sender != author. So in practice (at least in my git version) git 
> > always makes a raw string comparison between sender (name and email) string 
> > and author string and only adds the separate From: line to the body if they 
> > differ.
> > 
> > Hence also "git format-patch --from=" only works here if you use a different 
> > author string (name and email) there, otherwise on a perfect string match it 
> > is simply ignored and you end up with only one "From:" in the email header.
> 
> git folks:
> 
> How hard would it be to improve 'git format-patch'/'git send-email' to
> have an option to ALWAYS output a From: line in the body, even when the
> sender is the author, for the case of a mailing list that munges the
> mail headers due to DMARC/DKIM reasons?

It wouldn't be very hard to ask format-patch to just handle this
unconditionally. Something like:

diff --git a/pretty.c b/pretty.c
index e4ed14effe..9cf79d7874 100644
--- a/pretty.c
+++ b/pretty.c
@@ -451,7 +451,8 @@ void pp_user_info(struct pretty_print_context *pp,
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
 	if (cmit_fmt_is_mail(pp->fmt)) {
-		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
+		if (pp->always_use_in_body_from ||
+		    (pp->from_ident && ident_cmp(pp->from_ident, &ident))) {
 			struct strbuf buf = STRBUF_INIT;
 
 			strbuf_addstr(&buf, "From: ");

but most of the work would be ferrying that option from the command line
down to the pretty-print code.

That would work in conjunction with "--from" to avoid a duplicate. It
might require send-email learning about the option to avoid doing its
own in-body-from management. If you only care about send-email, it might
be easier to just add the option there.

-Peff

