Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F6AC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF76218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF76218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JFi-0003me-2a
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 08:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7JEI-0002xZ-Pr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7JEH-0000VN-9m
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:57:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7JEH-0000Ul-2a
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:57:13 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D0178535D
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 12:57:12 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r1so4446533wmr.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 05:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ab9bsxqgfm4A6EgeBcTqMtuwidDv7avVUMn1wxSDHFk=;
 b=m5FKRKVGFWCHa9rtk1NG7fI8a+CqpJaWA4ceamSdC/KU6RU4XWXcJfcxN2uGNJWX1V
 xCmDwyhah6SrfeysjN5Yxbm9vHVBZjbMHKyExT805eQPn9KXJlmSaWxH9KWTNUYsyW02
 k4UyTdnU5PJitsWJ41Zu/yulX5hCznHf2DhxglVQSF7bdN8ICB0sahRswaf2xrKwE5XK
 sqECev2cUCV0wxS76YLcGgVmVYlIS+o0ajSwVtevxG+vJulwI3TI4mSaWq58AzAOJf5M
 VJZhV5FhHgP+U4UAGirMwUe4BmH7/m9vFhDtAuhQz7F4ExrjZo/5aKF1hd3MWT4nS7gf
 8udQ==
X-Gm-Message-State: APjAAAVzVDUQdj88FHkyyA7zZ2VX65A+Izs44P98EUl5XJlFQyaksgar
 w52wadx0dWssofCEWW7sQoEITuf6jpaON/ztPaanBp/ThLa2g0ZyrPnwrGYHLFn5l1QvaT4+juE
 NkIpcVO2RwdJXz08=
X-Received: by 2002:adf:f790:: with SMTP id q16mr5849739wrp.164.1568033830918; 
 Mon, 09 Sep 2019 05:57:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrnDLmgRdPIOosxPtVvFeC8WfQpTL+TzevsBA77+zvwxqZ0Q9aMV+bV5CUB+73wzq397uL7g==
X-Received: by 2002:adf:f790:: with SMTP id q16mr5849718wrp.164.1568033830728; 
 Mon, 09 Sep 2019 05:57:10 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e12sm3402682wrw.37.2019.09.09.05.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 05:57:09 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <15ffac7c-e7f2-17e4-f4e5-e54500ae3ecb@redhat.com>
Date: Mon, 9 Sep 2019 14:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829165036.9773-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/4] docs: convert README,
 CODING_STYLE and HACKING to RST syntax
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 6:50 PM, Daniel P. Berrang=C3=A9 wrote:
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  CODING_STYLE =3D> CODING_STYLE.rst | 121 +++++++++++++++++++----------=
-
>  HACKING =3D> HACKING.rst           | 123 +++++++++++++++++++++--------=
--
>  README =3D> README.rst             |  47 +++++++-----
>  scripts/checkpatch.pl            |   2 +-
>  4 files changed, 191 insertions(+), 102 deletions(-)
>  rename CODING_STYLE =3D> CODING_STYLE.rst (72%)
>  rename HACKING =3D> HACKING.rst (79%)
>  rename README =3D> README.rst (84%)

This change broke the NSIS build:

(cd /tmp/qemu-nsis; \
         for i in qemu-system-*.exe; do \
           arch=3D${i%.exe}; \
           arch=3D${arch#qemu-system-}; \
           echo Section \"$arch\" Section_$arch; \
           echo SetOutPath \"\$INSTDIR\"; \
           echo File \"\${BINDIR}\\$i\"; \
           echo SectionEnd; \
         done \
        ) >/tmp/qemu-nsis/system-emulations.nsh
makensis -V2 -NOCD \
                -DCONFIG_DOCUMENTATION=3D"y" \
                -DCONFIG_GTK=3D"y" \
                -DBINDIR=3D"/tmp/qemu-nsis" \
                 \
                -DSRCDIR=3D"/tmp/qemu-test/src" \
                -DOUTFILE=3D"qemu-setup-4.1.50.exe" \
                -DDISPLAYVERSION=3D"4.1.50" \
                /tmp/qemu-test/src/qemu.nsi
File: "/tmp/qemu-test/src\README" -> no files found.
Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
   /oname=3Doutfile one_file_only)
Error in script "/tmp/qemu-test/src/qemu.nsi" on line 122 -- aborting
creation process
make: *** [Makefile:1083: qemu-setup-4.1.50.exe] Error 1

I'll send a fix.

