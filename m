Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8617C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B437321D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfdQhY9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B437321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC27r-0000yV-Sg
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1v6-0005zL-Cu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1v1-0007tP-GQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1v1-0007sv-9H
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:01:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id v9so2742313wrf.10
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xCrHuwTsY4ruG0qePikD+4nKRFPnMgp6IrrwqOlHWk0=;
 b=kfdQhY9oGpOBeckESy+5SpbVdSId9OJjvO6+5422IRu+GvgBiVnQPC0y26CTR4dKNz
 Typ9kPTS/CsvNqnd06dgCZgiMTeXDvU/vpVoYFT3oLNime2J2+/9I2b2W+1z5lVmqBfS
 CpMfO/8AdROjydpA4AxO8f6nz8yDcGeOnX08HegmgcXpTEfyn+0kosqUNuqz5YNtjU9G
 4nIPS7onT2FFgB99qX7gzg4sPhSP/b8I8XXERWJcYbk6RndY1CuOV91eQz5g1iUE17GX
 QxSHkUaRjRSWzKVVfE0uXcbfVq/B7HzqWgJbpbTaCUKCrUTXU5rEuz82OCt4nRNTvWtW
 /zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xCrHuwTsY4ruG0qePikD+4nKRFPnMgp6IrrwqOlHWk0=;
 b=E8SlvchUGfoX8G7SLBY3+a4KxRoySVqrhZJaCEj38HOH7KP6hfpyeUNHxzj7dHD5sZ
 ZI129kf5qvw3dTFdJ+JQxu9RpqtqV/sz5R7Q2GRzxvMyi2cFNugB8SlighzpnzdpYPtS
 4crzB70tQwjgDQ5Jdhr+/pYEn9wZJaK2NKNbsTz3zjXUJIA5R+slbQSIliuX9W6e0sit
 ojNZkeFmau4fPMxzhsf3KmKDUVowL8tKYaCuilfotn7rWNdjveMtxC6SSxjluPbvHr3b
 CRpAZ7uyIffdf3XH1iyhotAIaHi35hQ74AGiAq7dvO80OK3XtgN2Z087WZUTV4j/T9ha
 RsAQ==
X-Gm-Message-State: ANhLgQ1H+cGrsn7Tp09CsZ9GAQWNuYPpWNjsYbQYw+FunSxMeWUKLxkR
 duYHIx06tre/pJYYsSPmpYOREA==
X-Google-Smtp-Source: ADFU+vvDXp33Bv896lRd9TQWVkyOjg2Gk6TIFvvA5yqmk7c/Q0wKWjHjdCxapQoNrbhlWsPf50EOSg==
X-Received: by 2002:a5d:6610:: with SMTP id n16mr589570wru.405.1583935266368; 
 Wed, 11 Mar 2020 07:01:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b6sm13416697wrv.43.2020.03.11.07.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:01:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 609A91FF7E;
 Wed, 11 Mar 2020 14:01:04 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-15-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 14/18] tests/boot_linux_console: Add initrd test for
 the Orange Pi PC board
In-reply-to: <20200310213203.18730-15-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:01:04 +0000
Message-ID: <87zhcnf0tb.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, b.galvani@gmail.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> This test boots a Linux kernel on a OrangePi PC board and verify
> the serial output is working.
>
<snip>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

