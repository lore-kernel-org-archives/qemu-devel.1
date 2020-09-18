Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A961AC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8CA23600
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBgbfVfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8CA23600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGH2-0005qX-Sz
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJGDS-00030z-1b
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:14:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJGDP-0000WN-Bq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:14:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so5578190wrm.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fp7IBPhfvTK0RipU3vakZylBs68OMQy8vOqxKFikpmc=;
 b=kBgbfVfs74BSU8VWQinZQ6MZDsMw1uLNlY+ZI6h6iU7kqRtVNxVQ4s3aAH5Qh63chK
 MG8Lr96nuVLsAfq2T9vzRX9TomesE9rKPkeDPFpaSMA/kppn4oaZ7SB1vd0M5bOqEdCD
 yP9mDThJp+81Va1cP+NP1Bevj8ryiJvi8+T6Fc6qLQ9pBeuV7/u14R0ul1+197384Lhf
 xNMRfs84nmSwhyaFMw2ktAmSpJDRGZB35uhwlNnNB7p6QGv0AqKo9OJDzBq3NWl5/XXa
 f2BoPzOU3eB0xo5Jm24v7amtBpMWNt52raSVglcXz8NcBpacpmOgnLvzg6zz2taoyktV
 tWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fp7IBPhfvTK0RipU3vakZylBs68OMQy8vOqxKFikpmc=;
 b=FY3BRkRWBlnvLKPltCjbfQDhxE1kodTDZexTUn3ge3RNqz+vkhHXhjb9OSkrLtJdQ5
 Kl5NJM+yUm/P1ePhhyy2eGL5kI0BHpm5KNqMXDBhsabX+uMU1Qg5cmzNWeK4SZLlMUDN
 AYkZvgXfi7Tb9VMl6BbG+K2qrY2/dbSYzXiUtmk0Un6XEpGJTN2Zx42dqrXQ1r5Mmpf8
 PUEq0Xu2976zRdzcvQlgPSJg0mp8T0HPUTk/4fKsyLxpYr/nyQcNK3unxdVwbHe5KbmB
 Y0Jp5gSGoQG2eCzCZFBz/8S+Hj2LxRcCdLZKL5F9Nsh/CCetZDNGHKCu5xg6JIjtYVQg
 wHRQ==
X-Gm-Message-State: AOAM532V3DD7KSngMaj45bwkDz9LqTqPi8El87vDU244kkP/R3ssOsnq
 UqLSJIB9cBJZdPer4bG2k1YmKw==
X-Google-Smtp-Source: ABdhPJxARTGmD5JHB1xNjfBVVRsJFx9xToI9j3FHWMrQmQk22KGWuwY5x/mssAxIYUuL4rAvk32vBA==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr36246750wrm.136.1600434853771; 
 Fri, 18 Sep 2020 06:14:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm4842811wml.46.2020.09.18.06.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:14:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F6A81FF7E;
 Fri, 18 Sep 2020 14:14:12 +0100 (BST)
References: <20200819144309.67579-1-liq3ea@163.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Li Qiang <liq3ea@163.com>
Subject: Re: [PATCH] virtio: vdpa: omit check return of g_malloc
In-reply-to: <20200819144309.67579-1-liq3ea@163.com>
Date: Fri, 18 Sep 2020 14:14:12 +0100
Message-ID: <87o8m3w7kr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Li Qiang <liq3ea@163.com> writes:

> If g_malloc fails, the application will be terminated.
> No need to check the return value of g_malloc.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>

I think this is fine because a failure to config the dev would just
cause an error_report later and it's extremely unlikely you don't have
enough memory to get that far anyway.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

