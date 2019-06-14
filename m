Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE38C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CA421537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+n5DY4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CA421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmxZ-0004Em-DV
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbmib-0008E6-Ev
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbmia-0003Ad-CK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:58:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbmia-00038T-3E
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:58:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so2662668wrs.5
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Gm9TUL/89b34X+XFCL8WVV7OUJKrb7tXBVXQhUIyXl4=;
 b=S+n5DY4FLHxNJcr5tU67AZFWsdigOFsNqiDXN6UELgmeEZmdUsKZMQ0OSSq2/NKjMZ
 ZpJ/MhiT0LGoVexvktOZFidgKNPMPMkOL8GX8CFnavmorxkQZHjbi3+4k4yko7HxUO+4
 FkOOzovf8o8GApajvg86ARMm5PpYffuO9NOjnCMc8Qajp2+TJoa8rYW1nIF6VUyN2Fhw
 APdzYB3bZsc0h3VX1qsZwD6oLz3ChCS3aI2Es0Flea+7HNcNjWXWl75kJj5gDOAzzQ4J
 Dt1d5IV3YVWfc/y8VzKSSz6m1qqZi+TxP87rE+W8t0iKz+2W0vE2JDMlIGgNPwAI+40T
 08Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Gm9TUL/89b34X+XFCL8WVV7OUJKrb7tXBVXQhUIyXl4=;
 b=adSEXV+keKK2U/mH3UDP0NVcILebDEcSm25ddls9Cp55xgtBJCxm33pP5kzxXUMBF4
 L8fmIR0StibROro3SAq0vJKmHieFBknNJzNUEi/D/dIlEG/pmfgxpyhIW1YN72unm+km
 VZWyjVYEf6oUeQH+I7tJgyUroTOEPWuuTPQcDX1dBJvyKYndyAR+CImBrDv9cjlpkrIF
 O75Wc8BSS7VPtNzt4vv1K0wE6pJkUz5jsN7cbTPuh/F+20inHoByHtIFeCF5bE9CtZXJ
 DmiNbjMq3wfI4WFsCN3QOflPEGd5OAxSYjjh0WpMzdwfzN5VB6FWbmcugJAYoxqkEPC3
 +Wog==
X-Gm-Message-State: APjAAAW749YnHfn5o94mxQaPJ6B4WFId1empIE1l9/avDMdqVvzegEQg
 0R21V3Gd9wofTm3QbsdSc8hWvg==
X-Google-Smtp-Source: APXvYqye4yXbWWjDC5CM3RYdmb6uZhxl+8XVQObrBV5UccCR9yuhP3klWbUqDjn9Fj+PuxTiUzTSdw==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr18828559wrp.245.1560520690243; 
 Fri, 14 Jun 2019 06:58:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v204sm5012941wma.20.2019.06.14.06.58.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 06:58:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 428D81FF87;
 Fri, 14 Jun 2019 14:58:09 +0100 (BST)
References: <20190614072432.820-1-philmd@redhat.com>
 <CAFEAcA9zEKePcOHK6WMqAitf282EWh5LUYRqZ3oAJ_W1wPsohw@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9zEKePcOHK6WMqAitf282EWh5LUYRqZ3oAJ_W1wPsohw@mail.gmail.com>
Date: Fri, 14 Jun 2019 14:58:09 +0100
Message-ID: <8736kce0b2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 0/6] configure: Try to fix --static linking
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 =?utf-8?Q?Daniel_P=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 =?utf-8?Q?Lo=C3=AFc?= Minier <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 14 Jun 2019 at 08:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> Apparently QEMU static linking is slowly bitroting. Obviously it
>> depends the libraries an user has installed, anyway it seems there
>> are not much testing done.
>
> The main reason for supporting static linking is so we can build
> the user-mode emulators. Almost always the problems with
> static linking the softmmu binaries and the tools are
> issues with the distro's packaging of the static libraries
> (pkg-config files which specify things that don't work for
> static is a common one).
>
> So we could put in a lot of checking of "is what pkg-config
> tells us broken". Or we could just say "we don't support static
> linking for anything except the usermode binaries". We
> should probably phase in deprecation of that because it's
> possible somebody's using it seriously, but it seems like
> a fairly weird thing to do to me.

It would be nice to have a --static-user config flag and deprecate the
--static flag. I don't think there is a decent use case for system
emulation targets.

The Gentoo ebuild currently jumps through hoops to build QEMU by doing
the build twice, first for softmmu targets and then for user targets. I
suspect all of that is mostly to handle the reasonable "static-user" use
case which is what people really want*.

*I'm guessing

--
Alex Benn=C3=A9e

