Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C85F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6Szs8fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C85F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2lQ-0007zs-HE
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv2kp-0007ae-27
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv2kn-0008UL-RF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:28:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv2kn-0008Tm-Hx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:28:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so2957003wru.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IjXXNrYHdgCLaO6rOPneUH6jRsPdfBXF8YEi0thCcro=;
 b=X6Szs8fNwgqh7rMQHG9N4J1NzVOP/Y6wPxQBUiBAXboCIo+O5MaMYIL+9oIgBuZzfh
 3MZS8O2EHuRY7FUEpTS1YuP03PpVvw3K9TVttwIWdGT2Vez7AcINuDxCqG+xEFY1JWGb
 tbVLI5pyDo1H5MMK9Jwwv1afemL4zX5GCChRXTE0ngDM10zUbixsRmumdIYtV3ULqDYP
 24WOEjCnBNbLBu+uroDEZ1bHapFFodUX0K3GV22MOSBSGFYWmDO4YApLklWcRH41h3Es
 UG0j4YXS8xvzBz5K0MMKbg8u0N4srD2AGuF22K/HxBIpwI4qmD0IdRR+C/zrNnC8fEbW
 KkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IjXXNrYHdgCLaO6rOPneUH6jRsPdfBXF8YEi0thCcro=;
 b=ks7whci63mMe+sGBxaZv2cPrw/dcxmiD54Y9jOyWeDcBRDqFAD9o3ozkMIhgTyC/Td
 64Sz/rLcsgpwGw9jnAi70rE2+CEKiv9ud1oV4nuuBNH+x8ggIyeJEA1RViNiIUiEr5sD
 H40NX9O1pVdinEVMaF3AuQjy63zsdusQFni9Z3MtF2K+NxIhwk7jK7WsGURLuYBKc6u+
 fHArvGCYtn0I2bVbm+5xMHpYlohfmpEIM7N1KKKyhCI4AUU3XpBood5ygHO3UDCIKcA4
 LMX6Vw4o/h5qfI7xQWe6yzQmS81qMSKzAX6N0gYZNOWvdFU3O0Y6rEOExeewKDV2Ak8D
 ry9Q==
X-Gm-Message-State: APjAAAVhM9B+ZGzmEEupRSob48+eRr8HI9U5VlLQmcya2utVm9g5gvlU
 nhdA9aBB/Y9vWce+/Dd84lfSWw==
X-Google-Smtp-Source: APXvYqwRQeOgOaKDK9c7Gg31gzDogkx4/t/PHx2T6eXf1zLvYmy/6ApeOaMI9KJqlUl0XbqAXirTjA==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr5266758wro.51.1579886900191;
 Fri, 24 Jan 2020 09:28:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h2sm9026607wrt.45.2020.01.24.09.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 09:28:18 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 44D1D1FF87;
 Fri, 24 Jan 2020 17:28:18 +0000 (GMT)
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-2-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 1/8] tests/vm: Debug mode shows ssh output.
In-reply-to: <20200124165335.422-2-robert.foley@linaro.org>
Date: Fri, 24 Jan 2020 17:28:18 +0000
Message-ID: <87blqsahn1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Add changes to tests/vm/basevm.py so that during debug
>  mode we show ssh output.

nit: space

>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/vm/basevm.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index ed5dd4f3d0..991115e44b 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -122,11 +122,16 @@ class BaseVM(object):
>          return fname
>=20=20
>      def _ssh_do(self, user, cmd, check):
> -        ssh_cmd =3D ["ssh", "-q", "-t",
> +        ssh_cmd =3D ["ssh",
> +                   "-t",
>                     "-o", "StrictHostKeyChecking=3Dno",
>                     "-o", "UserKnownHostsFile=3D" + os.devnull,
>                     "-o", "ConnectTimeout=3D1",
>                     "-p", self.ssh_port, "-i", self._ssh_key_file]
> +        # If not in debug mode, set ssh to quiet mode to
> +        # avoid printing the results of commands.
> +        if not self.debug:
> +            ssh_cmd.append("-q")
>          for var in self.envvars:
>              ssh_cmd +=3D ['-o', "SendEnv=3D%s" % var ]
>          assert not isinstance(cmd, str)


--=20
Alex Benn=C3=A9e

