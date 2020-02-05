Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2087C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC562082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrUz9Ebv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC562082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTRR-0003BD-KG
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izTQH-0001cF-Dt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izTQG-0002Ud-Dw
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izTQE-0002Rl-2W
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9yosY6UeqpiFEy8Ek2MJ/xWgBGS43g2n3fE9CvX818=;
 b=PrUz9Ebv3CqUYaqhYGP7xxiodq3MXOop3d8BZZamYBpikxbtJUVwwArx6h9TLmCnjZi1O5
 KczCd/nIA7XXL3aem6+XOa7qmUvmZixzXPuuFNyoC+yGwVxw3Zzmil63x6S3fOBg73ZNQa
 Y4guIGGqqSp725AF868Tc452UejqkEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-fZOg21tyPc2zJ00_TqCtuw-1; Wed, 05 Feb 2020 17:45:23 -0500
X-MC-Unique: fZOg21tyPc2zJ00_TqCtuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75AA5190D340;
 Wed,  5 Feb 2020 22:45:22 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2543410013A1;
 Wed,  5 Feb 2020 22:45:15 +0000 (UTC)
Date: Wed, 5 Feb 2020 23:45:12 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 3/5] ui/sdl: implement show-cursor option
Message-ID: <20200205224512.GH31521@lpt>
References: <20200205110356.3491-1-kraxel@redhat.com>
 <20200205110356.3491-4-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205110356.3491-4-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 jpewhacker@gmail.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 12:03:54PM +0100, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> ui/sdl2.c | 28 ++++++++++++++++++++--------
> 1 file changed, 20 insertions(+), 8 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl47RXgACgkQ+YPwO/Ma
t50LAQf+OGv9cW4901yB20F4YIFkanpQ2Bp0kYF7sIQOSGmGQ9vC3WharUPCmep7
b4AugDNBNQmZX8V1I2lDjkpY37U4GczVJZA6dSvo/4oT42MZhM8bhIrY0DvVtNJx
3xnXLbauTYwN51xvZOkuGBruvCQpd3v7xjSjmhLWIPT5W0wqlWWSA4F6Owfxzkmx
x/0OSxjTuruETQW6pmxJbF9rI5LY493zNNVvVWegmJUDV+uGfoKhU8uNxVZ50XQu
7QdcQTKUkCxEuygoILzBMY1Ybn/Nya3Vx9REV9XFGPd+rbAySzdT2O/IH/MQkGA1
9deZEJ3/rvRcLopc5/lKN6DW8cpiGw==
=6ATx
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--


