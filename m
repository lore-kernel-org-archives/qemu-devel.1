Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261BC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15AF206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Yl0j0QTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15AF206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBh5-0007Jw-P1
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYBe8-0005fa-Dg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:51:16 -0400
Received: from mout.web.de ([212.227.17.12]:53419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYBe6-0005EC-R0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589215869;
 bh=0XjSKjr7n+6igO2THQtt/aZP7Vy4DkajowhEDes9Z8w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Yl0j0QTpXy6OeK7JnYac/QULVwPvzKbh5/A2+z0XWhlGescQN48ISM1TxJ/53BnFD
 l19rkLQhnf3eR+JNc3v1D/OD62+b5k+OLB0LYJ7chkSHDLxUhuj7Srx5LHzUBysial
 j7QS+OOlVdekH1urDHjTUPJy5PtYX4sNB0ZPJ2WE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1jamyk3763-00XpdX; Mon, 11
 May 2020 18:51:09 +0200
Date: Mon, 11 May 2020 18:51:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
Message-ID: <20200511185101.6fd82fe5@luklap>
In-Reply-To: <CAFEAcA8g1gq4QsXxfLYSOChd_Nj6u0EKeXO-s8Qww9qA_dBiLw@mail.gmail.com>
References: <20200507162235.1790-1-philmd@redhat.com>
 <20200509151801.780059c3@luklap>
 <CAFEAcA8g1gq4QsXxfLYSOChd_Nj6u0EKeXO-s8Qww9qA_dBiLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ORBbV722Fc0Yuj4/nmB.Ry=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ZR0X9C7ri04mhS/aq1jAqH9UUimCnw6yk+CEaJWMefl76LmQXAE
 JZqRse+zAx27r8hXQnSS+0l60Tkmkd+zbf7MV9muaLugtOCIcbLQTil2kGIPeGuJLuQr0bx
 8FjxInpEEe5iIqOXZDwI5repb+NKypol13MSCYk0NYGPlxS9F32bPHa9RU7FLtrJU5Mo6OV
 z8ogUGXAQzA7Dmxq3cGPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ce88splLpus=:Q5Y/7yrT1uIenL4N4NxtqH
 M543ciVU5W1Sniw49Tv5CUFhn4wqC3vCgF7P6ILBb598E8nmIgkzhpKF7fcBUo3rDpAYw2QCi
 2L/ReqOdn+b+XQ+K/JqKqSkaJ/t+GE5of1cZwposOiflzlwYKUol5ye1bSaaJKAKmWwhngwwr
 9yn0ATLwohSemUdWpfHmq1hJ5HMkgZTfLmsSGjhhTGpRtgp+VbJnGzNGvdjMxB3ljBfxUQQNK
 Ov8t9kZBJyjQOohVdHdOcH4OO7OjEL3oLvjLHN8yxPWpftlgmzsqSXHw0F62FpyDWiCjhnIHT
 EaI5cbdSzIapBAK46QILGJ64wFVfgE542y4GJNYDsqy/h508VhXmHiV5nbwa58/oSYVDU8nKb
 uC/OWDsyAtFeDSvba/uXEbZ6K4ILZHBRW6ex48tvtkoJoU+/VmpA8I1Uzt8p+rtR5hDeMvcEd
 ci0DhihNAqQYMCLg8Cb7sX7HpME7Iy+AuCsdrBnVrHaj0MqiFSBWB9q/R8ekAeTUuKcnl9Hmm
 PI8c3TD/TaHT5ON9C8XJhEV4dTCUcL2e/V//IFhXC/bWogeTafLgxbukNRESWaWXahD1DHtTu
 NlG6Qy2RBiYjVUX0M40f2u5GKjby9QY4k2fgCc7SjMSYGP33FP4hPjedBGBR9w1lrGG8kzBpf
 nrvOIiYCCRERKLU6iMApML27v5tVDtBWbyAeql5PD6TAC39z0QFr+VJ2pvkXgEivl5wCV0KAF
 q1+gyiD0MK3m0oQY3jod4lDxTrRtLW8XLAB4QxXXMAsA18SOS+MO8zyu6XiR7F+rXTsIMLQVK
 C8I7sfREZwXambve28FC95eRSo+GFSVzZqC/AJPWAa+qK6gBck6I+Sc/AlAJk0tGIfXR5Kurx
 sgkY0HoYbI2oh2HJ+Sg/1AwrG3MvlzDJp1ba6H4o0+81mi07mb5qs7QXZ9QHeiwZ44jOI+QVz
 SFx9RewOS/X+86/7spdFbDQYi+8z12QejyZFCyN7FX6qWIG8s13/6Ub05myC9nHkCj8n61S74
 GOrAUDKh4kzjFm0B053ffcfv4LnSp7zWLQu47tzB4Zt6uOorNuXiWVZbR71YMU81xU4xdiEYA
 GE70jOkGrhpkO7Afiht7NnhdWixSPZsEB3EMdxwmf1wxG0AtkfKEbQik/eksiiSbC3UmCVFW+
 VP8U02unFXnEzRIhjgvBJU5Xr7zWIaYulOe0EoBPpzSXkLezfaqNmCF8LHjJtbqlY60MXfQos
 hdDzV4P7Yx4alXSLD
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 12:51:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ORBbV722Fc0Yuj4/nmB.Ry=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 10:11:20 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Sat, 9 May 2020 at 14:18, Lukas Straub <lukasstraub2@web.de> wrote:
> > Hi,
> > Why not simply add slow tag to the test. Like:
> > :avocado: tags=3Dslow
> >
> > The slow tests can then be skipped with
> > $ make check-acceptance AVOCADO_TAGS=3D'-t -slow' =20
>=20
> Is it possible to have the default be "do the fast stuff"
> and only do the slow stuff if the user asks? That's the
> way round that we do the iotests, I think.

I'd set AVOCADO_TAGS to '-t -slow' by default, but now that I look at the M=
akefile it's not that simple:

AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET_=
DIRS)))

