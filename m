Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7EEC54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A26520720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qwz/LqRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A26520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEgD-0007rd-Hs
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 16:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYEbj-00049U-SD; Mon, 11 May 2020 16:01:00 -0400
Received: from mout.web.de ([212.227.15.14]:35343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYEbi-0007q3-Ix; Mon, 11 May 2020 16:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589227251;
 bh=o0GBAHDH/4KPa8rw5f4k2nO41w+F7oWdLMFzYd/zU4o=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=qwz/LqRwGzznRNPyU/4TsU7Ue6MOT2WXA4wjJdvVuuxJzK/1B/WZKVWJMqmP7HIlT
 jJtOmC4Roq7LTCrLJy3Yv48PrRsn/G3mWOvWcmeMTN4+/KaNpygYhVtvwLnl40aGgL
 OYGuzZoyuKy4TA6Ahmr9XqlWoBnekCodPC3gymCA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MevzF-1jj2M62gNl-00OYp2; Mon, 11
 May 2020 22:00:51 +0200
Date: Mon, 11 May 2020 22:00:42 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 2/5] io/channel.c,io/channel-socket.c: Add yank feature
Message-ID: <20200511220042.1f226f70@luklap>
In-Reply-To: <20200511115146.GK1135885@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <db00ff13f62fe97634132e43105b9bf63bbbf582.1589193717.git.lukasstraub2@web.de>
 <20200511115146.GK1135885@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hlX8Matle/Uuvv1wk+f81Ux";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:TSah9ZkKk/8xVrmXl/09Q7UAXnzPzKhfXir6MSCpYH4DBKgkLY8
 Dhc8MCragEmp5gFM55Lt8YJ29ACs7WrSL+wOI61/t9A/KetncaJgQoLO/jdfwWUDAkRoWkp
 r2GD6PJ17PljeZjlYxyJXu/GED6sMhXCFJVF/6ccZANc5aq6GOB+TinY8CEVCVJbyAwo/iT
 pT14xmqaZvsSqphW+1plQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+aZVAe/4+IQ=:+O25/xuTUASMN5UkZKUgd1
 w2w0sYb3CqitPl1122ov8dtAvkHvsjOtYAOJ6B4wHkXjfN6N6LB8A1MmtlLrJj/oaeD6YJIpa
 J7eibYG2Or4FPi4k19m2SeTfFzzEoRoZP/gRZsg1IozS5BUe8RLpiw1yIWl1sXLU4FzQxN4Lf
 LInJ7UROZu14+VprMtEjPoLI55UhRhWvrG2niA6E4s4eZbOWtB9RYJUS9gWtHFGpHO1+MOR/P
 fByw/ZbOrD/DN7EpJ73pRtO8rFnxTG4oPNxuVtXSgVT1huGZrIyhyhCV+uzgPu6XRxA06OTHN
 c9MaP/o346RF09LDuQbrSM6HnaBLQYFOTo3tSE/AlRdf9W8w25BH+0A2KniwJdMGlnJZO7Z+d
 zDAJOKblZkp5KNJamElhCBR2w3BMQ08UVqREOnr/SREMUJfjbB8fuBj/klLOtbOBsfvtAgl07
 yXihesJ8PfHCHUpcWOTPaSSNxZKSgKnIevj/3hPCiPEDI1L2YRAYqTHpT2eZTzA9mI9x+zJey
 HsPWbMBCeisjbYMOxygfMyujMVehzUAide/+rqYAwtetsMI9IIJUE2DdeN6Qxyx9F5DRgYwPq
 TxoJERB2+IkHHF5Zhe+st+3RFDjQFCsKWbq2dRMPkyrwGLoakugI6tjtgJJDq/D+VY/5WL2rA
 kzI0HhHsOcRFZVsoUSAj/aMAYZRX5LAJarc0AvzEQmur31i/Db2J82sS84KlCNTyMXzYtf4J4
 wGHEUULEi4oUzNr6vF6f3pMpWepKM9gTFLU4h8defBTaV0lAVhRAVhXItlhhWSztfV/CCIgCz
 pdpCQjpDu60sURSLAeEutakoWmauepdhbOCSxqaksSVr7rOSmPNCbytmu4s71wk/q+LYiq4Rk
 O8EbpXAPT56bUtaWBcY7g54vqey7o12z3yTqm4cM8KAWyMLo+n2gybzn9jYeuk66KauN0lxD+
 +vV0OyL2y8Lm3ekIALyAZWB5qTXUvr6UKgVg0lpCZUapqLqoRwjG6Sy5lLcTbeYPJH1jNQi0t
 q8QIom1//7679j4gdqebLzSCKsBSuThJcEo503bN9CN5RLB6ge1f07+SmwCkncTL9KfeZH5og
 TVASlh+9g8dgogknH4YUzkvXY5W//YyegtxszWtnFerDVjbwyckIbUh5D8N+N12XKuuRe+iJr
 2q2Gt+wzIeGUgjGjoIe1O0JOlI/gU4qdpEk/yLyF5Qa9Y5/BikZaN1d47orIWss4jfpUXaSdt
 jw7XAftf2FO36vX+W
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 15:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/hlX8Matle/Uuvv1wk+f81Ux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 12:51:46 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, May 11, 2020 at 01:14:41PM +0200, Lukas Straub wrote:
> > Add qio_channel_set_yank function to channel and to channel-socket,
> > which will register a yank function. The yank function calls
> > shutdown() on the socket.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  Makefile.objs               |  1 +
> >  include/io/channel-socket.h |  1 +
> >  include/io/channel.h        | 12 ++++++++++++
> >  io/channel-socket.c         | 29 +++++++++++++++++++++++++++++
> >  io/channel.c                |  9 +++++++++
> >  5 files changed, 52 insertions(+) =20
>=20
> Assuming we want the yank feature (which I'm not entirely convinced
> of), then I don't think any of this addition should exist. The
> QIOChannel class already provides a "qio_channel_shutdown" method
> which can be invoked. The layer above which is using the QIOChannel
> should be calling this existing qio_channel_shutdown method in
> response to any yank request.  The I/O layer shouldn't have any
> direct dependancy on the yank feature.

