Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0AC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2E92077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2E92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLSb-0005A6-5W
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1iSLRr-0004XK-LJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1iSLRq-0006SN-L7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:34:11 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:19965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1iSLRo-0006Nz-4o; Wed, 06 Nov 2019 08:34:08 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 11CB246444;
 Wed,  6 Nov 2019 14:34:06 +0100 (CET)
Date: Wed, 6 Nov 2019 14:34:05 +0100 (CET)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Max Reitz <mreitz@redhat.com>, Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <1098165569.40.1573047245058@webmail.proxmox.com>
In-Reply-To: <2bd155fe-af04-05f2-0bd4-28e844564fc4@redhat.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
 <20191106103450.cafwk7m5xd5eulxo@olga.proxmox.com>
 <37f72cb7-7085-3c40-7728-e41d59137b3b@redhat.com>
 <1868807950.27.1573039080274@webmail.proxmox.com>
 <eb3a232d-6567-1816-b7fc-121770aa42b4@redhat.com>
 <6684852e-da7d-13b2-f226-1c0074e4ab3b@redhat.com>
 <396057714.35.1573045777293@webmail.proxmox.com>
 <2bd155fe-af04-05f2-0bd4-28e844564fc4@redhat.com>
Subject: Re: backup_calculate_cluster_size does not consider source
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev15
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 6 November 2019 14:17 Max Reitz <mreitz@redhat.com> wrote:
>=20
> =20
> On 06.11.19 14:09, Dietmar Maurer wrote:
> >> Let me elaborate: Yes, a cluster size generally means that it is most
> >> =E2=80=9Cefficient=E2=80=9D to access the storage at that size.  But t=
here=E2=80=99s a tradeoff.
> >>  At some point, reading the data takes sufficiently long that reading =
a
> >> bit of metadata doesn=E2=80=99t matter anymore (usually, that is).
> >=20
> > Any network storage suffers from long network latencies, so it always
> > matters if you do more IOs than necessary.
>=20
> Yes, exactly, that=E2=80=99s why I=E2=80=99m saying it makes sense to me =
to increase the
> buffer size from the measly 64 kB that we currently have.  I just don=E2=
=80=99t
> see the point of increasing it exactly to the source cluster size.
>=20
> >> There is a bit of a problem with making the backup copy size rather
> >> large, and that is the fact that backup=E2=80=99s copy-before-write ca=
uses guest
> >> writes to stall. So if the guest just writes a bit of data, a 4 MB
> >> buffer size may mean that in the background it will have to wait for 4
> >> MB of data to be copied.[1]
> >=20
> > We use this for several years now in production, and it is not a proble=
m.
> > (Ceph storage is mostly on 10G (or faster) network equipment).
>=20
> So you mean for cases where backup already chooses a 4 MB buffer size
> because the target has that cluster size?

To make it clear. Backups from Ceph as source are slow.

That is why we use a patched qemu version, which uses:

cluster_size =3D Max_Block_Size(source, target)

(I guess this only triggers for ceph)


