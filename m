Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82382C31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 06:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5172C21855
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 06:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5172C21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hclUo-00038B-Cb
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 02:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hclTm-0002a8-2X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hclTl-00055c-5d
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hclTj-00053b-4Q; Mon, 17 Jun 2019 02:50:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84E26C04FFF1;
 Mon, 17 Jun 2019 06:50:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 209A04647A;
 Mon, 17 Jun 2019 06:50:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4CD0916E18; Mon, 17 Jun 2019 08:50:50 +0200 (CEST)
Date: Mon, 17 Jun 2019 08:50:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190617065050.nx76n6625tm3d2oo@sirius.home.kraxel.org>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
 <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
 <20190612191817.5bilt2abif2xvcbv@sirius.home.kraxel.org>
 <02844D7D-ED79-4744-A203-8E713DE7A717@oracle.com>
 <20190613093850.5k7prawn6x4qt3fi@sirius.home.kraxel.org>
 <730C65DE-A9B4-4553-B6A0-7A3B81A1FA12@oracle.com>
 <20190614044310.wxnkwxagr23d5cbt@sirius.home.kraxel.org>
 <985C60F2-999C-44C6-B8BC-B5603DD0F716@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <985C60F2-999C-44C6-B8BC-B5603DD0F716@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 17 Jun 2019 06:50:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 0/8] Add Qemu to SeaBIOS LCHS
 interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kevin O'Connor <kevin@koconnor.net>,
 liran.alon@oracle.com, Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Ok, given that seabios has no setup any manual configuration needs to=
 be done via qemu.
> >=20
> > But why do we need a new interface for that?  IDE can pass the geomet=
ry
> > to the guest.  virtio-blk has support too (VIRTIO_BLK_F_GEOMETRY).
> > Likewise scsi (MODE_PAGE_HD_GEOMETRY).  So this should be doable with=
out
> > any qemu changes.
>=20
> This was indeed considered (all 3 methods) but it has the following iss=
ues:
>=20
> Physical geometries of devices must now also be logical geometries with=
 translation=3Dnone.

Yes.

> When the OS will query these devices - It will now see different physic=
al geometries, adapted to be logical geometries.

Yes.

> I=E2=80=99m not sure even how to implement this without breaking existi=
ng
> compatibility - since we don=E2=80=99t want to affect logical geometrie=
s of
> currently used guests.

We can copy the logic which calculates lchs from seabios to qemu and use
it for pchs.

The tricky part of this is how to do the switch without requiring a
lockstep update of seabios and qemu.  seabios can't easily know whenever
it should use the current logic (current qemu) or whenever it should
simply use pchs with translation=3Dnone (updated qemu).

Hmm ...

> MODE_PAGE_HD_GEOMETRY does not contain the spts, only cylinders (as 3
> byte number) and heads (as 1 byte number) and computes the spts using:

Well, there also is MODE_PAGE_FLEXIBLE_DISK_GEOMETRY.

> Moving a scsi-hd/virtio-blk with 255 physical heads to ide-hd, we will
> still need to report 255 heads - this is possible since a whole byte
> can be used in the =E2=80=9Cide identify=E2=80=9D command, but goes aga=
inst the spec
> of a maximum of 16 heads for IDE.

Why do you want migrate _to_ IDE?

> Overall this approach is much more complicated.

Well, adding new fw_cfg interfaces has a long term maintenance cost.
So there should be a pretty good reason for them.

cheers,
  Gerd


