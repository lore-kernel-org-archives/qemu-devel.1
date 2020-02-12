Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79E0C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721872082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYTC2dfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721872082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1s9d-0000qU-O8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j1s8j-0000IL-HJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j1s8g-00048g-UD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:33:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j1s8g-000488-J7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/XpKfc9Oc9dQVzdJIvZKWcGI5mztgvc25rzDcq0kGs=;
 b=bYTC2dfhZaZhEYZRaCCmbWPQMWhgAqcP6nkgRABYufq6QYe8j2V+tFM7hHFQ1vTN8/jvln
 zbVNRPD2i3fSB6ceJ3HmviMLVHxVng40JA0g30whbxPL1fPQX6rAZg6cT/UrRLCuTYmmyu
 IrsA7FUr0CxyY4u5ztsymUxyWABe0rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-5qIW5G8_OPStCdPuyqatJg-1; Wed, 12 Feb 2020 08:33:09 -0500
X-MC-Unique: 5qIW5G8_OPStCdPuyqatJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC4D107ACC9;
 Wed, 12 Feb 2020 13:33:08 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2F95C124;
 Wed, 12 Feb 2020 13:33:06 +0000 (UTC)
Date: Wed, 12 Feb 2020 14:33:04 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] nbd-client: Support leading / in NBD URI
Message-ID: <20200212133304.GC2893@lpt>
References: <20200212023101.1162686-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212023101.1162686-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>, rjones@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 08:31:01PM -0600, Eric Blake wrote:
>The NBD URI specification [1] states that only one leading slash at
>the beginning of the URI path component is stripped, not all such
>slashes.  This becomes important to a patch I just proposed to nbdkit
>[2], which would allow the exportname to select a file embedded within
>an ext2 image: ext2fs demands an absolute pathname beginning with '/',
>and because qemu was inadvertantly stripping it, my nbdkit patch had
>to work around the behavior.
>
>[1] https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md
>[2] https://www.redhat.com/archives/libguestfs/2020-February/msg00109.html
>
>Note that the qemu bug only affects handling of URIs such as
>nbd://host:port//abs/path (where '/abs/path' should be the export
>name); it is still possible to use --image-opts and pass the desired
>export name with a leading slash directly through JSON even without
>this patch.
>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>---
> block/nbd.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5D/owACgkQ+YPwO/Ma
t50F0Af/eFpPwHMGNWOxwRH5PweYQ8HyE3R6ADtVHHL6bNsYdn7Uvq8ibyOHuco4
ix+HMsrDPwcdW+MDOWn1r8kD6i8SnnXGKF2cwVVeHWwXaNC+GwRjdNdvynMdSst0
SS/T05+L/+BldYSyvolJKWvCn0TgwNQPc8RYD1+qs+BHyUNJKd0ZQCP+hQ52Xy1G
+Is9vB+PRFkR/VfMX+0FiTpRkE/BTUB5QVYTSFGMaagSPAID/TWobAdW6/dNTcMC
JxJ/Ur0JMelIuRAo5lxTgtLjxJrajHfF5zpLGWGo+h/nch8+2jTCGZB45RTqbpfA
rrBd355lgOdK3CfMc+Oda+U9yNKuwA==
=LeIN
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--


