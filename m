Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A7F207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A7F207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXR3c-00063k-42
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kXQq9-0001bN-MZ; Tue, 27 Oct 2020 11:24:49 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:36581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kXQq7-0000XL-4b; Tue, 27 Oct 2020 11:24:49 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.7])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 35E4568D1754;
 Tue, 27 Oct 2020 16:24:44 +0100 (CET)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 27 Oct
 2020 16:24:43 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004ff616048-2b97-4645-83f5-f6ea8a06e79a,
 8E5A4880AAF567D55136F4F8027E0847E2FD1EE8) smtp.auth=groug@kaod.org
Date: Tue, 27 Oct 2020 16:24:41 +0100
From: Greg Kurz <groug@kaod.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] block: End quiescent sections when a BDS is deleted
Message-ID: <20201027162441.787da040@bahia>
In-Reply-To: <20201027135404.GB102411@stefanha-x1.localdomain>
References: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
 <20201027135404.GB102411@stefanha-x1.localdomain>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nVl6kiE/PHnVZ9SLZu/.fB5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 934e5e7e-eb22-4aae-8118-bd5d37b0acb8
X-Ovh-Tracer-Id: 4304315346919332259
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtghisehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelgffgfeeugedugeekveeiveevjeffhfduvdegffetkeeiveeufefgledtgfeiteenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepmhhrvghithiisehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 11:19:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/nVl6kiE/PHnVZ9SLZu/.fB5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2020 13:54:04 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Fri, Oct 23, 2020 at 05:01:10PM +0200, Greg Kurz wrote:
> > +/**
> > + * End all quiescent sections started by bdrv_drain_all_begin(). This =
is
> > + * only needed when deleting a BDS before bdrv_drain_all_end() is call=
ed.
> > + */
> > +void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
>=20
> This function is only called from block.c. Can it be moved to the
> private block_int.h header?
>=20

Ha, I wasn't aware of block_int.h... It seems to be a very good idea.

> The code is not clear on whether bdrv_drain_all_end_quiesce() is an API
> that others can use or an internal helper function that must only be
> called by bdrv_close(). I came to the conclusion that the latter is true
> after reviewing the patch.
>=20

Yes it is.

> Please update the bdrv_drain_all_end_quiesce() doc comment to clarify
> that this function is an internal helper for bdrv_close() - no one else
> needs to worry about it.

I'll do that.

Thanks for the suggestions Stefan.

Cheers,

--
Greg

--Sig_/nVl6kiE/PHnVZ9SLZu/.fB5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl+YO7kACgkQcdTV5YIv
c9aYdA/7BbmtE30t3uX47myOzulTepiecVJwBI4cFJS8d/hH8Bfm1HgYUYkgHXPx
dWINs6RZpAtKxiz6Ks17BdgvTN0xrWEKIyBywBxC+lcRq8w6jZ5THz+Adj2eCzsd
6hwcQ9XRpKCKYi6zGoKvFKv7Cmml6m+GsMIsBkkrwuJKa+JoyL8DLtFThdjWt0EQ
5bbX8imL/d2GkNCvfMKZKLuaM9b/+qf3s4qke8uGTzUApg2wam2otwdO/zBezwse
Bfzm5GujXj1SXDoJ2KrgqRd33rbb/IXDg9lZrt2rm5Z+5sgI1OQ4qz7+bW/OuV7W
UKoh62bxH7FkbDnh7r0G6aBjx0gYbWSB18/h6X5C9hh6F1+8LsUr22QUY9mZC6Od
ICcDoGiNyAt6dGvq9FkJrGcVHKq31Zp625htCr5O28kyfeZXx6pYH9DYjxnZSUrT
iT6q4YLlTBLOBPWNL8ixKW2NwcuUW6VI5lTJJkoatzTkEE2q6g49lJb28c7QO39F
Hy+DpZ7QDcVo65MdrtWRj911xQs5UZokT0vn+c3OV97lNSdfTQEPX0v469phK47c
So34QLyz2cY6nlaIzU3wnNF5chNHarwjAUTnYM2AgefVX8UheDrF88DwAcSFFIK2
XaDEcnvsy9EqzVuWRH4wVnI7kch2bi3pOEcliCAjAitkdwcsaQE=
=7pLx
-----END PGP SIGNATURE-----

--Sig_/nVl6kiE/PHnVZ9SLZu/.fB5--

