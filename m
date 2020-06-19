Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6189BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FC9208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dtzf//Wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FC9208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmLA2-0004TL-7f
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmL6i-00021Z-Aa
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:47:16 -0400
Received: from mout.web.de ([212.227.17.11]:44185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmL6g-0002Y7-FU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592588826;
 bh=1ndZnOBFa8N5COtDBnOKP+UlVdDaFFMpKwieRogZ+h8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dtzf//WaaACR9LHhXRUJvl6fYCVc5ovcp1MxHDlWJf4CD5ABmYn6B3SDmdcL2qmT7
 DE0ZfH682JvVSnpjERouBM7aeHqBKDN8tGSx2Y0ed1iLyWMABMLva8BnGQbCUp6gEs
 MVUqfua4C8Oy/2cMNIK2mDIaXMM7DSWqukckMk8g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfY9-1jXfaz1Asd-00P4IQ; Fri, 19
 Jun 2020 19:47:06 +0200
Date: Fri, 19 Jun 2020 19:46:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to
 users and clean up
Message-ID: <20200619194611.057b48ed@luklap>
In-Reply-To: <c8ce4348-d81c-1d10-ff82-74be39a03b5a@redhat.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <c8ce4348-d81c-1d10-ff82-74be39a03b5a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dILQxiEUoJT+S0y.pQ0pOXa";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:kFeqfYL6p0YkttC53h0M/W0xlt87O894e35vQAuUkRPCQnmhq87
 bLRwoHGDHTAqOZJKbXOaBlKo981r1Rn4WBF7fIrjPZgYN1Fu33sIhiMYkm/ZpV7heTzMzkX
 dG3OkHDeITlIaSglhhfg78NMeFvVYbXgrVgX3DvRoRYmG5gmvCBp1rfFA4Su81tO4W1+vmg
 Dsuz3f8lkFI/opRcMuXtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xie6EnyonE=:Pt+sjJ6Ko+hoz0SRZ52nTJ
 EcIVnrUbxuP1QSQ9a5Inemw36ElV2+54dfgMVKbP3eOlAiNlzzhRagr+8aGJTJ0kn4uYt2nam
 EeXZZXtnaK0ezCFCLBXSWUHKuDB685qTDofASIcEY3lIEj3o1qHoNfS+H2khCB/mWvPS6ex3u
 JV45l6pEfQdv3aGZcjIQFbQWRkpCdonZaGPXVwLCFDqC2tzIsP/a/Lvc8BNHVEcgioXrVr0MR
 +LdHJgPExl+u+zMY8qKEorW/GxQPp5WOe0ryAse3mJ0E+4+JYaN/STtQ7pxJB36PJm0P69cEt
 ITfDUP97uolgW0iXv8mwfjCmvp1p0AGzKhqClQRcARRw1yYD+Fa91hOvY6N+PILuxULycGXN+
 FM0gptcZ/MYZaXc0qyfjGvlDP6HfaiZ5+g0FHPU9xdWSGz17EV4HBeMMJD2mjMqLVPf4xBXWx
 coiYx6P9ADQwtgunRUzM4nDacewvWv5rw9X1iEAH7loaYGpMs90T0b28FCQ8bHwop8K1464kC
 76iTtsNMt9r62uu/zQMy26O549EKwVTZhCqShrwAfRqGZSJB2JGK8KlzY90rhs88FSmdwoUNP
 s1pACzRWPjStVPZ6b23MEGxMB4a2r7FUgvqfsgpNQ5DL8QIEIl+eSWK2zUD8RwlVB7RLzIpaG
 +9hmS6SJBVwojBLYCGEvHFcnSJWo4dP59e9M0hYGlWYj0/ilsf/vZl1U4I3fADyZlWYtE/iBd
 SmcGqcc4w4CefukCWHR1n097PLkBAKBV5FGQg71Ko3CE+7RYx7QacRIIv7yld2zl9+B4IwKCF
 laCo13arR5o6toHpUngZYevTonZof+6XhPJYJ29IMapO/Kl3ST9ndZyh5eu4Na0at5eAEyyf5
 HAMqd3gQW+GP8iqZXOLbSQNR3mxrzQFyW+rnI+60T2GgPpjvOnT81WaueNjsYZNKNvGuZyES3
 UM7vnJYk1lxRIMBwFrtIPvJs+wxCxj8JtHnbfh+gW18pfuV4R+voKkO2FJw70eKx/vphfmv+3
 cOTizXptNeHw/5Vl6FKTGmRHoqkfKNCDxRRcQ5ZogMjNmwtwXQbEqCbviARII3AQAirXPIZ8x
 17Gtubq6nABQqPnvic8BDAq6RsqAfintoDZ8ivQVv0ZQ5NcXNWcy063/5tWuV1nrWLhygABMY
 GsHU7DG/DMCrOehNgWKdlwup+HqWuk8kIPB9iaNZelWhl0Tg6Df+veIGpZ27KWuvEd5cnf1b4
 g4K48+7MMv3IDdI0j
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/dILQxiEUoJT+S0y.pQ0pOXa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2020 10:19:48 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2020/4/11 =E4=B8=8A=E5=8D=8811:38, Zhang Chen wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > This series make a way to config COLO "max_queue_size" parameters accor=
ding to
> > user's scenarios and environments and do some clean up for descriptions.
> >
> > Zhang Chen (2):
> >    net/colo-compare.c: Expose compare "max_queue_size" to users
> >    qemu-options.hx: Clean up and fix typo for colo-compare
> >
> >   net/colo-compare.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
> >   qemu-options.hx    | 33 +++++++++++++++++----------------
> >   2 files changed, 59 insertions(+), 17 deletions(-) =20
>=20
>=20
> Queued for 5.1.
>=20
> Thanks
>=20
>=20

Hi,
It looks like this hasn't been merged.

Regards,
Lukas Straub

--Sig_/dILQxiEUoJT+S0y.pQ0pOXa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7s+goACgkQNasLKJxd
sljojA/+PppSDbXdprjR+5reD5wJTPp57q8AEUD0dBekfjus0NUaZUij4nFpbmBa
z1wzmXIK92/s4g97pOeSGRPBJhnLp1uECybk3dQ7xPxLFVHRkKwlYiP9ij7E8cfD
s6zmC7b3NKmSoH5UDorrjjTnV+Qsp5eBC9Xpp7ng6wiQjH18o3tOjw+oSOe8/xGi
p/WKpF4hLwnhJSs/bGLpZUwLXGyhng016RTG4tqAavtHhvXWgZhS1jTNtId5KlaL
vWvN5ZpLTSf06nbzN9jJCB3bFn5CMD4A8dAg7OobwXVEwcHXZz5aAkyk0YYfMe9V
CSlnVi1ZCL5q7/GtxcCpvDqwq3+DOIXXaTgOk1769upkl5ifhS6FGpa2Qr1lUdeo
R+PJNfUaeJaA4VSfdIDLyZxAJ/Z4ybOCtu4p2016GLIcmkQ3hhT67XJ4DZXx16Za
5n9SwcJpLxXhD52SiX2ZC6fRs1gAzpmZXVyy9zdShrp1HMdhQSE8Hymb5DFwq8CF
QbZ6ERTDItyRneSVRzx0vsqNciWR+OLUlcOdL2Pz2vuGX2bB40ltXSvbHsgu2NVM
Q7OAXZnnT8S+7GBk2P9uJUS5seduQ/UWWbqGRK1eXxBSNiFl+zFzQttph2pkue0W
ANmKEMOETu3Ya8USSthO+Ejj7Y3IT1NFyMuE9mOb+cN65nztF3c=
=ZozS
-----END PGP SIGNATURE-----

--Sig_/dILQxiEUoJT+S0y.pQ0pOXa--

