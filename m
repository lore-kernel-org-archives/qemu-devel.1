Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8382C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51902070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0X1bGMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51902070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeHB-0006AM-Vd
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jZeG3-0004it-US
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:36:28 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jZeG2-0002in-SN
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:36:27 -0400
Received: by mail-lj1-x244.google.com with SMTP id h4so3095588ljg.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L/OGdSTxT3/1tzjvnxyfpnVpN/l0XS/lFZB84m/Bv6o=;
 b=x0X1bGMqAiBcXZK3pjIra89Y03YYwL2Q1EiRnCRGjtA+WQdEd8DOpu5cWeGbEQ/U0j
 3elIHbSHwC9w4CArBK9frOwvjurHnXTq8bVCuP2xlSQuWLE55E93wLU6L+hbSGEiazAB
 DjxoGJRLESW0OSaDpxjTrLc+Y8pPChyoPN4/S6FcrbTpNyuonTwg6hdmQrccB3E6Idxj
 msAWruUyus3dhseJbBc6crZeE4uLPXBBEovwwDPRfv2qFrukkEHx2MwHJSTo6K6ycYK1
 3b7PignztChD8z9J2mBaFK8Yrj165lJ5UwMlVll1IZslsSzYDAYY9vCmAsTbF1XsD+U7
 THRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L/OGdSTxT3/1tzjvnxyfpnVpN/l0XS/lFZB84m/Bv6o=;
 b=TPhe0owYA/WPXl9h0pocnG24TBZHS6G5dScwHPZsWbqB10Cf0zWQzOPP9F0LvJl7tV
 p2Fj9/ujNO0LjNYnnOeMIyyinRvy+FNpC1FUq4t+d2t2UIjJNi+odK9BF4tummcGruLF
 lPnAmgD88xOciIoeRP9OPB71VaLtbOkLW7R8yftSKWBNV3vDnVBbGmcEqIvvLzHCCb2J
 rWKlBbojKU2ltlZ19gLuOaE8bVabNKVRI0e+Hh7Rh2WDeOT3l5tYDiRFq3GL3MjMF3Oi
 9wAgsFSUFq6h53Q8eIHE6PfkH9mq/JQZE7S7wrNWJrz2iNXN5UePVWRJNzA5B8VbTNhA
 oMaw==
X-Gm-Message-State: AOAM531FaBmNQYwIYeptewk5taLDbOMQ3W3eRRao2DSulMJ8X7ksXDUW
 rKm0SFKpbk6z9ZphbiJiMAzwBcDUppWJeqEhPy8FTQ==
X-Google-Smtp-Source: ABdhPJxnpgYK2zNg+NTO/LuIMNrliVW2HeXmOaE+BNT1M/cwUpnp7Sdasxs+HdvgGzKqN9u1inKYxTDjlxMvl6ZFxr8=
X-Received: by 2002:a2e:b4d0:: with SMTP id r16mr3007485ljm.129.1589564183816; 
 Fri, 15 May 2020 10:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200515172831.8439-1-alex.bennee@linaro.org>
In-Reply-To: <20200515172831.8439-1-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 15 May 2020 13:36:17 -0400
Message-ID: <CAEyhzFuViKwZK=kuxtf02w=qvZsu2Z3jWtaZXaym_KDUz9YxKg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] some fixes for genisoimage usage
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
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

On Fri, 15 May 2020 at 13:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Hi Robert,
>
> Here are a couple of patches you might want to add to the start of
> your vm build series that deal with the fact genisoimage might not
> exist or have a different name.

Hi Alex,
Sounds good. I will add them to the start of the series.

Thanks & Regards,
-Rob

