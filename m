Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68645C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ACD2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ACD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Zbi-0007nw-BY
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 07:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2Zaf-0007DW-6l
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2Zae-00043U-6W
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2Zaa-00040z-N5; Tue, 27 Aug 2019 07:24:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0086DC057F88;
 Tue, 27 Aug 2019 11:24:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 761295C1B2;
 Tue, 27 Aug 2019 11:24:32 +0000 (UTC)
Message-ID: <165d58ab7e9fe07835c233b2b1347d763be819a8.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Tue, 27 Aug 2019 14:24:30 +0300
In-Reply-To: <20190827105226.GI16500@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-2-mlevitsk@redhat.com>
 <20190827105226.GI16500@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 27 Aug 2019 11:24:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/13] introduce g_autowipe
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-27 at 11:52 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Aug 26, 2019 at 04:50:51PM +0300, Maxim Levitsky wrote:
> > Marking a pointer with g_autowipe, will
> > not only free it at the scope exit, but also
> > erase the data it points to just prior to freeing it.
> >=20
> > This is first attempt to implement this feature,
> > as suggested by Daniel and Nir.
> >=20
> > The things that need to be verified prior to merging this is
> >=20
> > 1. Can we just always use memset_s (defined in C++)
> >  or some alternative.
> >=20
> > 2. is it portable enought for us to use malloc_usable_size
> > to get the size of malloced pointer in the autofree callback?
> > This function is aviable in glibc (but no wrapper in glib).
>=20
> Urgh, no, we can't rely on that.
>=20
> I completely forgot that we would need to know the size during
> the deallocate function.  The portable way to deal with this
> will be to change all our code that handles passwords to use
> GString instead, since that is a struct carrying around the
> allocated size.
>=20
> As mentioned in v1, I'm fine if you just let this series use
> memset as this is a pre-existing problem & we can fix it
> in separate yseries.

All right, I *was* afraid of that, but I guess it was worth a try anyway.
So I think I'll keep that patch that adds few missing memsets,=20
just to consistency/documentation purposes since anyway
in addtion to these there are lot of other places that keys are kept,
like the ciphers itself, secrets (which aren't even freed  usually
as long as VM is running)

The purpose was that I just that memsetting caught my eye and
I wanted to make it at least consistent.

Thanks for the review,
	Best regards,
		Maxim Levitsky



