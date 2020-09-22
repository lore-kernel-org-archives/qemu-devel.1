Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75CC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9A820BED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWh/CLk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9A820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfzx-0001Yv-LR
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKfsF-0000Xb-9r
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKfsC-0000Va-RH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:50:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id b79so2834258wmb.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WF0lpd5Ap/lGdwZNS+Ri51CfE/uIbwfqeeZO5OL3CXw=;
 b=HWh/CLk4WfCTi76/sI9LrOjTAmGAn04YXKI7QeECj5uCS9LQZWk6KaoYMioLiB07qd
 86CAXROPoSG21l94mFulV52s5hLta8/3LswCuT+pv1Fmb91fid8cmIV0NBbRoyAfGF3U
 EVgEoTsuJc062bbWtw5SDoojDeWTWS9nIr0TNK67WDqYW3p6lALVsHqBkh1wGtxq6Exs
 sJ2lkA0HYqCaXwVuf6BahfzLmvzXBzoh7/6nPzt7yOU1YKIzt03Ge9R+J0funYIXtvcV
 sCvFX6SQNCjdpLgGRX9+0ohjdrJxtR0gDLFYTk0auRVzTkVBmeIjh8zdV3Lsy1VBd9Ks
 A8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WF0lpd5Ap/lGdwZNS+Ri51CfE/uIbwfqeeZO5OL3CXw=;
 b=RzMV4TatBGjspRG8Fds/I52lh7YigrscZNUgKAxLCYkMzyTPFN+3VSMMSBtOzkjJ1Y
 hzcRgIr1ywPitmxXXmpty5OEpXUg1n+ocqIW9cLaBkyi8fwsnl9GeAfnVIpLCEcpNikY
 2a1+27KneFEDNqCx+HCsk1RdTMJ1EkI7H2jcL2szFYKoxe7K5bgNsdBBCLNPcVxGSDp1
 iTz1etWDxVjAgQPkj5/z2z7Vyzto+6bp+V8C1yYGOk28BVa20YDPiu38YifEetrtsX8u
 A7bxBepuHCSohVwyROEDBkcMB6n4W9KtoNM9MeTU28+82NV7If3ecCG6r5cglIt4o8AP
 4ahw==
X-Gm-Message-State: AOAM532Jz9u4HGacu0qF9VbxruwRnXIOPyXwJ2fTumAdlDrhXI99YuJ7
 XmNoULS0wWwZWMWHJqHLePJdqA==
X-Google-Smtp-Source: ABdhPJwAfr1ezRP4Qz/nFnCKp1SEjK7eSngeZpCzdSjnaUPkXdHotCJVx+CFsHzo4crk5gSO9yGs8Q==
X-Received: by 2002:a1c:a593:: with SMTP id o141mr366361wme.88.1600771810154; 
 Tue, 22 Sep 2020 03:50:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w21sm4059361wmk.34.2020.09.22.03.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:50:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 64EE51FF7E;
 Tue, 22 Sep 2020 11:50:08 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-10-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 09/11] disas: Split out capstone code to
 disas/capstone.c
In-reply-to: <20200921174118.39352-10-richard.henderson@linaro.org>
Date: Tue, 22 Sep 2020 11:50:08 +0100
Message-ID: <87sgbam6fz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There is nothing target-specific about this code, so it
> can be added to common_ss.  This also requires that the
> base capstone dependency be added to common_ss, so that
> we get the correct include paths added to CFLAGS.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

