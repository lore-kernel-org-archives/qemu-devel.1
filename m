Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DB72146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhQ14pqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DB72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihFCU-0000tJ-24
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihFBp-0000Lq-4X
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihFBn-0000xb-4x
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:55:12 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:44465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihFBm-0000w4-Sd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:55:11 -0500
Received: by mail-oi1-x22b.google.com with SMTP id d62so5697818oia.11
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X11bSzF0+QWLbhrZRxWgGqmhCRlbq6R+5cjDsGi3l2U=;
 b=JhQ14pqAk63FbnBH0sohxIsH8jI4z8v5zZfpe9EhUH1XfhwLJ4tiLEtfzZsNrjCGre
 p69LlWxPvI9sFcevjdmW3bqpiJN9wIXytA+fyoUXDoqAGnzyvWr2+e5Sd84QT+apxLvl
 Sg9pbcpYZ4OH1DElAHAwlhJcJ338NZ96B/HjL7hKzGUWJRkiL6Ng7L6fRiK+S2kPU6og
 7IS7fONDhhLLHHCr1ZQ+Yk+pHXcwmJrAzhc9PKXbKCTzfe9sl0etlBCZoPtXMJtcomW9
 /7D2i7BNdzzWGLXmfKx3nAGih11AHpMu4W4xNVFraIQAHX8VLyoAyib8fAESVfR0zzCj
 tZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X11bSzF0+QWLbhrZRxWgGqmhCRlbq6R+5cjDsGi3l2U=;
 b=V5NuIbmuEhW4Gj/7+o6fsDtNKFhZrO04qMi8MDEMCUx1zO8a7CGI0dktWAYJw93qf0
 2VnQASQNyb+914YtoFv9FOmJmGJ9gBlNSMyVENfNLCHmWKMg0lR9yx6pIraWpHnalfAj
 NYvwIacX45iCdoln5K4SE3V8WJdSwZ+QiFIrtKTyzTxP2VZXXc6I5NG5LtFg3/D51kYO
 xkIQXVxJLPPMeDn+mFElqxh+VFEsoKYk6V0NxywS1GVmbK5c4frW3G+XHU9UuUCJn57n
 TEm8JymvpJMzmZJ4/Cl65YE8bk0ywFPYe6VP2SZ7mvmdinc/jZFDylNpzQcX8bU5M7i7
 ZYkg==
X-Gm-Message-State: APjAAAUTmwv6sbaiLlXqeZQ5XHKldx5YikO8h3dBEP6Wv4Ekd6Mesqhz
 z/e8oB0rWc0vHqtYJiiJmBYadf8/3Ib+tzmD7hIrQg==
X-Google-Smtp-Source: APXvYqwcUm6V7jQYQ3HXobr6oW8oDOyQ5RvafXA5ycQ4/IzX1FGnkELyhxPRgZwjT+MIC5W2eIjqnEbt7tUD2y5fb2M=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr1795789oic.146.1576598109588; 
 Tue, 17 Dec 2019 07:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20191217081454.8072-1-armbru@redhat.com>
