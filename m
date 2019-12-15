Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36089C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 19:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C2324679
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvuFjbvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C2324679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igZxC-0008DS-8N
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 14:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1igZw8-0007Kl-CP
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 14:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1igZw7-0002Mj-Cy
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 14:52:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48618
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1igZw7-0002L6-8Q
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 14:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576439534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uWI4K4hEXdpBon3bxEvmGem1MGm6/w5p9OGHb3UPRWc=;
 b=JvuFjbvmWIJTTtchRUVIsO4Jwu4KjA1I9kueVGejDOGlTlanQAxalKBqYDgJswy5MIliC7
 JdbAh5U9kfJs1utI3MJPd7rBF8639kKUzRpSL1VWZC8BqyVacNKT/lGY8unkE/GRYAnCai
 F1WJWZdxQX8IpCREtkrx/jPbcgE5e28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-TSqnV3MgOgyAKMPBH_ex4g-1; Sun, 15 Dec 2019 14:52:09 -0500
X-MC-Unique: TSqnV3MgOgyAKMPBH_ex4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61449107ACC4
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2019 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C916226177;
 Sun, 15 Dec 2019 19:52:02 +0000 (UTC)
Date: Sun, 15 Dec 2019 14:51:59 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 2/2] tests/acceptance: Makes linux_initrd and
 empty_cpu_model use QEMUMachine
Message-ID: <20191215195159.GB22814@localhost.localdomain>
References: <20191211185536.16962-1-wainersm@redhat.com>
 <20191211185536.16962-3-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211185536.16962-3-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 01:55:36PM -0500, Wainer dos Santos Moschetta wrote=
:
> On linux_initrd and empty_cpu_model tests the same effect of
> calling QEMU through run() to inspect the terminated process is
> achieved with a sequence of set_qmp_monitor() / launch() / wait()
> commands on an QEMUMachine object. This patch changes those
> tests to use QEMUMachine instead, so they follow the same pattern
> to launch QEMU found on other acceptance tests.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---

FIY, queued on my python-next branch.

- Cleber.

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl32jt8ACgkQZX6NM6Xy
CfMqEg//TBGuTEhGGmylRF4Kjtt68EqscSVdbqbVZfOPezTDoWQ9dxFyn7zNt0Fp
u7sf3CNL1KJdfqu5U7ypbFtisb7QBvYNSt/rAA2+yv8/qmTH4vdLRNP/4u2xqdF2
oinLMKB7r41rs+C+7ZlSA1o/tpkq2wqHpVZWvn/RvEDD9zPTtnusKNuIaM7IFX5W
PTlMA63+ob1zw0rRLRyOgFHFr8AKSi3zuJDbHKMWIw/JVLSlm9OcgqOF3DECqOzC
UHsd+3PpVfoACB+LKJFFzbGA/DxoaY/VdNWH910ZSaBZnhAH0TElRDMsH0OAHsW8
CWtKGj7jUYV88xmycZQykVLBS23ayS+/cDbeJf94UO0UfbSdgHuUZ1nZ9Qvr8VHf
sTWIN/v4e88aXN1OOb+U3/ek40X8gmNCmtZl3aboCH0rN3OlmTVwJxnMKiy6E9Cw
uKrsy/mbSZ4QeBAW5Iz8NOFnA584ytElHV7UEHJsO7fgP3x1ZKGnbSo4Fr6Sv7wD
KJvacsr0XA+GuXs0ZlvB5wKRfrdHwcO5dozHwj0KKUiIT/kL0+r+XFKd9lJgidln
CUJyNerpdy5rcReLZyysmwyUY4IEZT0fXePxpV3RKHuBtvcnjAXq2An12csswEnj
RQlkgy1Wk6vUIH0ZsI5EwCJdmwXNf6KKf27bmodnQMXF+KTc+Is=
=BS1G
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--


