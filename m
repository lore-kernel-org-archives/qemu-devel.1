Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD67C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98FB216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugwp9ucP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98FB216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRao-0006Ea-Fw
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRYW-0005Vp-FR
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:32:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRYU-0006nV-So
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:32:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so14054526wrm.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=00cvVnZq6/NoJcLoSrzSAoA5kj5eXS+FahCofKanBK8=;
 b=ugwp9ucPTEs57OSfIBb2GtcRvxwP+4Tbv1/XQ+7Kx2aEFK6WaNLABWq9+aFK9rdT3z
 KLbMM/ThwX3+Ld2ExTHdU1K/R7VX0+3xwwmREh/pnhiCRlDWrQ1G4sk96LSTPx4p3uWI
 RkTyP1eN2xEcVzohgpuV3QiEFGrmOFyEuikFoA0zziSduoW9AY7NooFAr8T+hUebwYH4
 435WsvAeMOwA1VGJiyTA+MfMx1maXT3u9VGViwlh0RyYuKKYcWno6NdJRrFwYX44sFzk
 ZYlh8AvOfFMCVDgd2McToJlYtPxL13FUnke6ENrLh7ZZ0RI+/WfKB41vh94BokIwi7y3
 LcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=00cvVnZq6/NoJcLoSrzSAoA5kj5eXS+FahCofKanBK8=;
 b=Y8YXY2MzFNMGWvh9085KgEBOWUOCYjiIamWS3k7CsDi1fwsyYdgTO9ZA17qz9HtDoz
 QKJI/OViU6LOwr2vXiM5DjCBeXX/AY3aMRRBxlkqYuO9DsBhYyG2GgjEfxw/yPj+aSd5
 Q0PRXiVyPgm0oLaCN+Yt/NQv7YSPzOC022V7CLxSC6hGbc3o3GlamTZEVQeoEjpwTz1+
 JWydB6ZXozy3ikKp08Oy48aMMf+oEjWWXxnrFJQsmRmYsuQ5I4wL/ctP+sTXSs/XDOGr
 5rUkSKuVC5OxTuaBbx29xiIq4O5fgmagiU1J9D4pZS6DEc5ZdlwM+I/aEuEbaCoDvGpk
 zl/Q==
X-Gm-Message-State: AOAM531fHMgbf8Q0deuSFHahmFJiRV+OaXuT9t5XF+Y8bikjwfkgYBVh
 XLyTPPEag+6bAZnj4/tPktuqMA==
X-Google-Smtp-Source: ABdhPJyetJxKLvEQswKh0ZbeIv7YvL35Jo6Gqq0K72Y4mqTv56+ZW4rPT5+j/zvFBbM3wZD/EYQTiw==
X-Received: by 2002:a5d:6311:: with SMTP id i17mr1260465wru.243.1600716773202; 
 Mon, 21 Sep 2020 12:32:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l16sm24423001wrb.70.2020.09.21.12.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 12:32:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 657261FF7E;
 Mon, 21 Sep 2020 20:32:51 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-6-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 05/11] disas: Clean up CPUDebug initialization
In-reply-to: <20200921174118.39352-6-richard.henderson@linaro.org>
Date: Mon, 21 Sep 2020 20:32:51 +0100
Message-ID: <87a6xjncws.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Rename several functions, dropping "generic" and making "host"
> vs "target" clearer.  Make a bunch of functions static that are
> not used outside this file. Replace INIT_DISASSEMBLE_INFO with
> a trio of functions.

  "Also clean up a bunch of CODING_STYLE violations."?

>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

