Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40AA20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuvWHjz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40AA20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZX4u-0001wM-0a
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZX3v-0000Tn-Pp
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:55:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZX3u-0004sQ-4s
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:55:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id j5so2828864wrq.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zzVeg7JjRJstVsoxH3EbUu9EAugBUFM+w+iUQD3X3fk=;
 b=KuvWHjz5T1OUF0U7a6C0kptwXeyarYBrne+hMO+vbhWbN0VMEW1+EbwDQC0yDSFojH
 h8K4/V9J1E821+oFpcx5mvSeY7EbNlr2X/4kVLhBPF6km6eM+7Cr+JTxe1L9wU89aY0T
 CLyQMPgiScewJxm1uPe4nvui3eRgJRsdUsBOSIjPz7Zf0DrebR2RNsf86MqnFFiqhlWX
 /3kvA3DqcUkCvfTOmvAQQG4gi2QdFqkzvO4dCSwSctz5F8re7XGo1b5UBEW38NRDII9b
 wgh05oGFrlTTAdFyyJW/wqPeFPdYFR0m3FtRDQVFdcSLthTgqBW7YEPpBEAgZGHzt+Cb
 Tlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zzVeg7JjRJstVsoxH3EbUu9EAugBUFM+w+iUQD3X3fk=;
 b=MoYQU+xEe9XP51mj63YFyd3t3UUt1QsAaxOK/+h0q2UXbTWFRIzdRoWYf4SuOrl9st
 mAd7uPvavF3vFaXuGM8JgCWJctVBjsh0h23SuXdrfIsSB1VazX82ipxOEr7Nhj6IozDJ
 O8/+dx0XNKv7odCj5uJ9SBMJnooIN7uQOJoopEOUuh7ZRFulpb20tv3460o8/cDRrJIE
 CQl82qWD6g4TIgbSG78Jx5dOqAUsf8sPEBkB6t9GWQJht8Qk5WiS7tZXWGnpa7VQG+Uq
 w2m2Tz6+YsjlBChc4dLt9+3JPHw2eoh3v8saqBRMzGB2kvyBkIqHdA01+ck/Bg5EctcF
 Y0iA==
X-Gm-Message-State: AOAM531MoaTSFyBcvqDekNER/8y87H5q0I3xoy4jTt/iO8feCDRxizTC
 1YMs6n/lLDt6VY9lCWIuQDHdZknb+1k=
X-Google-Smtp-Source: ABdhPJwzF7HJCV1+UgmPoqtvMnvYNR3k6siY0W/V8qgJARvpGpoaNB3ggRrOhi+zved2eCgC0Y7+6Q==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr3681420wrt.158.1589536524706; 
 Fri, 15 May 2020 02:55:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j1sm2784628wrm.40.2020.05.15.02.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:55:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D10EC1FF7E;
 Fri, 15 May 2020 10:55:22 +0100 (BST)
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-5-peter.maydell@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] docs/system: Document the various MPS2 models
In-reply-to: <20200507151819.28444-5-peter.maydell@linaro.org>
Date: Fri, 15 May 2020 10:55:22 +0100
Message-ID: <87h7whcyk5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add basic documentation of the MPS2 board models.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

