Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10F8C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931FB20881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOT60Sq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931FB20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTm5E-0006Ms-Pj
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:40:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTm2v-0004ug-FE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTlxy-0005sy-7r
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:32:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTlxy-0005Hl-1X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:32:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so1338522wma.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=dMsvrxWjunI334E1ZalZQsRXwFEfUx3RUTpOJsFj1jA=;
	b=aOT60Sq5ax0iMCeV6rOAe6AwzlbOBUhsPrnbu6dQI8jCZveRkNMS3M8wjmgA+NoMdz
	XZ6BUWJS8q72sLhKUZ8YxlPiSEfGzDzj7zb9SphWOMeNs2yHl68hKY5+99VoqLJ1G5Cb
	9SCAGl0z9JBOSK+2MPnJomE84UACQfgcXMdCmsxeiZ4gLY3qw/B6Trdd5x+1rzLOK7kl
	u1u7wJURhAJCQKpsSckhIDnod5iOuK5OEj5PTls0R9UnRik/eiiLj4sx70LWSsCvFJiG
	4zauY+F7yHp10Wm0AZjUc0TTPLeUIOta3Vi53Spvv3QFv94shYPNDEjTc9QjZTs6TADR
	6dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=dMsvrxWjunI334E1ZalZQsRXwFEfUx3RUTpOJsFj1jA=;
	b=pd533csxEF6G+don1nmGUuQMLO/gyysO5lKuIgrKG7NqAUso9wK89zFNN20TlhZ1c+
	OuGW/geyo+IPGSZjNcOuksuk2fuYPOpTUoKDKjO7IK8yrqnUkROcvGr+zbyyr4TZLJN0
	/ym44ODWTh5wM+qupEcWwF7YCLpspQX44zROIvb+uiDd+OhMDkeeYV/tPLpdpKIpXUpk
	ZgXif26v3dNEQlLKJ4H2Mo78IfSe8x679O3GDZ/VBmgoh5I/28BgqDXrQXJMCltcE3mX
	IGeW93zjyj0Mi3WjaCuwANG2PudOzglvdD0kK7x8xKOZ6G85A1AXZccdXCqBbKpPdLIA
	ZX+w==
X-Gm-Message-State: APjAAAUAh3e4vZzI5V7BTzn3WVwhZJB6YGxvrufw3mb7+JGzCpcARM+o
	ikDuoH/U+K7HMCDxl0hgoSAjZuYM03U=
X-Google-Smtp-Source: APXvYqwkB60EVs02ZR189BlGBHDtUPtPJVAD4GfUySlj7D91mdtEhIdLW//3+l3XBW4cdpmzZ4Ns2Q==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr11101852wme.104.1558611160028;
	Thu, 23 May 2019 04:32:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h15sm25954083wru.52.2019.05.23.04.32.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 04:32:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 153C71FF87;
	Thu, 23 May 2019 12:32:39 +0100 (BST)
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-2-richard.henderson@linaro.org>
	<20190523110736.GD20973@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190523110736.GD20973@redhat.com>
Date: Thu, 23 May 2019 12:32:39 +0100
Message-ID: <87h89l1k4o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 1/3] capstone: Adjust include of capstone.h
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, May 22, 2019 at 10:42:27PM -0400, Richard Henderson wrote:
>> Since v4.0, capstone.h has moved to <capstone/capstone.h>.
>
> NB this was a regression bug in capstone pkg-config file which has been
> fixed upstream
>
>    https://github.com/aquynh/capstone/pull/1276
>
> In Fedora we pulled in the fix to our v4.0 builds and I'd suggest
> other distros should do the same

But I think it's worth keeping the workaround in the likely event that
it takes a while for that to filter through.

>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/disas/capstone.h | 4 ++++
>>  configure                | 6 ++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
>> index e29068dd97..90631d84a9 100644
>> --- a/include/disas/capstone.h
>> +++ b/include/disas/capstone.h
>> @@ -3,7 +3,11 @@
>>
>>  #ifdef CONFIG_CAPSTONE
>>
>> +#ifdef CONFIG_CAPSTONE_CAPSTONE_H
>> +#include <capstone/capstone.h>
>> +#else
>>  #include <capstone.h>
>> +#endif
>>
>>  #else
>>
>> diff --git a/configure b/configure
>> index d2fc346302..eec7f061c3 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5021,6 +5021,9 @@ case "$capstone" in
>>    system)
>>      QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags capstone)"
>>      LIBS=3D"$($pkg_config --libs capstone) $LIBS"
>> +    if check_include capstone/capstone.h; then
>> +      capstone_capstone_h=3Dyes
>> +    fi
>>      ;;
>>
>>    no)
>> @@ -7197,6 +7200,9 @@ if test "$ivshmem" =3D "yes" ; then
>>  fi
>>  if test "$capstone" !=3D "no" ; then
>>    echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
>> +  if test "$capstone_capstone_h" !=3D "no" ; then
>> +    echo "CONFIG_CAPSTONE_CAPSTONE_H=3Dy" >> $config_host_mak
>> +  fi
>>  fi
>>  if test "$debug_mutex" =3D "yes" ; then
>>    echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

