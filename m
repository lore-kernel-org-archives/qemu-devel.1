Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA989C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9660621835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 11:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c90GcX5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inLEe-000234-Ob
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 06:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inLCa-0008Kt-GH
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inLCY-0007Tf-UI
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:33:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inLCY-0007SX-Oa
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 06:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578051189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7vVJQhK0VvjnsAM/u/QU+ZXsjyr2uligoVoAYQObTFQ=;
 b=c90GcX5X+6rx+ABJ5O6QuobgWmSxrZh8QKS8tWh7PvJ/gfZcJiqHU1jyo+VhMK1ZjC+v9+
 0F3LH/zvhB1BH736o/JlvM3s3C/E8oRvVKQ203gxQkgcEGzHM57l1awaBJRMHD+6c9KD26
 APSb5zNyP3T7KkskZVv73SFzQtha8ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-itIStMS-OTyuWH5HOjDf8g-1; Fri, 03 Jan 2020 06:33:06 -0500
X-MC-Unique: itIStMS-OTyuWH5HOjDf8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2DFDB64;
 Fri,  3 Jan 2020 11:33:05 +0000 (UTC)
Received: from localhost (ovpn-116-102.ams2.redhat.com [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21EA65D9C9;
 Fri,  3 Jan 2020 11:33:01 +0000 (UTC)
Date: Fri, 3 Jan 2020 11:33:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v6 00/21] Add virtual device fuzzing support
Message-ID: <20200103113300.GQ130240@stefanha-x1.localdomain>
References: <20191129213424.6290-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cxMSjUqMQBJIqbX5"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cxMSjUqMQBJIqbX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 09:34:35PM +0000, Oleinik, Alexander wrote:
> This series adds a framework for coverage-guided fuzzing of
> virtual-devices. Fuzzing targets are based on qtest and can make use of
> the libqos abstractions.
>=20
> In this version, I added a virtio-scsi fuzzer. The actual fuzzing code
> is very similar to the the virtio-net fuzzer. I experimented with using
> a single fuzzer with device-specific initialization for each virtio
> device, but it did not come out as cleanly as I hoped, since I could not
> find an easy way to override the qos drivers for devices that have
> more-complete qos support (such as virtio-net), so these changes have
> not made it into v6.
>=20
> V5/V6: (V5 did not have review tags)
>  * added virtio-scsi fuzzer
>  * add support for using fork-based fuzzers with multiple libfuzzer
>    workers
>  * misc fixes addressing V4 comments
>  * cleanup in-process handlers/globals in libqtest.c
>  * small fixes to fork-based fuzzing and support for multiple workers
>  * changes to the virtio-net fuzzer to kick after each vq add

Please run scripts/checkpatch.pl on all patches in case you haven't
already.

I have finished reviewing this revision and posted my Reviewed-by on
most patches.  Unless other feedback is raised the next revision could
be merged.

--cxMSjUqMQBJIqbX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PJmwACgkQnKSrs4Gr
c8i1uAf+Jgu/u2mOltby27ACjcuJ1wzg8q+T3hj3KS00YbFAY2igbCOPLpOlJ913
VfVu4Efwgclz3jE9fJ40BoApQyt43MiCjRbfPR9Gr0Z5+WshE7nbevK3qJkp1AS1
CoKUQCEnrPpYy6z/NciFXJzXr7Y5PLBcutAaNEdYQvjFSMON6EfZ9t9/C/mGZqhQ
PahuWKOfgJxCHs78CaAwgVt26Ok4Msa56mN7G48hG/TfnIVpgUcrw0kkdZ5XniZL
BLf1erJWi2cQUzOy0r8PX+hUukRaMNCZaqziZYYc8NAk6i8S+z/jrv11GiCnlycR
V8IarKX8Vv3T6FdWJgj9ELDFsbb7Lw==
=n0wH
-----END PGP SIGNATURE-----

--cxMSjUqMQBJIqbX5--


