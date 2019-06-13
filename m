Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87645C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509C520896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509C520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMLm-0004Ps-1e
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hbMIi-0002QL-3z
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hbMC7-00011u-DM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hbMC6-00010m-3P; Thu, 13 Jun 2019 05:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 007B7308124D;
 Thu, 13 Jun 2019 09:38:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E680537B3;
 Thu, 13 Jun 2019 09:38:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8596611AA3; Thu, 13 Jun 2019 11:38:50 +0200 (CEST)
Date: Thu, 13 Jun 2019 11:38:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190613093850.5k7prawn6x4qt3fi@sirius.home.kraxel.org>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
 <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
 <20190612191817.5bilt2abif2xvcbv@sirius.home.kraxel.org>
 <02844D7D-ED79-4744-A203-8E713DE7A717@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02844D7D-ED79-4744-A203-8E713DE7A717@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 09:38:53 +0000 (UTC)
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
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Yes they are pretty rare.
> Windows 2000 and Windows XP guests migrated from VMware to Qemu/KVM
> would not boot due to incorrect disk geometries (some had 32/56 spt ins=
tead of
> 56. Also number of heads was not entirely correct)

Ok.

> > Why?  Asking the user to deal with the mess is pretty lame if there a=
re
> > better options.  And IMO doing this fully automatic in seabios is
> > better.
>=20
> I=E2=80=99m not against an automatic approach, however I do think that =
doing this
> in SeaBIOS might break compatibility for already existing guests that w=
ill
> suddenly see different LCHS values. (Explanation below)

> > I can't see how this can break guests.  It should either have no effe=
ct
> > (guests using LBA) or unbreak guests due to LCHS changing from "wrong=
"
> > to "correct=E2=80=9D.
>=20
> I=E2=80=99m not sure what do you mean by "unbreak guests=E2=80=9D if yo=
u change an existing
> guest that uses LCHS from 56 spt to LBA (63 spt) it will stop booting.

Well, that LCHS change happens because you move the guest from vmware to
qemu and seabios uses 63 spt no matter what if the disk is too big for
chs addressing.

When seabios is changed to look at the MBR to figure what the lchs of
the disk is that will make your guest boot.

> Your guessing algorithm will have to guess 56, if it will fail guessing=
 56 correctly,
> the user can not perform any action beside downgrading SeaBIOS in order=
 to run
> the guest.

Sure, if the guess is wrong then the guest will not boot.  That isn't
worse than the situation we have today where seabios will not even try
to figure what the lchs of the disk is.

And, no, downgrading seabios will not make your vmware guest with 56 spt
boot.

cheers,
  Gerd


