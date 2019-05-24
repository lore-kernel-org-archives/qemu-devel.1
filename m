Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B8FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F152075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F152075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56139 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBvE-0002lS-LF
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:15:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUBsx-0001LO-8s
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUBsw-0003SU-AT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hUBsu-00039E-1q; Fri, 24 May 2019 11:13:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA71D7FDFF;
	Fri, 24 May 2019 15:12:57 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED2EA7BE8F;
	Fri, 24 May 2019 15:12:56 +0000 (UTC)
Date: Fri, 24 May 2019 16:12:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190524151255.GB31070@stefanha-x1.localdomain>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
	<20190524140337.13415-3-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20190524140337.13415-3-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 24 May 2019 15:13:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/9] block/block: add BDRV flag for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2019 at 07:33:30PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  include/block/block.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzoCfcACgkQnKSrs4Gr
c8jfpAgAumNqEERlV2GXHmJPibH3F8F7L/WRO/TzHh0EhM0zLMCngm+H3mh593Ss
H3X5uVJ02t0QhkJI/K1nAFi0FJLCGl2P4lrBLfOIJ0XPipbuiQOg9/j0Mfu62s5t
PdB8M1i66yv3DCMKYIvZDn5Bjn14tEaOerK852sEJ8oyLxXsIJYC9VyoXVQeDHWe
2GDGsQJ5wrC3HEqiyNpB+u0nRxduD00agWsUqO/WNAj6zsKuPKnEaHwha94Kxs8+
FQ6Di8yEqMT3IRdYFDWcxRJ9XuzFziveHm2F7zGIB+Z6GzJLqk2qnbbhjC9GtMLR
TTOi5Q8HgabnK/YQ/TOhmcIH+9dZpw==
=Q5Sd
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--

