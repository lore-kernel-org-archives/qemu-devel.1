Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F68C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D601205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XyviM7x7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D601205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFEc-0001j2-7m
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZEtg-0005VO-Dv
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:31:40 -0400
Received: from mout.web.de ([217.72.192.78]:32841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZEte-0000Pt-Hf
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589466675;
 bh=k6BwiqNVkyaaVhHBVXOjGsv9ADTyjkH5GRGyAHrc1AE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XyviM7x7HpsXbF21a/ZmzkGSl/GujOs06I4DfRT5wmXv8e63TZxGXgVdrSsfbH0Ec
 cKqgnXZa/WRrWA2JMlY+epkBIdeXWCceljB7RSRdjcJ9YGiCdoyumJa6wZ0ww3B+N4
 NgLnbCxtWhAOO1b1NlnljBMFKJ8NfKyUSjQVfaaQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.68]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyZi-1j7Ijo3Fz0-012Zra; Thu, 14
 May 2020 16:31:14 +0200
Date: Thu, 14 May 2020 16:31:05 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>
Subject: Re: [PATCH 6/6] migration/colo.c: Move colo_notify_compares_event
 to the right place
Message-ID: <20200514163105.14d7b97d@luklap>
In-Reply-To: <f2ea9b8ff1824a09ae8837625d6ac3f5@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <d4555dd5146a54518c4d9d4efd996b7c745c6687.1589193382.git.lukasstraub2@web.de>
 <f2ea9b8ff1824a09ae8837625d6ac3f5@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HXnf3nXgZ5xa./Cjr+Lz79N";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:EqREIUxXx6IFCSnTExE/O9AcKEpUm7qABGYXFPwLHBnveHQjvUA
 8J3GoSIPBJqCxmw7TAczy2uyYse+bBssJLelZ917LUkpS1oL/FRcqJJgatCjEiKuB9hp+Fy
 63oHxpVUtefHqAS+ye+AAXtrv5d3DFO/44q8WYU+UKJingwr6dOXwmgS4Gmexgtz0SLSd4r
 5S+xQZa2Y6CB0jWbMOs7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ahI8z8JtLc=:FgsX9rAl9NdjmfBM7J6SDA
 aAWGqYQ3bfz56zY+QB8uriG5HnbTl0wlCcdTKQByH+gVS1AfYrLPU8oXXa8N6Jmzmx1uuYjAF
 ks73wGFJtGkzKiVQPUWifpGNDGluLVfbLnJRd8dtbmwPeMKLhj+yQFn85A0X7EqMWiFbJgj/A
 i3y5Qul/0WTP8wJkly2Cbic8fk4uVmO9/6eyq0ugcj+9jNxqrY4+ZybQD7A5elL+rVe4bo8gG
 JFH+Sn2sVeJZIQT2IpUJynXji6h+1qBhYsbi0HlSJiKu5bsJV9N8pkd2aygVwcAjbjASMfsPg
 CynVkFkGacyfYa8EnOKvj0sH0FTZW1u/7m0zdKtVPMHKLlSINWLVNvxWvrG+6qoB1vbczYtKE
 Mb6DTx9T5DhbHSiEqiVFJmPKVyOKt8RYEpeTzUg3wWBjWeAT4mH7eoN9NjFmvkEhBnhW17RN8
 mnaraIu2fMtfVDigknSQVGuDvkOLFY/94R7nfrp8qBY/DN55Wj1HZzHUiqwVl9VsXLGIg3MFn
 /Gd6/0Pt9WbMiYUe5SIHmXVAEhOIbzLTvkaN2pXfdbmlzxfkcFx5SbDvxOpV//7Y+1iCcvSTy
 JRGVp6aOpr/RoJp9iJdA0S5LcTLLmSaxSCebrXsQMqH+Aht2JYHX2rLFMy1oRk9Lo2cX8K+uj
 FLjjCsdLZLh1n36XItARQEOAAJxvRPH83APPXrnJopBMaiWXzWqJ5N/vwrw+xIIyfmXLaTU4S
 B/XkK5tkQFe2LaWZW+cspaE3unKjJH6LzV80xg4hqXfbO4nbgEDN0e0zKnvR5NpQSZyRnrVEC
 EP/aATRtNaBTHY5TuWwTcxoZVinQNnB7Y1SqIEKZCEfxXO9HMCLFrmYsRMXyqdtmVwwVrWmyt
 jZRvpalFXughF5BMcIZSvnMFHACJp/tYvZY3n0JW58et3VAoVJEVBm9kLpKgjkP3bD1HRyZGC
 Upoen++U8q+JC2pNx1SEi3RoNjEQLFti0EvkQWzyTN+E+KJ8dtH0eNGOySB9I4UMQKnD+rQ4N
 5Eks+PLFGf/RQ7iwuAdBZQUl62eA64msgXDeslJaJI6FgI/vvD10Gy5327qylabJDHqBQzx5D
 jb3L2mwWa7+Tzil0AtQpVam8Zd+69B6xaXUCxK9qOdug6+Jx/6S8a8ni883O39jNaI0y45Ua+
 AOrPAUYQgkA7wxxBx4onIizEvdzG8nbYA7MUdDv59lv4GnsGHkIIxsKG5F6SXcJMhArZzt0oK
 bGgoSzuQ1aSKh5syG
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 10:31:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Zhang Chen <chen.zhang@intel.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/HXnf3nXgZ5xa./Cjr+Lz79N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2020 13:27:30 +0000
Zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:

