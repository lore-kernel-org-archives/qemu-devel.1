Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51241C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE28206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjBa7z9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE28206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORLP-0002KL-An
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 15:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORJw-0001eW-MV
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORJv-000310-Lg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:34:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORJv-00030Y-En
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:34:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id h9so15881739wrc.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DWOgD6jTrW/YsWE5dPkHCjiUisTCTCPSR9WsSDag4gc=;
 b=EjBa7z9i0MAO6949xRQUNpRNzLfOAdUl2GUkkigTFVvZHlvEN8P+YpN7d6tgoA29BW
 j4nnf+MUqLv1H46QRpkBsSvfOOkjbMyYw1lyjC0HeNCKDGyf36ySIyaH0O5QAQqHg1lO
 x7U6YhMbuh1OkXGhE1a6Lx29/LSej4FbI77uMpC6d4LpkxKgalzoQQ/XQE8gjJpGsqGd
 QDYthlJo9ZSh+pMGvqmNdzVCc9J+wvAXD6cS3/VECEKRc2/ifRlr1pR6DY12axlAhxX5
 lwR2Ko6XEE1HOm3BqdUU7+YHi9BiBtAM3b7Px6lFJ4nFF5T0XoEPwjCAOmxKm2yKZTAS
 hllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DWOgD6jTrW/YsWE5dPkHCjiUisTCTCPSR9WsSDag4gc=;
 b=Nl4fafi4jwElSwZLb/Oe0iHfIuBtlq1g8uKaSmmv2D7umVuvY9ggCM4k2Rp8c7ZbUe
 AHt0Dbl2OV7q51oWs8AElJKl6ZVXhrj1sZEonb1DtRUq9tMtVYCmg26bklecNu/udRYS
 T8EMKouMot8U7GfsQpiOO9jrn378nP7a+sECgW1jBj5L6xZ+VlH+gpIbBfD8iGgqj9a/
 YmsgvlAu5RIbZ5MyVK7ihDTJOZ7VrykyP3HXufOgwTcwNnQeOOGpFpnj3D1iyHmD0hTN
 ML3UJyaSjJMUlVC1Sq0ETR4zNvRn8JFMWTDvg2vf6bbpBbk8Tez14VyHdjqi4ZkGGanc
 MPRw==
X-Gm-Message-State: AGi0PuZ3OyIAhaApHlSczvFAUxhdD7iUncErCmpLX+BP02nXRt/XCiT7
 M2HEt/MrgKOevAjl2gQXrSK6jQ==
X-Google-Smtp-Source: APiQypIBvM8qov4ydMW6VICwiFX3lxBU96f76EbVKrSOaERgqOeTPEpXunpcw5eQuQCykK6dLpg73A==
X-Received: by 2002:adf:cc8c:: with SMTP id p12mr25026271wrj.165.1586892846064; 
 Tue, 14 Apr 2020 12:34:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q187sm19983513wma.41.2020.04.14.12.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 12:34:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD7611FF7E;
 Tue, 14 Apr 2020 20:34:03 +0100 (BST)
References: <20200414163853.12164-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v3 0/2] gdbstub: Introduce
 gdb_get_float32/gdb_get_float64 helpers
In-reply-to: <20200414163853.12164-1-philmd@redhat.com>
Date: Tue, 14 Apr 2020 20:34:03 +0100
Message-ID: <87pnc9980k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Fixes for GByteArray (commits 462474d760c & a010bdbe719).
>
> Based-on: <20200414102427.7459-1-philmd@redhat.com>
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   gdbstub: Introduce gdb_get_float32() to get 32-bit float registers
>   gdbstub: Introduce gdb_get_float64() to get 64-bit float registers
>
>  include/exec/gdbstub.h          | 20 ++++++++++++++++++++
>  target/m68k/helper.c            |  3 ++-
>  target/ppc/gdbstub.c            |  4 ++--
>  target/ppc/translate_init.inc.c |  2 +-
>  target/sh4/gdbstub.c            |  6 ++----
>  5 files changed, 27 insertions(+), 8 deletions(-)

Queued to for-5.0/more-random-fixes, thanks.

--=20
Alex Benn=C3=A9e

