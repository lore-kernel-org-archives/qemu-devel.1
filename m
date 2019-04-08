Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE4C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1698E20870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1698E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQAR-00074s-Eq
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:02:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hDQ8a-00067X-Jh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hDQ8Z-0002lq-Hc
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:00:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hDQ8W-0002kT-UD; Mon, 08 Apr 2019 05:00:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F342E3082B4C;
	Mon,  8 Apr 2019 09:00:15 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D71D25FC17;
	Mon,  8 Apr 2019 09:00:14 +0000 (UTC)
Date: Mon, 8 Apr 2019 10:00:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190408090013.GJ15001@stefanha-x1.localdomain>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 08 Apr 2019 09:00:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
	den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408090013.wve70FoM7pLeMWIhYqQ79FZTKPFA55747FHcWVAF1lQ@z>


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 05:24:04PM +0300, Andrey Shinkevich wrote:
> On a file system used by the customer, fallocate() returns an error
> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> fails. We can handle that case the same way as it is done for the
> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
> zeroes to an image for the unaligned chunk of the block.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block-next tree for QEMU 4.1:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqw2dAAoJEJykq7OBq3PIfVQH/RDkGhJfcMi4ewcbpIreJvHg
N7MwBnaAMhGaQfIVmTfxsOAvbfe3X+j/biQDRp38g5E2YV15yKT8T4qgOzVeUemg
bVm6i4pZS+m2z/V53FERIS1FOPYyMMFHQF5ttC8uicKJmpkk4tMhOmZtVj9PyLb/
Q7d9yWXFrXxERmpJ+SY3vuCX5f48Nt48hYqCLIENypFa1jFg24S8z/w8Qq22zFzk
DlafQoTLQENSVoBuLjriLQRWVjmuq+kpVxARGYxf9++iBScG2kET46swNbVIfU8y
aijI1NdxKhBR2f748po7JPiOennTWefHbo010PwdJ7kPbpeBBaqwkDkJ/0H5Euw=
=nhUx
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--

