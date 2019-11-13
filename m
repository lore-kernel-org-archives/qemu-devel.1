Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB28E2246D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ03KvKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB28E2246D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUugv-0004uH-U6
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUugA-0003z0-CG
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUug8-0005XY-QL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:35:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUug8-0005X3-M5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573659331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kLDMjeic1Y/Rhmz3kahuWRpEUgIDWMGl0Sit/e8JgGQ=;
 b=eQ03KvKlPY+99ijRyVW/jBhvMaloq3qQSLUqj2/fVPcxnFxYM7iTai5fanSYtN4wevgY4s
 mvu8y7sxeojrhIpfOSndnzRZbliIbrlv1un9qfIZ7Z6AgZnbSMkUtj83Mpxji5u7MJyE13
 vdGDRLqfkf0dTF0QZJmxTBTFkK52jy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-pu3q5FOGNKqIV4caZ2rwng-1; Wed, 13 Nov 2019 10:35:27 -0500
X-MC-Unique: pu3q5FOGNKqIV4caZ2rwng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A51011011CE6;
 Wed, 13 Nov 2019 15:35:25 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D90F31D0;
 Wed, 13 Nov 2019 15:35:19 +0000 (UTC)
Date: Wed, 13 Nov 2019 15:35:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 03/49] multi-process: add a command line option
 for debug file
Message-ID: <20191113153518.GB563983@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <a321649464d9176634ade5b6f7e6175f654f6a46.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <a321649464d9176634ade5b6f7e6175f654f6a46.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:44AM -0400, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Can be used with -d rdebug command options when starting qemu.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  include/qemu/log.h | 1 +
>  util/log.c         | 2 ++
>  2 files changed, 3 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3MIrYACgkQnKSrs4Gr
c8hzbgf+LzwKF89akQToFKWcOMATI8s/f0nPBEQm0UUoT02D1RAnIarPXvt2P4/k
G66giZQDSo1eoloF1zZ8JnWipLeM+L/006qnP99HNlOsEoX5qLI6c9qZEnlpNxQJ
GYudDPCIahox/y8XahSFcL/r5Q/kOKESCeZojlBQ5N7sIh5NdSOUJvquO5ZISo6B
8+Immm2gOHGoQBvPmrz4ovf9DCeaE0WW0lsSZrFt+IWxupAd+0UMoeDolgtUBAHx
vC5kus6uGA9iSqkkj9cNhs7Zf5FU0o2PAXJ+HZ+TPAGiJOE4wi4BcmCLdTO58phj
npdixIShmlHdSbSZd75SCTFoW2629w==
=kbYy
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--