> Cc: Zhang Chen <chen.zhang@intel.com>
>=20
> >=20
> > If the secondary has to failover during checkpointing, it still is in t=
he old state
> > (i.e. different state than primary). Thus we can't expose the primary s=
tate
> > until after the checkpoint is sent.
> >  =20
>=20
> Hmm, do you mean we should not flush the net packages to client connectio=
n until checkpointing
> Process almost success because it may fail during checkpointing ?

No.
If the primary fails/crashes during checkpointing, the secondary is still i=
n different state than the primary because it didn't receive the full check=
point. We can release the miscompared packets only after both primary and s=
econdary are in the same state.

Example:
1. Client opens a TCP connection, sends SYN.
2. Primary accepts the connection with SYN-ACK, but due to nondeterministic=
 execution the secondary is delayed.
3. Checkpoint happens, primary releases the SYN-ACK packet but then crashes=
 while sending the checkpoint.
4. The Secondary fails over. At this point it is still in the old state whe=
re it hasn't sent the SYN-ACK packet.
5. The client responds with ACK to the SYN-ACK packet.
6. Because it doesn't know the connection, the secondary responds with RST,=
 connection reset.

Regards,
Lukas Straub

> > This fixes sporadic connection reset of client connections during failo=
ver.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  migration/colo.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/migration/colo.c b/migration/colo.c index
> > a69782efc5..a3fc21e86e 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -430,12 +430,6 @@ static int
> > colo_do_checkpoint_transaction(MigrationState *s,
> >          goto out;
> >      }
> >=20
> > -    qemu_event_reset(&s->colo_checkpoint_event);
> > -    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT,
> > &local_err);
> > -    if (local_err) {
> > -        goto out;
> > -    }
> > -
> >      /* Disable block migration */
> >      migrate_set_block_enabled(false, &local_err);
> >      qemu_mutex_lock_iothread();
> > @@ -494,6 +488,12 @@ static int
> > colo_do_checkpoint_transaction(MigrationState *s,
> >          goto out;
> >      }
> >=20
> > +    qemu_event_reset(&s->colo_checkpoint_event);
> > +    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT,
> > &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +
> >      colo_receive_check_message(s->rp_state.from_dst_file,
> >                         COLO_MESSAGE_VMSTATE_LOADED, &local_err);
> >      if (local_err) {
> > --
> > 2.20.1 =20


--Sig_/HXnf3nXgZ5xa./Cjr+Lz79N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl69VikACgkQNasLKJxd
slgPMg//cr558I4PHTTC4FB0fxhKh8PjTphHrLy/OcqtJMK9SD3Df3+v8ARAjuus
x+Cev3r1/FlMGWvWorWjnL0SIuVtoIqYx6rfUfeJyCIOY6B9fjTYs7G3fwmb4U9u
6VkLYoXCB1ljkNpMxCZjFfj0WUrd+7B2PAJ78FcyH86RAOB9Hb2ykYROXrDjQK7o
NpnTldb5KSkIbZaVWkhDN4yq6VD6k2OqWOmCJ8A98Atuqm/y2d7jzgWCeK51vr1c
51fAtmL6MfxS4OpwcA6XzIiGj0QsxA9IYPp26Canu9Iebh5V61fZnuLJhnE/9FaM
S+y4SIjDxr2TH+YQtdZSesPl3Mg1KfjMYfNbUup8BoduZ7RsLiBc7DlWTNfydEcv
TGUWr1l2EKlzlz5A1sFzjTXXokqNl39zRGaD8QuFCLIlnZs58v6/a1Zg8ce3wOV9
qHBu1gxl88nFl8xBFNwButz+GjedyVhpSKyYKasBICyR27yYNefmVEAQphaR7Qaw
sXY10JiBGPWZviDTBjGl3BrEFmt856IkNCngaIjJQKIP+LVZ1J31MqJfhT29u7BU
5JhBMwVbuU2KrBf+/8Vboy+zLfEgZ6DMaP7148I47cMVS02Tgk9fgmLES1wOKnW3
PWTStcf3SOYT2hMyaS3itMj8n0AEzyvBMKjuoqApfQWV2YuoAFU=
=uv6Q
-----END PGP SIGNATURE-----

--Sig_/HXnf3nXgZ5xa./Cjr+Lz79N--

