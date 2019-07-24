Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD84C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240AC22387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240AC22387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFfb-0007Bw-Dr
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60333)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hqFfR-0006jV-7r
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hqFfQ-0003em-1l
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hqFfN-0003cg-KU; Wed, 24 Jul 2019 07:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83D2930A00E5;
 Wed, 24 Jul 2019 11:42:40 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2B785C225;
 Wed, 24 Jul 2019 11:42:37 +0000 (UTC)
Date: Wed, 24 Jul 2019 12:42:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190724114236.GA15439@stefanha-x1.localdomain>
References: <20190723190623.21537-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20190723190623.21537-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 24 Jul 2019 11:42:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/async: hold AioContext ref to prevent
 use-after-free
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 08:06:23PM +0100, Stefan Hajnoczi wrote:
> The tests/test-bdrv-drain /bdrv-drain/iothread/drain test case does the
> following:
>=20
> 1. The preadv coroutine calls aio_bh_schedule_oneshot() and then yields.
> 2. The one-shot BH executes in another AioContext.  All it does is call
>    aio_co_wakeup(preadv_co).
> 3. The preadv coroutine is re-entered and returns.
>=20
> There is a race condition in aio_co_wake() where the preadv coroutine
> returns and the test case destroys the preadv IOThread.  aio_co_wake()
> can still be running in the other AioContext and it performs an access
> to the freed IOThread AioContext.
>=20
> Here is the race in aio_co_schedule():
>=20
>   QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
>                             co, co_scheduled_next);
>   <-- race: co may execute before we invoke qemu_bh_schedule()!
>   qemu_bh_schedule(ctx->co_schedule_bh);
>=20
> So if co causes ctx to be freed then we're in trouble.  Fix this problem
> by holding a reference to ctx.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/async.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl04RCwACgkQnKSrs4Gr
c8jBrQf+Jd7q+Ai5QM+pug6iKZogj+BqCy5Da85i8H8v2diupxs9e67znt5C4Zh1
RNYCTfd4617Sh8JxHJFFrqNuB9NcS0BRnLwIYnNtaHAG9hqyoSVe6MQKZ5fl2Uzq
Y5KAegaH8ndQZKKSglbyotIbcZlARn6ZOFEINQo9UR83J92Qm3+RARrhMB0jOATG
gEd/AWJn5z0CNBugA2Vvj7OJMsuZu1yXImf3RMqkbngrH5yjuGk3U52EH2Cn6IOw
/o9FgETE6ag4BFSAI5P9nTrpng9lxUIiWn0DHONXS2nTki3TuXYkdJSkmORnCivO
V0vn+Vh3stpmsRVk1jPQPyC0eqK0ZA==
=uELr
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

