Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D010C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE55D217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk62To0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE55D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTT0-00052c-0v
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izTQ0-0001IN-AZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izTPz-0001ed-Fh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izTPz-0001cr-BJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I517xhC1v9YIwJ3bqUHEyybJBeC+JH4WPZ5oxc5CMns=;
 b=Nk62To0lMMPP7+vg/YvmunixnT7TcxwIgdrmAr9B/5ubNsm/gJoVjyITAVRkF3HvfBAVuz
 MLReb7HJPjxcS8oG7tWZdzOlOZwc01T2EICgOmVcbY326ZqeLfIYGyao7eoLYgRhNXDGqK
 BwnaQM1TGMnIqh/w1MRGjK9QgqGcGqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-zCMnM3ZrNvaKkt8p9mzGQA-1; Wed, 05 Feb 2020 17:45:06 -0500
X-MC-Unique: zCMnM3ZrNvaKkt8p9mzGQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC371007278;
 Wed,  5 Feb 2020 22:45:05 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E575F6E8;
 Wed,  5 Feb 2020 22:44:57 +0000 (UTC)
Date: Wed, 5 Feb 2020 23:44:54 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/5] ui/gtk: implement show-cursor option
Message-ID: <20200205224454.GG31521@lpt>
References: <20200205110356.3491-1-kraxel@redhat.com>
 <20200205110356.3491-3-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205110356.3491-3-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
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

--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 12:03:53PM +0100, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> ui/gtk.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl47RWYACgkQ+YPwO/Ma
t51ligf/WpyYsQz14yQ3a2IHIag8sY/XDvL80WUyAQZpENJIa4+uU40yB5Y7nhIz
jX2/Pc+xo2RAmoEe1t5prbqtXshlZlBoKQL6VUEB2ZM7jFsQsCI7Lip+v11v/Pyr
2VHEm2UuWj2/poiF6WlwsGGBDEIhz4pVwDfFmn+0GbMKwDdsO8+QbOpCpNbljNOs
e4wgfcl21vDUwy1M1e9BYvhKFETG6vz/FHEJlchyjedcWIcImhg9liNf7dQp5i9e
Fk6ajuOiuW7ABk0oSuC5roz9StzUqIF4rHfSXr4paIQ88pOTBWAzZat3IxSniXQA
zspvZvWDbN6bt2/PxVxECj8Kl3KEjQ==
=1ZLf
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--


