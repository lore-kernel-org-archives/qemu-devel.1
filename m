Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80770C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1E7206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDOBt04M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1E7206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf5O-0006v9-EX
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqezk-0007AR-KX
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:49:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqezj-0001Bh-3M
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593618594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWiXx0yc3DyFao0rIIM+wSF2OJWieBN3kpdzf4OkXPA=;
 b=RDOBt04Myw5MN2uG5nHGJB+bHzBd11WKKj7wwQXCuYFbcqFJI50j/05n5WztDuovsDVpmr
 T36ai3tnh0CPGh/Z5xucNMsOi+hLUdPyrOIuAVIowxY/xbP0It2iNFjAdSbBVW0WlMnDaR
 RtfRltt2kYHLYMD3CG17vtPSdWeG5Vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-THyTnIbSP4Gp0Z7DUIg9Ag-1; Wed, 01 Jul 2020 11:49:52 -0400
X-MC-Unique: THyTnIbSP4Gp0Z7DUIg9Ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AF2B193248F;
 Wed,  1 Jul 2020 15:49:51 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A17814F6B1;
 Wed,  1 Jul 2020 15:49:50 +0000 (UTC)
Date: Wed, 1 Jul 2020 16:49:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 05/12] block/nvme: Rename local variable
Message-ID: <20200701154949.GP126613@stefanha-x1.localdomain>
References: <20200630191318.30021-1-philmd@redhat.com>
 <20200630191318.30021-6-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630191318.30021-6-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 09:13:11PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We are going to modify the code in the next commit. Renaming
> the 'resp' variable to 'id' first makes the next commit easier
> to review. No logical changes.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78sJ0ACgkQnKSrs4Gr
c8hFJwf/cK0LlGqt+TDa+cLGfcUbHAKF5sKJkQmWIhxWRzs3QSe65xf0YEEexTWj
QbSKGg3i+rTu3YbFXYui9tTrsohkBapSIEuiTCI69ZCRWEnuMDrcg6V2+gwMniGs
Ze9JWVLeuiPk+WTeAe4upCXslWiG65qwavBK6uhQFz/+q4xBABZ520RyVEGvcLBg
DKYe3SZ+mHiPnlXfpSYk//Zo3y89DZTbLFE9xqoCaK+ZtedCQhDfrbaQZ90ewmAH
M45FmV/YMhavznEkaLtd/lZs+1RmKSt288i7XnXyt0zfX0gTz1ZBP5c6tBQxzUOj
NiAt7ZBw4KCG/klpqk0igLS2RihLxg==
=zybr
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--


