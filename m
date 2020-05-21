Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4572CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA015207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BVDgsdsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA015207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnPd-0007NU-Hv
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbnLa-0004fs-1S; Thu, 21 May 2020 11:43:02 -0400
Received: from mout.web.de ([212.227.17.11]:58913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbnLY-0000yT-Rz; Thu, 21 May 2020 11:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590075771;
 bh=s6EmzGnQKvQhNxY/0H67s9SSPbcPWSQxAXlMeNLwU9w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BVDgsdsG987FRk8HgjcigOcly/FubRS6nnonjhOtZFoUh2N0MynIOcXwz342uJLRi
 EbBSDAl4YOm3Jef+VDtMazdkA2P5too8TkaX4cWpwlBqV5G79nA+EqQOusi1c7Nf0I
 di18PHN1Jgg9yR+59Kthbm9TwbY2NZUrjGwtomeA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFaui-1jpXdt03sU-00H8UR; Thu, 21
 May 2020 17:42:51 +0200
Date: Thu, 21 May 2020 17:42:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 1/4] Introduce yank feature
Message-ID: <20200521174241.3b0a267f@luklap>
In-Reply-To: <20200521150335.GO251811@stefanha-x1.localdomain>
References: <cover.1590008051.git.lukasstraub2@web.de>
 <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
 <20200521150335.GO251811@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DvQBs6t243FwTUuOGz3kuZD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:1KNrUeTiw6hj/xNh12tv9yLWepZvLO0l1+acpnHkyGCLNF+30R6
 9e1WM5HJTR+dmMEYGVibjpaU5yV17a5qGAs+i4IGwUnxHi6yT4fhg6DC4Pj/JlMFnRJyzuO
 6WW+XE6KJ/zFMwYkxo53JVLS7nnuutMj0+mRQFrX4orHLUyERwL3KMivSDDhAa85zLa7iQF
 NXvKmHHg1zTfZ0MGohkgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tbWfAf4iCuI=:QQlc3pE4B7kosZUTkV9oZ0
 QbefJR5DoZPt3jw1FREvxaUjVh5ityOMCFLAQHSiUe3ZNVpPYFL01RTPzHHYl+kLu65EicXZ4
 LzNtOx2AP9fpydgKMUh+4d1iSkMpX2m6pKY+1AlCxgV7SCcLj/hpQqtfYwK02ne2eGIuwYMxb
 r+kZHPLw4p7aXGFn8avwzgt8Mkd3Vp2MFmwcuRzMG9XY80jR9f+N6S/YZe5Utf2Iq0uB335Re
 nGi2TawYBag7Ved3bh+5C6boA65PX1ij5dM+fU0X5+3jlVzVbLozhcMmWDqxINeFc8ceZMBuK
 ReickYZBMKGhPEhQI08Ff1jj+lS1fxUJu5irH009EEkr16O50TWo8niD1w92bkr48CO9CgJed
 tXnkvSKlG+oj/s7fPkW+wyG7Mt9VLD8l//55+eKDxUZAAdJfJFFWpjUb31Ml0ZHPRWHAGW5/P
 SZOH6R+7oUSzUz7WyOfdEvkrJ7ZsWO2TP0Y9Ox20cGszjeF4TXyG93NqnPqfmgz+1+K25tef0
 AH8dratIJ1gRVhkbNfXcY1cANwkpT7ULPAc/xx/FEhVepqNjxTFpfjc/HE1kjXH1p9aa/q3eU
 w0kLRyLD60KYMKby3sO9pnyn/jNaUvZIy2aedsQEiXvddkxx72dsmTZ0dY/RN2bav625EDhGJ
 JwlavFwtoqlxmG+nLabp0VMBv2ecMiiPaCVIM3KIhRFMp+e9U9JxmDrWL7qTS17/pGNOTLR98
 PMcm4TGKLgEAgmyE33gjf9fekerpKqw0B3A6PWB0KHDrEN8kVb19R8OnEKvnwXoFdMBpTMW1y
 dCMXVscKpAXHKnUkQ1a8nlRKsNXbeV7eB/i4nCi5a8JMNHuKSvM+sn+xCSzKaEE8T/v833A76
 JkoQ5aMqzVC12iQ/IRowF3copydm+UmV77bS8UvCWzX6VTllfTpJaVOX2rpCIfC8XcGd2YaUk
 Lea+7EgaRMCvqmFDHLKjPNId1B3CrwtDtwUY2740jeBfezXBAO8EvQUghdPDzvkMbQTpvpGSr
 k4ZS+9lVAzGY1u/SX7T/CT87pGkOn1BRrq36qR/TnbDfMmsQVd6ohNpYrscTZwEod9RvkFdlp
 vsEoylByRat5icDsJSSZnq/18Qr6KSKxslZJLIZNH56k02xakmxaiy7kuYiQDUZmDcR0tj/5V
 wANYskFyhoHRx6ir69apMgE+y4epf8FXTWLKxQp0VML1W/YpLSwaFM6Y7ysG/p9wBUljI5w2G
 7m/pz4f3Wp+d94OdH
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 11:42:59
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/DvQBs6t243FwTUuOGz3kuZD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2020 16:03:35 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, May 20, 2020 at 11:05:39PM +0200, Lukas Straub wrote:
> > +void yank_generic_iochannel(void *opaque)
> > +{
> > +    QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> > +
> > +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > +}
> > +
> > +void qmp_yank(strList *instances, Error **errp)
> > +{
> > +    strList *tmp;
> > +    struct YankInstance *instance;
> > +    struct YankFuncAndParam *entry;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    tmp =3D instances;
> > +    for (; tmp; tmp =3D tmp->next) {
> > +        instance =3D yank_find_instance(tmp->value);
> > +        if (!instance) {
> > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > +                      "Instance '%s' not found", tmp->value);
> > +            qemu_mutex_unlock(&lock);
> > +            return;
> > +        }
> > +    }
> > +    tmp =3D instances;
> > +    for (; tmp; tmp =3D tmp->next) {
> > +        instance =3D yank_find_instance(tmp->value);
> > +        assert(instance);
> > +        QLIST_FOREACH(entry, &instance->yankfns, next) {
> > +            entry->func(entry->opaque);
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&lock);
> > +} =20
>=20
> From docs/devel/qapi-code-gen.txt:
>=20
>   An OOB-capable command handler must satisfy the following conditions:
>=20
>   - It terminates quickly.
Check.