Having the code here simplifys the code in the other places.

Regards,
Lukas Straub

>=20
> Regards,
> Daniel


--Sig_/hlX8Matle/Uuvv1wk+f81Ux
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65ruoACgkQNasLKJxd
sljeWg/8D5/EVQJ0pFLNxNmctBtKS7GyexKAEm+6KqVu+HSTs8/Enf2zmL/FuxHM
efViTVRa84OUXCZD1wZEfHQGm/40Et73h36gJMC69VLTJ3BuwwABWF+rQmBBG3vP
62wOXx2d9eIqadQZw8i6to27DTcsFBvlV9abUfx8z5aCYZZAxF0eu4BkQi+HKdTb
WgSj1n0qfLhpx1Y4U79xf6ZJWJbbwBHm54S/D9ylzy+q7agtcOLSPnva6HYKjc/7
qlOr7kRCTdFvgMNtIExMxY6L2UKt1Rttmexk1PU91B6HGodEegyQs/ZAFI0f1FyI
dUEuNNvXqPSQXuGkp0ZHdVt2wGiRfrU+ag5BwDGOhHtq//YF9vlj4xyQfuOl9mwr
LuCQvQy7zA98uj7nYS1ew34+fSl7yff/bXyUwJN3PjyNEtlciwQbQJCQ/L70Hll4
njPG/rFxLKaiiawu1qOuUCYEzkRtMZWzX0J2WU+TJtjqnFQep0HIK7ez7rHykV7M
GCZ1yHVvsQ6MfvOWocg+6MSghSylY0rBOPK6SqaX+afeax5bNwMj9B5/ESfE8syL
3XrDijp9zDpmyFcpjRHDd17zj2KxvZJTD7atwV5mPZHE6k8zEhdI0wBcIna/Z4dc
fHtJ69gJ9YsyOYHd5taqTkAZFvLKVhb8JNAiqd2RR48UXSEBv4g=
=D/VM
-----END PGP SIGNATURE-----

--Sig_/hlX8Matle/Uuvv1wk+f81Ux--

