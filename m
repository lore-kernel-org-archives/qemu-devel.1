Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B3CA9EC7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E6A20818
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 08:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MN5jr4ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E6A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRu1Q-0006lC-PZ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 03:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRu0a-0006Cs-3R
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 03:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRu0Y-0001D3-ID
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 03:16:11 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRu0Y-0001Bs-AU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 03:16:10 -0500
Received: by mail-wm1-x32e.google.com with SMTP id z26so6541913wmi.4
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 00:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pz6NCRSrqLbjvY2Wj3fxrpPEduIrQL6aoWd5/f8EqWk=;
 b=MN5jr4eyOeo5D5os8lF4tuHxZZNT29rabArJvMSnAE771dhOLpZpL9zEXwteD58VR9
 wdceCOLpvMwE+hgzxRMvx+0Mwp2245GnjXmxxjcqh++2zJfeSOVHZ/9aVB+hlEjOHSer
 QJhOq0GFHOD+3LhxK9c2nr1CW3qICP/a9RUiEBCCl9gwVQjCXPtAudv6qPKuTTcOAljP
 uWvZc3b5hjKCCrzNtciL6mmRJzX4aBj+gvy2vEMTF9asq7Dr8JWWi/4RFuKT6P2h6kNr
 SzljWPCb21ZHh0Sn67G3vxmaN35wOimgMaVV9jTbFKs8tgPDQAJF++0mMEamDhD9Jrfj
 e+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pz6NCRSrqLbjvY2Wj3fxrpPEduIrQL6aoWd5/f8EqWk=;
 b=RETBqO7xknIlKdnZPmutGXD6wbPZHzJYUYJxSwkOiB9cNLBe2Fvq5YWQG6yw+7qe7e
 Jvag2n8n3z5GGvOrQdYjrxQf32U0PPqNOOxAg1IZns+6bMuZIV7pF0SboiZ6dcMNuh/K
 5NvQC/Yf5jsZUJIlHxE4XUrUnFsfZE0ky4MA1dGBgJr78cOND7WNW3UmFs/WlYveSsFi
 zAhXt6JHxjXfysstwTGOdevlzt4Qbh3F9A3kLA7CrR/Sx4G483b80dfkVI4XfjviP4Jf
 NAQ8sRIs7ayV4z1ur2czyM7S/FirloofBZ2mybD4gEem51FysoxDYRLPTVI30R8wuDxp
 f0UA==
X-Gm-Message-State: APjAAAX/bXUSBpBoXk3BnkOmvoYQnzFbpxQSfmHu+B7S1/QKjDwu8yXi
 6TEAmPC9HfkjmmFDr7eWSiRJGQ==
X-Google-Smtp-Source: APXvYqxDreqS1U+iXMt1UVCp74zllZfh1FPcRTDZ+RsnX1aD8zeBYhso26LqLHjko4Rh/ohb5ZzQxQ==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr2840521wmj.125.1572941767488; 
 Tue, 05 Nov 2019 00:16:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w4sm5657709wmk.29.2019.11.05.00.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 00:16:06 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA5221FF87;
 Tue,  5 Nov 2019 08:16:05 +0000 (GMT)
References: <20191104185202.102504-1-dgilbert@redhat.com>
 <157290359988.27285.16497763825853147226@37313f22b938>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] global: Squash 'the the'
In-reply-to: <157290359988.27285.16497763825853147226@37313f22b938>
Date: Tue, 05 Nov 2019 08:16:05 +0000
Message-ID: <87ftj2kabe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru, dgilbert@redhat.com, laurent@vivier.eu,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20191104185202.102504-1-dgilbert@re=
dhat.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>   TEST    iotest-qcow2: 009
>   TEST    iotest-qcow2: 010
> **
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:wait_for_migration_fa=
il: assertion failed: (!strcmp(status, "setup") || !strcmp(status, "failed"=
) || (allow_active && !strcmp(status, "active")))
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:wai=
t_for_migration_fail: assertion failed: (!strcmp(status, "setup") || !strcm=
p(status, "failed") || (allow_active && !strcmp(status, "active")))
> make: *** [check-qtest-aarch64] Error 1
> make: *** Waiting for unfinished jobs....

That's one I've been seeing intermittently on Travis since the
softfreeze started. It was masked by the other regressions which are now
fixed.


>   TEST    check-unit: tests/test-bdrv-drain
>   TEST    iotest-qcow2: 011
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dacf3f0f780e741e6a5c367dda157d023', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '=
/var/tmp/patchew-tester-tmp-_ad8j8yg/src/docker-src.2019-11-04-16.29.40.744=
5:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' =
returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dacf3f0f780e741e6a5c3=
67dda157d023
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-_ad8j8yg/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
> real    10m19.416s
> user    0m7.957s
>
>
> The full log is available at
> http://patchew.org/logs/20191104185202.102504-1-dgilbert@redhat.com/testi=
ng.docker-quick@centos7/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


--
Alex Benn=C3=A9e

