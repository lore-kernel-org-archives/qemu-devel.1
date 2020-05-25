Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC9B206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPQDLxmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC9B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd89U-0002Nq-UF
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd88t-0001te-6W
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:07:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd88r-0008Fx-IM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78fV676WWckCqY/6pxqJc0u642laGGmZSW63jHhuPc4=;
 b=HPQDLxmvS4VwyFmBbxAi1MQDTPeKq+LSlQMNUNvBJVNUIuUia7Xe00e+ujdn6udgPmGY3P
 Oxl4Ac6Od+Az9RXY3fZbEinQNcqSFX2H7HSDCCIUdsjuv9/thOm9F2VKC+lp6V5HVZZmlR
 flX6bfpUXTYlF0MwKnDygTEr0iVwve4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Hp9iNj1ONOqlwQWooVzf0g-1; Mon, 25 May 2020 04:07:19 -0400
X-MC-Unique: Hp9iNj1ONOqlwQWooVzf0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 560A41855A01;
 Mon, 25 May 2020 08:07:18 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C89A60CC0;
 Mon, 25 May 2020 08:07:14 +0000 (UTC)
Date: Mon, 25 May 2020 10:07:13 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/7] block/nvme: poll queues without q->lock
Message-ID: <20200525080713.7kvgnlzvdbhfbowt@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2fus6o6tflghjq4v"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:54:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--2fus6o6tflghjq4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:32PM +0100, Stefan Hajnoczi wrote:
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
> index eb2f54dd9d..7eb4512666 100644
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
> +         * q->lock isn't needed for checking completion because
> +         * nvme_process_completion() only runs in the event loop thread =
and
> +         * cannot race with itself.
> +         */
> +        if ((le16_to_cpu(cqe->status) & 0x1) =3D=3D q->cq_phase) {
> +            continue;
> +        }
> +

IIUC, this is introducing an early check of the phase bit to determine
if there is something new in the queue.

I'm fine with this optimization, but I have the feeling that the
comment doesn't properly describe it.

Sergio.

>          qemu_mutex_lock(&q->lock);
>          while (nvme_process_completion(s, q)) {
>              /* Keep polling */
> --=20
> 2.25.3
>=20

--2fus6o6tflghjq4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LfK0ACgkQ9GknjS8M
AjWyhQ/+IfFu2RC6BL/AmqzuThU/jrB7ChC2fq7YYfBduTyJpgsRCABpyYt6V91z
GtdbeSE00xDtc9avEI9aQJpjTlHP6Z5tfDSETYpQ2+Pah7apr1KrIrBFoPJX7GLE
r8JYRA37nGEM6lnLvZZduHsM9vhOsLBDynMeHrSQpposObCk9i/DGT5N9SkOFfbJ
aLX1XbfHJvAk5+0sKPmvq1UXnvBa850lasSBnGRqq2xP4aBbI9UJAQxfrG5PnFxC
W8WhPz4BGNeTQzH2NMya20LwipnlLl+3NnZydFvywSADBylPKNVB/p2Y9T5n38MD
LKGfC3CSUGV4OyBPFcI/9s3VSAF57YWV+q+zmOmqYgJVfypfXdRzSXYkmIw2QH8l
ylANC0hLOw7UhvQ9QXmcDAXzrtiMFRJQzffuUOXHIPCLJ4nWvKuB25pXR/EmpCg4
Uj5VQi7k08mthaMpA4ekPEFunP89YMYYvsarBga3G/lFUTHG4qROIhTnhiqcN9Sy
3zxWlmxjAHGPrlm8Ohp4HjG/hUNLJ+QrqiENckg8nnOsbw0zdwTWz7fm6lAVWYbp
aeCoUDAIKawqzchS4+ToXW/3AVTBSM5433vvcoOcCd30JkkW6gV9y/24qU6P1RD8
I9qHaA/mrn5KHg+20lct8haYX/ALUjYjtKd7RUvN9W/+hESV9XY=
=TEi7
-----END PGP SIGNATURE-----

--2fus6o6tflghjq4v--


