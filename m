Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6DBC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C4E2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDOW2c9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C4E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVAy-0004Wi-8h
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQV9i-0003bs-18
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:36:22 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQV9f-00078Q-VP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:36:21 -0400
Received: by mail-oi1-x241.google.com with SMTP id u17so6132406oie.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xCgAJy1B7yWFfym0TncgMprT+/tVx6rd3/sSSBUyA1A=;
 b=VDOW2c9Sh2SLw4LZhHA4tgafcs3JFLqUsHdqXtqp5WTDAc1Mi9WZhJ6uo8lGbsxwl/
 8NOHrdNsylsT4D90wYFRNpLTpg9lINR0J/q0/EMMqXeNsHquZ7eD+3xKxEzerHz5Nm/1
 AeYZjfJLttAeeqUQLFPvYaKR770earNa4CBQA7eYa+mBXHc8cFnuGfPfGcKDSAGUn2Tw
 IdbqdEhaeRYH2z0D+yQ7lPrsqeMW4U55oss6nznFM9NQS3QGKSuZjJx16p8o9usPGVLp
 9dnjqLJI+RlTTr7vIKTpUUqIMKt19UQpvQd3dj41SRlD8wh5mjV8ZEuFXRZWRgF463wK
 bc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xCgAJy1B7yWFfym0TncgMprT+/tVx6rd3/sSSBUyA1A=;
 b=DQrSn6dLenSjTEayUWc7v2WILVPhALpSxNNH+oqsxLDtFumJni8KwXjX8W8fWNrqtV
 5cPOPSNQO74xmsV3q9NIMIlqgzq20cgf7h+M98EC4Y56NjZrw3EX19r1pBUIVpveBUri
 1xMOlUkKSrTFk1o2Q/8GGXJ5z2M7MhHD+w9N5C9vYrHdBRWfjPhE63CzGzZ9mQNkfpxc
 LR7i4AhGzNRmr/qo/WSsTog0XmJx27s70ZujB6chIBVuZ2s7xvq3fNKiroieR5wrvAPh
 jKPo8hrr+FtxLiW+oyriqX0qFCJeutE0sBtIWcbv9hbN1XDHPcG9OrDQt9saink4R6KJ
 uV5w==
X-Gm-Message-State: AOAM532w9pXB9e1FKiP2aWlBZfvbI+x0uHUI3Xa647M/6TxBOgPNTOnr
 geW+V0t17zp/4HDqx4LMp3Ytgg==
X-Google-Smtp-Source: ABdhPJyI7rzNcFeC5PNxciAfvr3LwFHgRfrKiJlzCxLtkQsUVgGKeGMNRQnaMeV6cP7ie8lldK/q/Q==
X-Received: by 2002:aca:5058:: with SMTP id e85mr3827188oib.79.1602160576275; 
 Thu, 08 Oct 2020 05:36:16 -0700 (PDT)
Received: from [172.24.51.127] (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id k24sm4113828otl.37.2020.10.08.05.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 05:36:15 -0700 (PDT)
Subject: Re: [PATCH v1 03/22] hw/ide: restore replay support of IDE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201007160038.26953-1-alex.bennee@linaro.org>
 <20201007160038.26953-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1bd62f67-efe9-3881-0286-cec1a4095488@linaro.org>
Date: Thu, 8 Oct 2020 07:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007160038.26953-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, John Snow <jsnow@redhat.com>,
 "open list:IDE" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 11:00 AM, Alex Bennée wrote:
> A recent change to weak reset handling broke replay due to the use of
> aio_bh_schedule_oneshot instead of the replay aware
> replay_bh_schedule_oneshot_event.
> 
> Fixes: 55adb3c456 ("ide: cancel pending callbacks on SRST")
> Suggested-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/ide/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

