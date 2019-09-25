Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2119C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4A6205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4A6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFd7-0003Fj-5L
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFaz-00022I-Fq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFay-00053g-E4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFay-00051z-4J
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:17:12 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3445A5859E
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:17:11 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r187so3289898wme.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U32e0gvF+Du/ZMCNJhETOwflhH+X8Ij8z6MlMuQx8ZA=;
 b=dD+3si/TpUnuQAPlB2CtTWbWUz79m+Sgls62iUDPXW61AE5JRMmHHj0RPvXFV5giNP
 WYMZbvg0XMS8qStCz6EjJcoKGLO2DIGWJY3LCRccjAc2BoX8VdsPGQD342cGekQkmICV
 MwmmvebPmQElzL3tbJlTNAJqXN0ILcvMKMn12eSeIGrOrCYEmeC4VmXhFbKj7CbOiulo
 r7JekReJxtQz8HAillJe+19746RhU25U/wNCIhUg0s+Wdz55zZFzDckbdLQVsXP8Ogx9
 kAHBA2a0YJi//Jr/+GFHgv51SpLZ811IIcMKAfQD1JzUE5NrvrcRIGJvDgZB48pkQ6E2
 sYTA==
X-Gm-Message-State: APjAAAU/6VaJ1Z7evZM5nE0S1tOaHFGR3LZH3GU5nkKmDJz9GhcOmhFV
 hF5V/fl5JDk/6rbwHLdS9dCk4LWTE5VBXDjAYp0qJGmXf8yAOG6UHMRaXpP/k5clgMIxcfGV5BH
 MrrS+xJbG4XEgXIE=
X-Received: by 2002:a7b:c932:: with SMTP id h18mr298960wml.86.1569449829924;
 Wed, 25 Sep 2019 15:17:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzqGNPeJhfxnwKih/vyFhjqm6pTEwifF1drsl9TTLK/3Z9VvOjqHWE2M29++NyJoWoYr9o+Fg==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr298952wml.86.1569449829770;
 Wed, 25 Sep 2019 15:17:09 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id p85sm760651wme.23.2019.09.25.15.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:17:09 -0700 (PDT)
Subject: Re: [PATCH v3 19/33] tests/tcg: add float_madds test to multiarch
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8e118a0c-becb-aeb3-5407-4f371945029e@redhat.com>
Date: Thu, 26 Sep 2019 00:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-20-alex.bennee@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, jsnow@redhat.com,
 f4bug@amsat.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> This is a generic floating point multiply and accumulate test for
> single precision floating point values. I've split of the common float
> functions into a helper library so additional tests can use the same
> common code.
>=20
> As I don't have references for all architectures I've allowed some
> flexibility for tests to pass without reference files. They can be
> added as we get collect them.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2
>   - allow tests to add addition patterns to the list
>   - conditional diff-out
>   - use __builtin_fmaf instead of forcing optimisation
>   - use hex floating point definitions and output
> v3
>   - remove add_const stuff, make explicit tests explicit
>   - various style clean-ups
> ---
>  tests/tcg/Makefile.target           |   9 +
>  tests/tcg/aarch64/float_madds.ref   | 768 ++++++++++++++++++++++++++++
>  tests/tcg/arm/Makefile.target       |   3 +
>  tests/tcg/arm/float_madds.ref       | 768 ++++++++++++++++++++++++++++
>  tests/tcg/multiarch/Makefile.target |  12 +-
>  tests/tcg/multiarch/float_helpers.c | 230 +++++++++
>  tests/tcg/multiarch/float_helpers.h |  26 +
>  tests/tcg/multiarch/float_madds.c   | 103 ++++
>  8 files changed, 1918 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/aarch64/float_madds.ref
>  create mode 100644 tests/tcg/arm/float_madds.ref
>  create mode 100644 tests/tcg/multiarch/float_helpers.c
>  create mode 100644 tests/tcg/multiarch/float_helpers.h
>  create mode 100644 tests/tcg/multiarch/float_madds.c
[...]

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


