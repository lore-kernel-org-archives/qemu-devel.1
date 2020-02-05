Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C7C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A1C2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Njl9MIlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A1C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTRG-0002iN-JB
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izTPf-0000u3-5j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izTPe-0000UB-9m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:44:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izTPe-0000Sc-5s
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMcGJ7McT3ikn/n7C/ZO8N6M4dHO9pMQqT55YRC9oB0=;
 b=Njl9MIlkteE+6pWj8y7GpldEGJU4QeDWb/tJh6i5j4/1HBl9Qxqg9OFe9fj1pFXFpzGe2Z
 ZAdcTB3jV2RHl9/OuDpwft2D9Rp34O0wMVcWdXbMf+vv9PdTV8pBHy7cvlUMl61dSYe0HT
 uA9IqnTNfpgkk35JR0+jnv3XB725wLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-h_I9QwVYMqCXwGjcAO1toA-1; Wed, 05 Feb 2020 17:44:47 -0500
X-MC-Unique: h_I9QwVYMqCXwGjcAO1toA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 415AB1005F73;
 Wed,  5 Feb 2020 22:44:46 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E6960C05;
 Wed,  5 Feb 2020 22:44:38 +0000 (UTC)
Date: Wed, 5 Feb 2020 23:44:35 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/5] ui: add show-cursor option
Message-ID: <20200205224435.GF31521@lpt>
References: <20200205110356.3491-1-kraxel@redhat.com>
 <20200205110356.3491-2-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205110356.3491-2-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 jpewhacker@gmail.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 12:03:52PM +0100, Gerd Hoffmann wrote:
>When enabled forces showing a the mouse cursor, i.e. do
>nowallow the guest to hide it.  Defaults to off.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> qapi/ui.json | 2 ++
> 1 file changed, 2 insertions(+)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl47RVMACgkQ+YPwO/Ma
t52xNgf/QZGtc5UbWYSHUtxTCmyCW8udauJoUka8m68EBNrK3oXL8RcVGUOXBw7x
MnvftyMphQQv71I5/iJn6F7kchrjsHadW8uHDXZbTcE3K2TogXwHX1httgixClLJ
3YUEHE9YkSl5i6uhFNVGzAy3bCdJHgTJgooxupO58NpS2W69+DaFQrkdClBu6v5b
Yv5w1U4EcDtERalTVQlTK6pfysRf6Zv9XDsYEJonkYyFyXrusi2op3yp5QTt1kI9
sWp8zO3ZYg725FibvuDksxeoE6+TlgQfbfoGtBZ/mYRW3sU6cDzjb9bm3E00+FDl
J/3GF5lA/ihK/GvpZBAVOscCni3mZw==
=xFH6
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--


