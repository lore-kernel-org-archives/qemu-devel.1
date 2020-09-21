Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61909C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C2E21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEzvZoOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C2E21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKSbF-0007k1-Uu
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 16:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKSag-0007I1-RX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 16:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46662
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKSac-0007ZB-HO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 16:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600720748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3dwzaFIeL+Lof0VT93/4xLDBp6dicJeWxcm9EYJivw=;
 b=DEzvZoOjhecNO6PQchhXZoyCWmiPxre/+/k4S5YTu7KVl3NHIi/jJzovcyDHgDpKvL2LCN
 SvtEO4WFDHqCH8rW1T3gBffLdu4+CwMhDuG4pApZtraioyiP/9c2DLEzHFdvWab1whMh0P
 eb6Qiag3CEXnnwyfu4bufKIszZQb69c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-u6W8uqppM3W9Voetj0YzfQ-1; Mon, 21 Sep 2020 16:39:05 -0400
X-MC-Unique: u6W8uqppM3W9Voetj0YzfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB0A1074665;
 Mon, 21 Sep 2020 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC0573689;
 Mon, 21 Sep 2020 20:39:03 +0000 (UTC)
Date: Mon, 21 Sep 2020 16:39:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/6] migration: Silence compiler warning in
 global_state_store_running()
Message-ID: <20200921203902.GA15763@localhost.localdomain>
References: <20200918103430.297167-1-thuth@redhat.com>
 <20200918103430.297167-4-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918103430.297167-4-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 16:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 12:34:27PM +0200, Thomas Huth wrote:
> GCC 9.3.0 on Ubuntu complains:
>=20
> In file included from /usr/include/string.h:495,
>                  from /home/travis/build/huth/qemu/include/qemu/osdep.h:8=
7,
>                  from ../migration/global_state.c:13:
> In function =E2=80=98strncpy=E2=80=99,
>     inlined from =E2=80=98global_state_store_running=E2=80=99 at ../migra=
tion/global_state.c:47:5:
> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
>  =E2=80=98__builtin_strncpy=E2=80=99 specified bound 100 equals destinati=
on size [-Werror=3Dstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>=20
> ... but we apparently really want to do a strncpy here - the size is alre=
ady
> checked with the assert() statement right in front of it. To silence the
> warning, simply replace it with our strpadcpy() function.
>=20
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> (two years =
ago)
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  migration/global_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 25311479a4..a33947ca32 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>  {
>      const char *state =3D RunState_str(RUN_STATE_RUNNING);
>      assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstat=
e),
> +              state, '\0');
>  }
> =20
>  bool global_state_received(void)
> --=20
> 2.18.2
>=20
>=20

Hi Thomas,

FIY, I couldn't reproduce the complaint from GCC.  I've tested it on focal,
"gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0", with QEMU 5df6c87e8.

After a succesfull "configure --target-list=3Dx86_64-softmmu && meson
compile" build, I tried to manually enable meson's "werror" option,
and found no difference.

Then, I manually ran gcc, with a couple of "-Werror" variations, such
as:

cc -Ilibcommon.fa.p -I. -I../../src/qemu -Iqapi -Itrace -Iui \
   -Iui/shader -I/usr/include/libpng16 -I/usr/include/libmount \
   -I/usr/include/blkid -I/usr/include/glib-2.0 \
   -I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
   -I/usr/include/gio-unix-2.0 -I/root/src/qemu/slirp/src -Islirp/src \
   -I/usr/include/pixman-1 -I/usr/include/gtk-3.0 \
   -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 \
   -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include \
   -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/fribidi \
   -I/usr/include/harfbuzz -I/usr/include/atk-1.0 -I/usr/include/uuid \
   -I/usr/include/freetype2 -I/usr/include/gdk-pixbuf-2.0 -Ilinux-headers \
   -fdiagnostics-color=3Dauto -pipe -Wall -Winvalid-pch -Werror \
   -Werror=3Dstringop-truncation -std=3Dgnu99 -O2 -g -U_FORTIFY_SOURCE \
   -D_FORTIFY_SOURCE=3D2 -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64=
 \
   -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef \
   -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common \
   -fwrapv -Wold-style-declaration -Wold-style-definition -Wtype-limits \
   -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers \
   -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined \
   -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi \
   -fstack-protector-strong -iquote /root/src/qemu/tcg/i386 -isystem \
   /root/src/qemu/linux-headers -iquote . -iquote /root/src/qemu -iquote \
   /root/src/qemu/accel/tcg -iquote /root/src/qemu/include -iquote \
   /root/src/qemu/disas/libvixl -pthread -fPIC -MD -MQ \
   libcommon.fa.p/migration_global_state.c.o -MF \
   libcommon.fa.p/migration_global_state.c.o.d -o \
   libcommon.fa.p/migration_global_state.c.o -c \
   ../../src/qemu/migration/global_state.c

But I could not trigger the warning (and thus error).  The change here
looks good, but I thought I should let you know, and maybe I'm missing
something obvious.

Thanks,
- Cleber.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9pD2AACgkQZX6NM6Xy
CfOGdg/9GT0RnzjZE16jpwGain3m8Iu7LzoyuerljVneP+hRxdNLv3B7Yn6l2OjI
FabWXIEZ8y/22gzYxOrUtOUEmFmEks+DWjAZ8iHUHof20zXxeOIsw0qQi0M3dZbc
zx9Tl+Xe1BeYoHPKoiTDXr8u8NFQAvLbsPQReJPHwzAsiVjFfIscxEuFB/ZF05I5
nIXlM1bYBZA+JlG1YPCzcn3kWM+sjTxs4LsiyVNX4LIzGiCToKgUcJeK/26+METR
a9dUymUxLb2rWxxtW9pEiRfr6TVyKfmmrjI1BEj4jUYPmK4DpGxW+L00AfGbxLst
ZWzTfLlI/qCsVE4h2XK7tHm9vK4y/lqIHBuFr3DwMvSQn5wQZkgdbOIxPcIkYeqh
XJJm+myZpZSQXSbTzFOBeu6/0PYXAPKkpZ893hWtjNQZfRQoDE0fCpN6mX41RMNh
W58hZBbSiu4AwJ6oJJ1k8WdtmrvtDE0FlsvLtXaBUlSIUFf8cc/pfJiUhKyRLvd4
nUFAS2mi0FTDiAS7WvQuFeqVKQEOF5s5NhVPE/bRP1wUcY55/rEa71pu8Lf6d4a0
PKDARlNjIr0ZoznVVKSDq9O6hHVz1wEzREHLYSolDCGIPQ72jy4/PK1yQuiHBfaY
aWjdxkYgjucIspSO0Actmlfv9v/49md0B6KDQFL4fGlHCahVRP8=
=ZQoh
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


