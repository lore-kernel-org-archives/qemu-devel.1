Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0751BC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E2F20674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 10:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E2F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfMZa-00053z-It
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 06:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hfMZ4-0004fO-5U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:51:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hfMZ2-0000PY-RD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hfMZ2-0000O1-LG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 06:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E4B2368FF
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 10:51:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E67C1001B01;
 Mon, 24 Jun 2019 10:51:02 +0000 (UTC)
Date: Mon, 24 Jun 2019 12:50:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Message-ID: <20190624125057.312554c2@redhat.com>
In-Reply-To: <20190624093655.GE17698@redhat.com>
References: <20190620114116.27254-1-imammedo@redhat.com>
 <87blynv1lu.fsf@dusky.pond.sub.org>
 <20190624093655.GE17698@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 24 Jun 2019 10:51:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH] deprecate -mem-path fallback to
 anonymous RAM
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
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
 ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 10:36:55 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Jun 24, 2019 at 10:17:33AM +0200, Markus Armbruster wrote:
> > Igor Mammedov <imammedo@redhat.com> writes:
> >  =20
> > > Fallback might affect guest or worse whole host performance
> > > or functionality if backing file were used to share guest RAM
> > > with another process.
> > >
> > > Patch deprecates fallback so that we could remove it in future
> > > and ensure that QEMU will provide expected behavior and fail if
> > > it can't use user provided backing file.
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > PS:
> > > Patch is written on top of
> > >   [PATCH v4 0/3] numa: deprecate '-numa node,  mem' and default memor=
y distribution
> > > to avoid conflicts in qemu-deprecated.texi
> > >
> > >  numa.c               | 4 ++--
> > >  qemu-deprecated.texi | 8 ++++++++
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/numa.c b/numa.c
> > > index 91a29138a2..53d67b8ad9 100644
> > > --- a/numa.c
> > > +++ b/numa.c
> > > @@ -494,8 +494,8 @@ static void allocate_system_memory_nonnuma(Memory=
Region *mr, Object *owner,
> > >              if (mem_prealloc) {
> > >                  exit(1);
> > >              }
> > > -            error_report("falling back to regular RAM allocation.");
> > > -
> > > +            warn_report("falling back to regular RAM allocation. "
> > > +                        "Fallback to RAM allocation is deprecated.")=
; =20
> >=20
> > Can we give the user clues on how to avoid the deprecated fallback? =20
>=20
> There's nothing a user can do aside from ensuring they have sufficient
> free memory before launching QEMU to satisfy the huge pag request.
>=20
> Probably just needs changing to do.
>=20
>     "This is deprecated, future QEMU releases will exit when
>      huge pages cannot be allocated"

Also it could be that users might use other than hugepages backing
storage, that's why I completely left concrete advice out from
suggestion.

User should know what he/she is doing when providing mem-path,
if user supplies mis-configured path QEMU will print error
from memory-backend-file if/when allocation fails.


> Regards,
> Daniel


