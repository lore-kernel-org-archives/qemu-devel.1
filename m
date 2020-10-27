Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A74C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1E72225C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT/gNwxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1E72225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLW0-0006yo-Hh
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLUW-00063X-Ki
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXLUU-0002Uk-F1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603791725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JOh/abKDFW7cVfr4KzWq+f5JSLaYlYc7MPHuEB8b4k0=;
 b=CT/gNwxapTUAn/rknUWJAeW8GYqWC9sfTG5xoPZspQ8qp2wSjuNu1na0P/ea6b3oQh9H+u
 lE+9jiWEg1R12U1zkodKV7B7lSC0J+70PfheL1jRZ9WZ08LJyLpMMfkrwY73H9WhvUXHPd
 JyfwLBlKenlv4U1I9FWlrljoDM+8JME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189--uRyao25PAajNechn-qGJg-1; Tue, 27 Oct 2020 05:42:03 -0400
X-MC-Unique: -uRyao25PAajNechn-qGJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0660A1006C9B;
 Tue, 27 Oct 2020 09:42:02 +0000 (UTC)
Received: from localhost (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E5E5D9DD;
 Tue, 27 Oct 2020 09:41:55 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:41:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/19] block/nvme: Trace controller capabilities
Message-ID: <20201027094154.GD79063@stefanha-x1.localdomain>
References: <20201026105504.4023620-1-philmd@redhat.com>
 <20201026105504.4023620-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026105504.4023620-5-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 11:54:49AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Controllers have different capabilities and report them in the
> CAP register. We are particularly interested by the page size
> limits.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c       | 10 ++++++++++
>  block/trace-events |  1 +
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 5abd7257cac..3b6d3972ec2 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -720,6 +720,16 @@ static int nvme_init(BlockDriverState *bs, const cha=
r *device, int namespace,
>       * Initialization". */
> =20
>      cap =3D le64_to_cpu(regs->cap);
> +    trace_nvme_controller_capability("Maximum Queue Entries Supported",
> +                                     NVME_CAP_MQES(cap));
> +    trace_nvme_controller_capability("Contiguous Queues Required",
> +                                     NVME_CAP_CQR(cap));
> +    trace_nvme_controller_capability("Subsystem  Reset Supported",
> +                                     NVME_CAP_NSSRS(cap));
> +    trace_nvme_controller_capability("Memory Page Size Minimum",
> +                                     NVME_CAP_MPSMIN(cap));
> +    trace_nvme_controller_capability("Memory Page Size Maximum",
> +                                     NVME_CAP_MPSMAX(cap));

This works well for printf-style tracing but it can be tedious to
strcmp() or parse strings from SystemTap and other tracing scripts.

Another way of expressing these trace events is:

  trace_nvme_controller_capabilities(NVME_CAP_MQES(cap),
                                     NVME_CAP_CQR(cap),
=09=09=09=09     ...);

Or:

  trace_nvme_controller_capability_mqes(NVME_CAP_MQES(cap));
  trace_nvme_controller_capability_cqr(NVME_CAP_CQR(cap));

One view is that tracing is like printf (the style used in this patch).
Another view is that tracing produces records that scripts can process
(the style I showed). Trace events defined in one style may be hard to
use in the other style (i.e. less human-readable vs harder to process in
a script).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+X62IACgkQnKSrs4Gr
c8gdwwgAnTn9dhfrX43z+3Gr8Hj54hRXlOX5RHmifqTBJ231m4PrY2VurTNHtdE/
nLcTopBpo7Sos+4bhFOpsbG1yYm8aPFXFvh2QebNxuJ1cBiObUuXhczDeQBWWaOe
2nLLVk4pafQGEAaLEz2YrMhm+gSKQXgfjz2Gcke63OIuvzMu/bqrzum3vrF1g+vw
nKbivXOYjqBPlRkRWDd2gSoaV0aRdZqqVaSYcftILO0Go3bezZ8QaFRdSUoOAUtX
NVKn/57HnFZ3h37ONfDCHwJxWkqoPNwjDhH4mCoB9fpNHzwuOlonh/5QURp8XCDJ
uLiGRYOUTGC6WxiV8nP9SecCwIYdQg==
=qOMY
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--