>   - It does not invoke system calls that may block.
brk/sbrk (malloc and friends):
The manpage doesn't say anything about blocking, but malloc is already used=
 while handling the qmp command.

shutdown():
The manpage doesn't say anything about blocking, but this is already used i=
n migration oob qmp commands.

There are no other syscalls involved to my knowledge.

>   - It does not access guest RAM that may block when userfaultfd is
>     enabled for postcopy live migration.
Check.

>   - It takes only "fast" locks, i.e. all critical sections protected by
>     any lock it takes also satisfy the conditions for OOB command
>     handler code.

The lock in yank.c satisfies this requirement.

qio_channel_shutdown doesn't take any locks.

Regards,
Lukas Straub

> This patch series violates these rules and calls existing functions that
> were not designed for OOB execution.
>=20
> Please explain why it is safe to do this.
>=20
> Stefan


--Sig_/DvQBs6t243FwTUuOGz3kuZD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7GoXEACgkQNasLKJxd
sljvww//UdOEfISDpu0u4sPDkX1y7ZDKwpiFG1cpRV8V7df3vT5xTMn1yy//rlOf
2tVm9Pi6X2TQSSGAtoKSh7kskoWpwzMa52bOIW3KGTj4ijToFrYD3m3EfD2O7VEi
ZE0KrV3T74XIC25VPKWa4cyhqSjdiwKcpJpF0jtOtiXG3ZTMzaUGqDfXkAQ3/V0R
hBcDUYsJbq7d48+wxANMq+dvlXOwVZuYkAwHIJ6wuSvEqYZDayxJ+XYshZ+wb4Kv
JV3AM62gOU47t99fFgIzhypxuCQcQone1BnkzcnewZQnto2BnDN64JgG0wYxy9bI
8PYzRWd+nYeS8hpS8VvTFLo453VGPISODyXYrZCtbXMHIJnEnAveAj0n2kvPBxJj
bgBMOcyDI9V914+NAgO/Wvx7xYNnuT1FbJ3hhnnKMSmqHzeUXPwXtBHPUAmcBzIs
kCf2w0Y5q5fzuhAfMbUzYAZq9a1yrD6NOrjsmxEfXb+OtPzqgCPT114iDGVExo1X
+0bYuZlQH4oFtk9fJ50TkGunnoUoABZNmB/PpypF7lIYU1CXvZmhKbcmHERlRgHJ
DRxD4idZ+zs+1PuKpSE3gIv9F9nnvtQnaj9hpfZAyxSZQ7guKKFUsJaqr2kKnDzk
cTHlDT/BF64WZyCtup0lTA/uULvkgVIkOQFloxrfuCwha+8uOP4=
=lpsK
-----END PGP SIGNATURE-----

--Sig_/DvQBs6t243FwTUuOGz3kuZD--

