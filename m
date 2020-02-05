Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D2C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D79214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcGCnNuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D79214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTPh-0000oK-VV
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izTP8-0000Op-8T
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izTP7-0007bg-0j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:44:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izTP6-0007W0-Rz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KmXG/HN/ylkoMsoys3nozjmKG3+H5EgY4knarSf5pw=;
 b=KcGCnNuQZQyaS/Ft/qvnhDiJbreRafSZfTwgMxIbVhkxJLMtQBZ5l4e8YSEkAQ29Fp9M8F
 3IY2JIE0zaVcUC/OJdrJT6uFMIZw3q7+b1wm226eMNzUw9ydEgM3x/OFYF1WYd+GubWF7t
 msdUuSMcpQkMS43MsAPt9V1aD3kKZ8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-c-O88qxgOkqe8V4hP9YBww-1; Wed, 05 Feb 2020 17:44:11 -0500
X-MC-Unique: c-O88qxgOkqe8V4hP9YBww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF974190D351;
 Wed,  5 Feb 2020 22:44:09 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1893D1A7E3;
 Wed,  5 Feb 2020 22:43:57 +0000 (UTC)
Date: Wed, 5 Feb 2020 23:43:53 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/5] ui: wire up legacy -show-cursor option
Message-ID: <20200205224353.GE31521@lpt>
References: <20200205110356.3491-1-kraxel@redhat.com>
 <20200205110356.3491-5-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205110356.3491-5-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
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

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 12:03:55PM +0100, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/sysemu/sysemu.h | 1 -
> vl.c                    | 4 ++--
> 2 files changed, 2 insertions(+), 3 deletions(-)
>

>diff --git a/vl.c b/vl.c
>index 24951b51a94b..0db0aa0fa040 100644
>--- a/vl.c
>+++ b/vl.c
>@@ -3553,7 +3552,8 @@ int main(int argc, char **argv, char **envp)
>                 no_shutdown =3D 1;
>                 break;
>             case QEMU_OPTION_show_cursor:
>-                cursor_hide =3D 0;

Since commit 13aefd303cf996c2d183e94082413885bf1d15bf
cursor_hide is also used in ui/cocoa.m

Jano

>+                dpy.has_show_cursor =3D true;
>+                dpy.show_cursor =3D true;
>                 break;
>             case QEMU_OPTION_uuid:
>                 if (qemu_uuid_parse(optarg, &qemu_uuid) < 0) {
>--=20
>2.18.1
>
>

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl47RR4ACgkQ+YPwO/Ma
t52kJAf7BXZROFsXb7M/OUfTfT/UtcErrRs0nAWqsaixBufk3BnJvJsIs3ZgoDNz
T+0yuTfq/gb7heUBTDIDKBCtL1KgxAfpd59XvVA9YwwFXE+cuYWfCSff4PIyWHXR
8rlpKu9nFI2IsZZH9tktNyM+MgE2w+VxB0w8x9ExTETCPZ0EstTncfdUy5H6PaVy
X3XceGnXjwF/yCMJqlCw5f/tjXcF6HOPHGYyxV7YjR/cfA0yT9nXyUHqByTCYHGx
ea5vkxT+GxvQb6TDx+uEOrZDu3OveK5X5ak9n3gYNu6WO5cJDgCte7pQ5uVt2EoW
z7KuCoHKGhKT8+weefRrzOg9TO1tDw==
=ooOm
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--


