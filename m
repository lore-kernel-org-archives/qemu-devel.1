Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D357C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA8520709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lC245UCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA8520709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXQy-00070z-8h
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZXMt-0005ny-17; Fri, 15 May 2020 06:15:03 -0400
Received: from mout.web.de ([212.227.17.11]:48247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZXMr-0002Fj-SA; Fri, 15 May 2020 06:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589537695;
 bh=dzOyk8UAtOVaTRP/naIH2GXbCJzTs8yOWxYzVG8SllE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lC245UCk1oHmkwXsXPqlzP5vG9TM6QFcUqEJLTBUsipf8IlNn1KiqxjwIAL7qtkEM
 xNDu7N3zXkvr3x0701LS/HqaIjxmJcrX1tE7KOy21DatZNCOZ23vaZ78YJ06KYeDEf
 R5dXsukbI+wsaeQslDtJs/n3t+eLzGv5kqord8hA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOipW-1jTVU12PeI-0066az; Fri, 15
 May 2020 12:14:55 +0200
Date: Fri, 15 May 2020 12:14:47 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 3/5] block/nbd.c: Add yank feature
Message-ID: <20200515121447.60bbd80d@luklap>
In-Reply-To: <20200515100413.GG1300305@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <1e712fa7f08e4772c2a68197a851161bee51610f.1589193717.git.lukasstraub2@web.de>
 <20200511161909.GJ2811@work-vm> <20200511190524.3681e58c@luklap>
 <20200512085458.GE1191162@redhat.com>
 <20200515114818.25d9eb9c@luklap>
 <20200515100413.GG1300305@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K8JX96vcBMHYNLjM+Ji=YPD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:O2Clv1ot37a4EyiqPkFmMg+0VkvbNOjl/Y8moLXebYLrdS7vC47
 +cs3OqvFk8/zbFcpYYzYsqMtc+p8s3DJ1rGmJONamjSjC9mwcZq2lza7PJq7MKFRCdTFA7F
 eXOfLB85fOqOESGrhSCSWux3EMpLPVFC0egOm7BYTBqWpOc+QerdvrupgbMstwipxbZ/SZW
 MVwKqlOWeX55NU7KzVyqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QHxDhq0qzzk=:26eaouHWKJHH1zZAn+GUnk
 TK0VOK3CYHSpo3CrQ6Mnf5viNpgxztdpK+ZoNpLgx3/he8JdW8nWsPKQ0oBpy+dqSwfvBUqOj
 wgtNDm+JZjopOfXyNIE6Nve0k5MfgFOQ/qS9r2QR4dQR9ccsT/z/PsG3Us/MrTGb5/RZPwjmt
 zFqOQIkgBNSFXGxURwT102rxvwjI22r1Z0rtlWup76+0Aav9QlOMUZ+HWuvwt6AfHLDk5dItZ
 XK+CT93JslEYPbXdgoNNNM08QO3gnqRkNf8fx0oHXhAQjDcrvIS41YZGDsz7keYzSTCoPgrMb
 w1Ug9f/lFyC1V8YOeRpJNePCYdjnUZtjWGxa+/3UQtPOfphyOW5uwZWs3T5Nh+zbkooqxW9ns
 NJUZVGVkXuo0EaPdddRGEZbLAcFf/OKquz1BdAV2rhFOpoYImYtfHG0bjnNdPdKxzBUj0Z/Gh
 8bSTgEr1+F3a/UCOjqgCk8P3L2vj+C7q1bBTD/WksfEhg2TiJtitBOzcdVvQlarkQvJqdTH0b
 yH51ILF2pyyjyV2a7xFHcdeZL40f+OVfGPHjLontQTB+IiwoibUt8qmbEzvqaUSTM7nrf7E0Q
 rUinfo4e0Q9vdg9KTrH6C43IbLm3LDBDg7UIaDOmJOr0teOEzd3AOxSBoClVMidIhZOOMsHSQ
 fI6RUm5TKq9jR184QCYjUuYiUhG5NSjwqgsehcTkBF5FFMse9XjWwTOqAsfAGs8tq+DZONR5j
 Ach+fRjm/47v8FkaWjIj89SV14kVV3h4npZjjoMbi9gShu8vQBy0NeJcmT4tscms4JjBvi9bj
 A4yy6m2uSy4VpsbHxTNTco0KSKY9in7gG7f5e+oFIn/RPNBX9NQ4nfTTf5lsiK2sTOYGtvPMe
 0byxUvLRPM9c+5Yci9SdCkLpmi1QAfQ6ylvUTgJF6kX+ays6DiyR/HsUo1OBfxILh0WwRrb7W
 m/+inujYkpimNbfjcOYpaYKGTqxBRnwoFomlMRNQ16J1ih0dMNR8zIHSb2ig4CoGXSLGTqFlI
 vbNWZ2krc93cuhqUQ+podVmhyuVL87WbQ7XhynZJCdDWBk6ijJAW2FCXo/Pm1D4huKEVrdm+Y
 wukzD4bRIxBJtenhisdBoN7UCtBX5E0aQd/79Q6kprpBHZBTvPz6koyuKt15rAGAZMPp6tljG
 Mz1IpmVKc0/F/WyX+DjsXZG2HXCTCle/PyhkGspZcT+vt61YIxu4eHx+7uTkVXPrD+7F4H+Nu
 OXRBy9xQtRhNTNCg8
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 06:14:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/K8JX96vcBMHYNLjM+Ji=YPD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2020 11:04:13 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, May 15, 2020 at 11:48:18AM +0200, Lukas Straub wrote:
> > On Tue, 12 May 2020 09:54:58 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Mon, May 11, 2020 at 07:05:24PM +0200, Lukas Straub wrote: =20
> > > > On Mon, 11 May 2020 17:19:09 +0100
> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > >    =20
> > > > > * Lukas Straub (lukasstraub2@web.de) wrote:   =20
> > > > > > Add yank option, pass it to the socket-channel and register a y=
ank
> > > > > > function which sets s->state =3D NBD_CLIENT_QUIT. This is the s=
ame
> > > > > > behaviour as if an error occured.
> > > > > >=20
> > > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>     =20
> > > > >    =20
> > > > > > +static void nbd_yank(void *opaque)
> > > > > > +{
> > > > > > +    BlockDriverState *bs =3D opaque;
> > > > > > +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> > > > > > +
> > > > > > +    atomic_set(&s->state, NBD_CLIENT_QUIT);     =20
> > > > >=20
> > > > > I think I was expecting a shutdown on the socket here - why doesn=
't it
> > > > > have one?   =20
> > > >=20
> > > > For nbd, we register two yank functions: This one and we enable
> > > > the yank feature on the qio channel (see function
> > > > nbd_establish_connection below).   =20
> > >=20
> > > As mentioned on the earlier patch, I don't want to see any yank
> > > code in the QIOChannel object directly. This nbd_yank function
> > > can simply call the qio_channel_shutdown() function directly
> > > and avoid need for modifying the QIOChannel object with yank
> > > support. =20
> >=20
> > Hi,
> > Looking at it again, the problem is not with registering the yank funct=
ions, but with tracking the lifetime of it. Suppose we add qio_channel_shut=
down to the yank_nbd function. Then we need to unregister it whenever the Q=
IOChannel object is freed.
> >=20
> > In the code that would lead to the following constructs in a lot of pla=
ces:
> >      if (local_err) {
> >          yank_unregister_function(s->yank_name, yank_nbd, bs);
> >          object_unref(OBJECT(sioc));
> >          error_propagate(errp, local_err);
> >          return NULL;
> >      } =20
>=20
> The nbd patch here already has a yank_unregister_function() so I'm
> not seeing anything changes in that respect. The "yank_nbd" function
> should check that the I/O channel is non-NULL before calling the
> qio_channel_shutdown method.

Hmm, but if object_unref frees the object, it doesn't set the pointer to NU=
LL does it?

> > If you don't want the code in QIOChannel I guess I can create a
> > subclass (YankableChannelSocket?) of QIOChannelSocket. What do
> > you think? =20
>=20
> That's no better, and I don't see any compelling need for it as calling
> yank_unregister_function is something nbd already does in its nbd_close
> function. It isn't a burden for the other backends to do similarly.
>=20
>=20
>=20
> Regards,
> Daniel


--Sig_/K8JX96vcBMHYNLjM+Ji=YPD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+a5cACgkQNasLKJxd
slg0wBAAoaKs/R6KsDYXNOnGv7DSQmC2L4s97C9GuJb7+mib3gXPjXUkMHPN9H6Q
ytE/HNZAvMYzOJSA+Capq273GU961YAUuCrCBsEFjcOSedCKEZTZT/RCdHQ+FsKU
W3lYp6jJt3ptdLtXaE6lY7BcKGE1G5/3M8H3SxiVafMq2iiGWRQ35+NccWzalZI+
+T3mTi6cuqoqrCa/4eqCyrk1zdse/uJfaQPEP+PnokSDaxxPuqs/TYblWrlY/jhR
CBBWI2Yn6L1URBpD9yG0QspW0MQ/W6zGLWboLnBJV60OExKhJgUUy4EmVzMjMzEH
UVAMxUAQay/D9VvPXTQ21Af14hjKRuESjr0NeC183LYjdZbfLN0wbkGgRya2noSu
Rpgwe9TJ7JoH9GDLRYmVBYtVCJvOrLEFHaBHdzRdXQJ5O1BqHFhM3QNMKWyQiKXS
sUL513bvcYlheR2sJeaYlzdwFnLdLvVIdV7QINbyGkuLKhhLkONxmUgJWR2ZztEG
08DWK/mB/kL5zLoHMRrER1SNfVTtVhtot/CVxu/2/A2lo9uUMtNnUqjWqCWv3DMI
QD2lw9ub6/IHdfM6Q0Mw02/6iI/O7KHGlDyg1OHX5iNOwdgYkNKIuRN35Nh17kU1
F4PX1ukPar1qx2CKCnFClyRLXBTCT9ArxBK8s6AuibUk+MVHN6Q=
=FInp
-----END PGP SIGNATURE-----

--Sig_/K8JX96vcBMHYNLjM+Ji=YPD--

