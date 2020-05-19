Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE70C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FB8207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JH2339Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FB8207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4ZV-0006uo-Km
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb4Xz-0004VG-1T
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:52:51 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jb4Xy-0000j8-7o
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:52:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id y3so16521182wrt.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IIEAlVuq4xKznrR01okFk0MRJK7dXoCRNE3+9KQgSuM=;
 b=JH2339BbEks6RI21mr6Z1Ttx48FcD1a5OJB2zH5MoGoGofwOcR/pk1RjOdLkEc6hI4
 +l4it1WZ2HpSK/iO5P1mV/J/UDeGXCbBQgDxflEE5PQuxdycIK/HBjco9kf2JDIOFhcY
 MzaeOnaW+RBNqgJfiB1J8vALW93bMEW4615R8HTtP80Nwcu5YcN05wZ6eJTzVJBtwSFI
 Gws/SN0IzM6mqt+ZgNzSbtFk3xbkAiGq6DnGM8PUedBab35wXTuIP+OIC64WjaWr9x3q
 nq0Lud9nzpbH2m+C1NcsDg6AxXyGn52jy1/66ZprdJvfcSNiLRLi+PA3N/PzMGqYZGkg
 hcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IIEAlVuq4xKznrR01okFk0MRJK7dXoCRNE3+9KQgSuM=;
 b=GuYAvugH2Vr81NPUtZPkjIo/+90A7B5a9pu0M3AUVCach5ydtufQmET7bGV0yeAszX
 Yil9xoZU5wIhMBMIhi93YARVNmhc+r0DP6ia/Kcxw2BiN2zeftPeH1n7EYKnnwRUdOIh
 fty9wlhS9Xv+MwRKMDMB+OC/vOeEwOX1KUxo+/ruDqlGNQO8PsvsmfgAi2LlGUyMsTPJ
 MVTdPaT5Te+51KK45GvS7yv+TbdP1wsRGNOWfIvZrh0a55VRiVUyQQcohVufkq/kHRsF
 odlvk8gLr+2qaPWAxV8c8YpK5x6rNdNKAj+3NyCG5pTYDZZTCnaAYQEhVhry0eht04fO
 naYw==
X-Gm-Message-State: AOAM532FQLPCJIKmoLO7NrWTmxo5ch26pUNRg7+WRi6TTmZzp5QNMDCp
 joF/r7dY1sm/w3yF7V71fOUf6g==
X-Google-Smtp-Source: ABdhPJz3fqNKkmPEwEr+ZQ9y/w56QZ9oY6SDbH1L2MssSHp9qcURv1EBpq4/nwr/1PxeWCYtPmw3ZA==
X-Received: by 2002:a5d:4911:: with SMTP id x17mr26025128wrq.160.1589903566342; 
 Tue, 19 May 2020 08:52:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y185sm135648wmy.11.2020.05.19.08.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:52:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45C461FF7E;
 Tue, 19 May 2020 16:52:44 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-3-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 02/17] Unify master_fd and apprentice_fd to comm_fd
In-reply-to: <20200519025355.4420-3-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 16:52:44 +0100
Message-ID: <878shnj50z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Any one invocation cannot be both master and apprentice.
> Let's use only one variable for the file descriptor.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

