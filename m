Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72775C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C69205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C69205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFbr-0002Bw-3D
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFaR-0001fE-3V
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFaP-0004DD-PC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFaP-0004Bf-Fh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:16:37 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D3CF88305
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:16:36 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 190so147802wme.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bn0UW9x0IX7FA4VQCZolqZ5d4cez3KZe3AfY7VNlXrY=;
 b=tPrqGVBJxrykfawHwFs4cZ+XFOyu2QUA2oAzRJMsjafty9BSY/sSOMlEuf8Ux9nlzD
 sL1+5k69flX7Xwn5KCRmMYp2yY9oMCIXhU+dDwNd+O3wLbwl1IX8+WLbNk9iQYMqUJmS
 qfVv1X48B12y2LCec8GJB/trl8FMmK7Hytbo8heb68aVhKqNce99lOU4ezBIw4s4Y2Wc
 X1Wnb7XkpDHzhegonp8kOIvNvGWNmIwQhdkzsUmKvSAgEHVwe1ucuBi016nz8HiHxs/P
 zDKLYjtRESdZhpjdJqtrmfg5TdPWjoVtTUYxct7QBsq/KwWHMdkwubJZUurLJjdhgTv+
 8pmA==
X-Gm-Message-State: APjAAAWCpKShUgAbAuECbq3LoTo+nu46PRyj+xYKIW5z5B9AxV5RQ7qi
 SYcVk27Mw/DOnB1XIlNP6FgkGApl9Jxau+e05PKPua0jjv5HGUSeUpVAd0W+bHHvzsXsOHfteHC
 QdY1Osegcn3O6ghc=
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr345888wml.40.1569449795108;
 Wed, 25 Sep 2019 15:16:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxU6w5HLaIiMEEyh53uV1dkqjJR7SFdfLrk5phSpFkxnUUXaHk6A/O5IiI8X0YZN1kA52nXBQ==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr345877wml.40.1569449794869;
 Wed, 25 Sep 2019 15:16:34 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v16sm315588wrt.12.2019.09.25.15.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:16:34 -0700 (PDT)
Subject: Re: [PATCH v3 23/33] docs/devel: add "check-tcg" to testing.rst
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-24-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <50171b61-9f14-f0af-77bd-a26fa3bd6eff@redhat.com>
Date: Thu, 26 Sep 2019 00:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-24-alex.bennee@linaro.org>
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
Cc: jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> It was pointed out we haven't documented the check-tcg part of the
> build system. Attempt to rectify that now.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/testing.rst | 62 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index bf75675fb04..1feee3ad101 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -266,6 +266,8 @@ another application on the host may have locked the=
 file, possibly leading to a
>  test failure.  If using such devices are explicitly desired, consider =
adding
>  ``locking=3Doff`` option to disable image locking.
> =20
> +.. _docker-ref:
> +
>  Docker based tests
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> @@ -799,3 +801,63 @@ And remove any package you want with::
> =20
>  If you've used ``make check-acceptance``, the Python virtual environme=
nt where
>  Avocado is installed will be cleaned up as part of ``make check-clean`=
`.
> +
> +Testing with "make check-tcg"
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +The check-tcg tests are intended for simple smoke tests of both
> +linux-user and softmmu TCG functionality. However to build test
> +programs for guest targets you need to have cross compilers available.
> +If your distribution supports cross compilers you can do something as
> +simple as::
> +
> +  apt install gcc-aarch64-linux-gnu
> +
> +The configure script will automatically pick up their presence.
> +Sometimes compilers have slightly odd names so the availability of
> +them can be prompted by passing in the appropriate configure option
> +for the architecture in question, for example::
> +
> +  $(configure) --cross-cc-aarch64=3Daarch64-cc
> +
> +There is also a ``--cross-cc-flags-ARCH`` flag in case additional
> +compiler flags are needed to build for a given target.
> +
> +If you have the ability to run containers as the user you can also
> +take advantage of the build systems "Docker" support. It will then use
> +containers to build any test case for an enabled guest where there is
> +no system compiler available. See :ref: `_docker-ref` for details.

Maybe you can add a line there is an easy way to run all tests for a
single target using 'make run-tcg-tests-$TARGET'?

> +TCG test dependencies
> +---------------------
> +
> +The TCG tests are deliberately very light on dependencies and are
> +either totally bare with minimal gcc lib support (for softmmu tests)
> +or just glibc (for linux-user tests). This is because getting a cross
> +compiler to work with additional libraries can be challenging.
> +
> +Other TCG Tests
> +---------------
> +
> +There are a number of out-of-tree test suites that are used for more
> +extensive testing of processor features.
> +
> +KVM Unit Tests
> +~~~~~~~~~~~~~~
> +
> +The KVM unit tests are designed to run as a Guest OS under KVM but
> +there is no reason why they can't exercise the TCG as well. It
> +provides a minimal OS kernel with hooks for enabling the MMU as well
> +as reporting test results via a special device::
> +
> +  https://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
> +
> +Linux Test Project
> +~~~~~~~~~~~~~~~~~~
> +
> +The LTP is focused on exercising the syscall interface of a Linux
> +kernel. It checks that syscalls behave as documented and strives to
> +exercise as many corner cases as possible. It is a useful test suite
> +to run to exercise QEMU's linux-user code::
> +
> +  https://linux-test-project.github.io/
>=20

