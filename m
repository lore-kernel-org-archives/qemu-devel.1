Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6015C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819B82073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NpmniK53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819B82073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOWy-0001Tw-Ix
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jrOH8-0000B7-9W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:10:54 -0400
Received: from mout.web.de ([217.72.192.78]:36341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jrOH6-0002J8-0v
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593792641;
 bh=xpHbtpP+GgyD7bEG1RQEqMQhn4aPPVOKSm0SMKZFXpE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=NpmniK53qaArYmstgupc8mnR0h2iTRB1J9oaDe1lhpPoQz5hqCbXhchzr9v5IdDHQ
 6B7qkYzIPNkYY84VDD47E7NW5YfTjKYVa0TyzxCMZIYuozz5DiYpB88IOH3nyPWsR4
 tQQeAJ590Jc66E8U0UamSVQNX491psOCqBYKei2E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.230]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMEvB-1jjOay25s5-0083om; Fri, 03
 Jul 2020 18:10:41 +0200
Date: Fri, 3 Jul 2020 18:10:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL V2 29/33] net/colo-compare.c: Correct ordering in
 complete and finalize
Message-ID: <20200703181031.4ed6fcde@luklap>
In-Reply-To: <CAFEAcA-1K_zVHPFz31W9Tx7CmAXo=4-qQNJxrZnYT0Heg5_1NA@mail.gmail.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
 <1592486508-6135-30-git-send-email-jasowang@redhat.com>
 <CAFEAcA-1K_zVHPFz31W9Tx7CmAXo=4-qQNJxrZnYT0Heg5_1NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pVkttQkYty3D3Cm/INVSv_E";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KvjfzB2AL6XnST9EZaMFxQGM9zmw8a42JkXskVtGu9G6d2/W2AB
 tAaWjGPdXY/loyFcLAO7aq0F5ztu2a2C1ULoQKi5vjL4Oac4qv4uHJ23vsixI7iOYYBXpFM
 V8pRHClGwPdZZK1wZ11JehW/vv7JHjTL2TGpEMVC7eJnjqFdEOwEALO/qr08N4KOgoKUjI5
 3huO9SZKB+fqlzo9beQDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Gr5VZ46A9c=:atC74PT4o4Ao5Bk+T9bFcy
 +WPc1D3SpXmPvooHnf9ZKVSEO+svE9NKrAVnyhL8CvDxqJDtDUv7SCRR2N9nAQSFF/exJA0NY
 TCxdQWq9OL8lxPyw7QsjV/JbJPRuOxxwSMEU6vP5kmv1/8itn9hnq3YT8SB+hR1n9TqXHpFHG
 T0s2yMWCoLcn8lWVz4Snn90cJLdIQpt61hRy1kLotGSqDCAH197LryYToA3uCP+F22Szukm1s
 BEvT4RtfLGwMM5SC2kJx8zsWEM5eJdp2bJyVmukF+Q8P2Tld7OfsMCkft2vRGrRaThlaxUspf
 79HTikyyE8S7hzj609VxFRx5PmhN3MIW1h9Pj0DG3+pDwMDFdnhxhK1nsZEQqlgzlDvhN7xdJ
 sKmwtHA9DmGqheCNI5fj96I4n/CeCYnkC6oR4rPLDjPaOeCo/cMB+uUX1UDIQtUETCqTfZmmg
 CxbqVd4ecurRsfOrSEknIvhzikkcTmxTUZg3s0bvRy1DV9OMzcWxmdOTfnYTqK86tGpfvzYo9
 THNajy1Cwkp2UP84+z3hpCrz9nfztIlwwbC/O2k17+YmpfCCXJGfSkdKlFRVfg2kQerFYFLFq
 IkRO+UyBeX9aNkJmT3n8Gq3zaG7EMXJU+/ULS+AxI4VsdECeVFCtC7jJItSlSSo4HrowFm7SO
 RVWzq7rK9pnrGRUbGqNZ/2qDfisZRtsFZq0mGq30+tRcD5g4TaUYGMUU0xWBtAhkzf/wAF4Zi
 A+NiSqBa6mVf0a1eToXFMam7AkseZrMang/+MOFiqtxrAca4H1UKlQ3Qcojd03MUhZyaLUFJV
 27tgwnD+nih9lAh3+oLTJa+oqkeygFFGHvsPuXu2uf5Kyr6YoU2Dm37uOytn6/gfM3ZXur7FI
 RJeYaRWZpAGOicelmTQ2eMhMTgiTyYKDq7S1Z+H3iGwCGam0je8lb5XKLejc6AebPlQD86hQZ
 Ptzs2hw92S1cKcnJL5y4b/ovkFUA4LYeB9HETsNBWDvVBaSuW+eOiQzF/W/vtT8XieYEN3feH
 kCAIoUPfaz6T5E+CmPmWglv683Dv5LC5KKMDjAGX9lEGiEPY0RxgTmoImPhRXI5r4Zwyw/N+n
 FwK+QDX61ZgnIhQ5vrJN+2PxTp1xTrTgXCvqR1jPWxwQuTzWeQD9vZijDshk0tIyj3dYZ//gl
 QpH+DFVJcp0/NB0eKjm/bMaVdoYBzUiHECIb1UZdBQsnfLxZDBoizDlcMs1pYH4ZJQWusKe64
 6A/0/J+hakqtxUAe5
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:10:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/pVkttQkYty3D3Cm/INVSv_E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2020 10:30:24 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 18 Jun 2020 at 14:23, Jason Wang <jasowang@redhat.com> wrote:
> >
> > From: Lukas Straub <lukasstraub2@web.de>
> >
> > In colo_compare_complete, insert CompareState into net_compares
> > only after everything has been initialized.
> > In colo_compare_finalize, remove CompareState from net_compares
> > before anything is deinitialized. =20
>=20
> Hi; this code-motion seems to have prompted Coverity to
> discover a possible deref-of-NULL-pointer (cID 1429969):
>=20
>=20
> > @@ -1409,6 +1397,19 @@ static void colo_compare_finalize(Object *obj)
> >      }
> >      qemu_mutex_unlock(&colo_compare_mutex);
> >
> > +    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> > +    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> > +    qemu_chr_fe_deinit(&s->chr_out, false);
> > +    if (s->notify_dev) {
> > +        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
> > +    }
> > +
> > +    if (s->iothread) { =20
>=20
> Here we check s->iothread, which implies that it could be NULL...
>=20
> > +        colo_compare_timer_del(s);
> > +    }
> > +
> > +    qemu_bh_delete(s->event_bh);
> > +
> >      AioContext *ctx =3D iothread_get_aio_context(s->iothread); =20
>=20
> ...but here we pass it to iothread_get_aio_context(), which
> unconditionally dereferences it, so will crash if it is NULL.
>=20
> Either we need to avoid calling this if s->iothread is NULL,
> or if it can't ever be NULL then the earlier NULL check was
> pointless and can be removed.

