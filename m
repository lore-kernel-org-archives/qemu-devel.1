Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456BC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFB32075A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtuV6Ab1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFB32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK89-0007ou-Hb
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRK7E-0006Ys-H4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRK76-0007tR-3O
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:28:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRK75-0007rf-Mw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:28:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id y24so3618457wma.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PhuciOTxGzyt42NozTpQG7KL1ETjDSYk2QrBi6IxQio=;
 b=GtuV6Ab11FdV9I+t2EwnE3Rr1jeiSj3WTyI02wt/ltWJTb8zDiaCh4pINZwAyam165
 FXHppBkQgdUkWSs9F89+KFEJ1C+59jZpL8zCbJd2g7Jl7u8hzOX676tdLzm5cirBmn1b
 AXdXTJ0m6QYC1j1o93wXmBoTnCEQ4ZKOvdifWH/3/bu9jXtZ0GjSj4uZgB6S4UxjRC+A
 k3jgRmB3MABUmGmAV2cpk6KHfj5Tql/vL4x08ymBHtgF9T5Cc/+XxwWujK2d0F8wqW05
 MqaS1eH3G5KE3J8VAkP5P1jetbfBNXY5IhKH4wIr1ioYtkgIbpFVfgfEtlU4WghbwCVV
 gisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PhuciOTxGzyt42NozTpQG7KL1ETjDSYk2QrBi6IxQio=;
 b=c77M6g2DLQo7j95cluzUp8yxpzOIP6Je3jrOAhL8Y5cdHGSW0yWXXD4wdmctA13r6Y
 f8O9gzhU2zZ9WZYH8JewJdjfbIJGA+JzsM57hNufMcoKYdnPQl1FodZU4rkziDL9NmhA
 IZ1b+kEsA/bGQKY5WlaT1kF1brN330/tFNs9Fm19INWfwygci0YkqLxBrhw1g4cg1OdC
 OfVEqnI38p9YgG2zDKtu+BvatKygsbquCt8m1EdBizsW8oRQW1+Ewy3Jae1x9mCQVa6M
 Z5miW4AKP0xQNHGcJa93nZ1VJDFH41skBN7OEWijSwfzmVAN+2cajz4qzY8cPNIFypQm
 GrdQ==
X-Gm-Message-State: AGi0PuZ/+k5r1GRcbl9OcHcBBel7WF1A81pkfJn68OxDKENhEJqVCNA2
 VVkFN5NlAXuThcQQPmzgLTEuONsi08Q=
X-Google-Smtp-Source: APiQypIcwSer55YXaBjUPW6hqWxAKIkMRoS6eSgWVHsT09h0ViEFEi7cbvrE1v+x/JhuyGDhih2Csg==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr10762095wme.89.1587580125824; 
 Wed, 22 Apr 2020 11:28:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s9sm63536wrg.27.2020.04.22.11.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 11:28:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 40FD11FF7E;
 Wed, 22 Apr 2020 19:28:42 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-19-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 18/36] tcg/optimize: Use tcg_constant_internal with
 constant folding
In-reply-to: <20200422011722.13287-19-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 19:28:42 +0100
Message-ID: <87zhb3bcit.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

