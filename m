Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443CCC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B41206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IIqCEBPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B41206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRKC-0004oa-2M
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYRH2-00036Q-7c; Tue, 12 May 2020 05:32:28 -0400
Received: from mout.web.de ([212.227.15.14]:46887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYRH0-0005ya-KW; Tue, 12 May 2020 05:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589275936;
 bh=1u/twbX/tN5Bqoao2y8JEDNL2tP55ni2eAN8Bz4FQNY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=IIqCEBPc7ZZ3AHX1tyq18lCktd2zLA1OYgmwjpKCqwfrlqxoMPik7VSM77P7VTMRm
 eultEZVgZSvRuouxMbHZdlpWPfbA7dd38hak7S4zdKsCPndQL4pVMsNJ7j4xbUwM4I
 y60pVqraBww2kwIY/ugVb4jz8F+h7c4ckwIH421M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.130]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVen-1jLUpt1UFV-00DZrF; Tue, 12
 May 2020 11:32:16 +0200
Date: Tue, 12 May 2020 11:32:06 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200512113206.62836e44@luklap>
In-Reply-To: <20200511154645.GI2811@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
 <20200511154645.GI2811@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GuR6uG8UsC8gR0s8Tz_Z1UG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:mLvx5mJQV3TjJweVHuSJ23aeLgBt0WLgi04NbXuKk1EUpGdmGVt
 QqGISkphbu+/BZ8Zkdw40bzPWqBf87tUPH1AfRjB3j3q4gdV+Mm0HSSHOBPzAJmu4CJSIc6
 okXZE/+5i3DyEuBeQEgLp2zBgqTz9ceiGLrNL06ypciHgEr35l5Oqnj5eU9qc/mIqkUHtH1
 2dTSbXjfZ3nXcDV1DKt3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/X556IVTRUc=:p3V1q3OOubPOnwwxdmPH5K
 dJA2s/2ndxXyeWqNRK9M0a+ZpUDXE0AzptA/ivYBv4tp3ooN45ki2gKdBAfK2sTpjI00O0Q/O
 WJJ5WUZC4DBfoDq1uuyGBHBIhIZr+wHSgewpfpBiyDkl7mojVjDuWA6bqVETCOxpGFRkIfsFG
 8EUiujQ+KEDt34QMjBrBMk4qaECxWsdbljbN6O7y8RnuYkFwY6kxhHalszHyXSHPgDEr+sD62
 +bdl3Is1dxWmuqLdZCbL6cEQmLPjxGzMgxJyyMDoZndU0Zf20O3yLG0C4JOPQPM/wrn7bqTRv
 nbzBJC2j/bni8aLmlnRcKmPWdEhszD/hhMXiru1/gt3NNyJ6Q3Cv9wPgwZhVh/I4NRG3v930e
 hGYMLB6e668wOQkOEV8AfE1q/gv6kM/O7MnijQOvVi7tNIRFkKgVkHYMNlH1gOPK2YbH4NWMP
 TNzOCSXviz5RgMPlLIqmnuT2SCHU4ZE14sEUMVSV0rCMYtiftMmL50PdfC2DPC9KuT/xIRED4
 hKSVxJYLq0W5tyaz/gB1ecM+9gCjspur+d3aEurUM+fxeE+6YISKqgdJqDtQ8M5FaMvVJX6jT
 3mxJClHr6G+gyQQP+K46suwbrorhG5Kfag1YTHL0H9VbGMaab2FzvqPY4R95nMvY+TgWj4tus
 skAnKgiD0U+BhFISIlvecqyumHxgvGxYtp7rZZQ1otE9yr8Tkzqd++V/AzTGfOhC8KkjF6rnR
 gcWTKaOTZdwFBPoiojWlvUx3/zAl62rOnPbLjoaj9thpXl4quNntT5qs4V6XNp4mbY5vSDP4Z
 h/FpNLZtASp4xbkOm9fAf5EIlT9SRCeXlz24svZtZVqKQKavylnFYqD6fRfmp59001E5lNDGT
 DCqQqpBVH1NOPA9oqucCHWD2lrSv5bwCcj4xXvEBiNeQmKlkKAE4Q85aqIjRF+UwUV0JON8Vd
 ped2o7n+r2ouUl9NbRXUIDFssTVEYkNHdUzcwBGiekM1Zq17tIcnXZaQ1KATVdRaUcpFoBsO8
 7TdHQ8IM2oB6qwK7vAGYbLt3KMWRkUJ+oKGqGkXqeTXUUb6iBb0yna6O/Tl1Yu2LKSQjD0HBW
 emUOQrvMQ8UXdS5wR24MoTVnJ31nSXSvo3x9Shk9jghRyEzv0TjPenmEhcNpi+qYU/kRYPvlE
 6PLfEXIBxPiF5PF9Gec7INkbkEoX087o60y5v26XzE+7mAkmTXxBraYimE+n8jFPrr00Dq3jd
 /rSbXrj8W3utY4cVL
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 05:32:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/GuR6uG8UsC8gR0s8Tz_Z1UG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 16:46:45 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Daniel P. Berrang=C3=83=C2=A9 (berrange@redhat.com) wrote:=20
> > ...
> > That way if QEMU does get stuck, you can start by tearing down the
> > least distruptive channel. eg try tearing down the migration connection
> > first (which shouldn't negatively impact the guest), and only if that
> > doesn't work then, move on to tear down the NBD connection (which risks
> > data loss) =20
>=20
> I wonder if a different way would be to make all network connections
> register with yank, but then make yank take a list of connections to
> shutdown(2).

