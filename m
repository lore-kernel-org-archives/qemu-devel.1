Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76106C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4483B21871
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+KjhdwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4483B21871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZHE-0002HR-Eg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqZH4-0001sV-45
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqZH2-00059f-W4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:38:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqZH2-000597-PF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:38:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so43946699wmj.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zRIf7orfyRP0cVSioXoY/tEazqKP9Ks0QICO0ikncdc=;
 b=n+KjhdwRkFcJ3M6W9EA1Pi44CDaUTqTAkSEIClZXOGrFaxsa5ONnXV+B8lQ8npnPmt
 uYOqcIOtnF2A76b9UI52nBoWZ/H9zlpaMHylQ6sULmjX304jH8WUk/6I1qbRwtzQSKNX
 jFtyMX11PWfyQ4H/VNQVMa+p5eBxe57yat7UGSiMsgiemBzmdYiJ3DcEiL7p0PvKmtuC
 iqUtHJXkvr83QOV7CpU1haj/uHH4Mp/VOrWyXQ2I9gyVv/a/NrH0Ov21wCr4sepo2eB6
 3AZAOFIL5hhnYBhtgzW6q7rqCF92iL8K+esx+zYLihWJ4ZIITTOlJYUsONTddKewbBSh
 5wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zRIf7orfyRP0cVSioXoY/tEazqKP9Ks0QICO0ikncdc=;
 b=GQWrrbfzdhfjv+fs96iBav0t/24Uue7811rmuYRC+Fz0vpBtZycUIzsPxX4JZgeF2d
 jVvOrJVXcK/vFF2O8svzNbe4EosPzHm8ljKDiU7KgkLRU3+W1n8fMrAtCFryQdyz0F8E
 Fw/XtZdbh7mq8Sqj0og0Y1UdrLPmp2ZJNMLhY5cViU2zHtsY2eaBPatLWge7JM52rx/y
 h4JYgMSf0MuxE1kVtZHK9BnliHoF0bSNdZ+fiwh2I0up2cNEqB+I9Juyb/kWmyKin6Tq
 AA9Bo7H7B6R3UY92ZCDFqOy4z4Vb2Bsp6eXWCfPsLSoVlronASLaifsg35l7Isjj5UI2
 XTXQ==
X-Gm-Message-State: APjAAAXdzrcat9Ob7DfBEQo2NQ7bBm7q+Mvp6gLwr4B1na4pcHlxaJDC
 J9X7gvGm7zjkIJOfmYoadjI=
X-Google-Smtp-Source: APXvYqwV8zOx8X313z0CmHst5hzVbTbd4/WSN0xIzXEz7GGG9A20qKfzAnm4O0enzZ4kjfa4TAZ0Dg==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr532711wmg.48.1564043931228;
 Thu, 25 Jul 2019 01:38:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f3sm30687869wrt.56.2019.07.25.01.38.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 01:38:50 -0700 (PDT)
Date: Thu, 25 Jul 2019 09:38:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190725083849.GC26914@stefanha-x1.localdomain>
References: <20190723154856.17348-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20190723154856.17348-1-berrange@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for 4.2 0/3] require newer glib2 to enable
 autofree'ing of stack variables exiting scope
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 04:48:53PM +0100, Daniel P. Berrang=E9 wrote:
> Both GCC and CLang support a C extension attribute((cleanup)) which
> allows you to define a function that is invoked when a stack variable
> exits scope. This typically used to free the memory allocated to it,
> though you're not restricted to this. For example it could be used to
> unlock a mutex.
>=20
> We could use that functionality now, but the syntax is a bit ugly in
> plain C. Since version 2.44 of GLib, there have been a few macros to
> make it more friendly to use - g_autofree, g_autoptr and
> G_DEFINE_AUTOPTR_CLEANUP_FUNC.
>=20
>   https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html
>=20
>   https://blogs.gnome.org/desrt/2015/01/30/g_autoptr/
>=20
> The key selling point is that it simplifies the cleanup code paths,
> often eliminating the need to goto cleanup labels. This improves
> the readability of the code and makes it less likely that you'll
> leak memory accidentally.
>=20
> Inspired by seeing it added to glib, and used in systemd, Libvirt
> finally got around to adopting this in Feb 2019. Overall our
> experience with it has been favourable/positive, with the code
> simplification being very nice.
>=20
> The main caveats with it are
>=20
>  - Only works with GCC or CLang. We don't care as those are
>    the only two compilers we declare support for.
>=20
>  - You must always initialize the variables when declared
>    to ensure predictable behaviour when they leave scope.
>    Chances are most methods with goto jumps for cleanup
>    are doing this already
>=20
>  - You must not directly return the value that's assigned
>    to a auto-cleaned variable. You must steal the pointer
>    in some way. ie
>=20
>     BAD:
>         g_autofree char *wibble =3D g_strdup("wibble")
> 	....
> 	return wibble;
>=20
>     GOOD:
>         g_autofree char *wibble =3D g_strdup("wibble")
> 	...
> 	return g_steal_pointer(wibble);
>=20
>     g_steal_pointer is an inline function which simply copies
>     the pointer to a new variable, and sets the original variable
>     to NULL, thus avoiding cleanup.
>=20
> I've illustrated the usage by converting a bunch of the crypto code in
> QEMU to use auto cleanup.
>=20
> Daniel P. Berrang=E9 (3):
>   glib: bump min required glib library version to 2.48
>   crypto: define cleanup functions for use with g_autoptr
>   crypto: use auto cleanup for many stack variables
>=20
>  configure                   |  2 +-
>  crypto/afsplit.c            | 28 ++++----------
>  crypto/block-luks.c         | 74 +++++++++++--------------------------
>  crypto/block.c              | 15 +++-----
>  crypto/hmac-glib.c          |  5 ---
>  crypto/pbkdf.c              |  5 +--
>  crypto/secret.c             |  9 ++---
>  crypto/tlscredsanon.c       | 16 +++-----
>  crypto/tlscredspsk.c        |  5 +--
>  crypto/tlscredsx509.c       | 16 +++-----
>  include/crypto/block.h      |  2 +
>  include/crypto/cipher.h     |  2 +
>  include/crypto/hmac.h       |  2 +
>  include/crypto/ivgen.h      |  2 +
>  include/crypto/tlssession.h |  2 +
>  include/glib-compat.h       | 42 +--------------------
>  16 files changed, 66 insertions(+), 161 deletions(-)
>=20
> --=20
> 2.21.0
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl05apkACgkQnKSrs4Gr
c8j1rQgAmB/Tt61AHKbpKcgTrtjHbAdueF/FE9WZcK5MJ7G2kdc97LpOYVx+8hHe
yhmnEHf6fjXfUTXRvJ91yYsL1e2IEdlP9YUuyNIiUgqvVrXxcXLWxL7nGGwHYzWq
Lbauur/FQ7vBdRtoqAtsE9vXTxfG0Z/ttgpscXfC7NBwRMT7GZp+/cZm2jD+zNZg
Z78194ZkclYa01ODpbI1S7eVXxQIRSV4vCrLjO247M0I2k2TUhwqMg2eUWjZvO4h
H0wxjJWnmIuXDFf2v/mzfKTuhgFX5Dgs0HaGrhp3GF4fh0dPpOuoxXcfTI+L8cR5
V9EyueZOThZJ7fDh9uTikQhJr4or9g==
=CU2Z
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

