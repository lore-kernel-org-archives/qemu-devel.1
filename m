Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA219C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833CA2186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833CA2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUzY-0001z0-Li
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hoUzA-0000YQ-Pw
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hoUz6-0002mk-O8
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hoUyv-0001jV-Rd; Fri, 19 Jul 2019 11:39:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26DEE3092651;
 Fri, 19 Jul 2019 15:36:53 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE98F60BF3;
 Fri, 19 Jul 2019 15:36:52 +0000 (UTC)
Date: Fri, 19 Jul 2019 16:36:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190719153638.GD24412@stefanha-x1.localdomain>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-8-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20190719133530.28688-8-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 19 Jul 2019 15:36:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 07/14] blockdev: accept io_uring as
 option
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
Cc: Fam Zheng <fam@euphon.net>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefan@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2019 at 07:05:23PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  blockdev.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0x44YACgkQnKSrs4Gr
c8gLmwgAyWboxTpevgBSfw/bP1F50u0uMqD9PKJaNpfylvnTdzrb5SrYxP/RsmiB
lXz0vw6aGR6OMT5FKVYQ7/aMeQxeU2R8qQHI5gy41EsdQ9H4GEI6cV5e/w07EOg4
8mu72Qqz8xjgd2taugG9bIlAJAZ+IcqH/dqL4XToPD6zZAUFwYW1O600SUgQWFpT
BNRef89Ic3ufS+H2XnhhmbLFGTtmLlT9Ez/d+uKZUIfbIEW44b3G0ed4Arixii4i
MmBKsU6Z0Pch2Sg8y1skhWgsR/cGQGYGzqN1hP+vNFJSi1cp29eaDGjStZT1/o+6
j1BnOk29nR1LaSfsDOiNUi8yil2yag==
=0skM
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

