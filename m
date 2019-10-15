Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DBECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FA92089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FA92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKJpF-0004YY-PT
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iKJoe-00049R-Lt
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iKJoc-0002YO-VY
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iKJoc-0002Xz-NM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:12:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07811308624A;
 Tue, 15 Oct 2019 10:12:29 +0000 (UTC)
Received: from redhat.com (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4814460BE2;
 Tue, 15 Oct 2019 10:12:26 +0000 (UTC)
Date: Tue, 15 Oct 2019 11:12:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: RFC: Why dont we move to newer capstone?
Message-ID: <20191015101223.GF22859@redhat.com>
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
 <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
 <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
 <20191015082708.GB22859@redhat.com>
 <0a4262f8-df07-e83e-0928-b6cf4e12800d@redhat.com>
 <20191015084722.GD22859@redhat.com>
 <CAJ+F1CJACARosH6agtDQoyo6VoubYfrRm5z6DpiiV+fdw0U8aQ@mail.gmail.com>
 <20191015091444.GE22859@redhat.com>
 <CAFEAcA8_MSHnGhr0R=YDqT7kZJTSOh-U5KmqGAJ5A3XuqV=-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8_MSHnGhr0R=YDqT7kZJTSOh-U5KmqGAJ5A3XuqV=-Qw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 15 Oct 2019 10:12:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 10:57:44AM +0100, Peter Maydell wrote:
> On Tue, 15 Oct 2019 at 10:14, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Tue, Oct 15, 2019 at 11:02:43AM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > I suppose the same applies to dtc (1.4.2 required by qemu, but xeni=
al
> > > has 1.4.0... so we have to wait until April 26, 2020? 18.04 LTS
> > > release date + 2y).
> >
> > Possibly - depends on scope of changes between 1.4.0 & 1.4.2 - maybe =
it
> > is easy to conditionally support 1.4.0 too.
>=20
> We need fdt_first_subnode() and fdt_next_subnode() which only
> came in in 1.4.2.

Looks like those are just shims around fdt_next_node() which existed
in previous releases already, just to make code a little cleaner:

  commit 4e76ec796c90d44d417f82d9db2d67cfe575f8ed
  Author: Simon Glass <sjg@chromium.org>
  Date:   Fri Apr 26 05:43:31 2013 -0700

    libfdt: Add fdt_next_subnode() to permit easy subnode iteration
   =20
    Iterating through subnodes with libfdt is a little painful to write a=
s we
    need something like this:
   =20
    for (depth =3D 0, count =3D 0,
            offset =3D fdt_next_node(fdt, parent_offset, &depth);
         (offset >=3D 0) && (depth > 0);
         offset =3D fdt_next_node(fdt, offset, &depth)) {
            if (depth =3D=3D 1) {
                    /* code body */
            }
    }
   =20
    Using fdt_next_subnode() we can instead write this, which is shorter =
and
    easier to get right:
   =20
    for (offset =3D fdt_first_subnode(fdt, parent_offset);
         offset >=3D 0;
         offset =3D fdt_next_subnode(fdt, offset)) {
            /* code body */
    }
   =20
    Also, it doesn't require two levels of indentation for the loop body.
   =20

so I think we could indeed do conditional compilation where we provide a
local impl of fdt_first|next_subnode if we see older dtc present.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

