Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F51BC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257E020722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zq/J13Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257E020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEgw-0007ik-Bh
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFEgG-0007CS-FQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFEgE-0003oi-OP
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:15:08 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:44667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFEgE-0003nj-EB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:15:06 -0400
Received: by mail-ot1-x336.google.com with SMTP id a49so5396667otc.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IsuAvZWWkXr5BZcjiTYRvW+SY5TDwaDVkcrSrqNVFSY=;
 b=Zq/J13JwK+f1HZB8y2rDYegUh+QyAPPReY1Zbj8JgOURzjD1k3QEKQc9Om9Zd1PQ6o
 UAaOGTAz+nFb03CD47OKTYmvVRa7gNDFuxPJNBRCr6L9zxEkdHavj2M9nwltSz3F/vA+
 7ckklIxFKSNgYOj874P4KOp9iomVvlnT96aXNl+DoDHbG0KKCBCgAQ7I5hUzmNDYVWYb
 9ePZ47ry9EgylD4qIPQBe8DvNXnnTyLcSBbTW/AytIqkZJhsM+Ju/5cR1ADAev9QtyoL
 AvTlnBi+xdVSNbSW8bLtwDK8FebwjcUqqvB+suqqvqCz7I8IQgYyII3ziBnOrKfSo3CO
 eGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IsuAvZWWkXr5BZcjiTYRvW+SY5TDwaDVkcrSrqNVFSY=;
 b=JyEzZQYQfb+ZQrZvbC7/W2cB6Qd8cEVnGAXLpgvC8fcLcvq9m+iOujmVK280YioPwB
 ufO8KvCIYqlKD+uqf+FWO0hz+PEEbxwP7N0BL3/6ZOcNTHkXmkisNs9Z+s06l2N5OpaY
 z+0YMhAc4BB9kYe5aCHc8VGvdVzvJCoEqg1XmE7N4ilwAOubm4mTF++ry/TnR6b58YBE
 uARV/ETwHpTJeAFUYAueHdckT9QLde5AKHRvPcup+6VofaNgXKp0VRK2lNBrA+vCXDEe
 Utp2bhwSeKxV7TpI8DgRm57to/RvKtKvrxCPHRl5l4DgtYCnjnBVvJpbEsHNqfpcSq27
 Vw9A==
X-Gm-Message-State: ANhLgQ2uYZTa7X+oUbVegBCKlEI8m9RnB+hsj2kGZafHvx6hyc3voK16
 AOZ/BCB1JG/E1lXjoWIP+Mrd9PhqEGjrrq7Ah/c2cQ==
X-Google-Smtp-Source: ADFU+vuEiRl4JRwWvzdDDW6dU4gi18PRDSOynWccN0YVLJu/DyllU7Rw3JbrQNNEPaqxVHHZo7uXao2OBH4Z7XC5QQw=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr6040808otm.91.1584699305204; 
 Fri, 20 Mar 2020 03:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200319112911.353244-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200319112911.353244-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 10:14:53 +0000
Message-ID: <CAFEAcA-UyC1o2aNYA=uGWQ1W7y2j2QKPqVgfRrXtXObA13RaVw@mail.gmail.com>
Subject: Re: [PULL 0/1] Slirp patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 at 11:33, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit f57587c7d47b35b2d9b31def3a74d81bdb5475=
d7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-17'=
 into staging (2020-03-19 10:18:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-pull-request
>
> for you to fetch changes up to 9f6b9fcc153f6d4f2e10193014d2eaf7329fa181:
>
>   slirp: update submodule to v4.2.0 + mingw-fix (2020-03-19 12:17:43 +010=
0)
>
> ----------------------------------------------------------------

Hi; this fails to build on NetBSD:

In file included from /usr/pkg/lib/glib-2.0/include/glibconfig.h:9:0,
                 from /usr/pkg/include/glib-2.0/glib/gtypes.h:32,
                 from /usr/pkg/include/glib-2.0/glib/galloca.h:32,
                 from /usr/pkg/include/glib-2.0/glib.h:30,
                 from /home/qemu/qemu-test.1QzWG1/src/slirp/src/util.h:27,
                 from /home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.h:47,
                 from /home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:25:
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c: In function 'slirp_new':
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:277:29: error:
'SlirpConfig {aka const struct SlirpConfig}' has no member named
'if_data'
     g_return_val_if_fail(cfg->if_mtu >=3D IF_MTU_MIN || cfg->if_mtu =3D=3D=
 0, NULL);
                             ^
/usr/pkg/include/glib-2.0/glib/gmacros.h:928:8: note: in definition of
macro '_G_BOOLEAN_EXPR'
    if (expr)                                    \
        ^
/usr/pkg/include/glib-2.0/glib/gmessages.h:599:9: note: in expansion
of macro 'G_LIKELY'
     if (G_LIKELY (expr)) \
         ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:277:5: note: in
expansion of macro 'g_return_val_if_fail'
     g_return_val_if_fail(cfg->if_mtu >=3D IF_MTU_MIN || cfg->if_mtu =3D=3D=
 0, NULL);
     ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:277:58: error:
'SlirpConfig {aka const struct SlirpConfig}' has no member named
'if_data'
     g_return_val_if_fail(cfg->if_mtu >=3D IF_MTU_MIN || cfg->if_mtu =3D=3D=
 0, NULL);
fcntl(): Invalid argument
                                                          ^
/usr/pkg/include/glib-2.0/glib/gmacros.h:928:8: note: in definition of
macro '_G_BOOLEAN_EXPR'
    if (expr)                                    \
        ^
/usr/pkg/include/glib-2.0/glib/gmessages.h:599:9: note: in expansion
of macro 'G_LIKELY'
     if (G_LIKELY (expr)) \
         ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:277:5: note: in
expansion of macro 'g_return_val_if_fail'
     g_return_val_if_fail(cfg->if_mtu >=3D IF_MTU_MIN || cfg->if_mtu =3D=3D=
 0, NULL);
     ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:278:29: error:
'SlirpConfig {aka const struct SlirpConfig}' has no member named
'if_data'
     g_return_val_if_fail(cfg->if_mtu <=3D IF_MTU_MAX, NULL);
                             ^
/usr/pkg/include/glib-2.0/glib/gmacros.h:928:8: note: in definition of
macro '_G_BOOLEAN_EXPR'
    if (expr)                                    \
        ^
/usr/pkg/include/glib-2.0/glib/gmessages.h:599:9: note: in expansion
of macro 'G_LIKELY'
     if (G_LIKELY (expr)) \
         ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:278:5: note: in
expansion of macro 'g_return_val_if_fail'
     g_return_val_if_fail(cfg->if_mtu <=3D IF_MTU_MAX, NULL);
     ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:324:10: error:
'Slirp {aka struct Slirp}' has no member named 'if_data'
     slirp->if_mtu =3D cfg->if_mtu =3D=3D 0 ? IF_MTU_DEFAULT : cfg->if_mtu;
          ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:324:24: error:
'SlirpConfig {aka const struct SlirpConfig}' has no member named
'if_data'
     slirp->if_mtu =3D cfg->if_mtu =3D=3D 0 ? IF_MTU_DEFAULT : cfg->if_mtu;
                        ^
/home/qemu/qemu-test.1QzWG1/src/slirp/src/slirp.c:324:60: error:
'SlirpConfig {aka const struct SlirpConfig}' has no member named
'if_data'
     slirp->if_mtu =3D cfg->if_mtu =3D=3D 0 ? IF_MTU_DEFAULT : cfg->if_mtu;
                                                            ^


thanks
-- PMM

