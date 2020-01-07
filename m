Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9831C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 06:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25B42051A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 06:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAM+/9eV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25B42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioiFI-0002WU-QR
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 01:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ioiAB-0003NJ-0f
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ioiA8-0005Ms-Jr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:16:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57394
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ioiA7-0005L1-LF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578377778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gl3IHRBnUfNiNfbm7kDwWA8vLMUOpz/MlQtCtJQ6lU=;
 b=XAM+/9eVflWbJzJQHRKn0pQ3hkIlKc2RxoMr/aOIptRwiK2Kk/wARklqhRsZflDDyp4TJH
 ye4ZHyMQfSNCoXEpcfrCYQwn79KjkIuCUr1K6AqrVJqxeVACPVQzkFdZrRpsEgXpDgZyoV
 5EX5FXVz5SZAunAKRYCp9UsKSlA78Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-K_c-blTaORyJRwgHFoOYmA-1; Tue, 07 Jan 2020 01:16:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA75801E77;
 Tue,  7 Jan 2020 06:16:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CED167EF77;
 Tue,  7 Jan 2020 06:16:14 +0000 (UTC)
Date: Tue, 7 Jan 2020 07:16:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
Message-ID: <20200107061613.GB4076@linux.fritz.box>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106195457.GE2886@minyard.net>
 <f71eb524-571b-54d1-1a99-95d2896f6586@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f71eb524-571b-54d1-1a99-95d2896f6586@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: K_c-blTaORyJRwgHFoOYmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.01.2020 um 21:35 hat Daniel Henrique Barboza geschrieben:
>=20
>=20
> On 1/6/20 4:54 PM, Corey Minyard wrote:
> > On Mon, Jan 06, 2020 at 03:23:26PM -0300, Daniel Henrique Barboza wrote=
:
> > > Hello,
> [...]
> > >=20
> > > Which is cleaner and requires less brain cycles to wonder
> > > whether the 'cleanup' label does anything special, such
> > > as a heap memory cleanup.
> >=20
> > I would disagree with this analysis.  To me, I often wonder
> > when I have to add cleanup code to a routine whether there is
> > some hidden return in the middle of the function.  That's a lot
> > harder to spot than just looking for the cleanup label at the
> > end of the function to see what it does.  For non-trivial
> > functions I prefer to have one point of return at the end
> > (and maybe some minor checks with returns right at the beginning).
> > I'm not adamant about this, just my opinion.

It depends on the case, but yes, I had similar thoughts, at least when
we're talking about non-trivial parts of a function. (Very short
functions of just some initial checks returning directly are usually
fine.)

> I agree that what I'm doing here isn't a one rule fits all situation. Thi=
s
> is why I didn't purge all the 'unused' labels I found. The criteria used =
to
> remove/spare labels will differ from person to person (although I believe=
 that
> cases such as patch 15 isn't too much of a debate), thus I'd rather leave=
 to
> each maintainer to accept/deny the changes based on the context of the co=
de.

So what is your plan for getting the series merged? Should maintainers
just picks patches from the series, or do you want to collect Acked-by
tags and then merge it through a single tree? If the latter, which one?

Kevin


