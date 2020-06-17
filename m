Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE176C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D224206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4vO56o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D224206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYxE-0008Qn-Qo
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlYwK-0007Nd-6f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:21:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlYwG-0005B1-Kq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592403675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYv9UkkFRC2CxcQDSe8reW/njI0vFithaOOZ/pnAqTo=;
 b=R4vO56o8PmsYhk6dLAP6/FSUlcwrtG+NGk2f2lcQLb+yvUs/B4vTS2At8AFnd40shNP8Sc
 eFbBtdH6l/l1bL94qbmhA4sZrktGFjs3MYS47KtD3OMOu/yA0enkSTCr0zBjg1V8TcmlsY
 pvTz4744qAClBkeBMSxwbPGyU2TxO6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-Kr7tx5nxMA-b11YMEHf8tw-1; Wed, 17 Jun 2020 10:19:25 -0400
X-MC-Unique: Kr7tx5nxMA-b11YMEHf8tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB1321100F62;
 Wed, 17 Jun 2020 14:19:24 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBF0F7CACF;
 Wed, 17 Jun 2020 14:19:23 +0000 (UTC)
Date: Wed, 17 Jun 2020 16:19:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 0/5] iotests: Some fixes for rarely run cases
Message-ID: <20200617141922.GE5166@linux.fritz.box>
References: <20200617104822.27525-1-mreitz@redhat.com>
 <20200617125238.GC5166@linux.fritz.box>
 <f8192770-0fe1-95e6-9560-47571a1ebc59@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f8192770-0fe1-95e6-9560-47571a1ebc59@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.06.2020 um 16:11 hat Max Reitz geschrieben:
> On 17.06.20 14:52, Kevin Wolf wrote:
> > Am 17.06.2020 um 12:48 hat Max Reitz geschrieben:
> >> Hi,
> >>
> >> Thomas=E2=80=99s report
> >> (https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00791.htm=
l)
> >> has given me a nice excuse to write this series.
> >>
> >> There are some iotests that have recently start to fail in rarely
> >> exercised test environments (qed, qcow2 with data_file, qcow2 v2), and
> >> this series fixes what I found.
> >=20
> > Thanks, applied to the block branch.
>=20
> Sorry, I didn=E2=80=99t run iotest 297 before sending this series...
>=20
> The problems arise in patch 1:
>=20
> iotests.py:1113:0: C0301: Line too long (80/79) (line-too-long)
> iotests.py:1106: error: Function is missing a return type annotation
>=20
> (So there=E2=80=99s a line with 80 characters, when 79 is the maximum (*s=
hrug*),
> and I failed to specify skip_for_format=E2=80=99s return type.)
>=20
> I think patch 1 needs the attached diff squashed in.  Are you willing to
> do that or should I just send a v2?

I'm squashing it in. In fact, I already had fixed it, but I was too lazy
to be more specific than Callable[..., Any], so I'll replace that with
your version.

Kevin

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl7qJmoACgkQfwmycsiP
L9aylRAAyISE2wDWKj0lm92u0i8zhBFP9LRT72neVBYp1SKOe1UahsRa0gf5xdHt
qug1l/eaiHgCzs/hSjc8YsbSiVvf5Ku6nvBKl+pxkgWT8TiHJ+mDv9He3DsI/aEX
VQK/eHMmgslXB5f8u/1i00fn6X4lWjfrv2EOEcWAczyieJz/nnr6J5TxQxCMsn76
doYDby2RM8cLlSCmejBWZ5NKy+cIWhdUmSa9F0Pjkhmig67fU5BnMTYn+hWN/9qv
8u1Llt322tk91bAL1oW7U1BKfxDSD6YReNJ4fO49IGdRNI1ZVuAtjbnmnbngY33i
xJaCY8QB/kn2Q+7wJP6KvLK/iEKb0z5KWhqB1w1pTKi9HcwtaE8opqaxttilZzYq
+qgWHkgzgw9kh/fPZ8L4fjCB+gTsNfDmpxxUbzDcMmCdflijnyJgJFkcwFgYzsnA
+xe3bO49HV03bkuv93Tc3mujWTHl3XaEwJzKEEwqcRWkSXZ70VJITKFxZ5pnvP4X
UieEEj1gY1JgjYKLUuH5n0uHOBVasOGgPFWzfSoHQm3Ifi9BZAXcZ3yr1EjD8N2O
d72PP85qfd87x8Czf9qfNO5/BzP/6LAlQLHfeG924NZjSQ6yw+2yWM/k7ix4L19C
Ajk0cz/FB2K76axM8SfiX0iSiQLRQNJNSSOldbvKb6K86N2BJLM=
=4WT/
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


