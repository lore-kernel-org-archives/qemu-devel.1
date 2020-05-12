Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B3C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEE0206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDB6ZXtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEE0206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVoA-0002z8-35
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVm5-0000kG-FK
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:20:49 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVm4-0004q8-AY
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:20:49 -0400
Received: by mail-oi1-x244.google.com with SMTP id v128so1515778oia.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SmkmfEI3ped15fy3gN+X33HzVtvi/w5x05OOcLPYsD0=;
 b=qDB6ZXtMJjKIRPKYOzaofRPOe7CtIypG3r2xlobGGT8X+ENYGZkM2YL7bGzQ4mbjFk
 NMSTSpaAkHxHxrDC4PFfu4BC8i8uczPhcsf8dEiiUmnnlqxkmNiCT6Xob8MJXW+oqTwy
 Cwx7l6S236XYtqeXSOBiUBfRcpNUaSFUDtan88dARWijrZWn3ekz41vz4P9lTUBJNwDS
 ZPbEj9plc/UVfZWbiYcZo0etkAJSDGn7KTTaHibKgtLe9tps1XpaJuiDPD+Ni2BeDjyn
 YKy6WFr04tQrMrRLFWWjQ2STp9L049PWXupvJrNmieV5UxvJeyWwviohgznKJIkLizCq
 eXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SmkmfEI3ped15fy3gN+X33HzVtvi/w5x05OOcLPYsD0=;
 b=IDdgI8yAIpoyUgW1GTUHFrR6xzRJ61ErZeokpre2y7hZ8i9EXm/hB2hxnHzKAjK0EZ
 ovZ5cjkN3RpL+M99K8R3CEde61YmTqUTmMBBkEwMnHCMca6aYvFlt3sLkh3MXc62cqnb
 OY6A4AwTE8j2oa36zQ6JFvGANkMx52UEAN0EFaPIrkvULjPK6wtbPyK0IcBUzIfHB8cW
 gGqCa6x+aF4eGpjuKdRpLg4eEvF3HOCWExioWqtArl+5OeWRvJ5aJ13xrUHCm0LZf6J5
 MB15yINnSv1ACLCglcZySKcdtWQPaMpjjiuGfJgyhG5eJvfxb/N14PVDKhXOomQqHb8Q
 TFZA==
X-Gm-Message-State: AGi0PuY5gdHuimRTKtP/5OJ1ObeVC2fGz/Z1ls3KlaBvBRFH6M9yAj97
 HTNlCq4/bKe6v74WnyqT7jUO+lM3kkMOmz6EBssbafHA/lQ=
X-Google-Smtp-Source: APiQypJ19lRhH4waRcIaZt5EihUUX6Qya6RmemIu9sNOkLA24CdvrPFhqgGzG/HqvYhuytpGBAVzVDLwS9KKXcWafRw=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr21999412oia.48.1589293247110; 
 Tue, 12 May 2020 07:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-13-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:20:35 +0100
Message-ID: <CAFEAcA-shaMg5POcDduAgQyqw3sB1q=KsUNe81xRUty795nd+A@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] target/arm: Create gen_gvec_{qrdmla,qrdmls}
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a functional interface for the vector expansion.
> This fits better with the existing set of helpers that
> we provide for other operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

