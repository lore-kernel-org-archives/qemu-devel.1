Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF236C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9FF2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEnjBMOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9FF2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPBF-0007UQ-Q4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1joPAL-0006n8-GV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:31:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1joPAJ-0000Ke-OU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:31:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id q5so5279975wru.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uiH2pe6Mx5wDiNI66YfsS+S+i5Wj2zPOfJ+VYjMbUrg=;
 b=AEnjBMOc32Qr/Abta+TVDNJFfQpgnKe899dx4FfHqpjeUP6Fdom0y5HMBzQjJ2/e+7
 /zLBB9fVhpC74FtyYzZ9L45vBsTZo159wlTB0w5l1eSPJKJzcwj20RD7O1gxlnJXVn6j
 x39NroD3OvcUI+YFzvUqDZ8LxZd+UVnSyUs/j21g0iI5g2mZRLyfYAVI9i0JBmQS0q4q
 OasBt45mIeH+H43xqtigIJ3kbq8P2LZoHSbl8KaGXtMrgxt7SMla3DTa/QA9b740XA0f
 wALIPOymoLpldjtNgMxsd8t/hWdO2p2uR93fEOZS4XkiS8zONOXepg9GrbWJOECIZVFD
 3PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uiH2pe6Mx5wDiNI66YfsS+S+i5Wj2zPOfJ+VYjMbUrg=;
 b=ijlsnO4BHz0Ztf3NBpgQryFwoe0iptLkAyQTZFSw5X1eVlQ0TX1xT5hYLEF+/Lrsri
 R8Osdek9rbMIM5V+MYKmlWvTVNSqvtVzRe+wZ/EUJ4A9GmnlQXd/wZ8OFtnTkoqCs2em
 I31kOSadKI8e+ZOHNs33clmF/l3whbx0+o4+S9oJMxKyJ18l2uan0IZw/sbSWDN0IBKo
 41YIu4gzoROt5TEnIz2dthk/OysdoIGz/8MFdIyByXN+/ab/n3mj4kLJkyatLAEPlHri
 L/jVsoVSeK9BPktqOnEh/KF3c/Y0RsdFffueDoDmFxlAOWyzTdvZt90l8XT99DIQ+86r
 WYHw==
X-Gm-Message-State: AOAM531BET7+8xnSXRq3aov1H24hARLN+/3WxBwPdO2bctmISVzz2MFB
 2mh7oaynyFDVICmNsn9f/FVa0QMeNhQ=
X-Google-Smtp-Source: ABdhPJwggQaEI6TM4xZD5+d8Yc3suVi6pVuoWR6+wsRIqvNjkA89xrGWeyS83LeP0+Nkeuhy2Yfa7w==
X-Received: by 2002:a5d:4986:: with SMTP id r6mr30860885wrq.424.1593081089345; 
 Thu, 25 Jun 2020 03:31:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w17sm32121249wra.42.2020.06.25.03.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 03:31:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 573591FF7E;
 Thu, 25 Jun 2020 11:31:27 +0100 (BST)
References: <20200622153318.751107-1-berrange@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH RFC 0/3] gitlab: build containers to use in build jobs
In-reply-to: <20200622153318.751107-1-berrange@redhat.com>
Date: Thu, 25 Jun 2020 11:31:27 +0100
Message-ID: <877dvv77y8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The current gitlab CI jobs are quite inefficient because they
> use the generic distro images and then apt-get/dnf install
> extra packages every time.
<snip>

I should say I've queued this into testing/next and tweaked it slightly.

--=20
Alex Benn=C3=A9e

