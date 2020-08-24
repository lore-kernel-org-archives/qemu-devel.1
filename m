Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CA42071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbM/eN0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CA42071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA91q-0002j1-9w
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA91H-0002Ap-PE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:44:03 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:44431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA91G-0004Fx-6i
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:44:03 -0400
Received: by mail-ed1-x52f.google.com with SMTP id l23so7427596edv.11
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=ncu3iykmXC3IR8vZdSA2cTx7LB+vZMHKnCvgsNj3B20=;
 b=WbM/eN0f55MTfm/ZqFKXYMCtQkJHGWRl3dsEvorBpagYeCr1PxPj0mjkvKfwIhM8d6
 KEgvQE4VKACZNu1OW0/5Es3LYuKnb9xiMgD8884BNAai5PYXlQyxxaAShko9IgKCps+H
 +AirBJ86Ed+bWl3991ny19BN2LtbM0elyjEH/FXXFb9ZXwRA8ctCN02IUOCjw7H1L1D9
 HvOikOIMoSaeLCPsUYaUcJ56JYlwflfDUONGYONA0MDpHlBUcE+QWop2PiNNX1xmJuWa
 h0HjqW/4zMsY2v5f3MQzniiRYSX/NE4fKbSESTz00J73ZYPTjLhE85CcKSxrKx5jb4DU
 iVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ncu3iykmXC3IR8vZdSA2cTx7LB+vZMHKnCvgsNj3B20=;
 b=TzH0mmxdm/kpb19kznR67+V4edcJqfLWBfK/2B4FQoOv8L0hFC54eYviZbQwGbQLTo
 RuaQnaiiqpW1NeY4QP4xX21Hkl3gyilQzeO60i+kHtCWVQpDSMBVNGVHvN4WBxez4c2G
 aSpsRsr/tMqI4Gruvd3vuhak0gvATLZQLP+wAYUmTVFg0Rp/OmqPCwqndG0zxaY2tZiD
 ztVBV/AbzbnI5m7+kqmzWP0+jj8mufZ8x8P/xZ28nclt6t2/0CqGSt4T2uciH4rOwdBq
 N830E89yOuXa4uVjKc6F/wH9YvTYL7NKdTPeT8TgxZYoca+MyzXz+lITfo6JA/UOUUtf
 RbPw==
X-Gm-Message-State: AOAM531RKBaBEDzpeUhX7ArLPtAgUW+mwv682Pd74rdeTanbp7bGlKRd
 xt6lZSy+NiF8jqS+DahWx4CSCbNc9dyFTT5jWJ7JPH802VHk6A==
X-Google-Smtp-Source: ABdhPJwvn82ZH8czuAO8j4Dtjo7nNCL7i6tnjdf22ItxSsjwbhu+PttTQoYb+p7LKPIGZTi9JHPNAWhhy2TSXwq/tik=
X-Received: by 2002:a05:6402:1218:: with SMTP id
 c24mr4416022edw.44.1598262240300; 
 Mon, 24 Aug 2020 02:44:00 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 10:43:49 +0100
Message-ID: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
Subject: meson.build files are missing copyright/license headers
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 It looks like the new meson.build files are missing the usual
copyright-and-license header comment. Could somebody add them,
please?

scripts/ninjatool.py does have a copyright line but is missing
the license statement.

thanks
-- PMM

