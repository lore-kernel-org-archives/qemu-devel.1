Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21EDC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900220829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUbWN2Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpx6-0002Dn-At
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpIz-0001YH-6J
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpIu-0000ia-1a
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600093079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0DRYUTev2Zw0jFY/cXy4PZXw9ZXSB2SlOXz/RGTkKM=;
 b=hUbWN2Z0K6g57DCgTy9fIIbMigxd+bj05MKf7MKkJth5KiWMk2f1GYp/AOUhNLZ+HJTPXy
 5RZ68uHGexrMjhdksekBq6dMa42emW8sUVpeXZ5QI52EM4T0EG9ZkIFIO16RxHPWQSUxuN
 GdDYgLUQSwvNwQJBbq4A8ozvamHIDAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-TkSKagBmNsqBlb-t7GMlTA-1; Mon, 14 Sep 2020 10:17:57 -0400
X-MC-Unique: TkSKagBmNsqBlb-t7GMlTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E124918BA281;
 Mon, 14 Sep 2020 14:17:55 +0000 (UTC)
Received: from localhost (ovpn-114-32.ams2.redhat.com [10.36.114.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 426ED7A414;
 Mon, 14 Sep 2020 14:17:55 +0000 (UTC)
Date: Mon, 14 Sep 2020 14:06:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v5 0/5] fix & merge block_status_above and
 is_allocated_above
Message-ID: <20200914130643.GI579094@stefanha-x1.localdomain>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 03:04:21PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> v5: rebase on coroutine-wrappers series, 02 changed correspondingly
>=20
> Based on series "[PATCH v7 0/7] coroutines: generate wrapper code", or
> in other words:
> Based-on: <20200610100336.23451-1-vsementsov@virtuozzo.com>

Hi Vladimir,
Please rebase this series and the coroutine wrapper series onto
qemu.git/master so the meson build system change is resolved.

Thanks,
Stefan

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fauMACgkQnKSrs4Gr
c8gW/gf/b/7+LJmwWi8SngpbFLY+iscfX/eEXli1tA1flyVnWrZ1rnuk+80OYEXz
v/D2E3TRpVv8kS0CSGxvXV8Dn4AcVR/9ZrKQktBARRWQ6SE7osfw8J9QTM7/0xNF
T045WohOpz9xoPE0m/gqgBjsQ6Ru+NpBml2IdZE9XDUz01bHOy0IzfAW5CfsWPPF
mm4AYNf6V8MbfWGiYokl8mMgPkiM6w3c8787KENtdMJtlhVx5M4LT2Q/jPnYHplU
Ps7GtJSz1kh9ZUAxx4PKevZOq76aMOVsF2i/nMFITyinuyRwPblZTUBhG1GZnBva
UJ6wepp5kJi/OEwvFT9VN+yS3F9x+A==
=Ew2U
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--


