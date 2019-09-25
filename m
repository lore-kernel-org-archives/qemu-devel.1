Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB531C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5B720673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5B720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFYZ-0000K7-QD
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFXb-0008Jl-R4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFXZ-0000ci-Dy
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFXZ-0000ar-4Z
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:13:41 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D171C83F3C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:13:39 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k184so148956wmk.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tHj0oTc5G74dt1r9vva+vEN5YPRXcL7N8mg9ed9Yw50=;
 b=pFT2U9bZ3o4GcIaCba4xFS99uSgm+mHuxBqeelrlrUO2rP+AtHf9iZHBOTRdBVMt02
 sn4nOi6+xpUltbjttEEPLX2HZDGWZfJG8ZtCQz9n9b26P0DaHOxZydw5JSSYXieGZrIt
 kcMrD5k5IEm20o8QnKDfTRdx6V5QU0JsD/zPhGtw67XwYSndpgJayMXGvgbjLwOeeImX
 pNgHbGCIaOk12APbXldUrqwP6Fcw4VpjTFMT7YmdnK5C+8CDCf7H+HqnaYi8LcEiS4OZ
 WkdpwbzcG4UsOXeQYOgufKGUptz3aSqMgt3xegfOKBPw0jwDUT73XZhYIxmwbAdOaARn
 FZJg==
X-Gm-Message-State: APjAAAVgOcAZD78Wp7PohKfXHw0Pvj007an7W70ap4NHVeIvxhHVVLs3
 few1pYfdc1c+FZWRz/la3OyS+pvSPhI/UdkP9VOYlAMIwkLoMT9SLzsypvLhtRu74gNizSvsmuF
 6m3nA+du59b+9HwE=
X-Received: by 2002:a5d:430e:: with SMTP id h14mr394198wrq.18.1569449618628;
 Wed, 25 Sep 2019 15:13:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsLQQHWi2b8IhUiuQr6usK1DnUfVnoPrNddscxOYZJgylnZ122EwAZkpl91SL7lFtzN3H76w==
X-Received: by 2002:a5d:430e:: with SMTP id h14mr394189wrq.18.1569449618422;
 Wed, 25 Sep 2019 15:13:38 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id a14sm293786wmm.44.2019.09.25.15.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:13:37 -0700 (PDT)
Subject: Re: [PATCH v3 18/33] tests/tcg: re-enable linux-test for ppc64abi32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-19-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c1f4e36d-45f5-4efe-bc7d-c6af23513769@redhat.com>
Date: Thu, 26 Sep 2019 00:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-19-alex.bennee@linaro.org>
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
Cc: jsnow@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> Now we have fixed the signal delivary bug we can remove this horrible

"delivery"

> hack from the system.
>=20
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Can you reorder this patch after directly "target/ppc: fix signal
delivery for ppc64abi32"?

>=20
> ---
> v2
>   - drop un-needed cflags
> ---
>  tests/tcg/multiarch/Makefile.target | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/=
Makefile.target
> index 6b1e30e2fec..657a04f802d 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -12,14 +12,6 @@ VPATH 		+=3D $(MULTIARCH_SRC)
>  MULTIARCH_SRCS   =3D$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
>  MULTIARCH_TESTS  =3D$(MULTIARCH_SRCS:.c=3D)
> =20
> -# FIXME: ppc64abi32 linux-test seems to have issues but the other basi=
c tests work
> -ifeq ($(TARGET_NAME),ppc64abi32)
> -BROKEN_TESTS =3D linux-test
> -endif
> -
> -# Update TESTS
> -TESTS		+=3D $(filter-out $(BROKEN_TESTS), $(MULTIARCH_TESTS))
> -
>  #
>  # The following are any additional rules needed to build things
>  #
> @@ -39,3 +31,6 @@ run-test-mmap: test-mmap
>  run-test-mmap-%: test-mmap
>  	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
>  		"$< ($* byte pages) on $(TARGET_NAME)")
> +
> +# Update TESTS
> +TESTS +=3D $(MULTIARCH_TESTS)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
(via make 'run-tcg-tests-ppc64abi32-linux-user')

