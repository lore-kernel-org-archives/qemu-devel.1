Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ECCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C927205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlMlf0GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C927205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4Yp-00057H-GM
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4YG-0004fp-LF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:55:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4YF-00048z-2j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:55:48 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so1045956wmf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zT33J2AhlS9w0kHxPDSK+pgNjz6M1D3sbG82BCKbPEs=;
 b=NlMlf0GFPUEqRNJ1uHODU67Y/8LM3K1PX0woqiTPJNV85pPy9pyYnl6A8ebSxMxVTS
 0IzM2hzpHLvNUaLCuj28easCY/KgOa2cSPYQIUf7d3UvGm8M6B2I1wRHSdY/P6PA4Uan
 jNoEQ+nNk0R12T3cpiKjrP504cN3DyJkXYD97umjSR1Qs2KB8BgMWOrrAPZ9HoWIvr6E
 zOTUCaFCIavsMUzERuUpPAu7kzYRRZnh8eMqKntfoGfqN/rgQPr/Fo0yAuAPfRDTpYZH
 gwhPxaCcKSkvw5ncDSQAK+2rc7EcQwOabohKplml3YftoCb7bsJv/k6oOT75HoD/Xvpv
 6JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zT33J2AhlS9w0kHxPDSK+pgNjz6M1D3sbG82BCKbPEs=;
 b=cNWzyX/9yxL7UVH/sjcL780nOzzFz74Bg6SBtfMyZCtF6StD2f27gbPQ0IpfPjbbRo
 kS1DYqAL/6xsvRIZ8g2YpJmCCxTtOP2CckkTOy13OhW6YLjGPz++Lqt0aTi0Nw8ks97g
 tzEIhek4b8rkpqUDLDiAmoi8Vnyi8BzhdVYWF7PrTqXpfH3dvczKwsnhdFhb+Rv4MwzK
 BIxz6nCsi/GQuyD6OQfQHqBd7EOeI89nC4suhjDm14z9DOHIqKHJOjb8mVO6NRRAK+1L
 IWZsf4JuHc5t2zKWPB/nmMHeUkRGpgBwGwohsMENMdiwajCOICvaar55iNFtFBaVWpfW
 9J7Q==
X-Gm-Message-State: AOAM531IdVh6RWQarJKCFpjuG4zR8cAA4KSOk5WJ4sgz6P/18JGd7EUl
 eigTG/4qUSAWlDQ4mskqizdxug==
X-Google-Smtp-Source: ABdhPJxw1stBkrcAOmIiVufNzglLakpbCIRRgMN1R4kUzb6EIYhq/xmBXcUGtfvJJ+vGqs2J/u4P/g==
X-Received: by 2002:a1c:a986:: with SMTP id s128mr1037582wme.121.1594670145644; 
 Mon, 13 Jul 2020 12:55:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm762874wmc.26.2020.07.13.12.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 12:55:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 143631FF7E;
 Mon, 13 Jul 2020 20:55:43 +0100 (BST)
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-2-zhiwei_liu@c-sky.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Re: [RFC PATCH 1/8] fpu/softfloat: fix up float16 nan recognition
In-reply-to: <20200712234521.3972-2-zhiwei_liu@c-sky.com>
Date: Mon, 13 Jul 2020 20:55:43 +0100
Message-ID: <87lfjnyytc.fsf@linaro.org>
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
Cc: wenmeng_zhang@c-sky.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


LIU Zhiwei <zhiwei_liu@c-sky.com> writes:

> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

Queued to misc/for-5.1-rc0, thanks.

--=20
Alex Benn=C3=A9e

