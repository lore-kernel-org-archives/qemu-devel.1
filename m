Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790BBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487382467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IK0D+bxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487382467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7itN-0000L3-BQ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j7ikR-0002Td-JY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j7ikQ-0005QO-32
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j7ikO-0005MM-OW
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582908259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JbKqI1nnK8EVo1x92Esuh5LZAjCk6KpIljqLivcx920=;
 b=IK0D+bxtFUPQZV7BjOH23T75m2UEwMGFwu4cQwN6dSImUA0ay/iPjM4mmL+TqfkTjpqjei
 SoMt9z5G1iLAxBpMERcRFehscoJpJDgNq5bKwXTiQGkThX3Z7f60Uh8JC83GgBtgE8EA/K
 z1KXWYHpBbjJI9ysToLRyB5ZYO+3ch0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-HOJ9gczDNcaMzF94O9KyeA-1; Fri, 28 Feb 2020 11:44:15 -0500
X-MC-Unique: HOJ9gczDNcaMzF94O9KyeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25C9918FF664;
 Fri, 28 Feb 2020 16:44:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B2D68C07F;
 Fri, 28 Feb 2020 16:44:04 +0000 (UTC)
Date: Fri, 28 Feb 2020 16:44:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 47/50] multi-process: Enable support for multiple
 devices in remote
Message-ID: <20200228164403.GA332098@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <cf33de60b827e0cdd3d5fce48eb038cb056dc304.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cf33de60b827e0cdd3d5fce48eb038cb056dc304.1582576372.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 03:55:38PM -0500, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Add support to allow multiple devices to be configured in the
> remote process

This patch allows multiple devices to be addressed over a single UNIX
domain socket.  This could be a scalability/performance bottleneck
because an SMP guest can only talk to 1 device at a time.

This approach doesn't address the qemu-storage-daemon use case where one
device emulation process provides devices to multiple guests.  Multiple
UNIX domain sockets are needed for that.

Is multiplexing multiple devices over a single connection is a desirable
feature?  The alternative of one UNIX domain socket per device instance
seems more practical to me because it should perform better and solves
the qemu-storage-daemon use case.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ZQ1MACgkQnKSrs4Gr
c8hfYwf/eSGyr7OXlpnFu5TR7dNACEilTRAIMr8sr03KuCcH6XTYwOyQ+1AeLFZh
hNWev760tdDQ4yF69mRhF5H7VyP246yXDMp/4OA9DVeMQyuDZIf1CrH32JUhGLdO
ky2UjhPBgzMQXEDLpWDBinKLFozS31UnoLl/NzOZb12BMLgDB0eEe/Ma1hS5fmpI
j6Hkfg8Bwyv9QvIM40UmUW82QacDhRDdfqJd0OW/kTYgFnmAHxX7iRj2xUDnlhvc
P012AAQnWS8r2MuU5VPrhLt6g0KMX9obEoXfEKZr1up0l021gzbzeaS8PGsdq9Hb
tVcIgvkhWFmXW/7D9gSCGwP6obX30w==
=ljcf
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--


