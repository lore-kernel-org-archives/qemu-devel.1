Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCADEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 23:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CF12076E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DgyFHM/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CF12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3SkZ-0004Kf-O8
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 19:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k3Sjx-0003ul-Aw
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 19:22:33 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k3Sju-0006Bi-P8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 19:22:33 -0400
Received: by mail-ed1-x541.google.com with SMTP id c15so24108524edj.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vax3JDy0lrpmlOxeTgGNFlCDufwX6rsxr7BS6+EDGEk=;
 b=DgyFHM/p4CIo0r6cgAYjwYrwj/flnvbecraq4EaFe6UOhqGmw4dEKkeI3M7lWgl8HS
 IL4AVe7g6UH0AQ8FCioV8UQL/YkaHG5n/Qt+De3V/DwvTP5P794eVfAb6+OukGsTR3qO
 RZRXk2/7rm5G0Bm4g1W3RW6eCpUnYQlBnzhDKQsaVEnCOq64CwAtPX91n+EzF7WBa4+b
 0II4qAQ+FTcnKe10YUGW5hDDId6ZLliY9XbnwFo+OhUEEjiWIL0eQBaNofeLEoSgMtoc
 3LEXsqXUA6nbYva11ezynZdU+ci0aRYsJvftVYdeQdzA5bxwK+KU8KofJANGbPx6Hihh
 +Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vax3JDy0lrpmlOxeTgGNFlCDufwX6rsxr7BS6+EDGEk=;
 b=IJ2lOJ7lj9PTm2eWsofIBcU+96jLKVBvQJku2QCPNkGNBBC9maI25qWiBmNecHLGnk
 0MwLEiPqxnq/Hep/tfvhopDJZF4PQfT+vNiteSG0guzTuG0Uk1UrfbXIS3+BN0G5PnAI
 8Csr68nzY8w734PuZGkD0XdUgK50DUo1rH64Rc99R63mV/vwxRV1uhAywiXUROVwJTX3
 0a5b0QS2QrO/9niTEtS9xRWaYzE6NGsC+OKGrdIsPBbgyamdms6emR6tNrLHVlFcvV4c
 tTHBrQQ7qDIKAuQSQ3Qbvvi1NfAob2QK+GPod0jr5Pdgs97zdsz7pIoSaqtblrgTuJIi
 5wlA==
X-Gm-Message-State: AOAM532RZUuI5++6U1aI4/WJTZQgJbSUwPjELJlfXDMzXwSypVrMIFG7
 gKRQMOG5eFBepTn87epIWaUOcJoehLYamywcskcnrKN3pnw=
X-Google-Smtp-Source: ABdhPJz6t6OFuIewBWtQpJ+JKi1BSH7+HE1vicVp5KCS6uqrNEBBE/a0pnJGYVDqTCRZ7z1+QQ9tHPg6XF25H9JYpeY=
X-Received: by 2002:aa7:c45a:: with SMTP id n26mr1564870edr.45.1596669746149; 
 Wed, 05 Aug 2020 16:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595461447.git.scw@google.com>
In-Reply-To: <cover.1595461447.git.scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Wed, 5 Aug 2020 16:22:15 -0700
Message-ID: <CAF3nBxgBm_GYkpYwqF2-OQvgn3twQMzpo3NufOG34EoWyB3R7A@mail.gmail.com>
Subject: Re: [PATCH 0/6] fcntl, sockopt, and ioctl options
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000001235da05ac29a58e"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=scw@google.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001235da05ac29a58e
Content-Type: multipart/alternative; boundary="0000000000000b928805ac29a504"

--0000000000000b928805ac29a504
Content-Type: text/plain; charset="UTF-8"

Ping! Patchew: https://patchew.org/QEMU/cover.1595461447.git.scw@google.com/

On Wed, Jul 22, 2020 at 5:19 PM Shu-Chun Weng <scw@google.com> wrote:

