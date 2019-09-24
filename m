Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC13C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DA020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HSq3lc2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DA020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgkm-0001ek-6d
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCgjZ-00015p-P6
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCgjY-00057F-DB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:03:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:43019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iCgjX-00056s-TU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=nGck1Wtr524nplgwPVub0IVaYw0ulDwWIzroh0FHfjY=; b=HSq3lc2zEE3tbCetwyhSq7BN3J
 G0g7qkGhhy6Sa6HG2z+RX7sWb/OpMHE4+IwhnkWyRdr5iMgQo1VgD8geZnciyu4tV9/lyZ2bGWkXr
 BTiMb8Ke/7iqaGP7KhkECPNV8OXr2svFm91qExkmc8vpYbotbWqXH1JAWbJ5ppqr8OH8Xbt6F+Cca
 fm5W5TkmfSHhwekwoEZULDovr9EIF4Sq2dNEh1ArVuO1QEIMuHb+WCqbaAi8Osuz/AIzBm++wYusa
 H+Pg4m2A3G4Mvxj3EYFpii+O39I7FCoJLlMdkWG1RVU8tcjByOAgDvShZKZW3BbPORH92sXp0ybzO
 wXGrC2vCaxyDnMnf6OeMUu28KKW5AIuzM+Qrn41irQGpYt2DvkI0f9H0KXm0cOu8ksr8nDCdeV1fM
 AkzXudeQQg1d/K7nTp6bNL4K5bnt8IEzxIn0mDomD8oOsmr5sE/ZSstRF4tau1xF4ZOAEY5L86N3S
 9lTtDUxkRlp4F4vtU8MBvbdQa2nvO1y8ZTqRJizGoPezcHiIvsvoZCR7ejQ16vZMPYTobxlWKBGR0
 jmqohKbtzsP7UgtsDz4abmQWGIbEZRE+qO1K8inM013Seg8hZmgRzVIwQoDeEMKVoZi6sf3AjgQTh
 UkvrrKVK6tHEzqpyHx5xeGTp0Wgo285eqb/zBFOXw=;
To: qemu-devel@nongnu.org
Subject: git format.from (was: 9p: Fix file ID collisions)
Date: Tue, 24 Sep 2019 11:03:38 +0200
Message-ID: <3312839.Zbq2WQg2AT@silver>
In-Reply-To: <20190923222415.GA22495@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <56046367.TiUlWITyhT@silver> <20190923222415.GA22495@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
 dgilbert@redhat.com, Jeff King <peff@peff.net>, Ian Kelling <iank@fsf.org>,
 antonios.motakis@huawei.com, git@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Christian Schoenebeck <qemu_oss@crudebyte.com>
From: Christian Schoenebeck via <qemu-devel@nongnu.org>

On Dienstag, 24. September 2019 00:24:15 CEST Jeff King wrote:
> > On the other hand, considering the already existing --from argument and
> > "format.from" config option:
> > https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatfro
> > m
> > 
> > Wouldn't it make sense to just drop the currently existing sender !=
> > author
> > string comparison in git and simply always add the "From:" line to the
> > email's body if "format.from yes" is used, instead of introducing a
> > suggested 2nd (e.g. "always-from") option? I mean sure automatically
> > removing redundant information in the generated emails if sender ==
> > author sounds nice on first thought, but does it address anything useful
> > in practice to justify introduction of a 2nd related option?
> 
> Yes, the resulting mail would be correct, in the sense that it could be
> applied just fine by git-am. But I think it would be uglier. IOW, I
> consider the presence of the in-body From to be a clue that something
> interesting is going on (like forwarding somebody else's patch). So from
> my perspective, it would just be useless noise. Other communities may
> have different opinions, though (I think I have seen some kernel folks
> always including all of the possible in-body headers, including Date).
> But it seems like it makes sense to keep both possibilities.

Exactly, current git behaviour is solely "prettier" (at first thought only 
though), but does not address anything useful in real life.

Current git behaviour does cause real life problems though: Many email lists 
are munging emails of patch senders whose domain is configured for requiring 
domain's emails being DKIM signed and/or being subject to SPF rules (a.k.a 
DMARC). So original sender's From: header is then automatically replaced by an 
alias (by e.g. mailman): https://en.wikipedia.org/wiki/DMARC#From:_rewriting

For instance the email header:

From: "Bob Bold" <bold@foo.com>

is automatically replaced by lists by something like

From: "Bob Bold via Somelist" <somelist@gnu.org>

And since git currently always drops the From: line from the email's body if
sender == author, as a consequence maintainers applying patches from such 
lists, always need to rewrite git history subsequently and have to replace 
patch author's identity manually for each commit to have their correct, real 
email address and real name in git history instead of something like
"Bob Bold via Somelist" <somelist@gnu.org>

So what do you find "uglier"? I prefer key info not being lost as default 
behaviour. :-)

Best regards,
Christian Schoenebeck



