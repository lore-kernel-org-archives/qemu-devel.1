Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99482064C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfsA1idh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99482064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJTX-0005nw-70
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJSc-0004mI-9x
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:13:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJSb-0006Y3-AP
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:13:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so15686768wmh.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WLCkBQKGOI1/nl1+IyJg+4rO6AB9KfPVDwXsEHkJ81A=;
 b=YfsA1idh7XwJ6vU82wdf4IMUimS7EBTVAAUmGXvojVW4ureFqUj2LNsybBEt9imroj
 yZq52PQ8Nk8ajSmemQ6oHqSVHHyMyxoMTBC3tREmae1YobaxPrxc5yRC7DeVpJfmqHjE
 JdrxTMHP6rfEhU4qntDnuA2qQobafu0IaTQOp79zxm2XSKngUBDwsoXt6J+vuPvCa9Cs
 Q+yxa6nEMQE6bRk7lz+Be32Ho/TrRxfHMKsC4k3qSfnklUlrgtng6fqQmxpbVwLPBGed
 I8RWBCSYW+ArmqCr4Vi3JaKYOtj6Pws7TdG6wt0RmaE1Yh1fCHEsop/4T6XWmksRkd9M
 cmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WLCkBQKGOI1/nl1+IyJg+4rO6AB9KfPVDwXsEHkJ81A=;
 b=dWho9n5oiGPRWXYCgLZ1NSZqZkdjLz6YkptpQ2P23bop2vwu62tPhZ34TfonGWEr43
 PIGwxFKjghlqv+r30b0SSzrAT+TWz5iqt5AVQE5OO2jHMKB0q1SKmLg0wfDwqFnHcKFe
 dSA7Tvx3fARkAz4/HuFKAndHXDszH8Ls2fssCwD4NBEEPoF5qUMp6TRe3uSm2ysf5YXu
 KvgcjR7hYk1d3hwrHVU9y+TxaTFfHQQeeQZ/quMOI32YsXb8PJwO8+LtU6DLc+sBtZn8
 RHIaReb4lcevynJ0TUH8IrT/tgemkrgivKCmE+t82ofFZoqrO/ddNhcD5f+66GBHA19j
 KPwQ==
X-Gm-Message-State: AOAM533CYAuY84Nl8ebfEbzkmRrq/ebd+tjT66SBQWX4bQBNuuCwy5+R
 Xv0/EaCZudOMhM0HDlMFaPsEgg==
X-Google-Smtp-Source: ABdhPJxp5G7aX3oIapUvNNla6zF1FwDgwKZ0x4iETbpFsKd2Ms8hbWHTl5M9XAGVdIlh+cKIg1z0/g==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr16662939wmi.58.1591629191702; 
 Mon, 08 Jun 2020 08:13:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm23514161wme.9.2020.06.08.08.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:13:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D357F1FF7E;
 Mon,  8 Jun 2020 16:13:09 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-13-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 12/13] docs: Added details on TSan to testing.rst
In-reply-to: <20200605173422.1490-13-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 16:13:09 +0100
Message-ID: <87r1up616i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Adds TSan details to testing.rst.
> This includes background and reference details on TSan,
> and details on how to build and test with TSan
> both with and without docker.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Emilio G. Cota <cota@braap.org>

Yay docs \o/

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

