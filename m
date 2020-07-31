Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F75C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 13:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E8F20656
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 13:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="E8iMvpWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E8F20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1VAC-0001MP-Ez
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 09:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1V6y-0000Y6-8X; Fri, 31 Jul 2020 09:30:12 -0400
Received: from mout.web.de ([212.227.17.11]:38683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1V6w-0000Cu-H3; Fri, 31 Jul 2020 09:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596202202;
 bh=cewFdCnX/8XoD9b3zQ50KVW5PM5XRUIhjPHkBynfEL8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=E8iMvpWFgVpOe3TFkQkXX4XCImLWHRPgmUidhd18l4+bxYqFy4tS6oQGEReHZZK5Q
 /JCpwygkowSveVL+Y+I6eHeuUt58wSP9CS1FrZrLKRMLaK7Sp1XFofDeu1debySPjI
 I8QedplHoeODjjNejHqWYPe/gD87B6xDYm2Wgn5w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1kStmT13RL-00j0x8; Fri, 31
 Jul 2020 15:30:02 +0200
Date: Fri, 31 Jul 2020 15:29:52 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v6 8/9] chardev/char.c: Check for duplicate id before
 creating chardev
Message-ID: <20200731152952.5d9ec9b3@luklap>
In-Reply-To: <20200731093734.GE3518939@redhat.com>
References: <cover.1596184200.git.lukasstraub2@web.de>
 <b6d4b5712afc095f3d315818723809a20a2de21e.1596184200.git.lukasstraub2@web.de>
 <20200731093734.GE3518939@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l/_N=w6fO3RzsmtI170W7Wk";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ER9VPtSUEIXEvTHl0/5hLNHQHGzz0TAJXzobgnaqysEZ/3ZiSP6
 7YPaDExkHfK+Cx9jBnzl1qFoXxqiWqtONaFhBmG3R8g2MEsMARouNkoOhV4Uao7Y/UVq4tQ
 E3ZSnT5dpio0jq0sI9QzKa+lnjnxKndrlnBFmzKBzduRI5LJqlSNapMpqMk74EJYyoLy0qf
 HkScRcHg/UFcxwluX1NHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZdRejazbnPw=:jRRvZhz7O6cY0j3vaSFr1m
 rxe26XExnYFx6Cqt8na1Ji4XqxM0aZ7XLqlyAASoGKfIuUByvwx7qrVMIynxmQPAvIzT9+U76
 RB8lPglUqWlxgJNTEhE118V/7qrR+LCSnIFY+jrECMwOUa+qpMtEQywN8JebpLavKe4WDHBwf
 mFDgFNJ/yMlBUHWCjZA+W5SfBNRZkcMF3HjCuTiXM1VKmsiQpcR22hQ4n/r6eR9FTBqZTPzk3
 TwUAe2nrWbnxeRIQYSFB3QJbO1873wOSGcWaWguGxSAr5ynTXkzeTVKx/3m26CEYBq5GBLa9b
 dKQ9UQ0tIM9UKNHSeG3fVcdVbRDbQoXE6bs1WVf2eBwQYNE+ZjhFbDBlVjBZUWN8+dTX63Aob
 ZL36w7XeAgn1xPQrO3ALXTmPethTz9klSWMERLeVH/Cn64q9pSwM6Y4Q08y5zH6ekU9g3hrSV
 5EfjRaQgC3YGPvyTEMdjZ+APh9wc4qYzlyYcInnvI+o9lHzgJ+J+zuDHrPOQUfhJ5DDfU539p
 9x/zI8xT9wXoHEhYryWCmuLTx8GggKucZZ4hdVvvJvOrP1nMpyx7jBvfxjkxIcLGgAzLB9P+f
 JGx5w9j+nCNVzKi2D2hHvesS8R6TZpwS9+hLox+Y41fkJwuTjKy2ENjpzaMP3qblPKaspCDzS
 GEvI7uAS44i1HpuFK2u79XzDu4+V1BuI7iL/LrelsTQkdk02+juzPeK7KM+qLooIfXuYzJl1j
 7psyLnjJbWEWkGjcoaVdcTu9/ZG+O/jeT10xTI33VTeFKXe61pzngVdEzBEprDEsDu53QL57r
 HQ/D9tzkYPI3iRDVIiepBbiRcNiaiDuiEApojVp+YwhL7Z6k3sT45xTDviQ9qSgRS/aKO6BPo
 Feqj3aD7/0Z/BxrSrxBct1CnP4YtMAFJJllpHcmE3j5KcBfeeTcUEF9WQ4L4V+ZrQKSy0poGJ
 BqPNzLuljFe0ZRy//rAQlcK3/as5Qh8H78JKEKWmKzaRXDYEQj0jXulLGlkWV8oLHTSSCHx1i
 vPXqTuy01LhxmeA7NozpRK8TECYjFIRU0xflhOJVfmhO2mWHvlDZHtJO0pbiCsV/pE9HOEfF4
 rPMHU+A/uHOBoOj1pxjbjVkgC+YLH0iXQOk9T1v+lpVtE3C8VleMB/JMpmH1jNCCLgb9IJKeZ
 nq9/VI2PTAZF8qsirrD9lDKS11MyjJ7jNf6hiB7sQu3aNTCdaarA2N0niIrlTb0SELwL3FSbY
 taVTJShb2BdPMiNB+HY/f85Zz/NLw8qPw83AmUw==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 09:30:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/l/_N=w6fO3RzsmtI170W7Wk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jul 2020 10:37:34 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Jul 31, 2020 at 11:27:04AM +0200, Lukas Straub wrote:
