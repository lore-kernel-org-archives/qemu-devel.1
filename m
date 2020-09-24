Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3480C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDEA2311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWgJtwpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDEA2311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPeK-0005gB-JV
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLPci-0004sA-Qg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLPcg-0006xs-5i
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600947670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1hUbyqOn8FCmQI8kF3mrfCrdpn0nKFIeu+CrocQ8UNA=;
 b=LWgJtwpfhofNYC4c1enfrdjDEjEp9/2mlekuUENCgLk+AEOegvhi+SV+YzZ0En72JTk/P3
 fR8AgDu33KQl0piq9seUlsVAgUgHqGR1DAEVL4UCksFoEjUvBq4Jja0Kad/zp0P6OOJhRs
 z5fTTYuzbdaau31H0N0TMnnV0+RtTZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-DjwwNViGPEKQoF89fA1i0w-1; Thu, 24 Sep 2020 07:41:05 -0400
X-MC-Unique: DjwwNViGPEKQoF89fA1i0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60AED18BE17D;
 Thu, 24 Sep 2020 11:40:46 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 010811002C06;
 Thu, 24 Sep 2020 11:40:45 +0000 (UTC)
Date: Thu, 24 Sep 2020 12:40:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
Message-ID: <20200924114045.GW62770@stefanha-x1.localdomain>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5UQzRzi9WojKXOfC"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5UQzRzi9WojKXOfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:44:08PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
>  create mode 100755 scripts/block-coroutine-wrapper.py

Please see docs/devel/build-system.rst "Support scripts" for the
preferred way of adding Python scripts to the build system. Mode should
be 644 and the interpreter line should be "#! /usr/bin/env python3"
(with the space). That way meson will run it under the configured
--python=3D interpreter.

>=20
> diff --git a/docs/devel/block-coroutine-wrapper.rst b/docs/devel/block-co=
routine-wrapper.rst
> new file mode 100644
> index 0000000000..f7050bbc8f
> --- /dev/null
> +++ b/docs/devel/block-coroutine-wrapper.rst
> @@ -0,0 +1,54 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +block-coroutine-wrapper
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A lot of functions in QEMJ block layer (see ``block/*``) can by called

s/QEMJ/QEMU/

> +only in coroutine context. Such functions are normally marked by
> +coroutine_fn specifier. Still, sometimes we need to call them from
> +non-coroutine context, for this we need to start a coroutine, run the
> +needed function from it and wait for coroutine finish in
> +BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
> +void* argument. So for each coroutine_fn function, which needs
> +non-coroutine interface, we should define a structure to pack the
> +parameters, define a separate function to unpack the parameters and
> +call the original function and finally define a new interface function
> +with same list of arguments as original one, which will pack the
> +parameters into a struct, create a coroutine, run it and wait in
> +BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand, so
> +we have a script to generate them.
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +Assume we have defined ``coroutine_fn`` function
> +``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
> +called ``bdrv_foo(<same args>)``. In this case the script can help. To
> +trigger the generation:
> +
> +1. You need ``bdrv_foo`` declaration somewhere (for example in
> +   ``block/coroutines.h`` with ``generated_co_wrapper`` mark,
> +   like this:
> +
> +.. code-block:: c
> +
> +    int generated_co_wrapper bdrv_foor(<some args>);

s/foor/foo/

--5UQzRzi9WojKXOfC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9shbwACgkQnKSrs4Gr
c8hEzQf/Uh+DQMhp2bvJXwZDicQNC3EbeqkyqB9hN4QuyEnZOm3Gr/FirBIIHthg
+joll3luqu9E1JOP87iMEuiJFxu2dmz8o7UgzvkYEjZxorUIJGFhyHpDiI/JTboE
X4W80dfp9Rvj3ZFUtSoMmmfsqSu5ejXAXttkGSQ8CJUJYcs/KSZ8SNjqr7Z0KD1K
z4KGjyEiAVN5YDU+sG/+OSOBHVwBho7whVYH4WkkqLKQmEhvzrRrGkv7gfeezfAF
vI0rvWN7RIPRyKyJ1dsVi1XVwqyPqXYGSOVVgmXX8baPCUWhkcxDDpMgyQdpJt0K
hADaxwLkWA8mwb2ATLo6monywDrDDA==
=Ih1/
-----END PGP SIGNATURE-----

--5UQzRzi9WojKXOfC--


