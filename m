Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762A7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B8720760
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="S7BZ85Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B8720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheco-00012H-AB
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheWw-0005rD-3J; Sat, 06 Jun 2020 15:30:58 -0400
Received: from mout.web.de ([212.227.15.3]:54339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheWu-0008DN-Ek; Sat, 06 Jun 2020 15:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471850;
 bh=kDEZLAKOUf0If1BbWR4LBOTYgfVm46p5/4qQjOPe/gY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=S7BZ85SpmMe/TsN7qnasvC8k65CY7HUPludV85SpdYakckv3D8i4jBHVTu3tIl5jX
 fBv636fqralFr4wXMpXiYGK0PLbNL5CBQFafJQwvINPJo04eWF3eB2+cQm4pFIxvdO
 ubS1pyJni4taRnzemaTHqKQlTfH9NTHD3vE+XTrs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtFAh-1iwNaT0gY7-012nJN; Sat, 06
 Jun 2020 21:30:50 +0200
Date: Sat, 6 Jun 2020 21:30:38 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200606213038.43538439@luklap>
In-Reply-To: <cover.1590421341.git.lukasstraub2@web.de>
References: <cover.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rH/=5XBjEGqnFs1leRxwi5B";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:8ZCICRB+4qwNZiSJsnjnouQBNg2774xWPGhem/kc1DKTFvSQGmA
 w0dYVAeAvoPjBfeM9ojAm/8Ac2MlLmsko8YX1pI96KpMqbJLwydth9AgNXXWYvbu3JXZM6V
 BwslrmrkftCbw3OXNwNq32eZrD6DFg5JsevaqUSsH0IiSJSi6SRzmGpWEACnyZmlEye1/v6
 VuhrN/ERe+KAkWPGjUdlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l7BpF6YFkxA=:DaBjC9o/LXtaaFRDNuRiYI
 h2Cq86YFnZ2NGd1ZO7f6rkpZ4nnx5aqhfGmqPgiv/zA+cRqpIaypDDUQ97R765KgT/pSQROgM
 gUwCt3VjsTG/f1j78VGmZNQF2BxAepSMhVvbwtMeLrC2WU/6Jf+tC5gaPsRXOhe4uUZYc1Dgc
 fL71wxDI8LbYqSFP8c6rfTty/sUE2LlNHacXTZws6ZOpBRL8CzYS/XTM7l9qo9wY5PoIVNUwj
 aolkKm6gtFs4vsfQO0qronavX1kW5wXlHyRbJMOy0grcRnJx0aXFKTkfNVcNMU91ql6boTjq9
 dsvzdQuq1o7WRmIFQffLHNlTHcXWOGIo+td/PhaC6UtDSfNxw+4koCOLSp/HUkKMd5APoeWbv
 r6gvNAgckOudE0xV8orf+c4PTuzCYre0H8jdvj3TzT5+pojrQZhSIttLdzbTjU4A+56gBrNyJ
 em9SuRDX47o8J9AUsIHPIlRV7jpe/gYVHBwe/WCJGnBdD2pqUFa9HbRVFDhCOp48DlPFugcDj
 0kzyU66q8ING+rD11k5rfdBXl1aEJPs7cJxtFltG7agpznU/QpTNUfUPxP1ps3HCheSOpePO6
 Vi44qGSaaRr2jpmduPzkFA3LorJyhgpZxX1Ei5TbdrRks/51fFeIqEnS+5YDEmh5sW7sTkBDR
 AfxXKzTuUNwJ/oM91CGBVKBOMNwVjYIzT9LuYClJIaWtoEGhwz0ezBI5ew3XRxGjNaw0Famia
 7KvqX72m5WkPewdl6Zlq6CyK/bjVChaaeY9CaOrO3G4tsJ5qHYePEwe3BkwzhIMb+GI42Tr26
 Wx7MyZ6ZJCM4GEXzkOYkeezoDQYqgwp0ZnxIUCkYr7Og2XqdK85rJzUxO4QxcZXuLmNOPfUYV
 IJbuLF2A+WpA2c24TNUDyy6CevuHifOfz0gBe0y0aCetoxfOKUV1DMqRt2MNcTRmdjhOdxbEn
 RS+BZApCd9mr9Dro0udk4JVucNtv623/Q/+yIRg5bmoSpANA0eRWsFtEI7lcUREXSYe8k3FHF
 FFhrqUMQH145e04fCTbbZdyWZHW4/fatsHbASl2rx1TETLhO9nntkPIEBpKhrZJeA57LCeDvg
 3bIY2LNwu2Jtr91GY5XG8cc9Ifj1a4RzoDUeeHMJI0Hq2FeGdEaJ6wJGhyR+5Sw0SthN5uQ5j
 HtkKoyraXhofY8+7itgNODNlRjrkOdkzZ/ZCXlh7eQ8IpqsuexV27jKptBM1Wqg4i9VFWUVxP
 9OiGjivDCNo+ZPT9M
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:17:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/rH/=5XBjEGqnFs1leRxwi5B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2020 17:44:12 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> In many cases, if qemu has a network connection (qmp, migration, chardev,=
 etc.)
> to some other server and that server dies or hangs, qemu hangs too.
> These patches introduce the new 'yank' out-of-band qmp command to recover=
 from
> these kinds of hangs. The different subsystems register callbacks which g=
et
> executed with the yank command. For example the callback can shutdown() a
> socket. This is intended for the colo use-case, but it can be used for ot=
her
> things too of course.
>=20
> Regards,
> Lukas Straub

Hello Everyone,
Can this be reviewed, it would be cool to have this in qemu 5.1.

Regards,
Lukas Straub

--Sig_/rH/=5XBjEGqnFs1leRxwi5B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b7t4ACgkQNasLKJxd
sljpCxAAsNrfNMV/Zy4hrUb+FExpeGpOhFhcItzVDezbglbQs0CUehRJSRs9AdxU
QuOUZWiqw4aE0z/w2TkOn49mKjrj4+8uiM0+KCcGUh5cvChksBWvv69jBjvX801u
aGdzhS9GqXJEpkUZq7dU1OnV2M47dnal5t2Q7Xy/62TVLVpCnpOxIAQsg9zH4Ohl
pYfD25e7fspgyrTtn3A8+KeHdd3QngAGndoYa1nayf5NkZS8zxk8XMFnM7ONsGc7
7IpMMdFRHLVnCeyshO5qYlNKVue5uIGK4ce9ZK349LpwjutkdrUL222m0k1WnEpX
d/+funF3hT17wA1rvhhpHh4XsPz6OmALBofIc9UQvygJwU7wR38CxJZJfTi/jFdG
iY8mpOh16uJakB0Z5HYNWqUvHAQHjJKsBUIyvt/VxQhEWEBIeuV/IJ4SrwUW59xZ
+dIom7f3ePfSQ+CUYt3+0SMHdhpnqlbxfko6S4OQ3Hy1bZN6BeqG/Y5C2dM4nVWB
sv3/QOwnoY26hVVKNRTn9sPAulDe5SRMG6/9Zt8k+cZeygxuEFyX4IN18LHvrsms
SjkSuRLuI93AF/puo5MMeOefkhZDH0uLsRPvei10bS2voLd0A/axRr1BvfiYcUNs
UOXe9N2hn9ylaiwdOmwacHJrbhLSn7p3vy8+vuqwd0iGe6dvSbM=
=xek4
-----END PGP SIGNATURE-----

--Sig_/rH/=5XBjEGqnFs1leRxwi5B--

