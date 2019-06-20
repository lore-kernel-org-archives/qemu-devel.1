Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2629C48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4182080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4182080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvbZ-0001jk-Cs
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hdvY8-00082C-AK
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hdvXx-0004J9-1f
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hdvXv-00046K-P7; Thu, 20 Jun 2019 07:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8528230BB559;
 Thu, 20 Jun 2019 11:47:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com
 [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7351001F54;
 Thu, 20 Jun 2019 11:47:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3E67717446; Thu, 20 Jun 2019 13:47:22 +0200 (CEST)
Date: Thu, 20 Jun 2019 13:47:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190620114722.uaw33cmfsysmf6xh@sirius.home.kraxel.org>
References: <20190619092352.23583-1-shmuel.eiderman@oracle.com>
 <20190619092352.23583-5-shmuel.eiderman@oracle.com>
 <20190620054224.hfspxgorpd6mjxca@sirius.home.kraxel.org>
 <ECC27FB9-1975-4C78-9584-BC82BB7FA34B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ECC27FB9-1975-4C78-9584-BC82BB7FA34B@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 20 Jun 2019 11:47:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH v3 4/4] geometry: Apply LCHS
 values for boot devices
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
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 11:52:01AM +0300, Sam Eiderman wrote:
>=20
>=20
> > On 20 Jun 2019, at 8:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >=20
> >> +static int
> >> +overriden_lchs_supplied(struct drive_s *drive)
> >> +{
> >> +    return drive->lchs.cylinder || drive->lchs.head || drive->lchs.=
sector;
> >> +}
> >=20
> >> +    case TRANSLATION_MACHINE:
> >=20
> > Hmm, why this name?  Doesn't look intuitive to me.
>=20
> TRANSLATION_HOST?
>=20
> >=20
> >> +        desc =3D "overriden";
> >=20
> > I'd name that "host-supplied" or "fw-cfg=E2=80=9D.
>=20
> =E2=80=9Chost-supplied=E2=80=9D?
>=20
> >=20
> >> +        cylinders =3D drive->lchs.cylinder;
> >> +        heads =3D drive->lchs.head;
> >> +        if (heads > 255)
> >> +            heads =3D 255;
> >=20
> > I suggest to move these sanity checks to overriden_lchs_supplied(), t=
hen
> > ignore the override altogether when heads or sectors is out of range
> > instead of trying to fixup things.
>=20
> Sounds reasonable.
> I=E2=80=99ll rename to host_lchs_supplied()?
>=20
> WDYT?

looks all good to me.

cheers,
  Gerd


