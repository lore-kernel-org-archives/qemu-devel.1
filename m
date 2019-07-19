Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C459BC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2C02186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2C02186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoV1O-0004B8-U7
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hoV1F-0003lc-89
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hoV17-0003UR-9x
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hoV0m-0002pq-Tx; Fri, 19 Jul 2019 11:41:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 340D57FDE5;
 Fri, 19 Jul 2019 15:40:01 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6874608AB;
 Fri, 19 Jul 2019 15:39:54 +0000 (UTC)
Date: Fri, 19 Jul 2019 16:39:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190719153954.GF24412@stefanha-x1.localdomain>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-11-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <20190719133530.28688-11-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 19 Jul 2019 15:40:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 10/14] block/io_uring: adds userspace
 completion polling
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


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2019 at 07:05:26PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  block/io_uring.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0x5EkACgkQnKSrs4Gr
c8ir/AgAkBwJ+hM/Ff7AW8i402CA5CG1FoV0CtwFM5Zsjqe8wAnMNNmHgqGB7iy5
EFwHNwNkcQMoAUgrG8oqrSw2wtgvm7K7rDSBRwwVZwMqsVQqTcPgLK5eC0VZHkvV
UeBna8n46pbP8GSoG/bxO0hLBKdsJDugvjSUPPHgMVQHHA5kLj+uwOoIOlRm7147
S9X3CNW7QKyrEiP/WTCeYt0WU7ZlGIwbbKGUKstUWwS871qQxnW4f5eeqVzhwFnM
1Obkvejn8F4GfYiS2PxXdhcwTvYC/9o6JDBb/ktSq2AqkZXtlHN137UZEvMf8Kx3
Bt+qO12pBYHa8sMDrM6/o/yv90R9tQ==
=V8Jq
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

