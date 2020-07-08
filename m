Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158BE206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZrRHo76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158BE206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIiB-0003tL-Ay
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIJy-0001wQ-9O
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:13:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIJw-0008Dy-Li
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1haLvuFx2XObXU/pf1rYymXMFK6e8lHWdKrNOYNwmn4=;
 b=cZrRHo766bwOTCXeHMHHlmYYuDwtgZ6Ic5i/2PHiioLBxiRuHoobubnePDaG21dfhWPQKx
 xjH0QdqOP+yJWal3xMLXpEGJmY5RCvAO7vSkUBuOd597O4a7g95K4ylnHeYPEX3xthcjBa
 /K7NeG0clKWS0L5ASbkAvbyOzgstu8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-Y0USLINIPnawX8r8fWDGoQ-1; Wed, 08 Jul 2020 08:08:04 -0400
X-MC-Unique: Y0USLINIPnawX8r8fWDGoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26BCE87952C;
 Wed,  8 Jul 2020 12:08:03 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3EA5DA27;
 Wed,  8 Jul 2020 12:08:02 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:08:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 4/5] iotests: QemuIoInteractive: use qemu_io_args_no_fmt
Message-ID: <20200708120801.GD459887@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200620143649.225852-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 05:36:48PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> All users of QemuIoInteractive provides -f argument, so it's incorrect
> to use qemu_io_args, which contains -f too. Let's use
> qemu_io_args_no_fmt, which also makes possible to use --image-opts with
> QemuIoInteractive in the following patch.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8FtyEACgkQnKSrs4Gr
c8iQTwgAxdfl7bYEdzyT4rj30BaA3jMZdC/BxQLXE8jXcId8ILVvuPp/+RJZE6Zt
cwHiPWajgRBIe6wNg6WuZHIUv0T8OX7XNiRfbOBrNFLdxbeqXGpgmYpR8rlH8CWy
sibgv5z7p1BGpwgI7oEHbyY49MR58RgEHIZwu2Cwqze/2kuFnzyoKKaYGhqbuFCT
+6KBJ6c//stLbL73WD/TjyCjFP34KcC3SUnLL731kw5K3DhMNtHJaNGpPeR8+sZL
suh+taUHY4kw0unZJGpLKtuzkZicS7U8DIAt4CNVio/sCXUZ1ovw1l8+5UL8jq0o
pGVF9RLSF05Lxld1aIdUiQURN2OWrQ==
=Z7Xn
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--


