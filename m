Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663D6C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363D020652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363D020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6Xt-0006Xv-Fj
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:42:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hL6Wc-0005pX-M7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hL6Wb-0001Rj-QJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hL6Wb-0001Qi-7r
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 259483092667;
	Mon, 29 Apr 2019 13:40:51 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46CDB6A68A;
	Mon, 29 Apr 2019 13:40:50 +0000 (UTC)
Date: Mon, 29 Apr 2019 09:40:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190429134048.GH7587@stefanha-x1.localdomain>
References: <2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 29 Apr 2019 13:40:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Wei Li <wei.d.li@oracle.com>,
	qemu-devel@nongnu.org, Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429134048.wDqAVkk3BYmMTIFNh2ulzrhP4FSC1iB_daphsDg3eL8@z>


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2019 at 10:14:16AM +0200, Paolo Bonzini wrote:
> On 23/04/19 14:04, Stefan Hajnoczi wrote:
> >> In addition, does Virtio-scsi support Batch I/O Submission feature
> >> which may be able to increase the IOPS via reducing the number of
> >> system calls?
> >
> > I don't see obvious batching support in drivers/scsi/virtio_scsi.c.
> > The Linux block layer supports batching but I'm not sure if the SCSI
> > layer does.
>=20
> I think he's referring to QEMU, in which case yes, virtio-scsi does
> batch I/O submission.  See virtio_scsi_handle_cmd_req_prepare and
> virtio_scsi_handle_cmd_req_submit in hw/scsi/virtio-scsi.c, they do
> blk_io_plug and blk_io_unplug in order to batch I/O requests from QEMU
> to the host kernel.

This isn't fully effective since the guest driver kicks once per
request.  Therefore QEMU-level batching you mentioned only works if QEMU
is slower at handling virtqueue kicks than the guest is at submitting
requests.

I wonder if this is something that can be improved.

Stefan

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxv7gAAoJEJykq7OBq3PIGJMH/11HaW7TKkiLS/WkH9plEatc
XT1tQc7TGjCq8G4p1HDCAgmc+hZTUbNFeLtpKRa4dor+OJAmNKjb+SJlW+PqD/9i
Cb8FuMPAgCmN0cthmcnpBZlW1ZK9pZuCfw+eeuSfTx7CfHvMAxN6keLXpHz2XeQz
1EJ2le/UWKALE9PnpdnVmSUgL3TsBmVAj85MXyaZKyNnyw1vzZ+QAzKTRUELaxxU
mBz0BbDuP+pizTNcxg2nLylAn39rpykwDTjPwKIbjPR+CNJAkYAxO+4rR2n457bR
vnuY/xVpcr0W51a5JwAKJUn7tbfCPzkb2VHpLjxIlIE2Ro2OPX1mq5d/VuL4IYQ=
=QQc2
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--