In-Reply-To: <20191217081454.8072-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 15:54:58 +0000
Message-ID: <CAFEAcA8r-wai+vMa8WiCjUFyRGwTQQs9fZo_ddRmAdr_6GAcTw@mail.gmail.com>
Subject: Re: [PULL 0/6] QAPI patches for 2019-12-17
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 08:16, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e21663=
04:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-=
2019' into staging (2019-12-16 14:07:56 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-12-17
>
> for you to fetch changes up to 328add3012e0b642134afedcd53660c30c758866:
>
>   qapi: Simplify QAPISchemaModularCVisitor (2019-12-17 08:09:28 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-12-17
>
> ----------------------------------------------------------------
> Markus Armbruster (6):
>       qapi: Tweak "command returns a nice type" check for clarity
>       tests/Makefile.include: Fix missing test-qapi-emit-events.[ch]
>       qapi: Generate command registration stuff into separate files
>       qapi: Proper intermediate representation for modules
>       qapi: Fix code generation for empty modules
>       qapi: Simplify QAPISchemaModularCVisitor

Build failures:

OSX:
In file included from In file included from qapi/qapi-types-block.c:15:
In file included from
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-block.h:17:
In file included from
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-block-core.h:18:
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:176:33:
error: field has incomplete type 'QCryptoBlockOptionsQCow' (aka
'struct QCryptoBlockOptionsQCow')
qapi/qapi-types-block-core.c:15:
In file included from
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-block-core.h:18:
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:176:33:
error: field has incomplete type 'QCryptoBlockOptionsQCow' (aka
'struct QCryptoBlockOptionsQCow')
        QCryptoBlockOptionsQCow qcow;
        QCryptoBlockOptionsQCow qcow;                                ^

                                ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:/Users/=
pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h115::16115::
16note::  forward declaration of 'struct QCryptoBlockOptionsQCow'
note: forward declaration of 'struct QCryptoBlockOptionsQCow'
typedef struct QCryptoBlockOptionsQCow QCryptoBlockOptionsQCow;
               ^
typedef struct QCryptoBlockOptionsQCow QCryptoBlockOptionsQCow;
               ^
  CC      qapi/qapi-types-common.o
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:177/Use=
rs/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:177:33::
error: field has incomplete type 'QCryptoBlockOptionsLUKS' (aka
'struct QCryptoBlockOptionsLUKS')
        QCryptoBlockOptionsLUKS luks;
                                ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:117:16:
note: forward declaration of 'struct QCryptoBlockOptionsLUKS'
33: error: typedef struct QCryptoBlockOptionsLUKS QCryptoBlockOptionsLUKS;
field has incomplete type 'QCryptoBlockOptionsLUKS' (aka 'struct
QCryptoBlockOptionsLUKS')               ^

        QCryptoBlockOptionsLUKS luks;
                                ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:117:16:
note: forward declaration of 'struct QCryptoBlockOptionsLUKS'
typedef struct QCryptoBlockOptionsLUKS QCryptoBlockOptionsLUKS;
               ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h/Users/p=
m215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:193:33:
error: field has incomplete type 'QCryptoBlockOptionsQCow' (aka
'struct QCryptoBlockOptionsQCow')
        QCryptoBlockOptionsQCow qcow;
                                ^
:193:33:/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h
:error115: :field has incomplete type 'QCryptoBlockOptionsQCow' (aka
'struct QCryptoBlockOptionsQCow')16
: note: forward declaration of 'struct QCryptoBlockOptionsQCow'
typedef struct QCryptoBlockOptionsQCow QCryptoBlockOptionsQCow;
               ^
        QCryptoBlockOptionsQCow qcow;
                                ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:115:16:
note: forward declaration of 'struct QCryptoBlockOptionsQCow'
typedef struct QCryptoBlockOptionsQCow QCryptoBlockOptionsQCow;
               ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:236:30:
error: field has incomplete type 'QCryptoBlockInfoLUKS' (aka 'struct
QCryptoBlockInfoLUKS')
        QCryptoBlockInfoLUKS luks;
                             ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:131:16:
note: forward declaration of 'struct QCryptoBlockInfoLUKS'
typedef struct QCryptoBlockInfoLUKS QCryptoBlockInfoLUKS;
               ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:236:30:
error: field has incomplete type 'QCryptoBlockInfoLUKS' (aka 'struct
QCryptoBlockInfoLUKS')
        QCryptoBlockInfoLUKS luks;
                             ^
/Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:131:16:
note: forward declaration of 'struct QCryptoBlockInfoLUKS'
typedef struct QCryptoBlockInfoLUKS QCryptoBlockInfoLUKS;
               ^
4 errors generated.

x86-64 linux:

In file included from qapi/qapi-types-block-core.h:18:0,
                 from qapi/qapi-types-block-core.c:15:
qapi/qapi-types-crypto.h:176:33: error: field =E2=80=98qcow=E2=80=99 has in=
complete type
         QCryptoBlockOptionsQCow qcow;
                                 ^~~~
qapi/qapi-types-crypto.h:177:33: error: field =E2=80=98luks=E2=80=99 has in=
complete type
         QCryptoBlockOptionsLUKS luks;
                                 ^~~~
qapi/qapi-types-crypto.h:193:33: error: field =E2=80=98qcow=E2=80=99 has in=
complete type
         QCryptoBlockOptionsQCow qcow;
                                 ^~~~
qapi/qapi-types-crypto.h:236:30: error: field =E2=80=98luks=E2=80=99 has in=
complete type
         QCryptoBlockInfoLUKS luks;
                              ^~~~

thanks
-- PMM