> > yank_register_instance (called when creating the new chardev object)
> > aborts if the instance already exists. So check for duplicate id before
> > creating the new chardev to prevent this. =20
>=20
> I feel the right answer here is for yank_register_instance to not
> use abort().
>=20
> Instead have it take a 'Error **errp' and report the error normally.
> The caller can then propagate the errors in the same way it does
> for the duplicate ID errors. If a particular caller can't handle
> errors gracefully, then it can pass "&error_abort" to the
> yank_register_instance() to get the same abort semantics as now.
>=20
> Regards,
> Daniel

Yes, makes sense for yank_register_instance not to kill qemu. Although (wit=
h this fix in) it always indicates a bug due to a leaked yank instance.

Regards,
Lukas Straub

--Sig_/l/_N=w6fO3RzsmtI170W7Wk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8kHNAACgkQNasLKJxd
sliOzA//VGUVg1K7o93gRownrK2PiCrwponNIgWzMnKo2k1c1A+A2Ff9acP3Xa+Z
fnqTXfCpNa9jcdjyQr2WsE/VvHxeqGa8KjwzW/h3kNCOzLags+BklX7Sh021yC4A
IUbnFJu/6Ny9h35Ud+jxgn4EbHm8t2GEuBw0JA6sScYQAw7whKCKDxsDWWwbecR3
0hWBoP9dpCmh26/M22iGY+NLK7+KFjid5eAUlG6mQrJXtcd7h1UYzH+XfWHDma1a
oS2FaFcItlXsSEHybmLIFgeV4mRf75GbgPt4UYMs8aaVkDOv3Nlhoa9HWUFD6gX+
1ItLIkLtxMO2tofHB1FKtCAzIkwbO5oLr1xvW/95G9Tmr2uIa4dpuijblB9zPgXr
jeXLIiOrqWXyoGCF8cyRoNKNxl6TeR+/NOUlIX6l2nuZaPeK+bi++yTXkH9vp8Ln
CNC0KXcOV562wd6qT0I2slpUS7X9KPx8ZgxflPhHn8FPE3tHCQw2c5L00v3//AQ5
SW9tctTe5PugMqJ2iXGBN6a45Y5ChFRtiDCpxDMAV7eIAYaiuFnfykaBId1Dw0tx
8VxFICz708xl+G3LMCBqXCYeqdeOXd3Dupxx5f4vuBLhO49C2PbTRSHSE1H5srAw
rwYG6ufBfApladMuP7xNb4mARI4FYPgMuGXOWByV3prnF90oYJo=
=ivCT
-----END PGP SIGNATURE-----

--Sig_/l/_N=w6fO3RzsmtI170W7Wk--

