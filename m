Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3BEC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FD120652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRVEbeIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FD120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5rY-0002oq-N9
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:58:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5qe-0002UC-1k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5qa-0000Ez-P4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:57:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5qa-0000C7-6u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:57:28 -0400
Received: by mail-ot1-x333.google.com with SMTP id g24so3880201otq.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=oyDIA6PLfDNq2lbYxMZkPb4Q1h89dIJQCbTu5C4UahM=;
	b=dRVEbeIcoYYkZuzbrTVuF5Ci1bY8aNsEFrTz7Us8gsHff3/pCxXu9DGcWFmAAdbO4j
	JuW09+T0L18ZsRfVyqZh1PLbcRSEXhs3Y+rET4+iAamrlMvndnj5I4mkMmRUyYJAV0VC
	Qdw0UnUqjN4RZjx6tCmssV4xdbVirUqCA30e6cQpU4f1Ei9tHoJX56GpAMuYAFVDg7Vp
	+vHWj/uk5bzCrnAp7hkfYCGFjFmXGe0sqhE79dknlBEJ+LlTZIrNlDQhu4NR9hfWmihV
	llTbGUj0oj5QXEljJxyBItoZmvZ6DduSFSg70J2KkBHh7u1J/OGYNv5jXhxajsBA5o8P
	vMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=oyDIA6PLfDNq2lbYxMZkPb4Q1h89dIJQCbTu5C4UahM=;
	b=UI4EwOT+tPnGSTczBdcFAKKn8fSsdMOSiW6nxAoOCnDnaf4d9nJJCsvuKpbxUpfhnL
	8DpJlhG8c8UALintNlDoi1eDuauxhWsOuLw92sPrk8/hd9wbbX6dP7kSsQ7UU1Mds62J
	qutBKLQd8RDkqEVbYJF9V8O661j2KJYvR3SkqwoVG26rkBv1PtNQT6GjfdUa7EoxWmGt
	O0Gl6RTplLV78tpTgiwqSi6ddGnUaDK2rCKnMhNUuJcMyJ2SAxk2XoGN5XV7eqgL5dLK
	zhRkGaHaT5Q0pnTgOh/UopPQCCNLcmVsxKcRLCnYmc/Dp7eUJqRIi2X1ug6MVCYwwr8n
	pwYQ==
X-Gm-Message-State: APjAAAXTDQFtsETtvp3hF6WBKZ31oCMvwhwuUSZZ8Ygm92sa/F/rve5Z
	n75fdTCLiw4SrPMGkFPQq/eBmBSEaz9VBWRPmReDmw==
X-Google-Smtp-Source: APXvYqyhWmkR0v5jZWFFPEryQfvGyKJPv72cp2g+LeA4rXSKgAQziCCUxZq9ybjh/9vq0k0v7PXL9a/AXbQk9A3BGI8=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr1066373otk.316.1556542644020; 
	Mon, 29 Apr 2019 05:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-2-richard.henderson@linaro.org>
In-Reply-To: <20190315032629.21234-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:57:13 +0100
Message-ID:
 <CAFEAcA_zP=KXXtiRn3AbpT6Dcjcjh3RNS1k+AB3TYZYBLOpiSw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PATCH v3 01/23] crypto: Merge crypto-obj-y into
 libqemuutil.a
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429125713.ITbcwGoEc7Js3F1SoLaviKZLn9WPNAkBSf0odW_SMzs@z>

On Fri, 15 Mar 2019 at 03:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will shortly need this in the user-only binaries, so drop the split
> into system and tools binaries.  This also means that crypto-aes-obj-y
> can be merged back into crypto-obj-y.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile             | 12 +++++-------
>  Makefile.objs        |  8 ++------
>  Makefile.target      |  4 ----
>  configure            |  9 +++------
>  crypto/Makefile.objs |  5 +----
>  5 files changed, 11 insertions(+), 27 deletions(-)

This patch breaks a --static configure for me:

e104462:bionic:qemu$ (cd build/all-linux-static/ && '../../configure'
'--cc=3Dccache gcc' '--enable-debug' '--static' '--disable-system'
'--disable-tools')

ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
       You probably need to set PKG_CONFIG_LIBDIR
       to point to the right pkg-config files for your
       build target

The error message is bogus, but the problem is that we
tried to build one of the test programs like this:

ccache gcc -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99
-Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-value
-Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-fstack-protector-strong -I/usr/include/p11-kit-1
-I/usr/include/libpng16 -g -o config-temp/qemu-conf.exe
config-temp/qemu-conf.c -m64 -static -g -lgthread-2.0 -pthread
-lglib-2.0 -pthread -lpcre -pthread -lnettle -lgnutls -lgmp
/usr/lib/x86_64-linux-gnu/libunistring.so -lidn2 -lhogweed -lgmp
-lnettle -ltasn1 -lp11-kit -lz
gcc: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or dire=
ctory

which is almost certainly because we're now including
a bunch of extra libraries in the link for the static
linux-user binaries which don't work statically linked.
(In particular one of them looks to have a bogus
pkg-config which puts a .so file in the link line for
a static link...)

thanks
-- PMM

