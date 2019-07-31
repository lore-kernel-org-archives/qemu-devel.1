Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93D4208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J75fPHGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93D4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsoCz-00006F-Jl
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hsoCX-00083H-Ey
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hsoCV-0007jN-Kr
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:59:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hsoCV-0007iC-Dc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:59:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id u25so49391881wmc.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 05:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HD1C6pev3eT2o7gZwrPiFohdf5FlJEYGBZdgepRvUI8=;
 b=J75fPHGP0z7+tVeDajjLzz1cH1rJW4hgVXCn4aWgxmBVJAItvTmGf6jPF6+drcVdBp
 tXcJRZdWgBTBlqbtZuv82nSrIuHP6I+o84uPhSwm8JGx8dNJwSRijRxZoJ9GqIjdXani
 7RXn5D2Dh25kWgprXClHA/U7cIO1CB1NXh9dnn2wUJSvs+k7FIIexNleVgjcXDHB1gw3
 PIgl8ba1NQwf7kFyt++m5HGSJsFVNQ2BBs3fxMgzNsDLY0eFwrjs03ZS8hhKV23TuISd
 mSVBE9wEW9aOhrYN/j/Cew5uPmoTXPIOOXnxlHHexxEhOpQ3V70lVZoYaQ+a2vyuabSp
 qiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HD1C6pev3eT2o7gZwrPiFohdf5FlJEYGBZdgepRvUI8=;
 b=FGNEJ0N08S4xH5/PUmpELQ1RZWq23pRgNr3dUIEM4SE4+Ae1zNdbvdDLoyzOFcq2l6
 R1kI8Ac39P8Fi+8no++DLk9k7hMCaWULCW7Q0JXwVLVrGLTqubV9taoiGTECYp5cDz+O
 ylIry21Oc5CpousXMgPY0oi3Qls2pRid/ErXxuaH+qxNFvvYybLZC4PlQHUzYh+6hMRg
 dCQfmZu2mmaLkDNy7ZPe/a9/iF4gWTvIMQvAKh/NdgoWUqiuv7TMW44jLNJLtcCPU9rL
 2lJHRK3TU9ywcL0czVtHv0CKcxdv6rxWfO6FFzGeLzE1wckvtXD46eCGe2aVPn8641oZ
 TMSA==
X-Gm-Message-State: APjAAAWuShLUjPFPQ7BDuL2Tk1xXQskal1SLASCxhqPJ2+hGJB87L005
 ZEeIyH4RbyX8ZTK0Y0qO2Ff28eEvikWyEWa4Kvw=
X-Google-Smtp-Source: APXvYqxZICZnigA5rwl6FBhBuNQtf1p8FpAnhoV+olsLN80Fsbnqukg/XXYdoKIjemgCIzhiJp/iEdQeJqSVMGqqaDM=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr106482526wma.107.1564577963682; 
 Wed, 31 Jul 2019 05:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190725084341.8287-1-berrange@redhat.com>
In-Reply-To: <20190725084341.8287-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Jul 2019 16:59:10 +0400
Message-ID: <CAJ+F1C+3E7=bOv6S9hWt5KaKDUvO5GbXCRJPUqaHEc4BKJD0PQ@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 0/3] require newer glib2 to enable
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 12:44 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> Both GCC and CLang support a C extension attribute((cleanup)) which
> allows you to define a function that is invoked when a stack variable
> exits scope. This typically used to free the memory allocated to it,
> though you're not restricted to this. For example it could be used to
> unlock a mutex.
>
> We could use that functionality now, but the syntax is a bit ugly in
> plain C. Since version 2.44 of GLib, there have been a few macros to
> make it more friendly to use - g_autofree, g_autoptr and
> G_DEFINE_AUTOPTR_CLEANUP_FUNC.
>
>   https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.html
>
>   https://blogs.gnome.org/desrt/2015/01/30/g_autoptr/
>
> The key selling point is that it simplifies the cleanup code paths,
> often eliminating the need to goto cleanup labels. This improves
> the readability of the code and makes it less likely that you'll
> leak memory accidentally.
>
> Inspired by seeing it added to glib, and used in systemd, Libvirt
> finally got around to adopting this in Feb 2019. Overall our
> experience with it has been favourable/positive, with the code
> simplification being very nice.
>
> The main caveats with it are
>
>  - Only works with GCC or CLang. We don't care as those are
>    the only two compilers we declare support for.
>
>  - You must always initialize the variables when declared
>    to ensure predictable behaviour when they leave scope.
>    Chances are most methods with goto jumps for cleanup
>    are doing this already
>
>  - You must not directly return the value that's assigned
>    to a auto-cleaned variable. You must steal the pointer
>    in some way. ie
>
>     BAD:
>         g_autofree char *wibble =3D g_strdup("wibble")
>         ....
>         return wibble;
>
>     GOOD:
>         g_autofree char *wibble =3D g_strdup("wibble")
>         ...
>         return g_steal_pointer(wibble);
>
>     g_steal_pointer is an inline function which simply copies
>     the pointer to a new variable, and sets the original variable
>     to NULL, thus avoiding cleanup.
>
> I've illustrated the usage by converting a bunch of the crypto code in
> QEMU to use auto cleanup.
>
> Changed on v2:
>
>  - Actually commit the rest of the changes to patch 3 so that what's
>    posted works :-) Sigh.
>
> Daniel P. Berrang=C3=A9 (3):
>   glib: bump min required glib library version to 2.48
>   crypto: define cleanup functions for use with g_autoptr
>   crypto: use auto cleanup for many stack variables

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
>  configure                   |  2 +-
>  crypto/afsplit.c            | 28 ++++----------
>  crypto/block-luks.c         | 74 +++++++++++--------------------------
>  crypto/block.c              | 15 +++-----
>  crypto/hmac-glib.c          |  5 ---
>  crypto/pbkdf.c              |  5 +--
>  crypto/secret.c             | 38 ++++++++-----------
>  crypto/tlscredsanon.c       | 16 +++-----
>  crypto/tlscredspsk.c        |  5 +--
>  crypto/tlscredsx509.c       | 16 +++-----
>  include/crypto/block.h      |  2 +
>  include/crypto/cipher.h     |  2 +
>  include/crypto/hmac.h       |  2 +
>  include/crypto/ivgen.h      |  2 +
>  include/crypto/tlssession.h |  2 +
>  include/glib-compat.h       | 42 +--------------------
>  16 files changed, 78 insertions(+), 178 deletions(-)
>
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