We'd have to change the tests to skip if their target was not built. Than w=
e can use tags for uses like this (and more like net, disk, ... tags). That=
 would make it easier to filter the tests one wants to run: https://avocado=
-framework.readthedocs.io/en/78.0/guides/user/chapters/tags.html

Regards,
Lukas Straub

> thanks
> -- PMM


--Sig_/ORBbV722Fc0Yuj4/nmB.Ry=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65gnUACgkQNasLKJxd
sliyAw/+PiHf+1Rt2OdQ6ZY3Ohq6RwSbN6QgHGvNEovVXYkWU3jRAa1flmV1alYj
myufenDFPoN46LVMZYKcvykxgYTU9BSM7LEtt2XX/uoXMA2ksS/m4OE6fWxH+Lzl
cVv4rEGp0uuTNGFbvYUj+9nXYaFCilZVm85HUXnmGUWUNaeAcbcIUXKpc/alf6yn
WmM63kPmSeX9uEhJPt+H8Uvcl5EMfBc5hwB2ThjhEIPGdLRl/wZR5VUWSNtfZt38
WMBPEOxKdP3qQLd0lDZKCw4OKmBbNWiyJYUD5d3bG/ZN3xENVw52yubce9254Ncl
pqr8vXuuYEhoQeVjvU6gGNTxjnTdDjMNiHZc7fjC90w6JarEHozOGXPEg804PYq+
rhKo9t7lpabYiZFfPSiaMj2fyHQE+wkGTeZQg6oauV51pxQQ7JPtKW7TcGW+aAuv
OQIi6deCbgrWwcx/7X1OepCCNWPrNCV3dZgC/0lmYj3O86jgR1o3zqBSoyYzWiNm
y4bwQL+Qf5jcm8SsTjozT5HVkuaATEYXFMbegh2arXT19ggWMrMW3HsAZosfNFEc
S+TGcW3scsVyeIGOZ7PSH+Ep+tskmHDhP12na54Z6gkWSip0dqOZ3/AtunOaFYw3
u/zGkaq7h7XuLDf2moMqYkt8IfeVsHprIqOHJLxyH2to3niGoFo=
=AF1A
-----END PGP SIGNATURE-----

--Sig_/ORBbV722Fc0Yuj4/nmB.Ry=--

