Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EE1C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B762064B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy5zrSVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B762064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33465 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih03h-0002pD-8g
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih02P-0001LM-Hh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih02M-0000zY-N9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:44:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih02M-0000xK-5b
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576539864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b2k4oefNeW4FKU9T+ddBdAZlfD3ds/PR3xEHTDFz2Vo=;
 b=Cy5zrSVBpQ3yCdT9AB4qht1NwLBXBJw2EVdMMtmWSpvyWR7Gm/fTS3ncFs1EAEkq1388q0
 6hTGiRNd3eflXaoIHx++4Wi7fwFa0Jptae0c/AKDXlS/VtR+RjY47Wt/rJ/sEAJuLB5GDx
 iQZvlZqLBnkbLA4zAQAqYsn+XdkHO5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-xlxuv-8FMUaXoErFtTJHxA-1; Mon, 16 Dec 2019 18:44:21 -0500
X-MC-Unique: xlxuv-8FMUaXoErFtTJHxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66A00DB20;
 Mon, 16 Dec 2019 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B452605BB;
 Mon, 16 Dec 2019 23:44:10 +0000 (UTC)
Date: Mon, 16 Dec 2019 18:44:07 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v4 0/5] python/qemu: New accel module and improvements
Message-ID: <20191216234407.GA23176@localhost.localdomain>
References: <20191216191438.93418-1-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191216191438.93418-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 04:14:33PM -0300, Wainer dos Santos Moschetta wrote=
:
> On commit abf0bf998dcb John Snow moved some code out of __init__.py
> to machine.py. kvm_available() remained in though. So on patch 01
> I continue his work by creating a home for that method (the new
> 'accel' module). Honestly I was unsure about whether move the code
> to any existing module or make a new, but since I am adding more
> methods related with accelerators then I thought they would deserve a
> module.
>=20
> The patches 02-04 introduce new helpers and make improvements. Later
> I intend to use those methods on the acceptance tests such as
> to automatically set the accelerator in QEMUMachine VM via Avocado
> tags, and skip the test if the accelerator is not available.
>=20
> Patch 05 just remove unneeded imports in __init__.py
>

FIY, queued all patches on my python-next branch.

- Cleber.

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl34FsUACgkQZX6NM6Xy
CfOUfA/9E5ARe1b1YfG14g9YdpbCOa1WwSKqgOUz6vYTnI2Ct7NSmspWK9xxFEBp
+uISls+x1aiP89sXWN6duCNcq9nquLRiFDyW4USkqNIg9ncRxSX6zgN5Yh9GlBe+
pYoMBuprqbYOJ1wx+z7yJRshv1v+U7JgJrvRwb4qYcX9Oi7k331f9IE03qta2KZF
6ujxjQpfBz8vEqXeCRD1tgqe9mbla7L1oOxZhorDeEFXHhnTmWPkutfddSNgqLPQ
ilBBKzXGkCvBK50ewrn7gSo6SVvP1jjm5EtBsHzm8Op7hOYTEL/3pzD0AUgQ+2Th
r9wxYzg7hroNQsNtVXXYZqqrVk1YtrHoFbShzI+Ue17M4AoFk89AdAlB4fmadeyZ
sV6h7uUWtGRF93t0MzUML7tQDZCQYL2EkJvTz9IYWj3cRodZsxm0rX59okpQaurK
/ACLhk6Ff5zvK6lx9PV8ur2OrG40rM1B56gylLujVHIF+GNbp/JmrH3KEuciFytq
zjNYbxNDSYVodzbK4VcgHZstPMvqCSnFUuoJXF/Y2ERJL2kfaG5q2NN8NOeUd8mf
DAkjGsXDtg1VQ2LS16NFxjTSGY+n6vSMj5ma7EhshahQzyLXJcMw9JMOpZ5caTFL
CTgZveIxMsPQDhJR+xK+EH/AZrlVAv1dmPjZHEtlvvRK0rAwIU8=
=Wmrl
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


