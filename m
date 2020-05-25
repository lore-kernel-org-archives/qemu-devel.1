Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3FC206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBSVa7z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3FC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8AF-0003LI-FU
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd89d-0002aw-9Q
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:08:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd89c-0008Jn-HM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QV1FihMBpD8XPvrVLp6w3MPT7jIJqmEpkWS/EJeLIsg=;
 b=CBSVa7z8TaDO5KZ7DCzHlznjuPJSyoFhDbQupqSz48ZP5rXbo5wOSNBXrcn3b0WhAsMVrx
 i3ixjtbmppRBdrBNmY0luGHk54ab3FTG/3a9iC8pyDP3CC2arPbFCjIgWmhTGgmlkYI1mA
 BS4nyzw7rqFn/ywJGbcPF+tccyVBxkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-MpC0aCc0MbaH6rTpq2t41w-1; Mon, 25 May 2020 04:08:09 -0400
X-MC-Unique: MpC0aCc0MbaH6rTpq2t41w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DC99835B50;
 Mon, 25 May 2020 08:08:08 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8B8160CC0;
 Mon, 25 May 2020 08:08:04 +0000 (UTC)
Date: Mon, 25 May 2020 10:08:03 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/7] block/nvme: drop tautologous assertion
Message-ID: <20200525080803.lzahtmimgas2zjvt@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qrgggpavbcsxzfo4"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 00:06:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qrgggpavbcsxzfo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:33PM +0100, Stefan Hajnoczi wrote:
> nvme_process_completion() explicitly checks cid so the assertion that
> follows is always true:
>=20
>   if (cid =3D=3D 0 || cid > NVME_QUEUE_SIZE) {
>       ...
>       continue;
>   }
>   assert(cid <=3D NVME_QUEUE_SIZE);
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--qrgggpavbcsxzfo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LfOIACgkQ9GknjS8M
AjV7LA/9Faft6jG97lfxI3DTU4Ffyq3CgQJJ0J4+kpG3alYyZY9VB7lbe/+dq8U8
5fDgCfWoK1SMeDmI3T8QhPNqGWAGEEVHKg5C+B9f6zPB1uK8dJODf2M1Lmmp5jUG
pHuiMLFLG45TWoi59fwsvYvlbi3OcySXmV05qSziDJj7J13JlkQA8d9RYBjfhap0
3TkRtco71DrEcb2xYuVTS+snEFsVTcXshPREiTZnYP0mmrJr5s1EXCnHWL/uIBaP
a91CCyqyi6/pcl/r6LKzcr3KLK3LS+RqPXp43dioK52yVM/kVlArYZJGiOIS2apC
R7CiVNFjkhX5CayyfIBno/2YdYtsHZ2ra25VYJS/B+UV2r9pGEZGIL2jU+BK48vZ
AYq/PJNDNXFu7DNR48EyCGmw+oIWma1JRPiWUJksEBOgD4dSY6I5wcOav8vqHO3D
vPEoRb+gi585VcMwyM43/nWWfoeScA1JF4gPChOfEen/3xGe9nBszRNvYueLRDC5
kTpWq7QaMBQ7Xr6VZUWTOabxpxXrvNyN4W+uGwdDugH4Nm3kyCKPADzc34/FBoB5
xYS8YaHY7h3VcMFVhklMdpZMOYEAndksr8jJI7YdeOqkYwZJyny6FUua25QS4q6u
f4fGZxEFidc5QuhQBeIgBZyVCovHHonJ/Y2b/x8le8qeNAP4lss=
=cyvf
-----END PGP SIGNATURE-----

--qrgggpavbcsxzfo4--


