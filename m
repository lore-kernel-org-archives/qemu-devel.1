Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69764C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3088A2190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="vIphTvnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3088A2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4VXn-00055i-9h
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4VWs-0004ZO-Lw
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 15:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4VWr-0003QL-Cg
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 15:28:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:60995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i4VWq-0003MS-SU
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 15:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xEDLjYHeT5GS+2rQbFL9VzyeaKpd+Z3jMP5umb7/1Wo=; b=vIphTvnM23T8N0ZT1yawophMCx
 uCmXoGy4Uhoof13++ZzGQ2IUHj4P9NxRuFQwHlqXOATyBTCRzB9439MUTdIOdCEe2ybyZS1HLO0hF
 UPSzZvM9NdmJdvqwnbv/zwmWbnRcRQq8OXkKpKr2qE2heFXJZCNyikV0+eN+LMQcWOd/03HaRnEso
 HB3xf2inKfSYDKgYER0Yoi5CoLSZD4AqAv1xv9KpUKE5oX0rw+8KwsFjMQkguxL+dNWyVefSX67NB
 L6mgFRQozgIVknSFh1sBikAzrap66GXqx4waTQh2JFNTtw1q6fC6mu2FhqxchW/ADnpgbYayl4qPP
 Z23BQMUdSt07f42Yae53IpkgD8IhjD5l3duBAAQQePFBEySEY5SecCflGGXPhwYcwHRDfoqWU4SPh
 GVxw11UbcVdHFXtRZovGrCSPjB1+r8AU6BYoj97njub72CoUcIKAq9LNGlFPmKyPnURP7ZjAnh2h/
 s59nUflYviI2rsK5MrV0GlQTHCbPu9N2vAfJHFn9LL4riknD2JhoSpGLQAoK5oUnqw7zi7BA4Ty2Q
 tFbF5tgTLG6cEtH/JnoJGynlWuvlI0lv6b5z7KFZ6Tf7rUt9oSpj+Q9oip9/bb/8ylpMsAWIWV0U1
 ZEXaONztONA35Ks/XJ+IUiA6sepQkFnDpNqYszPXA=;
To: qemu-devel@nongnu.org
Date: Sun, 01 Sep 2019 21:28:45 +0200
Message-ID: <21182000.2zn5IIMESL@silver>
In-Reply-To: <20190829190234.41c8d988@bahia.lan>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <156651233307.28865.18175668587519528989@5dec9699b7de>
 <20190829190234.41c8d988@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: stefanha@gmail.com, berrange@redhat.com, Greg Kurz <groug@kaod.org>,
 antonios.motakis@huawei.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 29. August 2019 19:02:34 CEST Greg Kurz wrote:
> On Thu, 22 Aug 2019 15:18:54 -0700 (PDT)
> 
> no-reply@patchew.org wrote:
> > Patchew URL:
> > https://patchew.org/QEMU/cover.1566503584.git.qemu_oss@crudebyte.com/
> > 
> > 
> > 
> > Hi,
> > 
> > This series seems to have some coding style problems. See output below for
> > more information:
[snip]
> > 
> > === OUTPUT BEGIN ===
> > 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one export
> > as an error) ERROR: Author email address is mangled by the mailing list
> > #2:
> > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> 
> This is problematic since it ends up in the Author: field in git. Please
> find a way to fix that.

Like in which way do you imagine that? And where is the actual practical 
problem? I mean every patch still has my signed-off-by tag with the correct 
email address ending up in git history.

The cause for this issue is that the domain is configured to require DKIM 
signatures for all outgoing emails. That's why mailman replaces my address by
"Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>" placeholder 
since it could not provide a valid signature.

There were good reasons for enabling DKIM and it is a good thing for all 
domains in general, since that ensures that (i.e. foreign) email addresses 
cannot be used as sender address if the actual sender is not authorized for 
sending emails with that address.

What I changed in the meantime though is that you should get all my patches 
directly to your personal address, not only from the list. Or did you receive 
v6 again just from the list?

> Other warnings/errors should also be fixed but they look trivial.

Yeah, they are trivial. *But* there is one thing ...

> > Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> > 
> > ERROR: space prohibited after that open parenthesis '('
> > #92: FILE: hw/9pfs/9p.c:586:
> > +    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
> > 
> > ERROR: space prohibited before that close parenthesis ')'
> > #98: FILE: hw/9pfs/9p.c:592:
> > +           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
> > 
> > ERROR: space prohibited before that close parenthesis ')'
> > #99: FILE: hw/9pfs/9p.c:593:
> > +           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;

... I would like to ignore this specific bot whining, because that particular 
function looks much more readable the way it is (in that patch) right now.

> > WARNING: Block comments use a leading /* on a separate line
> > #102: FILE: hw/9pfs/9p.c:596:
> > +/** @brief Parameter k for the Exponential Golomb algorihm to be used.
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #121: FILE: hw/9pfs/9p.c:615:
> > +/** @brief Exponential Golomb algorithm for arbitrary k (including k=0).
> > 
> > WARNING: Block comments use a leading /* on a separate line
> > #148: FILE: hw/9pfs/9p.c:642:
> > +/** @brief Converts a suffix into a prefix, or a prefix into a suffix.

