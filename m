Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C30C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1F22075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg6hp2U/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1F22075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5mP-0001qf-3U
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is5lL-0000z3-49
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is5lG-0007wO-Hv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:04:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is5lG-0007w3-DL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579183477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SgnxguWrQRfZusyMQJOUoNWcC7bKp7UYOzQqqDaFn8=;
 b=bg6hp2U/4YcFmRk7nCs6WQ2iJ1uMFZW1b02Edp0nmKCd1h0N8Jw4Yl9Woew7+wPhwo803R
 xhfPqIDKyfPF/OhLYMCM1gL3sodoGLmG13EfBEFC+84EwfTj5gE6YSxJ/+BtPcXCh9VD0S
 nP8kj0BWow4XLFTis6xND81uIKAn4tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-szFA9iJ1MkW_0-B1yufd-w-1; Thu, 16 Jan 2020 09:04:36 -0500
X-MC-Unique: szFA9iJ1MkW_0-B1yufd-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1328017CC;
 Thu, 16 Jan 2020 14:04:35 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 430115DA87;
 Thu, 16 Jan 2020 14:04:30 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:04:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v2 3/5] a standone-alone tool to directly share disk
 image file via vhost-user protocol
Message-ID: <20200116140429.GJ163546@stefanha-x1.localdomain>
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-4-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200114140620.10385-4-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 10:06:18PM +0800, Coiby Xu wrote:
> vhost-user-blk can have played as vhost-user backend but it only supports=
 raw file and don't support VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZER=
OES operations on raw file (ioctl(fd, BLKDISCARD) is only valid for real bl=
ock device).
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  qemu-vu.c | 264 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 264 insertions(+)
>  create mode 100644 qemu-vu.c

Kevin has been working on qemu-storage-daemon, a tool for running NBD
exports, block jobs, and other storage features that are not part of a
guest.  I think qemu-storage-daemon would be the appropriate tool for
running vhost-user-blk servers.  A dedicated binary is not necessary.

Stefan

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4gbWwACgkQnKSrs4Gr
c8iNUwf/RYjBnGzj8eAfP/WzlmnbMN/tClZwy6qzS+OLCpF4CAJysPxXLnZdyDFj
mI0yfiGqdHQ59mYKHl15QQUajdADKi89nB6+MWhk2jSGJGXuau6XA0hj1itafcwf
C5HyM/vxFtgOOXZa/hdOMOUqFvXmWxrnjkVHKTT2LZ+7oyhqlpB4dUC6D4YpSWCM
EsC+wNsRfAKCXS0F4xpdIkrG7jxbitpL4uUD7DMjMMhKGAN88lkgQItWL7sXHHrX
42/xI6Cv0ToJT2o7lVJv9IUjJXRTs4ucVRyABTgmPjlM/CS4dxKSEhhbxI1NMWhO
cn8RNsuGRtMFMJh5JWP+tdxiNVGgNQ==
=o1Ld
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--


