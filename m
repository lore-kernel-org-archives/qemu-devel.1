Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030A7207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FL1vrKB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030A7207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonWU-0001xu-4B
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonVl-0001Bw-FT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:31:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jonVj-00052W-6T
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593174673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1fCfvtgUzFbk46rRPBUxW+zqg3n/fTpu4Qci9gea418=;
 b=FL1vrKB3ODQQ8b4g23SjWIiCF4rX95nuOn2Sr6jld/dqDOZA5QImAFz5GiZprDX7kSQhG0
 cfrTEFgVKw7dyYvqyS+EtlRBUcuwbpXCACAIkoGt9efkZrR+z1xYHE2BQiLTCL0FkVrcGk
 kK3HvvJD9bgaXpRaL90ok6CZ2xKr9GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-7YR8j70AMjaCcW_CkmLzxQ-1; Fri, 26 Jun 2020 08:31:07 -0400
X-MC-Unique: 7YR8j70AMjaCcW_CkmLzxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B91B107ACCD;
 Fri, 26 Jun 2020 12:31:06 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14AC91010428;
 Fri, 26 Jun 2020 12:31:02 +0000 (UTC)
Date: Fri, 26 Jun 2020 13:31:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 08/17] block/nvme: Use correct type void*
Message-ID: <20200626123101.GO281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-9-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-9-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:29PM +0200, Philippe Mathieu-Daud=E9 wrote:
> qemu_try_memalign() returns a void*, qemu_vfio_dma_map() consumes
> a void*. Drop the confusing uint8_t* type.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl716oUACgkQnKSrs4Gr
c8hsugf6AggOjyXUdwtHDVKUCR4svadkwgKli31+snXUyopUzjyhDo/1OgXYDBgw
UBw6g3qOd+crzDS7Yv1ufe1OQUbr7igbmZpBLz8VBbMrRq1Jm6KmbizPMVA1Uor9
yT1Qhow9ecYoqr9Ka1u7gX08F0hjdzdGDol6v0n6l8+aGmGNeRbbttkGEWzMIR+K
2xphmQoQwqaeuxtD8CtEbU0/bvTqlKl8UhVxweKuyNEWChIvmU3/67kmlieBg4ul
m54lrCH6ivPUOZOqq3VlTE3dDxnocZ8W+0Ms+RYIxj3Y6W7YMwIIBaq5X83tkQ99
MO3xWBUJTYeMiioyTQ3B8uhZyouRDg==
=qktX
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--


