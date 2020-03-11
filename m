Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B9C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD594208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpvaY9IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD594208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2EA-0003uc-32
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1uD-0004Hc-8Z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1uC-0006UM-8k
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1uC-0006TH-0u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id a25so2778819wrd.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EJ8l74UHFox+uXHqAoEMtrjV6J+RCNSdy/uZaeqlAT4=;
 b=GpvaY9IBvh3/BQJydllHkTu0DLwVo/O/T+HbQjC5u2FBTEMxLHGmMaCChbZipDlEA7
 EajzGeydqKOpJJOo0+vOvThYUGgJ0XOpFyY/Yd8kxBdCbI1aoVZzPATbXvqwikZdZocS
 ZDuyqhIej4MvNsYCq1SMF94yJvMRvzRRhQubmYCfn1bZS2iC18fQjSixYS4mMnShJMQw
 dgogvLQoBwatilfZFLsWv1zkRUknfKcskKTQrPZFi/NobRUYRONJouJ2IUaHbdzmecEa
 dc07lwYK+bc2tLlQ74aaIAxUt1uNVfe20K+HUnbqpDIo7KUN2Gbcgp3GACoz82uHht+8
 vJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EJ8l74UHFox+uXHqAoEMtrjV6J+RCNSdy/uZaeqlAT4=;
 b=U3XBHr9rPnnnuiie4r7C/bJwPwCixgWZTcMpw2g20rWdRndi9i3qqBdpUIkqKu2mMH
 g49LpmwQ0gJ9Bp4vm+tbwAsXpJ2jDbpiixVcUvdRxgQF6plK0PER2etoWv775hj/S175
 77IEMxyeLo23AqcWQb3LI+bM1SgeMIwzPEwmktmXFEVkaZFbQGI6yT5PjpZIpLTZDZ9a
 ztEeeYQ71mY76jUhVebtogfp/8NKNK8G5FFpI5eNXF8viOQ/u35xoulSII3LXYI9QuXW
 kZYgSrTdLvjkqc3y3fYx3EBL74Ty1Ura8D0xkoETABnf7PVAMdCXTltdAi32h8uEfALr
 lWEA==
X-Gm-Message-State: ANhLgQ1/3QbVG7gyyAiKNMHPJew5XR/KAD3aXkNUePcM4bVnCJFg3XU+
 ps7cwXtXFtCJ2k2CbW+lKDdDfA==
X-Google-Smtp-Source: ADFU+vtz51NvybQ4R0pjKxzpI2r01ZmvebAqHCViZFE0gTf06Kcz06AjSraazltkjOehYZ7eSm2zzQ==
X-Received: by 2002:adf:80af:: with SMTP id 44mr4710671wrl.241.1583935214991; 
 Wed, 11 Mar 2020 07:00:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm49715581wrm.3.2020.03.11.07.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 07:00:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 649F21FF7E;
 Wed, 11 Mar 2020 14:00:11 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-19-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 18/18] docs: add Orange Pi PC document
In-reply-to: <20200310213203.18730-19-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 14:00:11 +0000
Message-ID: <875zfbgff8.fsf@linaro.org>
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
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> The Xunlong Orange Pi PC machine is a functional ARM machine
> based on the Allwinner H3 System-on-Chip. It supports mainline
> Linux, U-Boot, NetBSD and is covered by acceptance tests.
>
> This commit adds a documentation text file with a description
> of the machine and instructions for the user.

Awesome to have such comprehensive documentation for a system. Thanks
;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

