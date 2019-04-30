Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775BC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7C62080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcNx1wjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7C62080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPxJ-0007uE-Lo
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:25:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPq7-0001Py-2D
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPc5-0002Ro-MD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPc5-0002RR-Gg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:49 -0400
Received: by mail-ot1-x344.google.com with SMTP id 77so5193694otu.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+0LVksmHFxb8DH63ZwZa4UFMV0ydXFLgWS9mM83jlro=;
	b=kcNx1wjNpw04n58cBNrhMgOQvDr0wUhiqj0851ATdz7IxMqz12tLXoKme/03ddJFaR
	V4DybR9GfEFMDX1hXoqWjcQ26e5B0xh4pyf2nJK5e2aysipkWk/JLcA/Yy0G7jAu5bDQ
	QVjjruNRctY9b3yRUSGx2agtQr7+Yqh5tL1fec2O9GErhEtZ2dGGv58nKt07o2n2v5RF
	N9PMqsTXZMsO2GMPhQmcomDPya0BtVK6fx5+Hqha506WEGHQoVYQRTyYeMwpDsJLdUKa
	wUhR5XX1/JXnH9qRTJechRUDjjcTat42RG5ntY0xNWMVC5TTZCFTT43bltiS7xqNY2Mo
	vTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+0LVksmHFxb8DH63ZwZa4UFMV0ydXFLgWS9mM83jlro=;
	b=OdqRllBgneMKfkNXKMLAYM2dvjVy4Lii16pIkoG4tshKQHv5aVl75JgZyPUFaSUGfY
	k4WFdkhEU3783VosB51ycamY8w7yEK5yuTWta3Kpt0TSt3dbmlKHqfjW/sQ3W16mB9Zw
	yT2Ytxy0hUdPIkzScg0+x2G92CnBjoQbiDsGp0HlYa4b0T+Nkd4s5Ga1l2FCfUyRd/Ap
	Uxt+3MKpZlwMKBpQiH0ndMA1/yTLFhNmOHShUvt44WLGCZlBxGdP8TAfk5O3kO6Vy6pR
	igxaIOAkJU+hJpV/Qv3uwQKmSVMd8v3a1U90sUPijaTrkqbhnbDADlxJKmVFy75ZsEBq
	UMIw==
X-Gm-Message-State: APjAAAU+rQHgocQWSnCWj6rjfGNVDYJHDLtBK6Fnr8WsjS8wxCJJqvH2
	S2kFXZJYG3Gs/hy0bvbr3ePdOh4VQJ585YjdLCgvEw==
X-Google-Smtp-Source: APXvYqyXioxQxztfOAvhW9PO6pKXMl2ta6IsBgUZssrsNl/l3B7WfeiJzBjhqBjLxceuis2GmCwIVTKUNjEl3M/tDBI=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr11725500otk.363.1556618628677;
	Tue, 30 Apr 2019 03:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-22-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:03:37 +0100
Message-ID:
 <CAFEAcA_6-1+Pk8k7Wr8bVjWsLnNwyVp4R0TyYiPvcBy_o8ZmWA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 21/26] target/tricore: Convert to
 CPUClass::tlb_fill
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430100337.HkZK3VgiKZla8v4KbVb-KDl95dD8Zz9L_Z_wN6vjKV4@z>

On Wed, 3 Apr 2019 at 04:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/tricore/cpu.h       |  6 +++---
>  target/tricore/cpu.c       |  1 +
>  target/tricore/helper.c    | 27 +++++++++++++++++++--------
>  target/tricore/op_helper.c | 26 --------------------------
>  4 files changed, 23 insertions(+), 37 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