> Hi Laurent,
>
> This is a series of 6 patches in 4 groups, putting into a single thread for
> easier tracking.
>
> [PATCH 1/6] linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
>   An incidental follow up on
>   https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01925.html
>
> [PATCH 2/6] linux-user: add missing UDP and IPv6 get/setsockopt
>   Updated
> https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01317.html
>   to consistently add them in get/setsockopt
>
> [PATCH 3/6] linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW
> [PATCH 4/6] linux-user: setsockopt() SO_TIMESTAMPNS and SO_TIMESTAMPING
>   Updated
> https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01319.html
>   to only use TARGET_SO_*_OLD/NEW
>
> [PATCH 5/6] thunk: supports flexible arrays
> [PATCH 6/6] linux-user: Add support for SIOCETHTOOL ioctl
>   Updated
> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg05090.html
>
> Shu-Chun Weng (6):
>   linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
>   linux-user: add missing UDP and IPv6 get/setsockopt options
>   linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW
>   linux-user: setsockopt() SO_TIMESTAMPNS and SO_TIMESTAMPING
>   thunk: supports flexible arrays
>   linux-user: Add support for SIOCETHTOOL ioctl
>
>  include/exec/user/thunk.h              |  20 +
>  linux-user/Makefile.objs               |   3 +-
>  linux-user/alpha/sockbits.h            |  21 +-
>  linux-user/ethtool.c                   | 819 +++++++++++++++++++++++++
>  linux-user/ethtool.h                   |  19 +
>  linux-user/ethtool_entries.h           | 107 ++++
>  linux-user/fd-trans.h                  |  41 +-
>  linux-user/generic/sockbits.h          |  17 +-
>  linux-user/hppa/sockbits.h             |  20 +-
>  linux-user/ioctls.h                    |   2 +
>  linux-user/mips/sockbits.h             |  16 +-
>  linux-user/qemu.h                      |   1 +
>  linux-user/sparc/sockbits.h            |  21 +-
>  linux-user/strace.c                    |  19 +-
>  linux-user/syscall.c                   | 233 ++++++-
>  linux-user/syscall_defs.h              |  26 +-
>  linux-user/syscall_types.h             | 277 +++++++++
>  tests/tcg/multiarch/ethtool.c          | 417 +++++++++++++
>  tests/tcg/multiarch/socket_timestamp.c | 542 ++++++++++++++++
>  thunk.c                                | 151 ++++-
>  20 files changed, 2706 insertions(+), 66 deletions(-)
>  create mode 100644 linux-user/ethtool.c
>  create mode 100644 linux-user/ethtool.h
>  create mode 100644 linux-user/ethtool_entries.h
>  create mode 100644 tests/tcg/multiarch/ethtool.c
>  create mode 100644 tests/tcg/multiarch/socket_timestamp.c
>
> --
> 2.28.0.rc0.105.gf9edc3c819-goog
>
>

