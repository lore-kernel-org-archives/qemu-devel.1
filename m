Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620CDC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A1E246C7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq8KSeIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A1E246C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjpz-0002UN-6v
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXjnq-0001Lw-1Q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXjnm-0007f7-WF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603885178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DmM/NONAdJWi/wWx6BgwjH9s2Wf05Lfu3J/MfJzfk9I=;
 b=Cq8KSeIhahW31vnSIzDFxN90sf71OxPxQ3mNDP1qX3soh/XMnynlR1BHsLOwfrLcSLoc/d
 rKQh/oQc321m9qMoA400wlfzjOVY3jwgc3ITuleuQeqB1XU6D+hg5UakLZJaZJsxEj1kTj
 NKO93GCPojshRA/t9UetE32GG3uUOss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-kO-RICo7PzSqT8OytJfYlQ-1; Wed, 28 Oct 2020 07:39:33 -0400
X-MC-Unique: kO-RICo7PzSqT8OytJfYlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 295D31018F7F;
 Wed, 28 Oct 2020 11:39:31 +0000 (UTC)
Received: from localhost (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F1716EF40;
 Wed, 28 Oct 2020 11:39:29 +0000 (UTC)
Date: Wed, 28 Oct 2020 11:39:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 3/7] qemu: add support for iOS host
Message-ID: <20201028113928.GG221115@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-4-j@getutm.app>
MIME-Version: 1.0
In-Reply-To: <20201028030701.14086-4-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Marek Vasut <marex@denx.de>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 08:06:57PM -0700, Joelle van Dyne wrote:
> This introduces support for building for iOS hosts. When the correct Xcod=
e
> toolchain is used, iOS host will be detected automatically.
>=20
> block: disable features not supported by iOS sandbox
> slirp: disable SMB features for iOS
> target: disable system() calls for iOS
> tcg: use sys_icache_invalidate() instead of GCC builtin for iOS
> tests: disable tests on iOS which uses system()
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  configure                      | 43 +++++++++++++++++++++++++++++++++-
>  meson.build                    |  2 +-
>  tcg/aarch64/tcg-target.h       |  7 ++++++
>  block.c                        |  2 +-
>  block/file-posix.c             | 31 ++++++++++++++----------
>  net/slirp.c                    | 16 ++++++-------
>  qga/commands-posix.c           |  6 +++++
>  target/arm/arm-semi.c          |  2 ++
>  target/m68k/m68k-semi.c        |  2 ++
>  target/nios2/nios2-semi.c      |  2 ++
>  tests/qtest/libqos/virtio-9p.c |  8 +++++++
>  tests/qtest/meson.build        |  7 +++---
>  12 files changed, 101 insertions(+), 27 deletions(-)

Please add a ./MAINTAINERS file entry for iOS host support.

Maintainership duties involve:
1. Respond to emails and review patches for their subsystem.
2. Send pull requests with the patches they have merged.
3. Participate in keeping their subsystem functional, e.g. ensuring CI
   coverage and testing is working.

These are not strictly defined, people do them in different ways.

It is beneficial to get continuous integration working for iOS.
Otherwise other maintainers may merge patches that break iOS compilation
and you'll find out later and be left solving the issues.

> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
> index d7a80dd303..bb029070d3 100644
> --- a/target/nios2/nios2-semi.c
> +++ b/target/nios2/nios2-semi.c
> @@ -426,6 +426,7 @@ void do_nios2_semihosting(CPUNios2State *env)
>              result =3D isatty(arg0);
>          }
>          break;
> +#if !defined(CONFIG_IOS) /* iOS does not have system() */
>      case HOSTED_SYSTEM:
>          GET_ARG(0);
>          GET_ARG(1);
> @@ -444,6 +445,7 @@ void do_nios2_semihosting(CPUNios2State *env)
>              }
>          }
>          break;
> +#endif
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: unsupported "
>                        "semihosting syscall %d\n", nr);

Another option is to define a system() that always returns ENOSYS. Then
the #ifdefs can be avoided.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZWHAACgkQnKSrs4Gr
c8i8eAf+OT+endYKq7QRxCORO4OQ6EDoY7rjBwpaKTtUlQayed6ep5RJfZJSG8da
ioH3xInPYfo+lBFWQHtaB6mZ+iWcZ1ts8X9VeiPOvCIPgPJfKKbr9NRqGVhHPwFq
J374EwuIiQYqQK14ba4ZOCe587wRuufTzleEfkqu/LyS9Lr+6IIY1bYYNWeJWlzl
LNTyGi6jdA2Khz8npEoW0ZFc9t3cb1QkBq8GRsORCQMS8VZJF0sWKVqaoVncdHV5
G/he1rf4pO7+5zyyQr78W3Kw5sm2L3Y7uejhGMEiVgt8SDg6IVmJwzw/e4TWWEAe
p1HbVdjtDSSEEgIi1LTZmG7tTotnMA==
=qflh
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--


