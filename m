Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02903C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9D120661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtlkuSd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9D120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54531 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Zcb-00033q-05
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j1ZW0-0001NQ-Gu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j1ZVz-0007nM-E0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:40:04 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j1ZVy-0007jz-KW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:40:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id g3so12401274wrs.12
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Noqmg8cfjHwzPPaplaraDi7BhzESC7+sjf6K+biuZhM=;
 b=QtlkuSd7yE12W4PWDNQzeFTPIKiyMKrNhmIv7nzOIr4uAfqUto7mcK4Hg8QqT5Ermq
 TjgwjUPI9ViFU+JKkFXsjthrqe1srKtcyT4mFbtGhWecgFJCqLGpjtjXKDpryX1a2ruk
 OvczoaLjExveCmSgDfqTIgjju2XhCKzxo3fYLRaZlcdsSGE78mv7SCAi5wTVQyxrYAo+
 kSFsZRNWayThkeQCOIw9RCBU1MTIFdN+mCaH2ldJPdAnSbgBvXiiVPSrGsC0iIPPsCrn
 X1LmY5gXSr64tMgNM09lJdsQSyCkOgaBZdwAsqJMwcHQG/Qqzz/FeaSdnycyoX0qnlYp
 9PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Noqmg8cfjHwzPPaplaraDi7BhzESC7+sjf6K+biuZhM=;
 b=IFkeBK3JvsKofKipyO/48WrnfVFWd/yUH8d/T1uxRljZWp7C8YyQftCMnhuixCJWP3
 Tv8hyNHeGrxSFIDMLpNFSnfBUmi1/hlpkKp5XdyFapetRoOAtJQ00Fw6r+Nvwspp0c2s
 ivVf2xlD6YuDCaCk3mMG5g/kRqMN6UM2KL8xKVrcOZ9gl2pyISKm6FP5QVhVLKmPSmqm
 WRE3WS8h8EIGFAhm9nTl0k4rmA3+DTORTQkI7kAkAOBX3NWhT+AzbWNu+BKISFyq5aMl
 EabwiOBaeaGnkW3UJFsZmnNBVYrnbrU7Cj7dbjmnlw9kETdP62PNU7IGkq+jlZH+az4I
 fH1Q==
X-Gm-Message-State: APjAAAWnnPhcAgnEMap55Tk/xT/ptdomS64DECT/sFS87wYzBkmiv1Cc
 2R1TKDPGLjfr31iPoXWJhJttFg==
X-Google-Smtp-Source: APXvYqyQa2MNqC8Ysve4VGRi0dHffUp/QDzZi8NkvJsC5QCeTTc3Q2YZHPfwaL47iYyN6DJoAwYuBw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr10283320wrn.292.1581442801122; 
 Tue, 11 Feb 2020 09:40:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v17sm6024754wrt.91.2020.02.11.09.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:40:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 67DC41FF87;
 Tue, 11 Feb 2020 17:39:59 +0000 (GMT)
References: <tencent_BC7FD00363690990994E90F8@qq.com>
User-agent: mu4e 1.3.8; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: wuchenye1995 <wuchenye1995@gmail.com>
Subject: Re: A problem with live migration of UEFI virtual machines
In-reply-to: <tencent_BC7FD00363690990994E90F8@qq.com>
Date: Tue, 11 Feb 2020 17:39:59 +0000
Message-ID: <87sgjhxbtc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: discuss <discuss@edk2.groups.io>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 zhoujianjay <zhoujianjay@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


wuchenye1995 <wuchenye1995@gmail.com> writes:

> Hi all,
>    We found a problem with live migration of UEFI virtual machines due to=
 size of OVMF.fd changes.
>    Specifically, the size of OVMF.fd in edk with low version such as edk-=
2.0-25 is 2MB while the size of it in higher version such as edk-2.0-30 is =
4MB.
>    When we migrate a UEFI virtual machine from the host with low version =
of edk2 to the host with higher one, qemu component will report an error in=
 function qemu_ram_resize while
> checking size of ovmf_pcbios: Length mismatch: pc.bios: 0x200000 in !=3D =
0x400000: Invalid argument.
>    We want to know how to solve this problem after updating the
>    version of edk2.

You can only migrate a machine that is identical - so instantiating a
empty machine with a different EDK image is bound to cause a problem
because the machines don't match.

--=20
Alex Benn=C3=A9e