--0000000000000b928805ac29a504
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping! Patchew:=C2=A0<a href=3D"https://patchew.org/QEMU/co=
ver.1595461447.git.scw@google.com/" class=3D"cremed">https://patchew.org/QE=
MU/cover.1595461447.git.scw@google.com/</a></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 22, 2020 at 5:19 PM =
Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com">scw@google.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Lauren=
t,<br>
<br>
This is a series of 6 patches in 4 groups, putting into a single thread for=
<br>
easier tracking.<br>
<br>
[PATCH 1/6] linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls<br>
=C2=A0 An incidental follow up on<br>
=C2=A0 <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2019-09/=
msg01925.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.or=
g/archive/html/qemu-devel/2019-09/msg01925.html</a><br>
<br>
[PATCH 2/6] linux-user: add missing UDP and IPv6 get/setsockopt<br>
=C2=A0 Updated <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/=
2019-09/msg01317.html" rel=3D"noreferrer" target=3D"_blank">https://lists.n=
ongnu.org/archive/html/qemu-devel/2019-09/msg01317.html</a><br>
=C2=A0 to consistently add them in get/setsockopt<br>
<br>
[PATCH 3/6] linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW<br>
[PATCH 4/6] linux-user: setsockopt() SO_TIMESTAMPNS and SO_TIMESTAMPING<br>
=C2=A0 Updated <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/=
2019-09/msg01319.html" rel=3D"noreferrer" target=3D"_blank">https://lists.n=
ongnu.org/archive/html/qemu-devel/2019-09/msg01319.html</a><br>
=C2=A0 to only use TARGET_SO_*_OLD/NEW<br>
<br>
[PATCH 5/6] thunk: supports flexible arrays<br>
[PATCH 6/6] linux-user: Add support for SIOCETHTOOL ioctl<br>
=C2=A0 Updated <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/=
2019-08/msg05090.html" rel=3D"noreferrer" target=3D"_blank">https://lists.n=
ongnu.org/archive/html/qemu-devel/2019-08/msg05090.html</a><br>
<br>
Shu-Chun Weng (6):<br>
=C2=A0 linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls<br>
=C2=A0 linux-user: add missing UDP and IPv6 get/setsockopt options<br>
=C2=A0 linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW<br>
=C2=A0 linux-user: setsockopt() SO_TIMESTAMPNS and SO_TIMESTAMPING<br>
=C2=A0 thunk: supports flexible arrays<br>
=C2=A0 linux-user: Add support for SIOCETHTOOL ioctl<br>
<br>
=C2=A0include/exec/user/thunk.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 20 +<br>
=C2=A0linux-user/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
=C2=A0linux-user/alpha/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 21 +-<br>
=C2=A0linux-user/ethtool.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 819 +++++++++++++++++++++++++<br>
=C2=A0linux-user/ethtool.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 19 +<br>
=C2=A0linux-user/ethtool_entries.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 107 ++++<br>
=C2=A0linux-user/fd-trans.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 41 +-<br>
=C2=A0linux-user/generic/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 17 +-<br>
=C2=A0linux-user/hppa/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 20 +-<br>
=C2=A0linux-user/ioctls.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0linux-user/mips/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 16 +-<br>
=C2=A0linux-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0linux-user/sparc/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 21 +-<br>
=C2=A0linux-user/strace.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 +-<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 233 ++++++-<br>
=C2=A0linux-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 26 +-<br>
=C2=A0linux-user/syscall_types.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 277 +++++++++<br>
=C2=A0tests/tcg/multiarch/ethtool.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 417=
 +++++++++++++<br>
=C2=A0tests/tcg/multiarch/socket_timestamp.c | 542 ++++++++++++++++<br>
=C2=A0thunk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 151 ++++-<br>
=C2=A020 files changed, 2706 insertions(+), 66 deletions(-)<br>
=C2=A0create mode 100644 linux-user/ethtool.c<br>
=C2=A0create mode 100644 linux-user/ethtool.h<br>
=C2=A0create mode 100644 linux-user/ethtool_entries.h<br>
=C2=A0create mode 100644 tests/tcg/multiarch/ethtool.c<br>
=C2=A0create mode 100644 tests/tcg/multiarch/socket_timestamp.c<br>
<br>
-- <br>
2.28.0.rc0.105.gf9edc3c819-goog<br>
<br>
</blockquote></div>

--0000000000000b928805ac29a504--

--0000000000001235da05ac29a58e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCCf5COSZ7WozGCLePczCNsKz4USgMH4m9QTeonA/ncpczAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MDUyMzIyMjZaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAi0au
tCTZ8gba4j3zzRboOuN8gliFXd+DvsA4ub3g/v34kwdUpzP/xsZvLVr6t9A8jLFj5iBN+qkLzucK
RTXc5cZTbhwL54drhpLhatgWgPJwOg2zQxJDqQeH0tzeRlJjeoHFLDTKka/VZsD74LGgpVyVxsYA
mfqU97VBU42B8JJsEVMxAv+HMBBYOB1dx4nkn8ZAs6qrucJA1WSaIH+Whe780VDwkOmVTsdomGWX
OeSCljduZIJvZJwoJkw3/SBqw3tRgw8/Sz8sVHb4S3fZKV7BdAluqrXlt9dohtVpm10ofSjUAUAw
pSgWdXPTyAa9ewOioLD9zUyIsw5hUV05YQ==
--0000000000001235da05ac29a58e--

