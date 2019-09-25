Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F81B20640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F81B20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFmH-0003np-8p
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFji-0001So-1i
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFjh-0007E9-0C
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFjg-0007CU-QQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:26:12 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D703CC057F88
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:26:11 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l3so151040wmf.8
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ki4KWdct/PxQ711z7Z5gWMHnI3AztE+laXxt2f5hC1I=;
 b=oIm5+wmporwulJHOQj8hxo3T9vNZF0wgwj6kDlkpQBeD/2nR26JhuAviKQ/RO8WfX/
 mY6L6ZnpD/Fg/pP4/R0Jx70r+I1rZYlFVxAvnfK94dt8121i/e7TP9UuqAKL5m65auPR
 TWqiP6gIlTptQouVE5vwvAduHU6vHRd/kbRNyy3SCH/+hNI2CfwJOnzjoGkRWzCGdVw5
 dyZhv99lO005miY2bu72d/k5QXV3Zh0yJkIp8Bh03m2BzytSaEo/0ZONyLAf2wE8DPQi
 rAxdqITBh9kEK8fh++lpoEODPxRTWR83ZJfnYZ1DM7+zBLx1FylN9/e61JAc2YIqnsGi
 bHdQ==
X-Gm-Message-State: APjAAAXJAiZx03WSb71lux0PMHvMKuENXdxYdd3ezIc2feh+a7SOgJ+4
 90+Fo9g4gO86GvAz83FQ+YJZgcFt1DFmNDYv/FCog5jL4FT6C3V/h9dPR6d6MeG0qXjCMkuY1SM
 NLWnTr1X571T2qe4=
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr353678wmg.25.1569450370632;
 Wed, 25 Sep 2019 15:26:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYFU2WWzY6Det4kKdJyMkzbBNv+slmy3TQobZagtgoDJvJjEWt6ivbsj34x7NjpM44uXvxig==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr353670wmg.25.1569450370481;
 Wed, 25 Sep 2019 15:26:10 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id x5sm276669wrt.75.2019.09.25.15.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:26:09 -0700 (PDT)
Subject: Re: [PATCH v3 20/33] tests/tcg: add generic version of float_convs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-21-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1bcee6a3-fbc0-327a-340c-8e0eae655119@redhat.com>
Date: Thu, 26 Sep 2019 00:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> This is broadly similar to the existing fcvt test for ARM but using
> the generic float testing framework. We should be able to pare down
> the ARM fcvt test case to purely half-precision with or without the
> Alt HP provision.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/aarch64/float_convs.ref   | 748 ++++++++++++++++++++++++++++
>  tests/tcg/arm/float_convs.ref       | 748 ++++++++++++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target |   6 +-
>  tests/tcg/multiarch/float_convs.c   | 105 ++++
>  4 files changed, 1604 insertions(+), 3 deletions(-)
>  create mode 100755 tests/tcg/aarch64/float_convs.ref
>  create mode 100644 tests/tcg/arm/float_convs.ref
>  create mode 100644 tests/tcg/multiarch/float_convs.c
[...]

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

