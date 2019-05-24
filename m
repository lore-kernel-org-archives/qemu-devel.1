Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4797DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCF720856
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCF720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBza-0005Zh-DK
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:20:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUBvj-0003Ni-2c
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUBvi-0005Uc-BF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:16:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hUBvg-0005Sl-7K; Fri, 24 May 2019 11:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D34630832C9;
	Fri, 24 May 2019 15:16:17 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 100976871E;
	Fri, 24 May 2019 15:16:16 +0000 (UTC)
Date: Fri, 24 May 2019 16:16:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190524151615.GC31070@stefanha-x1.localdomain>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
	<20190524140337.13415-4-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20190524140337.13415-4-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 24 May 2019 15:16:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/9] include/block: declare
 interfaces for io_uring
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


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2019 at 07:33:31PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  include/block/aio.h     | 16 +++++++++++++++-
>  include/block/raw-aio.h | 15 +++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)

There's not much a code reviewer can do with this patch in isolation
since they don't know the behavior of the functions declared here.
Please squash this patch with the patch containing the function
definitions.  That way a full review can be done to decide "is this the
correct function prototype?", "can the interface be simplified?", etc.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzoCr8ACgkQnKSrs4Gr
c8j7egf/aIkYvegwyK3D2p/Le8GhDu1e8PXfquF0Q9WFTPKH+trmxKss/FM7QfxV
JwyQuQ9RdCVgqqKZBxF8/ZJnhijUXhrz8e6quuc+pn9pn81B9Y0nsbxAKDJoP9s1
DsDJwXFGNcU0qeDiljKUbh+aLxGD5cuZXq/bnManakSzvh+wIgNsbAagYX/Dth1T
xhKtYjpF7dZ2OKo3tj9NYp2aVDRoibKPWP6qnk3lBI8Dm/EbaDGppqM/S8NI2FPo
HkRC0EUfHJOorA3zTZlwRSv/nhWg/a9rSvIqvbN1gUZgWVr2pWnYXAK3rBZ0DdMN
XYMb6ihwuquaBoF0/WwLqK8xWgxVZw==
=obdT
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

