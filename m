Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E84DC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217AC20835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2+zFMbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217AC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLkez-0001bx-BD
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 04:32:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkdi-0000vq-C6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkdf-0001lg-AA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:30:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLkdd-0001gl-9a
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:30:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id c5so23819506wrs.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=1z2G2pva/AlfRXM+wJ6i7PE2zWB7jWLhRAd2kznCBFE=;
	b=i2+zFMbG7sWOehLYZsxEQaCZRGqTxkIT7napNeEvZbaNQlcKKPR8jOClZdiMXdAovc
	cOV/t1XfUN1+Dm6pq0umZvBmE/ElcDTsdeVNBr3sDK5yRj/OsgCLjaxYVGpzA9vIZMZo
	+cNxws4QSA+hzhAmQud7uRJkOAHb2yKFEJVb3gQ9YWYBS7C4hFHZdUNA0n7R1+Kl0bvn
	scqQOPKGhIG0H04varqrxzz1K5EPVe0xM1qpYWvANg7L+MArK2vnz69PuibYFCW422Cj
	Ald87q5QZcYgMxtiMe29NHpv5px6VIIXWZPJeHbLMN0hyBtrHbq4Qsep7cyM+G0ka/Vg
	NCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=1z2G2pva/AlfRXM+wJ6i7PE2zWB7jWLhRAd2kznCBFE=;
	b=incAI8iDH8BKwRlXZT83pQDXIE9EgWw3UC7BD5GEMhBa5LNFO0MnrHdkJMf+He9QJS
	9q2EwJWYAHLQ67daQO3zErJK/sWqNTPsa2eOPAMQTBkV/x/VaZcJfQoWV0+W61/WhJKx
	aLBLBdRA//puKvbLJuyeFtFdFbdhTHI+ttQPZyzDAd0UItxXhL67Jv4fOQLRyC4lm0C9
	J7VFU8xEir6UMf+vVK2aDDrVPhdhUiPpIrj863TFFMXA9wk8zLgsvD1kdhl7rGCxXAvC
	c/CrX/CQzab6C4NcTDUmirSHbbg6PXPyyvdWl8vwnDqc5x1j03zBUksXiiqSMf823IWh
	SrIg==
X-Gm-Message-State: APjAAAXBcOp/rhbS7ehXelgyHUlKUys/GLXA8oBDh815xjbnLlKygTct
	sTqtkFdV9+DJ3NTb5AtzRY36Hw==
X-Google-Smtp-Source: APXvYqzOk2txkRw1LIx+gMzxZFmxssHyErJovvQCM6pXSONS3ip734JVYPUTzX6Uvc8KblUdTx2snQ==
X-Received: by 2002:adf:a202:: with SMTP id p2mr14338431wra.166.1556699446600; 
	Wed, 01 May 2019 01:30:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 7sm15356937wro.85.2019.05.01.01.30.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 01:30:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id B1C051FF87;
	Wed,  1 May 2019 09:30:45 +0100 (BST)
References: <155650963851.10667.10736189532511840020@c2072b67cc0c>
	<ec0fad50-140c-0bf4-3421-d4e3d2d12dea@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <ec0fad50-140c-0bf4-3421-d4e3d2d12dea@redhat.com>
Date: Wed, 01 May 2019 09:30:45 +0100
Message-ID: <87a7g67f0q.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic
 iotests during "make check"
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
Cc: fam@euphon.net, kwolf@redhat.com, emaste@freebsd.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, cfergeau@redhat.com, armbru@redhat.com,
	wainersm@redhat.com, mreitz@redhat.com, philmd@redhat.com,
	lwhsu@freebsd.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501083045.kIcD4oEWgJQM3dqFEdvMtW6fZ-bNYntq2U7jvvXNyFs@z>


Thomas Huth <thuth@redhat.com> writes:

> On 29/04/2019 05.47, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20190428155451.15653-1-thuth@redha=
t.com/
>>
>> This series failed the asan build test. Please find the testing commands=
 and
>> their output below. If you have Docker installed, you can probably repro=
duce it
>> locally.
>>
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 N=
ETWORK=3D1
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>
>> The full log is available at
>> http://patchew.org/logs/20190428155451.15653-1-thuth@redhat.com/testing.=
asan/?type=3Dmessage.
>
> The asan test failed since it could not check out the repository ...
> a networking problem?
>
> Anyway, looks like there was a real bug here:
>
>  https://patchew.org/logs/20190428155451.15653-1-thuth@redhat.com/testing=
.docker-clang@ubuntu/?type=3Dmessage
>
> Test 162 failed with:
>
> 162         - output mismatch (see 162.out.bad)
> --- /tmp/qemu-test/src/tests/qemu-iotests/162.out	2019-04-28 16:09:31.000=
000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/162.out.bad	2019-04-28 16:24:=
21.669646149 +0000
> @@ -6,7 +6,9 @@
>  image: nbd+unix://?socket=3D42
>
>  =3D=3D=3D SSH =3D=3D=3D
> +qemu-img: warning: GLib: getpwuid_r(): failed due to unknown user id (10=
03)
>  qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "p=
ort": "0", "path": "/foo"}': Failed to connect socket: Connection refused
> +qemu-img: warning: GLib: getpwuid_r(): failed due to unknown user id (10=
03)
>  qemu-img: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0,path=3D=
/foo': Failed to connect socket: Connection refused
>  qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "p=
ort": 0.42, "path": "/foo"}': Parameter 'port' expects a number
>  qemu-img: Could not open 'driver=3Dssh,host=3Dlocalhost,port=3D0.42,path=
=3D/foo': Parameter 'port' expects a number
>
> ... I think I'll remove 162 from the "auto" group to avoid this.

Should I wait for a v3 then?

--
Alex Benn=C3=A9e

