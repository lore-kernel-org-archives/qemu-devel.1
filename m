Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55470C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC432067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzOoQgYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC432067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSO4m-0000Xt-9T
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iSO23-0006Tf-V1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iSO21-0005lz-E9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:19:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iSO20-0005l6-WD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573057178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=pQfv2eVX69LTxcGRrTwU3AWfNIRRdxNgDlEqkSTp8v8=;
 b=QzOoQgYmH/V/1irJOzlGy1Ggdo8APwNH8Q87XHzj0Aa8cyc9wiOu8K9R7qLlt1HAqr1RC4
 5JLty/yDuOqYVHxiz7Ihz2wviG8Z6curyBwcVjSceufekCFdg6x4M96bfRDn4OI1HfqQNF
 8HgcVwCdOR9WeDDtsA3L4QVmnQ9FPPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-ErJl3mL8NpixRBsoM67XXA-1; Wed, 06 Nov 2019 11:19:35 -0500
X-MC-Unique: ErJl3mL8NpixRBsoM67XXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90F952A3;
 Wed,  6 Nov 2019 16:19:34 +0000 (UTC)
Received: from localhost (ovpn-116-171.ams2.redhat.com [10.36.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51ECD60872;
 Wed,  6 Nov 2019 16:19:30 +0000 (UTC)
Date: Wed, 6 Nov 2019 17:19:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: QEMU HTML documentation now on qemu.org
Message-ID: <20191106161928.GA353373@stefanha-x1.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
You can now access the latest QEMU HTML documentation built from
qemu.git/master nightly at:

  https://wiki.qemu.org/docs/qemu-doc.html
  https://wiki.qemu.org/docs/qemu-qmp-ref.html
  https://wiki.qemu.org/docs/qemu-ga-ref.html
  ...as well as interop/ and specs/

Feel free to link to the documentation from the QEMU website and/or
wiki!

The container image that builds the docs is here:

  https://github.com/stefanha/qemu-docs

It is hosted on QEMU's Rackspace cloud account.

Stefan

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C8pAACgkQnKSrs4Gr
c8gT7Qf8DFDl+d4o9LVkCJVZRIus/13BC7hfZzfYX/fXqUzzISxntxgXOlWRtB4+
VG6ZeumJaV4YNiK7XXRnTWr2PXBUC83AT6V2XXO2ZZFyiDvwak37o4bIdn0tTJRk
8PxI7z9D5Qmroz9z72szSwObhc/oLIj9jQSWQXHlY82s42duj+cY/zoFM8vrUfkg
zeEIhIrv/OxAXHCRcIuMU6JXd4J4EgqUMRp7gt0vYfT85TqiOR1uJ1P6Ir+bnDuA
Mi6LtLFZ7l1qdU0m5p6YVuAQn1CGBWaJGz3vHpsPxWIhtHNBFU9+4kZkza7tyoho
eNIIoyVR/D3h4Jph+Um6CVokPgHqBw==
=2Ceu
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


