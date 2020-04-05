Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B3C2D0F4
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 14:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD6720672
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 14:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z2cUb9LN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD6720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL6RH-0005lf-TY
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 10:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jL6Qa-0004uQ-KD
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 10:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jL6QY-0006M4-B3
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 10:39:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jL6QX-0006KS-Cr
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 10:39:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id v2so12615588oto.2
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q212yT1sdwQ08ug0FmeO2jX/DQ4CmYtosdDT8mdr/U0=;
 b=Z2cUb9LNLsGeFsVWNnIsaOmIcrScAjN2oBUzuXYgJPju4872q8DiPZApS1zacLOHVy
 YDsFmOgybRM0OMQF4aIxLJq7AIOkcHOc5jjajxHeBU6hYzOyxFDJA8F3vkf7pKJIqOqk
 9P+Eo2P92iFvg7Ng+/Cc/DenDcpvFSXaJrLE+LqqhH1lMPOKaX5QV6w7n6rOi6OWLeNO
 LJguy/Sdc5N2GGgf1pFYTIV7MR48kClJwOI0Oj3ln3CSxMWNuiOJu0ze5vCNIfsZLRnC
 1DHNZeXSLhSFQu2NwheTObkEv6n8BxrhDiGa9ZlAyjn4ccE2dRhVQkgUwJCTzaxAf+cS
 779g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q212yT1sdwQ08ug0FmeO2jX/DQ4CmYtosdDT8mdr/U0=;
 b=ANA2mXfUWE0Agexq3i08+dNeLK13ewQX+oJ+Ps58OFHtaODuOhH77oTt52SRIfILI/
 e0jCMqjwAKE336+s9FHeswumCLrsF75yB56LwlR1p88mHvObBzOx01IS3bCcYchHACFz
 HGyf9hC2N5Eu6xW/yFki5XsHzvzoLGojgtgnGl7Pex7VcTh8JhELHDs1W6nUmXnAHmmT
 tn/eT25ehOameL2Cqw6fbaNNhHdjVsFMBTCg8f+py8nBDvQDFsarQLP4VFLi95XLVY5B
 KfCR51JU89DrEyNwt3UtZwYfzPCWj59MqHalyKPL/xZnjHQMBS6Kh4cWmRhCtgYa0Ydb
 6Odw==
X-Gm-Message-State: AGi0PuaLgphtH/ED5qzjbqsmTQXTSKrsSKOuDOIeWwW1jpzGiA8bhek8
 6phLVUqw2yGZPRCCvMNxGzakZNmjO73+2E51Fr5CoQ==
X-Google-Smtp-Source: APiQypLmndG68Tg8wJCAiFevAXkEV8bpPO0E/HxCyVFkCPXPNLHvyuIT63D4j6rIhqV/EQaW+nlCWJViRLjXp+3IjIw=
X-Received: by 2002:a4a:a226:: with SMTP id m38mr14154866ool.94.1586097546307; 
 Sun, 05 Apr 2020 07:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200403135306.665493-1-berrange@redhat.com>
In-Reply-To: <20200403135306.665493-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 Apr 2020 15:38:55 +0100
Message-ID: <CAFEAcA_CSiw4ojYHVD6S73O-iRuXt6gTS=3VdAO545q8ye0+Ww@mail.gmail.com>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 14:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +if test "$in_srcdir" =3D "yes"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DIR IS DEPRECATED"
> +    echo
> +    echo "Support for running the 'configure' script directly from the"
> +    echo "source directory is deprecated. In-tree builds are not covered=
"
> +    echo "by automated testing and thus may not correctly build QEMU."
> +    echo "Users are recommended to use a separate build directory:"
> +    echo
> +    echo "  $ mkdir build"
> +    echo "  $ cd build"
> +    echo "  $ ../configure"
> +    echo "  $ make"
> +    echo
> +fi

So here's my stab at some text here; I'm aiming at nudging users
towards out-of-tree builds if they were simply not thinking about
it, but not actively marking them as 'deprecated', since it sounded
to me like we were planning to keep at least the basic
'configure+make+make install' sequence of commands working.

echo "NOTE: we recommend against building in the source directory"
echo
echo "You've run the 'configure' script directly from the source"
echo "directory. This will work, but we recommend using a separate"
echo "build directory, especially if you plan to work with the QEMU"
echo "sources rather than just building it once. You can switch to"
echo "a separate build directory like this:"
[instructions go here]

thanks
-- PMM

