Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03244C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA653206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA653206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Jcz-00039V-Pg
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7JbG-0001sg-5W
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7JbE-000500-Ct
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7JbE-0004zs-5h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:20:56 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BB1E2A09BA
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 13:20:55 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id c1so7352277wrb.12
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 06:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rcMcroHw7g5/7GCIUYB9C5IhA/wa/ZMggUaVgdExPo4=;
 b=fYlEA1lxoeQaunovPpaX1xl87t/k6W+2z3GkFZle5MsB1CZbQ8biUQwj3IlmZgxNIL
 su3cSTuzRxaA13+3EiDJzq1XR/m5UadARb28R2d7u7mKn7FvteQsq/JvlL/y4qOoDIXT
 cXUEs4G2rczrJj7jAWctsp4Sh9ut/zdTDTxJwpK1XWm8v0YOhCF63mvohrzEXLMdwYsI
 hjm56ZqiQ5/xl/QgwZnrnKV7CxG91VaW+F5eRwKenyW84K3yJ5dTvwr9ff3FxUUi48DD
 v68BaAqL8kTWwkVbE+XHNbCyrMCrSRF6aejGD4NphGLeOd5FHd7I6x3hpZJ4lpVJwhda
 M3TQ==
X-Gm-Message-State: APjAAAXx9Ir0ubxuHrpaD14X5WhnF+bcgVFTSVd9OYC69px/bjNuGBYN
 boYzt2rT1jDyLiLt1vKkpz/zKmRF2hgDqw956KAknv3e8hy1h3m+xZtikRhPFMpFGN9UF4JHPkT
 FeS4gH5F9VTvzsDY=
X-Received: by 2002:a7b:c445:: with SMTP id l5mr19275349wmi.93.1568035253900; 
 Mon, 09 Sep 2019 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTTvkP2zn6w6+MgYTf917mAQepclws9sJ9VdBA+mpp/fWS7pCXsdwgMYd7oX1bv/3j1X70DQ==
X-Received: by 2002:a7b:c445:: with SMTP id l5mr19275326wmi.93.1568035253726; 
 Mon, 09 Sep 2019 06:20:53 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id d12sm13303337wme.33.2019.09.09.06.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 06:20:53 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190829165036.9773-1-berrange@redhat.com>
 <20190829165036.9773-2-berrange@redhat.com>
 <15ffac7c-e7f2-17e4-f4e5-e54500ae3ecb@redhat.com>
 <20190909131510.GG24509@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <429ee8e3-e6ce-5a37-f4fe-a8408b1cc7b9@redhat.com>
Date: Mon, 9 Sep 2019 15:20:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190909131510.GG24509@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/19 3:15 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Sep 09, 2019 at 02:57:08PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> On 8/29/19 6:50 PM, Daniel P. Berrang=C3=A9 wrote:
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>  CODING_STYLE =3D> CODING_STYLE.rst | 121 +++++++++++++++++++--------=
---
>>>  HACKING =3D> HACKING.rst           | 123 +++++++++++++++++++++------=
----
>>>  README =3D> README.rst             |  47 +++++++-----
>>>  scripts/checkpatch.pl            |   2 +-
>>>  4 files changed, 191 insertions(+), 102 deletions(-)
>>>  rename CODING_STYLE =3D> CODING_STYLE.rst (72%)
>>>  rename HACKING =3D> HACKING.rst (79%)
>>>  rename README =3D> README.rst (84%)
>>
>> This change broke the NSIS build:
>>
>> (cd /tmp/qemu-nsis; \
>>          for i in qemu-system-*.exe; do \
>>            arch=3D${i%.exe}; \
>>            arch=3D${arch#qemu-system-}; \
>>            echo Section \"$arch\" Section_$arch; \
>>            echo SetOutPath \"\$INSTDIR\"; \
>>            echo File \"\${BINDIR}\\$i\"; \
>>            echo SectionEnd; \
>>          done \
>>         ) >/tmp/qemu-nsis/system-emulations.nsh
>> makensis -V2 -NOCD \
>>                 -DCONFIG_DOCUMENTATION=3D"y" \
>>                 -DCONFIG_GTK=3D"y" \
>>                 -DBINDIR=3D"/tmp/qemu-nsis" \
>>                  \
>>                 -DSRCDIR=3D"/tmp/qemu-test/src" \
>>                 -DOUTFILE=3D"qemu-setup-4.1.50.exe" \
>>                 -DDISPLAYVERSION=3D"4.1.50" \
>>                 /tmp/qemu-test/src/qemu.nsi
>> File: "/tmp/qemu-test/src\README" -> no files found.
>> Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] =
|
>>    /oname=3Doutfile one_file_only)
>> Error in script "/tmp/qemu-test/src/qemu.nsi" on line 122 -- aborting
>> creation process
>> make: *** [Makefile:1083: qemu-setup-4.1.50.exe] Error 1
>>
>> I'll send a fix.
>=20
> Doh. If we care about NSIS, we really need to have it being tested by
> some part of our CI system, and by pre-merge build tests.

I believe Stefan Weil does, since he regularly sends fixes or opens LP
bugs during freeze time.

We do build nsis/win32 with CI, but for some reason patchew was down.

I'm not sure we should duplicate the build on another CI, we should
rather setup something to watch patchew and warn us when it goes down.

