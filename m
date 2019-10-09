Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6FDC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E076120679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E076120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHp4-0001N7-N4
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIG4F-0006Hg-Vy
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIG4D-00071D-0N
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIG4C-00070A-Qc
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:48:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8D3310A8120
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 17:48:02 +0000 (UTC)
Received: from localhost (ovpn-116-110.ams2.redhat.com [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D74B35D9E2;
 Wed,  9 Oct 2019 17:47:59 +0000 (UTC)
Date: Wed, 9 Oct 2019 18:47:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] trace: add --group=all to tracing.txt
Message-ID: <20191009174758.GK13568@stefanha-x1.localdomain>
References: <20191009135154.10970-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline
In-Reply-To: <20191009135154.10970-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 09 Oct 2019 17:48:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 02:51:54PM +0100, Stefan Hajnoczi wrote:
> tracetool needs to know the group name ("all", "root", or a specific
> subdirectory).  Also remove the stdin redirection because tracetool.py
> needs the path to the trace-events file.  Update the documentation.
>=20
> Fixes: 2098c56a9bc5901e145fa5d4759f075808811685
>        ("trace: move setting of group name into Makefiles")
> Launchpad: https://bugs.launchpad.net/bugs/1844814
> Reported-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/tracing.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2eHU4ACgkQnKSrs4Gr
c8hFswgAxX8+Y0siYw0MV17y1X4QU1GZVCzrEp4UGQMEuj0IFmhlE6vJMcK+HRv3
2vmicFoy8IQomzPqzZJVY1GZt4Oj6TkHtcrnHNMHjzlW9zyKYw8G9WJ1Tw1JvUMg
V/yqT6IGs74sSSV4OgadaRiraYBP1WRW/T+biop6fGAyuO+oMJ8npUQEcjoI7cYw
X3lfnn+bJEbJOdb+KoG64NGGbKrQYWD/b+MRVSmTq3EQjD8hPyI/ogAl4W9RTQyV
wva1NmGEqwIWBIhMhydT5yP9hmwrNSZrT90eTvKkz7di3DKVm7fl9/hFTzoMh5Jk
keioNAEvXZ1I/2JS0xojHMGqAkTJmg==
=lT4C
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--

