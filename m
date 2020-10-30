Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FEEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3D320756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJmFJGqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3D320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUzE-0004n1-At
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYUxS-00046V-D4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYUxO-0005nH-Bp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604066440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ujjf998JIjaSVjxSsfarVsUNCerNdAdRVOjQQuZLgBI=;
 b=MJmFJGqEPmypW5jF7Y8POhP69PtlcINRmFXoKNn0RWQqu5a/Vd15OmcuMKYkRmrvNzAn9V
 k+xv1/SmJG5ldhiJINeUVb5qQAxoKqwGDwpfzdSp1Esk8qvbZ3+l5o3+Ca/pEZ1PCFyreg
 j8wZQ0VHxrUwCW9cINLhXAhDvALXm4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-4iGio9_LMC6PLuhayLFPcA-1; Fri, 30 Oct 2020 10:00:37 -0400
X-MC-Unique: 4iGio9_LMC6PLuhayLFPcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DCA9195D599;
 Fri, 30 Oct 2020 14:00:34 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5D518E4A;
 Fri, 30 Oct 2020 14:00:02 +0000 (UTC)
Date: Fri, 30 Oct 2020 14:00:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-6.0 v2 25/25] block/nvme: Simplify Completion Queue
 Command Identifier field use
Message-ID: <20201030140002.GB330921@stefanha-x1.localdomain>
References: <20201029093306.1063879-1-philmd@redhat.com>
 <20201029093306.1063879-26-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029093306.1063879-26-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 10:33:06AM +0100, Philippe Mathieu-Daud=E9 wrote:
> The "Completion Queue Entry: DW 2" describes it as:
>=20
>   This identifier is assigned by host software when
>   the command is submitted to the Submission
>=20
> As the is just an opaque cookie, it is pointless to byte-swap it.
>=20
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index a06a188d530..e7723c42a6d 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -344,7 +344,7 @@ static inline int nvme_translate_error(const NvmeCqe =
*c)
>          trace_nvme_error(le32_to_cpu(c->result),
>                           le16_to_cpu(c->sq_head),
>                           le16_to_cpu(c->sq_id),
> -                         le16_to_cpu(c->cid),
> +                         c->cid,
>                           le16_to_cpu(status));
>      }
>      switch (status) {
> @@ -401,7 +401,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
>          if (!q->cq.head) {
>              q->cq_phase =3D !q->cq_phase;
>          }
> -        cid =3D le16_to_cpu(c->cid);
> +        cid =3D c->cid;
>          if (cid =3D=3D 0 || cid > NVME_QUEUE_SIZE) {
>              warn_report("NVMe: Unexpected CID in completion queue: %"PRI=
u32", "
>                          "queue size: %u", cid, NVME_QUEUE_SIZE);
> @@ -469,7 +469,7 @@ static void nvme_submit_command(NVMeQueuePair *q, NVM=
eRequest *req,
>      assert(!req->cb);
>      req->cb =3D cb;
>      req->opaque =3D opaque;
> -    cmd->cid =3D cpu_to_le16(req->cid);
> +    cmd->cid =3D req->cid;
> =20
>      trace_nvme_submit_command(q->s, q->index, req->cid);
>      nvme_trace_command(cmd);

Eliminating the byteswap is safe but this patch makes the code
confusing, as I mentioned previously.

Please use a comment or macro to mark this field native endian. It's not
obvious to the reader that we can skip the byteswap here.

Otherwise it will confuse readers into adding the byteswap back, not
using byteswapping in other places where it is needed, etc.

Thanks,
Stefan

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+cHGIACgkQnKSrs4Gr
c8jZNwf9GlBYMbmOc3qUnTOmCVuM+hSXD5FpBG8p2bPNBgtvd7ZRCNvAFRE/Xo6m
F3GOfUcWCspNZcPMh/IpdP+K0b3DiRAWDsEQq2mEOygFoQDrVQiw1cmN9V4Jq4Zc
fgiQ6kFIgs42OhgQr4vmZ4hWP8ujUGsBCQ9UuTdt2hXa6XEHSqeYWmwkKfIZZQJE
KpAHy6X74CFU2fmuXkdgpo4tMDjDOkHMXV2VPChjaOBXU6CC6++waVx5Ful2rnaf
AZnnZ3X47pX2Ynal6HQlyeA9Ij+4N1Zgiim5pwDVmvHsqTIJaYUsACN68gChSjax
++/6lZ7s8KuzzKlvfqqSOlWLrbmcMg==
=nqpQ
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--


