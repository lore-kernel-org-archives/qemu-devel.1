Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14DC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90AE21871
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90AE21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUzD-0000Uh-TT
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hoUz1-0008RN-8n
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hoUyw-0002jR-0C
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hoUyZ-0002BH-GU; Fri, 19 Jul 2019 11:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1814C3172D64;
 Fri, 19 Jul 2019 15:37:50 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E58785D978;
 Fri, 19 Jul 2019 15:37:44 +0000 (UTC)
Date: Fri, 19 Jul 2019 16:37:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190719153743.GE24412@stefanha-x1.localdomain>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-10-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Content-Disposition: inline
In-Reply-To: <20190719133530.28688-10-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 19 Jul 2019 15:37:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 09/14] block: add trace events for
 io_uring
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


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2019 at 07:05:25PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  block/io_uring.c   | 22 +++++++++++++++++++---
>  block/trace-events | 12 ++++++++++++
>  2 files changed, 31 insertions(+), 3 deletions(-)

Trace events don't need to be a separate patch, but this is okay too.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0x48cACgkQnKSrs4Gr
c8iM+ggAqKLBnjN+r3OkAX0gUbfURybrIvmqFcvmFJIeEeHAPxqTmmMea6BeyeqL
dysckZRHomYGgeb8bvI/mvKnnKoyh4iN412tHKYsuH+3wU7f9Josw7lUImC5+DDh
4XaiCfTVenVoln+nj6DtJ2KoRdzCYVnEfu5Yt0GCqo9Q1S0Yu2eMDElOJNXn+0rg
I+aTdq+2q5Tb8SdefL2pUmceLWwIHYgbg6y2MhuY56DD74mvZKY8n8bs1QSqEfew
HEYIUTCsvVXm4q/wO2d/Kzf4uo7KcOyYCsuNImMSay3wPKGF3RxlVW3h1Rn7VGqO
5eoJx3isGizSdcBqq9OXJLbcYVDjZg==
=uQds
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--

