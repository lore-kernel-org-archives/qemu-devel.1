Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B46C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C96208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yObVJ1yP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C96208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHlA-0003c4-Fs
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHgp-0006th-BE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:14:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHgn-00037v-J7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:14:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so3926103wrv.7
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=f96DR0+XXfLF724rXOKggeXh4Og3bbqZXKBbL9w7k+w=;
 b=yObVJ1yPKBCwXp1+Ssrdmw6YRvsHZV7OOEKIkHbogmVWDPagWZ2B29yhuZTsb0+NLZ
 6jbDf+WOe7GnTWjoOJnRlV1GyWlo1dsg9KS8g0e9Pw/WT6by46EPyVIXxdiceCckNjqa
 VCCrMNUJPZLodO6heCfHUIra8ZXvQT+ZTd6UFRtkgF5mOAh0nQkrfBrbAORtD4nFl+84
 sc0vWCWXj76kxrlA5ix0MDD0g5CSPy8cX/Bq8seIqcYjtMxeCzDIf3ilKddANLZ9y90X
 w+j9Bx0JbjJK6VbI8BGPvniGoPEVbG7FuVlfd/k1eNRy6//wUPwWqs9NtlQNRErw4/bP
 V/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=f96DR0+XXfLF724rXOKggeXh4Og3bbqZXKBbL9w7k+w=;
 b=J1D+qAiquCQRSOP0YHqST7L9hfukCugF5EafSJ0SZBK08ZoFxpNeluRsg+tS5Xrl+f
 Zp52McKaJoWd9svcZzxA/xTzaVM0RUP8wKfv7q81zas1ZkRVcY5x6kX23TJYfSV1mert
 YQn4xDgqdUtfdkndX73vIzhbfRY0C5ay6Ks7Kpcc1MSuDzo+IcneEmVu8tk+4mLtwafU
 EwcErz0R67KIDBk86gkm+pXZa13AzGugB5t5Jb0COxeCH2cDT5+BtRd9X53n+f67PsYV
 vRTyLwzPXH7KRmwM5rJGYWLK6bCa79WDkvRBv1I6EiQ3tcwR1dWcltaTYhh71WxoEKHC
 WmAQ==
X-Gm-Message-State: AOAM532GEWU2lBauhFFBdbGCoj05eSK7/ZVrM/x2+Iwhe6GxeLYeiJdr
 cKYRWRHNrWV7cs969FkDvvaHGg==
X-Google-Smtp-Source: ABdhPJyj5QwdUhXkBM+aX4Ai/tYl3DdVp6wPghlO2NegnbaG25ql5X6xtM3tExCbd5RckDF6LwP8QQ==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr5682413wrq.238.1603300455955; 
 Wed, 21 Oct 2020 10:14:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c130sm4526069wma.17.2020.10.21.10.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:14:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 796511FF7E;
 Wed, 21 Oct 2020 18:14:14 +0100 (BST)
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
 <20201021045149.1582203-4-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 03/15] qemu/int128: Rename int128_rshift, int128_lshift
In-reply-to: <20201021045149.1582203-4-richard.henderson@linaro.org>
Date: Wed, 21 Oct 2020 18:14:14 +0100
Message-ID: <87tuunv6vt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

> Change these to sar/shl to emphasize the signed shift.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

