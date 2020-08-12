Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC579C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818EC204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="totxb3Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818EC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rWw-0003db-Gn
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5rVs-0002Dc-7g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:13:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5rVq-0001OB-Oh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:13:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so2096856wme.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HFZ1MRgWEraNBLOBjnMvz0Kyv2paNJq3sQZJkOlGE04=;
 b=totxb3Z7b/eZnT8B5cFib0vemR2QQqEqi2O5Cihef1HGvlNtXXZS56BYSigZqYMnyd
 Rrs36YWmGANpFXA7oXmOdIRu93nQTP68Y85AJg5wDLUXxcZ51Df/Mb4xWj0EDjtf6VQt
 HVstiao38iM64mglJBuybU2GaZ8VX9ty4SUtsHxAaYMmUuP7HMN8qU0SGOGjpfdHBymY
 3+inVWd7qiUGZuppDZpgVxaoyEw1q3GK+98TUmzRD49vYj4//jbEerKl7hxsEhLGP5W3
 qjEPSNV5TvPCuua58t+uR817oE5zXdIdjLAm1gjMEz2Li9QdM7Ew3lSH0SqxmNIOyW1f
 Y3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HFZ1MRgWEraNBLOBjnMvz0Kyv2paNJq3sQZJkOlGE04=;
 b=sOHZwEfdbKMpIdnG3hGHVOS7unu3tAtH7exT/Z7FtlmiayAyrWvvlWPA2TxUasfhNB
 yV4nPJ8W5j7d6b7plqfmCe1WGX2AChr7aZtMxtrcowsjRMbZw8rZr7rLHgD/sqx/WGhP
 4arjf5MAPpv6EsjhpY9hcSB8GSDK+JwnD/ledl212VRmOkMTwVkI0BfpfPs89QXj+XTP
 5A+cVM9bnNH1CiUsDwOzTTPWf2IzNJHmabwRtXQj2dBWAzwjko4Hl6q5ug+JO70Ud++o
 aEDUJxwA05oXotyHwPfixhjY3ThvPxp+LJNc1hTlIIqOcFE+on7VFzAtntmip5/2xWlM
 nz3w==
X-Gm-Message-State: AOAM533Sl4hVjxyYQQuOclN2mQRpf/D56ujLL9aOBfdgdV+bi7omoEaW
 Cbethomn8Y3NrUkb1YWp+vBpqw==
X-Google-Smtp-Source: ABdhPJwGAW2WNFYMKeNZoC/KnguotxO0K9lesn+TMHx4U7f7QTDowVGhxg15FqJduB4GInvrxs6W5Q==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr13638wmc.40.1597241633423;
 Wed, 12 Aug 2020 07:13:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i66sm4290566wma.35.2020.08.12.07.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 07:13:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4FDFC1FF7E;
 Wed, 12 Aug 2020 15:13:51 +0100 (BST)
References: <20200812101500.2066-1-zhaolichang@huawei.com>
 <20200812101500.2066-4-zhaolichang@huawei.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: zhaolichang <zhaolichang@huawei.com>
Subject: Re: [PATCH RFC 03/10] docs/: fix some comment spelling errors
In-reply-to: <20200812101500.2066-4-zhaolichang@huawei.com>
Date: Wed, 12 Aug 2020 15:13:51 +0100
Message-ID: <87bljg0x5s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


zhaolichang <zhaolichang@huawei.com> writes:

> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the docs folder.
>
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

