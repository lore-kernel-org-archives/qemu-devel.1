Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07914C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EDD2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 21:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUd6yR/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EDD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYdDQ-0001eG-D8
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 17:13:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hYcu6-0002QJ-MQ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hYcu2-0004x8-VQ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:53:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hYcty-0003lR-PR; Wed, 05 Jun 2019 16:52:54 -0400
Received: by mail-oi1-x242.google.com with SMTP id q186so59831oia.0;
	Wed, 05 Jun 2019 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=XfHKPH+7wVpd9sl6nChvtGjSKkYYwanzDLHVofKGQkU=;
	b=rUd6yR/ngjv0K1A/rVC1N4P8PovK4oVMCgE7bCvJc9QVYSKD7SzCkn9svmeEtldsax
	YHi8C+ZjPE89pssiW3XDeflKYiXrfI09hmohKDuOd1rX60SMLsx41MWVmhvfqykmudBz
	kr+rkaB3umQIcZvdQSlLkqOnj4gGloDalkCJvKDP29vZL2K/mEqCMfsZ/YxnHmNt5GSq
	YBB4Pu/NPLSOt50LVs2ulv+xuAzK3pNTCHcE2/8AlHw1rIMBgjlb4kuO+PBZJ4BKPWbj
	c2UapgiemEY6ZxDGFJ7+gZY2KSKldknruqXuOKNNZeusMjCUF47au2sVgAqLRhBCry0s
	EDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=XfHKPH+7wVpd9sl6nChvtGjSKkYYwanzDLHVofKGQkU=;
	b=d5H9pgbQ1WMzt/1s1ZV0Gkp4LWVCKkq3KaDK4bTpLwUkq9TnbV9qsq+jTGR+azKu3l
	kZAd7vljyPhe/EEh0s9BXWbr/ngFIhz0SHoK5DG8uOA5W5Yubo8AFKVuqJvqtlmk3ucS
	3UQ05AKzxHbditXBgtM4zLMedPmqnCXaDydM06d4R7249oozW19mUr2nOdrxEbgL2N8Q
	fl3F3ee+fLHwkkmsJXqDCtyrgGhgAUBjkignbegDmRjs+iQ+hVvQEoqQ4LohcJtSGz1d
	mb4vVp45d/eMvJYtpxWsxVJWBAq2aRukKS9xe+fhxGy9q+PVZUbS7TTYEhiDA+5pfD+E
	Jl4Q==
X-Gm-Message-State: APjAAAVQCWlbW7ixGrxfBE9Q+9YSpAkvPR2KJUKU7TlArQgfGGF+vEBe
	snj83iT6cRbzyP4xZmKZRgywRYh/xTyb9ra6Cg4=
X-Google-Smtp-Source: APXvYqwB8H3qEIbGDMyv3Y+ZQsGBaurHtG4LPkZGQ3t1dsR8aE7WWe58Q3Afj9XlSNjwvVQyOIEdfJGQq+TGR4Mqnhg=
X-Received: by 2002:aca:abd8:: with SMTP id u207mr9017039oie.136.1559767970411;
	Wed, 05 Jun 2019 13:52:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
	Wed, 5 Jun 2019 13:52:49 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
	Wed, 5 Jun 2019 13:52:49 -0700 (PDT)
In-Reply-To: <20190520220635.10961-2-f4bug@amsat.org>
References: <20190520220635.10961-1-f4bug@amsat.org>
	<20190520220635.10961-2-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 5 Jun 2019 22:52:49 +0200
Message-ID: <CAL1e-=i81qtN5hVkGF=8iBsF-7v6R_f-FafDghjLjqzfgQLLVA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] BootLinuxConsoleTest: Do not log empty
 lines
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Caio Carrara <ccarrara@redhat.com>, qemu-arm@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 21, 2019 12:07 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Avoid to log empty lines in console debug logs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  tests/acceptance/boot_linux_console.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py
b/tests/acceptance/boot_linux_console.py
> index d5c500ea30..f593f3858e 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -37,8 +37,10 @@ class BootLinuxConsole(Test):
>          console =3D self.vm.console_socket.makefile()
>          console_logger =3D logging.getLogger('console')
>          while True:
> -            msg =3D console.readline()
> -            console_logger.debug(msg.strip())
> +            msg =3D console.readline().strip()
> +            if not msg:
> +                continue
> +            console_logger.debug(msg)
>              if success_message in msg:
>                  break
>              if failure_message in msg:
> --
> 2.19.1
>
>