I'll look into it.

Regards,
Lukas Straub

>=20
> >      aio_context_acquire(ctx);
> >      AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> > --
> > 2.5.0 =20
>=20
> thanks
> -- PMM


--Sig_/pVkttQkYty3D3Cm/INVSv_E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7/WHcACgkQNasLKJxd
sliSXQ//Q+0X+xL0DQH8CrTyNMnRR6z6TxtnQ2gZoCN83L0ENmH6j656yLoxPHef
9vI1qDCVBLb4A6UpYhsizmL9xIO/7kfCSkjqvNYc9qWt7P8wHg45OOmLQJOYMvaB
I0aDDEGcKf0SRgWbHFlVI0X6iAj5uE4h+B4gcwYoOcj9ruqSRafzeWn2xJJwV0Oe
AvI861I6yPkC7CuJhg7+kfekuW4WsZFB2vJzDU4SU8I0IBR+0VVRZOEYuUdWOdwP
ZKtR/F+qbGtaXms9tiDjY9mDuDnE3219Mw0sGPoh/EoyybcU9lakVzwCoVrtIkWm
Ct4yfawcxoeLqU+zL8geunrd07swCfKpbUyNrVhi3Ucuk8gvYnmHVBEQh/NDtIA2
9+ajRWPo18+hId35UbSmFNmepT7etjUOAocD5heHQ4boL7IcBNkiyLREmlbYk1EA
J2G1lzmwJMRFRMQcB7YbEKDAHl03ve9coFrdSJn24K7R6jsC5RynlJ+uPLVzjaNQ
y1+9SuQIFaGz6PMyijm1/eIZa5Q2Dh/IY3G2/GZnvKHcL4cFEwthFQgVmh7UsItF
ELwccDdAFKltx+a+7/uZftDi/bhnb656S39Bc+0maUCPyReEG+32r3NSX4r0wJeb
iplBoKIYlUBDs8KJIDV8vhNQ54HAgV1D7jqA8skgbIYFwJxZWeE=
=boCE
-----END PGP SIGNATURE-----

--Sig_/pVkttQkYty3D3Cm/INVSv_E--

