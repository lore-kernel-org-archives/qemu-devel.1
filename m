Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F44C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3ED72467B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlHeBhou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3ED72467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FO1-0007Uu-82
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j7FNL-0006ym-Be
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j7FNK-0001h7-Da
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:22:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j7FNK-0001fr-6S
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582795353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xEUmUVu2WZaI2Cp4Q/DG00vU6I0rs9/Aat1ANhOWVHc=;
 b=YlHeBhouTZYM/NBNPf3IdrqfCK8eNZ3rRska7JpXOrHBXDHEA337FRh5Qy6IYTo5mezAA+
 EYFPyUDNy0Jcc9cYYEcPCKr4+cg8RYoz5+EqyMxn99jNrZnf0Pj8CMf67+A+DhDX2jtLZx
 8p1Azvx3Uh4+Iwtk/zernEOQ+4NSoCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-U1L-OXD6Mee66Rwd7GqZwg-1; Thu, 27 Feb 2020 04:22:30 -0500
X-MC-Unique: U1L-OXD6Mee66Rwd7GqZwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9CE6107ACC7;
 Thu, 27 Feb 2020 09:22:29 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E97A5C578;
 Thu, 27 Feb 2020 09:22:25 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:22:22 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 2/3] block: Add support to warn on backing file change
 without format
Message-ID: <20200227092222.GE2262365@lpt>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-3-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227023928.1021959-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--//IivP0gvsAy3Can
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Wednesday in 2020, Eric Blake wrote:
>For now, this is a mechanical addition; all callers pass false. But
>the next patch will use it to improve 'qemu-img rebase -u' when
>selecting a backing file with no format.
>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>---
> include/block/block.h |  4 ++--
> block.c               | 13 ++++++++++---
> block/qcow2.c         |  2 +-
> block/stream.c        |  2 +-
> blockdev.c            |  3 ++-
> qemu-img.c            |  4 ++--
> 6 files changed, 18 insertions(+), 10 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5Xik4ACgkQ+YPwO/Ma
t50HnQf/e8CYxHxUqZVByDyW3bPdLeiI7A76iU4b0VCGryy/7O++2oM7sNfgQbbb
54Xh2TaXhEq1K6NASA+psX4n5giUy3L7W2BXxWUZjh7vN4POMKK05Yk2KyEOuOb1
5Z8UFXglKM4YUwOydVY2CVyVYFZ9TmMMQYO9/4aGYA1KqUBO+P/YCse4QRduTjhc
OqNCDm16jd9NY+ITD5pGpNfXCgV5KXF0xhgh2KfcqVeXOCNzijT24WPWTGXI+plQ
aquDMH0HfnrT8uJBiOCKiccTYc6zgUmpM2Zlc/aj1JEmyW70Eq3NhHAuVpNfPMoH
qlbXx7DEBVkCxnZDWYsC4pN998qkzA==
=XOmQ
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--


