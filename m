Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A164C468BE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070DB2083D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070DB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFhW-0003C0-1y
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50258)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hZFZS-0005tx-Gq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hZFZR-0003B4-Cf
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hZFZO-00030P-3S; Fri, 07 Jun 2019 10:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 448F730F1BC8;
 Fri,  7 Jun 2019 14:10:13 +0000 (UTC)
Received: from localhost (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C16DD7FE9A;
 Fri,  7 Jun 2019 14:10:07 +0000 (UTC)
Date: Fri, 7 Jun 2019 16:10:06 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190607141006.GA13542@stefanha-x1.localdomain>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
 <878sudu0d1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <878sudu0d1.fsf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 07 Jun 2019 14:10:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/9] Add support for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 12:59:54PM +0200, Sergio Lopez wrote:
> I gave this version of the patchset a try, and found that IO hangs when
> the device is assigned to an IOThread. Sometimes is able to serve a few
> requests getting through the Guest OS boot process, to hang the moment
> you try generate some IO on the device, while others it hangs when Linux
> tries to read the partitions from the device.
>=20
> I'm starting QEMU this way:
>=20
> ./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -name rhel80,debug-thread=
s=3Don -m 2g -smp 4 -object iothread,id=3Diothread0 -blockdev node-name=3Dr=
hel80,driver=3Dqcow2,file.driver=3Dfile,file.filename=3D/home/VirtualMachin=
es/rhel80.qcow2 -device virtio-blk,drive=3Drhel80 -serial tcp::6667,server,=
nowait -qmp tcp::6668,server,nowait -nographic -net user,hostfwd=3Dtcp::666=
6-:22 -net nic,model=3Dvirtio -device virtio-rng -drive file=3D/dev/nullb0,=
format=3Draw,cache=3Dnone,aio=3Dio_uring,if=3Dnone,id=3Dtest -device virtio=
-blk,drive=3Dtest,iothread=3Diothread0
>=20
> Could you please take a look at this issue?

BTW I was referring to the inverted logic where qemu_luring_process_complet=
ions_and_submit() fails to call ioq_submit().

Stefan

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz6cD4ACgkQnKSrs4Gr
c8jiQAf/YLgsRUmLpNrh9l5KwcDQkXb3WIcoBUslEVaXSK6Sq2cEDmqleQ0SCGrk
eSNrSwBw8xYt++vXRAuJCgL+9uS4bimfY33uSk4gKCqPRT+WiqMErhORsymdPkch
Er0WdvRg3DmR5I2ScYN0Q8gi//Fjfo2j2zffoOcjvz3ri9Dl1qWHd49JWcxzskfr
TpEWnHevEM+1dh4gwEu6bmSAOuZcSWzRYSx9Dvb5RqK+27yDY4p8pR/jeU0hUHuN
Anlo3lMisJIJZ1cVFh0Hgo1Dw5NY+1wmC1ORSF2BtYW77qxGzIwxW/g3il0Vd5+T
Etne8tER4Xw45OoHu7dH0D1caTjIMg==
=6fhB
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

