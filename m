Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A316C4CED0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2C22186A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2C22186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tDQ-0004pK-Kv
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i9sU9-0007iI-Jv
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i9sU6-0006Nw-Vn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i9sU0-0006H6-HS; Mon, 16 Sep 2019 11:00:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1518D3082145;
 Mon, 16 Sep 2019 15:00:00 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E929600C1;
 Mon, 16 Sep 2019 14:59:58 +0000 (UTC)
Message-ID: <3b92befa75d8d585a315506e9243ecffda3dbf6b.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 17:59:56 +0300
In-Reply-To: <09fe1c9595b9435bd1f48e173c140edab5e96dc3.camel@redhat.com>
References: <20190915203655.21638-1-mlevitsk@redhat.com>
 <d2c07712-c292-1341-3dfb-2529e71e3744@redhat.com>
 <09fe1c9595b9435bd1f48e173c140edab5e96dc3.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 16 Sep 2019 15:00:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 0/3] Fix qcow2+luks corruption
 introduced by commit 8ac0f15f335
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-16 at 16:59 +0300, Maxim Levitsky wrote:
> On Mon, 2019-09-16 at 15:39 +0200, Max Reitz wrote:
> > On 15.09.19 22:36, Maxim Levitsky wrote:
> > > Commit 8ac0f15f335 accidently broke the COW of non changed areas
> > > of newly allocated clusters, when the write spans multiple clusters=
,
> > > and needs COW both prior and after the write.
> > > This results in 'after' COW area being encrypted with wrong
> > > sector address, which render it corrupted.
> > >=20
> > > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1745922
> > >=20
> > > CC: qemu-stable <qemu-stable@nongnu.org>
> > >=20
> > > V2: grammar, spelling and code style fixes.
> > > V3: more fixes after the review.
> > > V4: addressed review comments from Max Reitz,
> > >     and futher refactored the qcow2_co_encrypt to just take full ho=
st and guest offset
> > >     which simplifies everything.
> > >=20
> > > V5: reworked the patches so one of them fixes the bug
> > >     only and other one is just refactoring
> > >=20
> > > V6: removed do_perform_cow_encrypt
> > >=20
> > > V7: removed do_perform_cow_encrypt take two, this
> > >     time I hopefully did that correctly :-)
> > >     Also updated commit names and messages a bit
> >=20
> > Luckily for you (maybe), Vladimir=E2=80=99s series doesn=E2=80=98t qu=
ite pass the
> > iotests for me, so unfortunately (I find it unfortunate) I had to rem=
ove
> > it from my branch.  Thus, the conflicts are much more tame and I felt
> > comfortable taking the series to my branch (with the remaining trivia=
l
> > conflicts resolved, and with Vladimir=E2=80=99s suggestion applied):
> >=20
> > https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20
>=20
> First of all, Thanks!
>=20
> I don't know if this is luckily for me since I already rebased my serie=
s on top of =20
> https://git.xanclic.moe/XanClic/qemu.git,
> and run all qcow2 iotests, and only tests=20
> 162 169 194 196 234 262 failed, and I know that 162 always fails
> due to that kernel change I talked about here few days ago,
> and rest for the AF_UNIX path len, which I need to do something
> about in the long term. I sometimes do a separate build in=20
> directory which path doesn't trigger this, and sometimes,
> when I know that I haven't done significant changes to the patches,
> I just let these tests fail. In long term, maybe even in a few days
> I'll allocate some time to rethink the build environment here to
> fix that permanently.
>=20
> Now I am rerunning the iotests just for fun, in short enough directory
> to see if I can reproduce the failure that you had. After looking
> in your report, that iotest 026 fails, it does pass here, but
> then I am only running these iotests on my laptop so I probably
> don't trigger the race you were able to.

Passed all the tests but 162, not that it matters much to be honest.
Best regards,
	Maxim Levitsky


