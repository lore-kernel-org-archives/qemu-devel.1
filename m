Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610EAC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5CA20719
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4F30raX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5CA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Zl-0002qn-Q0
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kL7VG-0006AY-MH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kL7VE-0008D8-Ct
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600878019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yV2hkv6zIFYXwPQDiePSggboH9Feq9gOx0h1oYvaOUo=;
 b=V4F30raX1qcA8Od/aBze/C5eAr4No+PwfX54GgbyIl3iJYGFdZ3lt4dpLUxrFb4c6HfGB3
 a2JlQULzpgD16JS8LIszYhGCKTw1e4ISLK2OU2Aj9EL9Kz601oRbxHPHRNtcFySgw4i29N
 dnqT2bhzzc9fxK/jnefQeLMCC7sVhzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-GinRIwkgNSCem4a5ALnDKg-1; Wed, 23 Sep 2020 12:20:16 -0400
X-MC-Unique: GinRIwkgNSCem4a5ALnDKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67B71188C159;
 Wed, 23 Sep 2020 16:20:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-239.ams2.redhat.com [10.36.112.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B54977DC7;
 Wed, 23 Sep 2020 16:20:00 +0000 (UTC)
Date: Wed, 23 Sep 2020 18:19:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 27/29] nbd: Deprecate nbd-server-add/remove
Message-ID: <20200923161958.GG6912@linux.fritz.box>
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-28-kwolf@redhat.com>
 <0b20d22d-7c68-a4af-e0c5-471d5ba61cd4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0b20d22d-7c68-a4af-e0c5-471d5ba61cd4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.09.2020 um 17:34 hat Max Reitz geschrieben:
> On 07.09.20 20:20, Kevin Wolf wrote:
> > These QMP commands are replaced by block-export-add/del.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-export.json     | 11 +++++++++--
> >  docs/system/deprecated.rst |  8 ++++++++
> >  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> OK, but:
>=20
> > diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> > index 851dbdeb8a..9a2e083f00 100644
> > --- a/docs/system/deprecated.rst
> > +++ b/docs/system/deprecated.rst
> > @@ -303,6 +303,14 @@ chardev client socket with ``wait`` option (since =
4.0)
> >  Character devices creating sockets in client mode should not specify
> >  the 'wait' field, which is only applicable to sockets in server mode
> > =20
> > +``nbd-server-add`` and ``nbd-server-remove`` (since 5.2)
> > +''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > +
> > +Use the more generic commands ``block-export-add`` and ``block-export-=
del``
> > +instead.
> > +
> > +Use argument value ``null`` instead.
>=20
> I don=E2=80=99t understand this sentence.

Me neither, it's wrong. Looks like a copy from a few lines further up...
I'll just remove this sentence.

Kevin

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9rda4ACgkQfwmycsiP
L9Y7exAAj0xidbplVoE4//RfmHnKWJtjfCHzMQZoOvlnsBwFdb1wH6gIHstIvZ7V
b5KmzqVPZfbNEHBQB81CV1z5Ox9N7Mc/UIaRFoJHX6WIi9ffprF0FUzg5NIrumsk
7lP+5F4zWAb0BTXTFpfJftTBFM1AC3eS4Z7UNBckP3GsRDY7j8raYge16ZMXPI5X
OQLoxVKqh5lL/p+Xs/tMD1z2MpL0CaA9gJz1xYD3qEgjgLJGD1a7A3p7tCRoVmWl
xlHRUD2+blSZJcdYcDyFO++6zMMzfx6WN9DgSxScVaXS5EyNL2SypOry9o1RZZDP
VQavrz5rmaHRVl1hvt8nDgTu4XLCamVajDA0iynLhmuAU2xXWWK4jSDez0tnqCxG
15ylfiNY62CED7/7Hf2JvO4RMUpKnD5rcAOUDy6MUCcmhPpYl/PALlMXUk1YYb7x
+VgN3l0LXWCwOBjayxW+221QIMj32gbtu5zYx6v+TFZlN+E3OREKcs1riAKheHTH
AiuuT8u9cwx0m8NzzE5moGRtwavOSVyrSxun8LN66DRL4oIsk3zvJ9fYHXysdgRR
+KRaRy7dw+qXcMAEfqYdpQab7wUyQ1sUViCkcHw7oBaLh7bjNOwvaCAKkvDDLazg
zAVT0lIDYYriamWD0VU9e71d+jwq3TB6CqTAG07liYusqxLv2oo=
=MRTN
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--