Good Idea. We could name the connections (/yank callbacks) in the form "nbd=
:<node-name>", "chardev:<chardev-name>" and "migration" (and add "netdev:..=
.", etc. in the future). Then make yank take a list of connection names as =
you suggest and silently ignore connections that don't exist. And maybe eve=
n add a 'query-yank' oob command returning a list of registered connections=
 so the management application can do pattern matching if it wants.

Comments?

Regards,
Lukas Straub

> Dave
>=20
> > Regards,
> > Daniel
> > --=20
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :| =20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/GuR6uG8UsC8gR0s8Tz_Z1UG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl66bRYACgkQNasLKJxd
slgPzw//decvn0bNfRKIma9djL8UkWvqCEuOPaJIPJVJp6s9UBWPhIMbQq+jES9V
AVzzp+x1Z50LfHH1Vq1bOpzM61MkJddPtLz6+f6QnNqipX9Kfx8Uix3fPaAwk3G8
K4QfHmZoccKRXbtgbEwyPXS7TsOhiJu686F4QfFT6xsOilVcANbUrYRc1V2QC/Xc
blQPnVMP2AsS6nslj5GuOjT09doDI3nCzY0Xw+QTQ3ngzHfCBQV9xMnEv66Iu8WL
SNapm31kDWfGd2ifmCmINPz8/KbndXx5PuHancy4mDHagPdepzVysCiIyWpk/qhF
lb/6/tWTF/4/bmAfM1pi7m9V/wITD/E3H+K4NqO+kc+4LJ8n/HkPMXj5ERjSj8MZ
f5BnP9B5PkW4kVIZC82hVtBleTtadaF5uHf6Xw9TJvDL2Zrh7iQnKe8fAPM5WnJB
+Uyx2188kJ0/iiWugsVy8TpfPNy9Zb4OsxiRFgzNe/JvN97JraSqPEv+nAUrjsDn
JSgyHMgqm0dXWxLevunFgYElbleAt4XxDLgO1fo36C8+jexrBseMryf6CBeMIiAD
KZC2PpLEfhSvcdrr9/fthk8Uk3LSccpRCGfSbtoK5k/yx4XqKXGMl6DQ6ZNMz4nc
Ej6vhXz6kj/vKSDVg4YLPBsZ4b+fu0nAVceqfdpXT2JaGoCEKks=
=zWEr
-----END PGP SIGNATURE-----

--Sig_/GuR6uG8UsC8gR0s8Tz_Z1UG--

