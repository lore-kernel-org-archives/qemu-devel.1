Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6401EC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340C62133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340C62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQhT-0003u9-83
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 18:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chewi@gentoo.org>) id 1iFPZe-0000SG-Ua
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chewi@gentoo.org>) id 1iFPZX-0000xN-Dn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:20:40 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:58258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chewi@gentoo.org>) id 1iFPZX-0000vN-4I
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 17:20:39 -0400
Received: from symphony.aura-online.co.uk (154.189.187.81.in-addr.arpa
 [81.187.189.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: chewi)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 0A2B334B773
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 21:20:35 +0000 (UTC)
Date: Tue, 1 Oct 2019 22:20:26 +0100
From: James Le Cuirot <chewi@gentoo.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] win32: fix main-loop busy loop on socket/fd event
Message-ID: <20191001222026.30a69801@symphony.aura-online.co.uk>
In-Reply-To: <20191001132609.23184-4-marcandre.lureau@redhat.com>
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
 <20191001132609.23184-4-marcandre.lureau@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NYDNIGFhkhqUzAVhnVfyFWg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 140.211.166.183
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/NYDNIGFhkhqUzAVhnVfyFWg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  1 Oct 2019 17:26:09 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3 introduced an AIO
> context optimization to avoid calling event_notifier_test_and_clear() on
> ctx->notifier. On Windows, the same notifier is being used to wakeup the
> wait on socket events (see commit
> d3385eb448e38f828c78f8f68ec5d79c66a58b5d).
>=20
> The ctx->notifier event is added to the gpoll sources in
> aio_set_event_notifier(), aio_ctx_check() should clear the event
> regardless of ctx->notified, since Windows sets the event by itself,
> bypassing the aio->notified. This fixes qemu not clearing the event
> resulting in a busy loop.
>=20
> Paolo suggested to me on irc to call event_notifier_test_and_clear()
> after select() >0 from aio-win32.c's aio_prepare. Unfortunately, not all
> fds associated with ctx->notifiers are in AIO fd handlers set.
> (qemu_set_nonblock() in util/oslib-win32.c calls qemu_fd_register()).
>=20
> This is essentially a v2 of a patch that was sent earlier:
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00420.html
>=20
> that resurfaced when James investigated Spice performance issues on Windo=
ws:
> https://gitlab.freedesktop.org/spice/spice/issues/36
>=20
> In order to test that patch, I simply tried running test-char on
> win32, and it hangs. Applying that patch solves it. QIO idle sources
> are not dispatched. I haven't investigated much further, I suspect
> source priorities and busy looping still come into play.
>=20
> This version keeps the "notified" field, so event_notifier_poll()
> should still work as expected.
>=20
> Cc: James Le Cuirot <chewi@gentoo.org>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/async.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/async.c b/util/async.c
> index 4e4c7af51e..ca83e32c7f 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -354,7 +354,11 @@ void aio_notify(AioContext *ctx)
> =20
>  void aio_notify_accept(AioContext *ctx)
>  {
> -    if (atomic_xchg(&ctx->notified, false)) {
> +    if (atomic_xchg(&ctx->notified, false)
> +#ifdef WIN32
> +        || true
> +#endif
> +    ) {
>          event_notifier_test_and_clear(&ctx->notifier);
>      }
>  }

I can confirm that this updated patch fixes my performance issue. The
idle CPU usage drops from around 35% to around 2%. Moving the mouse now
makes the usage go up, not down. :) Many thanks!

Regards,
--=20
James Le Cuirot (chewi)
Gentoo Linux Developer

--Sig_/NYDNIGFhkhqUzAVhnVfyFWg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPxcZ3tkwcedKm2a8EiZBXQDdMTcFAl2TwxoACgkQEiZBXQDd
MTfQzQ/9ETD9cLC0GRVymoq3ngxQFIU5Qc7wx/+d1GJr5g6AYfJSQYo/Qi/aBx39
+fKAVlsy7wQxElJ+1WoNOTEvnwYYR95QDjh9VRGhMqHuPkYOQo+eC5XQp1hmHxpT
U/XUzeXh+c4GkgErH0CEAS7BZi60c2uX03fSq5OUFt6dNoiDtyG+PzQumGuwHZvR
9ypy7Olw/9Z5QB1AkmczdE3rZS2qRVuaZnOVwVaxEY+RTERqprGznenctrH44GKR
cdZlAABeo4//6Fx1xcE1zEBtG2ueuaipeYbjYeop9t8fpetACXT4DMpcDCnozqL1
UKYRLSdWXqyKt4eu5Xiy/dXEZuw05W6Azggz++OnaCrWy//lJoEt6svkeG6ROSb6
ZdZEATVOlr75S8tLQjomvc0XM3a7N2PHwfeBom0HLD0oaZOI4jBx8PZ5xq76bY7w
2fc6VrSk05CVFpm45IO9yxHZ2Q2yFTVIESKsutTy6QXkGSisdx9/5EZnOeCnieM5
14Rw1IKZwvhTEa5Yft3TdZZT7T0ABxifmOZq8Cj0g+vU7vqbUonqzoVRn74ItR0x
e29DXTA5AA2blFIbpy4RA3CUdilZ5RMI2lnApl3YsqM8B0c5M6pMaURmqi8AP4UQ
uOv0EI/vhX6T0ir4mGTb9gJH7cuBf32CWugU67rXfyhuUWybp0s=
=YhAO
-----END PGP SIGNATURE-----

--Sig_/NYDNIGFhkhqUzAVhnVfyFWg--

