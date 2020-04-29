Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA07EC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A618E206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctAoL8LA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A618E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTop0-0008Q7-SP
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:40:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTom2-0002ja-Mu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTocA-0007tE-1S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:30:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38185
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jToc9-0007sQ-Ih
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588174027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NP7oes80jMZLO5POXHfQYdzuf8rcV2BJA2f5Onrnf1o=;
 b=ctAoL8LA+1mVYU9LZsvLy/D1dZ3XMLAiTG6KnZdDM8vcLL2ucgjFm/o/6iB+udQrrRbtpG
 N5kv10eKbfIWfUir3wnc48xvCBJGj0audeA+wHEzQwTAvlgzM49fSgG9I1Uc2qY5rs9Wzq
 vYH1Xewb7VaDfHsmo/cViUw9GM8+h94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-VH0eOEcbOTKXI53g109tlA-1; Wed, 29 Apr 2020 11:27:05 -0400
X-MC-Unique: VH0eOEcbOTKXI53g109tlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DADB872FE1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 15:27:04 +0000 (UTC)
Received: from localhost (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B1410013BD;
 Wed, 29 Apr 2020 15:27:00 +0000 (UTC)
Date: Wed, 29 Apr 2020 16:26:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: jail lo->proc_self_fd
Message-ID: <20200429152659.GA134868@stefanha-x1.localdomain>
References: <20200429124733.22488-1-mszeredi@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200429124733.22488-1-mszeredi@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 02:47:33PM +0200, Miklos Szeredi wrote:
> While it's not possible to escape the proc filesystem through
> lo->proc_self_fd, it is possible to escape to the root of the proc
> filesystem itself through "../..".
>=20
> Use a temporary mount for opening lo->proc_self_fd, that has it's root at
> /proc/self/fd/, preventing access to the ancestor directories.
>=20
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)

Good idea!

It's important to note that the proc file system is already mounted
within a new pid namespace.  Therefore the only process visible is our
own process and we don't need to worry about /proc/$PID.  However, there
are a bunch of other files in /proc.  Some of them are protected by
capability checks like /proc/kcore and virtiofsd is unable to access
them, but it's hard to guarantee that they are all off limits.  Better
safe than sorry!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6pnMMACgkQnKSrs4Gr
c8gVhAf9HxQ28zYG8KXMDIkOoF+8g4feaj3fdMjwcC9JV56+AJ7oKPJo+hMFqarF
UR41YIMTHhbojaSjnlWLWL0rUIrBre+YlQft1tzpc4B7BXuVrqbZgVwuhztVjs2R
Cpjc/9SiB/nBslL6USs18A46x3pI40XQYCDlgZ0P6aC7vtCLkGEcjYNa630rvZhQ
KqZpMPu4e2Xvl/iEo0oeExr2xmRJnrI1ECjL+pRS02HZpWoNRYB2K0JT+AQnvwsT
Lcoe0y9UXciq/UvvpL8ZtAkNoheK//PG8zx/HxCE9LO9O4z9/fdwjQuK5by1kV9o
Fpwybg8jn/dUP8JxX2ceXK64wDDQyg==
=S+XI
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--


