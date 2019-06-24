Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E281C48BE9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3565320645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 19:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3565320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfV5v-0003Jk-Am
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 15:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfV4h-0002qy-4i
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfV4g-0006O7-5p
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfV4f-0006Mu-W6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 15:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CF6058E23;
 Mon, 24 Jun 2019 19:56:15 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D17B60BFB;
 Mon, 24 Jun 2019 19:56:13 +0000 (UTC)
Date: Mon, 24 Jun 2019 16:56:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190624195612.GM1862@habkost.net>
References: <20190624190214.14468-1-mreitz@redhat.com>
 <20190624192108.GL1862@habkost.net>
 <8cfbd3c5-9473-46bf-b59b-b7d7711d636f@redhat.com>
 <a75ac63e-c84b-c674-4a42-e96c4c0d9326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a75ac63e-c84b-c674-4a42-e96c4c0d9326@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 19:56:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: Fix build with -m32
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 09:30:26PM +0200, Max Reitz wrote:
> On 24.06.19 21:26, Max Reitz wrote:
> > On 24.06.19 21:21, Eduardo Habkost wrote:
> >> On Mon, Jun 24, 2019 at 09:02:14PM +0200, Max Reitz wrote:
> >>> find_next_bit() takes a pointer of type "const unsigned long *", bu=
t the
> >>> first argument passed here is a "uint64_t *".  These types are
> >>> incompatible when compiling qemu with -m32.
> >>>
> >>> Just cast it to "const void *", find_next_bit() works fine with any=
 type
> >>> on little-endian hosts (which x86 is).
> >>>
> >>> Fixes: c686193072a47032d83cb4e131dc49ae30f9e5d
> >>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>
> >> Why not declare kvm_hyperv_properties.dependencies with the right
> >> type for bitmaps, using
> >>   unsigned long dependencies[BITS_TO_LONGS(64)]
> >> ?
> >=20
> > How would you (statically) initialize that field, then?
> >=20
> > I cannot imagine a reasonable static way that does not invoke the sam=
e
> > =E2=80=9CThe host must be little-endian, so it=E2=80=99s OK=E2=80=9D =
assumption.
>=20
> Sorry, brain fart.  That=E2=80=99s not the problem because in either ca=
se, the
> lower index will receive the lower-indexed bits.
>=20
> But we=E2=80=99d still have to deal with the fact that it could either =
be one or
> two indices, which doesn=E2=80=99t seem nice to initialize either.

Right, a uint64_t field is more convenient to initialize.

>=20
> Max
>=20
> > The better question is perhaps, why not use ffsll().  Hm.  I don=E2=80=
=99t know,
> > maybe I should?

uint64_t + ffsll() seems simple and appropriate.

--=20
Eduardo

