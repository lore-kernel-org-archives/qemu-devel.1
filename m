Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CBBCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AB4206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="g0XFcf3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AB4206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYaur-00043v-I7
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYanj-0006za-9R; Tue, 12 May 2020 15:42:51 -0400
Received: from mout.web.de ([212.227.15.3]:34159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYanh-0006NK-18; Tue, 12 May 2020 15:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589312563;
 bh=s+bMxp12l5qIKn128+TmnqbyjvnBXfQnye0liP9hico=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=g0XFcf3cjkpZfcrqUwQitvrKmlP98tPcyTnjSnvzMg66SOi6t7XrWE37A1U2u+mWL
 nZ+Znb/oYe3BtFUXtdoiJ58lzNOjNwajGcDZqoKPrfwnOgZON8PUYlJH5wCnaV+I0v
 s54xKEEAcl9jADLPZ93IGIu6ci8YiaDxcoKyzbLw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumJD-1jGW5A162t-00ro9q; Tue, 12
 May 2020 21:42:43 +0200
Date: Tue, 12 May 2020 21:42:18 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512214218.007953fa@luklap>
In-Reply-To: <20200512094337.GK1191162@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm> <20200512113206.62836e44@luklap>
 <20200512094337.GK1191162@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xqBLJNooJjZa=lfK8+ANU4=";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6CBbxyzkDRMe4UTVV8JhpFVMYW3lHsswcwor4mj6WqwnFVoZs5Y
 T5lqpDPrBOnAa5raE+cNRzIhC9Z9Cy1ZGQDPNl9UQEZ1qF8v4q0KJv8z1raRL3fzy1vboQk
 gnKsOwY1cnmfqlP7LPo7q1s4Rl14ZKnvMcDtuyLWVmUHCotSml/clYhpjeBFNNdRK2XnCs+
 V+R5NCSN/lTW8a4SRAkjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oa9Z5bqeOA0=:DLE+XrzlXapPMS+/UEcIyw
 TVWNTQTamVddoWuPJ5NjmQxtw2Sq/Gyy4b+7mnLZzDTgyqymj8LhaUrAEV8oZ+Ownx4A0wNbW
 tyWfNYZRf0tciMypCwOJIkYlONQ3VrTRUPOmRHie8aYwzj0SIJy3c2D2JwpWqET1ZfEz2emSC
 kYR+7LDo/K7Gd3TeDOeQoqJCN6FPNgVcw36ftDdRTyzMOGdc1OYoNn8cj/mWjunu4V9GfqwGK
 5jeingrHIbiDuCruILWnyGdusH8ho1Wrke3QxuXHtpCcuSFf3GoUuUnIzyW7c/UAhVjtc2HqA
 +XO4LmGOaS/wTHt7RvUoeSNbOLGWMTW4GxaQfcKQ1oPsGcDQucganPy2g/FoIzQPEF5QHjFI1
 HuMZ5QsPSdvHTZgiJrrj0xU2gULI5EDSa+Ik8zG0RL/X0KJZZqXDK5OCWTBnSPIYkf2B3M49W
 7gLw/MRPSAMkyVoj/M0SNekJpyiARz/RS4NNQtwLC5IRvVqg/JiOMW+qK/U22gchX9AlbnIPK
 w8+Xx92lErrlDXWgGV9+Rg96T+6qLfruQLUJPzniOAZVQqtUL8mtDvfA7B33i0xSPwYqHGwr8
 6esgrTyVzvCJ7bo1a2miMG6d/qBWU7T4NgHgd6iEQHdWq5jGbl+1/0cTVoRZ+vPnLuZ4QfUjV
 +9+0LjLcg97dd/qVnBKaklOl/BUVauMRosztQghlJnaZvV1F3qMS7hpkY7F9MpH+Qan7800Z5
 waZaVf42CRnPk+mHoUldL+rPAlnwFZ+tTXsdVvMQrHUHELAfoy5hMtWvN7EToxNSuc6EJ2xN1
 G3ysgF+SEONbzx57BK+zx3ur4MdVSgPgkAMrLPDDP3FFNpedi81TtCJzkpvPU1qSVeamhOtp6
 +lxArMbS6DGsaeECIn1xHo3KQw4xhyeH/dUreVWuUQU5tE8IFF9uM/gBo5iB5Xg3G/W8NTcx5
 5SonmGBc7IhYzErOB9EvcHMwi/S52CJNX1f46XIj9JKUeViax1g7mH4bTJEHvYvWU2S9xmwYZ
 hcTRogCFyN1vzBbU61J4EJBC2ag93n4Z5fLz9fEnJdeXQLSG/2RMl0PglaK9UFyyfC27v9SaD
 zH19Y1mQcF1PZ4STkWs4z0GH+G5gKvrpXudNGfiIt7zDeV2g8ZWglgX0z4E4x2+7cmgnFm/Ik
 XohZAAIlbCkSKNlnhSqL7rXtBWi1UfphDR9IlxtQ3XazIc+mXgfYJs0brZ3UmnQmuRdTHU49w
 xXp0lJtOQ9uYEaJnh
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 15:42:47
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/xqBLJNooJjZa=lfK8+ANU4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2020 10:43:37 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, May 12, 2020 at 11:32:06AM +0200, Lukas Straub wrote:
> > ...=20
> >=20
> > Good Idea. We could name the connections (/yank callbacks) in the
> > form "nbd:<node-name>", "chardev:<chardev-name>" and "migration"
> > (and add "netdev:...", etc. in the future). Then make yank take a
> > list of connection names as you suggest and silently ignore connections
> > that don't exist. And maybe even add a 'query-yank' oob command returni=
ng
> > a list of registered connections so the management application can do
> > pattern matching if it wants. =20
>=20
> Yes, that would make the yank command much more flexible in how it can
> be used.
>=20
> As an alternative to using formatted strings like this, it could be
> modelled more explicitly in QAPI
>=20
>   { 'struct':  'YankChannels',
>     'data': { 'chardev': [ 'string' ],
>               'nbd': ['string'],
> 	      'migration': bool } }
>=20
> In this example, 'chardev' would accept a list of chardev IDs which
> have it enabled, 'nbd' would accept a list of block node IDs which
> have it enabled, and migration is a singleton on/off.

With the new command, the yank feature can then be enabled unconditionally =
on the instances.

> The benefit of this modelling is that you can introspect QEMU
> to discover what classes of channels support being yanked by
> this QEMU build, as well as what instances are configured to
> be yanked. ie you can distinguish between a QEMU that doesn't
> support yanking network devices, from a QEMU that does support
> yanking network devices, but doesn't have it enabled for any
> network device instances.
>=20
> Regards,
> Daniel


--Sig_/xqBLJNooJjZa=lfK8+ANU4=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl66/BoACgkQNasLKJxd
slg51Q/+OtkIVnO+Ek/GqwuRguCtBxFA+VScox5f4JENNirL+bXxXjzX0+USuasb
flB+r9fGLUjQUuY2fNkXy7yg4a8lh4wjN82pQC7kalqynMBS759KTiDe3hRxJl7j
fZhUMINqMgzV5Qrn/ZIiZU5lL2RzpWTbO88WDhQsSEZJBvSpPrantGVyB/UAeoXs
xzzi1AHoasGu7CNQXel9lYarB9R99NwYdrkzNgk1t+0UxYzXYRu2gUAWNgHm5hv5
h5MCr2CFYEe2pXsWhtRBoS7/Ri8VcziD/tbI1glVDFKxAe+RGhmJzJuZArgnUvMv
et5gAhFbdbAyKSvTNWBNUWQZtA3t4c2lwO0LE0NipxZmfIX+UupnzzaVBzrtPNB+
XgDI8UQaQs1two0BItAmbpBhFM7YOOUrS3cM/elRCcyjhDXug55Q2oCYbas9tgcH
qtS1tIp3MA/P/g+9d6cGIZV3snKw6BMGlSCa/QCs1Xk1hbsJ3z9dF+4MZfmLqJhl
ms0PoFYHjMuu281htSON7MKFjlJ2DWLCo9ptsGTX8osDhM4PRQdQftiS7+bH3/OI
q0/xvVlNvbbXe1kmp8+eCHOPlYMSLdl8tw2dJwqdKLrASEBZVmQiINQErObL1Gzl
iqZxG2Ic1C36n/EkxCc4FCnUoebCuOGcS9oJY8CEShB4caL1Aps=
=RyaK
-----END PGP SIGNATURE-----

--Sig_/xqBLJNooJjZa=lfK8+ANU4=--

