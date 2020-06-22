Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470BF20706
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpPdLPv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470BF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMwO-0005hi-HN
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jnMv5-0003pB-F4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:55:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jnMv3-0007eR-Do
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3eabhNTQgUfzLWq5AH5Vfv2L4tvfZjzwzQbnsJq0HSg=;
 b=gpPdLPv7dCe5WN4etBeh86Rh0hcFbzCqnFYhf8dTFA3culDlWacleqSCqkICvmowPgezE8
 3GkeQm8IOuyFcPDPQgx9f5sLZIMcFSHdWRuDRm2UELzvsGmr81y8MEiH4gR2TMlpZC89Z3
 r/LHebHKmFMq0spyLCAMPSzdzJe+Dlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-vivjSs9xNt2oMeerYiy-xg-1; Mon, 22 Jun 2020 09:54:50 -0400
X-MC-Unique: vivjSs9xNt2oMeerYiy-xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EED9107ACF8;
 Mon, 22 Jun 2020 13:54:49 +0000 (UTC)
Received: from localhost (ovpn-113-68.rdu2.redhat.com [10.10.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29C8C5BAD8;
 Mon, 22 Jun 2020 13:54:45 +0000 (UTC)
Date: Mon, 22 Jun 2020 15:54:44 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/7] block/nvme: poll queues without q->lock
Message-ID: <20200622135444.pgpvzjofc5pood44@dritchie>
References: <20200617132201.1832152-1-stefanha@redhat.com>
 <20200617132201.1832152-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617132201.1832152-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hq3ufwnzlm7m4e7h"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hq3ufwnzlm7m4e7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 02:21:55PM +0100, Stefan Hajnoczi wrote:
> A lot of CPU time is spent simply locking/unlocking q->lock during
> polling. Check for completion outside the lock to make q->lock disappear
> from the profile.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index eb2f54dd9d..e4375ec245 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -512,6 +512,18 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
> =20
>      for (i =3D 0; i < s->nr_queues; i++) {
>          NVMeQueuePair *q =3D s->queues[i];
> +        const size_t cqe_offset =3D q->cq.head * NVME_CQ_ENTRY_BYTES;
> +        NvmeCqe *cqe =3D (NvmeCqe *)&q->cq.queue[cqe_offset];
> +
> +        /*
> +         * Do an early check for completions. q->lock isn't needed becau=
se
> +         * nvme_process_completion() only runs in the event loop thread =
and
> +         * cannot race with itself.
> +         */
> +        if ((le16_to_cpu(cqe->status) & 0x1) =3D=3D q->cq_phase) {
> +            continue;
> +        }
> +
>          qemu_mutex_lock(&q->lock);
>          while (nvme_process_completion(s, q)) {
>              /* Keep polling */
> --=20
> 2.26.2
>

Thanks for extending the comment.

Reviewed-by: Sergio Lopez <slp@redhat.com>

--hq3ufwnzlm7m4e7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7wuCMACgkQ9GknjS8M
AjVuQhAAsvO6q8Kcccgi2BfcaVtQHgjtFdoV9T8m+OsD2PO5UPGTQOc6AIEWrOpr
1ra+W8m7i2Xg0aPEwU7XIO0qfXRy2holciu3Pe5dQI3xPDeU1T0i4Y6SygZWuNtd
mIrTNkYAAx4WhvFRNRI5iGeI/uVDqaZFe+U5oyJ3WanTpszwvcWTh5QyQYIw1lrw
YwOVwr24KQL8jb0EN11BSkvFJpwugCrVsAiUysokRY1ot+QPdOYbPcT/yhTdcbu1
aSxc/tOgvlSit9hn4MIcXbUD7dcVwIbIBdh04ufCM3ejBQeWFgUWlm8v1kd+DOGv
5E1iPny7aiRK7Qdx6D/smX0mhUYmmb69Ta0MAbPKRnbKzVqRLxmZ2i87YPn+wEeX
MOKHksijAA6jgJw4S1I0zJxLZOTe7WSmMSBv4ea6M0RdurSMRBFB/4BLviVCoOnT
MPwPlENXb5R3sJRH92ywAHqp24RbmGC1yx/NpZRiHb6SjHytJ5c1KX77NSwXMn9b
obB57hJJqEco8dL1dpIQG+pK7e6A9Zxsf9DTS+UI0r3i2+sFi1cH78AACN1D43wo
Chs3s2cM7utgz0qsLAYjCUpAGvk8QmfqKoiuzsC5cfNLMHEqdU684MjpjZxdM+tL
3pwDDor5AUbZnt6tvoEeIDiiQJIxFNPYKZK+RVdwQvANlqwLdPA=
=I9LI
-----END PGP SIGNATURE-----

--hq3ufwnzlm7m4e7h--


