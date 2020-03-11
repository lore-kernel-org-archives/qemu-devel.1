Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24ABC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C68720727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVqdhiQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C68720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2BF-0007Y5-Qs
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1vt-0007FH-Hv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1vs-0008Uq-F4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:02:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1vs-0008U1-8e
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:02:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id t11so2780785wrw.5
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8EnQ9QwJ8hW5FwkQWzb9Lb3/UiCf1LYBCAuEW3vtE/g=;
 b=PVqdhiQ+8NbCQptbanxGtnEs0N5kuG8tdV+yboKrDvxbc+gNnolfbJknO10LMG+CyG
 hwcySwQcV0INcwBN/SSZ4JZzCKzI4lIxbfw7WkeF0HRTU9kU6GtZxhfHEI2tHFBRGbwD
 qTgQBl9w96LCrmlrXh3vUgd783BaRb7TYZnyozeTMTn1pFxlrWfKtq2UdQv3jlZovrpY
 ryjml7CwovwHtpnwZ33KAGjSCR1R6lbwP8J3FbPTV48GiS7s9IuUIFLTAcHUuOztY2O0
 IipoAS5v3068qdeR92YsSumXZoka9f8O593sBzSkShvl+ru5FszcPWeGvBLUd+x2VTDG
 x6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8EnQ9QwJ8hW5FwkQWzb9Lb3/UiCf1LYBCAuEW3vtE/g=;
 b=BdTXBOg9oMSeLKzvef9Rg+SpMNIrix34tVH/aWlW2EyLG2g5huc+YqwAEQcRpkFulz
 lnDphULvrGuxTDXV7DhR/LaNShwajpYkq4X3lg1QO3dv3uQflpe7GoZIhSxPw7BOacgf
 PXwIR8JNrxyNuHkpjVagGsoNLu/EIWdJG2DXgwE4T/RJu5dAPs2ik28u0HdDMr12qGeh
 ButTTCFI16By3t9GOQ+iuhXN/5ubxV7qBLfopsnpuNeEenocOrkyk9LBEOSWeK5dQRFC
 3nUlrV8EPM0TXGSdJjuv/TgJTsVWYdBxOc52N12NgbbQDWGLTptCQze5tC4Z0+2vVke0
 g9nQ==
X-Gm-Message-State: ANhLgQ2Il86Nt179a2Of/n+onQe7GjfjjMO789OTxIwXXZ6XrpY/sPLh
 6gKuRoxbEdiMMstOsU9r1AdoTg==
X-Google-Smtp-Source: ADFU+vsp2Af1E/nQPG5vt+2FV99ndSJLvjtOPjXvGI+sW3jLNiq7Vjn4n5pjPRivtP9y8mhJ9u5N5Q==
X-Received: by 2002:a5d:6282:: with SMTP id k2mr775161wru.401.1583935319318;
 Wed, 11 Mar 2020 07:01:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a199sm67654wme.29.2020.03.11.07.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:01:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 879BB1FF7E;
 Wed, 11 Mar 2020 14:01:57 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-17-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 16/18] tests/boot_linux_console: Add a SLOW test
 booting Ubuntu on OrangePi PC
In-reply-to: <20200310213203.18730-17-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:01:57 +0000
Message-ID: <87tv2vf0ru.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
> This test boots Ubuntu Bionic on a OrangePi PC board.
>
<snip>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

