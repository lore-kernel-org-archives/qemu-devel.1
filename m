Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8023AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B68820730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARH0okGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B68820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2kr-0002II-Ej
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1is2kG-0001sH-F2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1is2kF-0004Sg-5X
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:51:23 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1is2kE-0004S1-Up
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:51:23 -0500
Received: by mail-wm1-x342.google.com with SMTP id m24so3222952wmc.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AdrUlqRzxhlHmcPhuZisc10UFkQjL0A+MR2LWLO/AgE=;
 b=ARH0okGFudEolRmrM8lsT6awEzmAz/dgtQuZWgtsRbCPEqPs9ZyIah6V0Bj64kSvOI
 tvMxdVCs0CNvVUmy3mK+hXcC7VJ0XWKwYgMLIk49+xki/ooaS7muQRDDQfWeUmPt9Uzs
 u4tIPVEpEizxbBs9+CiLSWRbdgAdxxuUvmHMb0eNxYgflzOMnvEMwFeOfR8ScLiwowS8
 oz8Omk1f7Ue85VmELS+9nZ0GKAKpe8ZGl9dvoM3ZXRPqHBaGkyvCEGIdvKDJZZXjy4h7
 mdlQAvAAy/oNLT66/hVBhRcibBN5XclkPfZtwv7OUJwiqnxai7qfEc7r9VEPIZVvNChN
 z7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AdrUlqRzxhlHmcPhuZisc10UFkQjL0A+MR2LWLO/AgE=;
 b=tEnPKaWE9Hn2gD0lw58GXolykqr7G7/ioEVnJBcFhhusotWeIjaB+HBHaZLAHdES6n
 pPNP0kyr5oOBdXsBqaFlFp+iwHpbrJgo1lh4pSRvEw9Fqelysta+Z8CxoPPp5gNM4cM9
 tbWwCzsvtxYqS5WE1+N7MOtF/9S72G6c5HTx5iZeIzETmReeo1HKBf96+s/T8o9+e5Bs
 8SBx2RiZrahf59/9ZoTGT5xCZ5b8a/VUEH3/Gavq4MXTo0rDaMuzyddiY0RpUfj9Qt4v
 CIT+Ms2Z9GXujZFCnFzdTGqlWoOT3vWxtf5BnkqhWP0IpLuWhYClzfp04Z7eWKLYoKZO
 Xq4g==
X-Gm-Message-State: APjAAAW0RK9w4ldriHr6WLgGRpmY4dZvJ4dJ9vs2fX1W3XZpPaL8lvmt
 6eAfF6P3r390Xyvw+x6wAXC/Jg==
X-Google-Smtp-Source: APXvYqxM62K0gK+5yvfg8viAGSbh/kAlTVi6qNq3+g1AiTj9fyI7mOwSlZaZRuopKb4b90NAEPEqOw==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr5624068wmj.25.1579171881529; 
 Thu, 16 Jan 2020 02:51:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm28106070wrt.74.2020.01.16.02.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 02:51:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 614661FF87;
 Thu, 16 Jan 2020 10:51:19 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/3] linux-user/i386: Emulate x86_64 vsyscalls
In-reply-to: <20200114210921.11216-4-richard.henderson@linaro.org>
Date: Thu, 16 Jan 2020 10:51:19 +0000
Message-ID: <87r1zzllnc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Notice the magic page during translate, much like we already
> do for the arm32 commpage.  At runtime, raise an exception to
> return cpu_loop for emulation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

So I've been trying to test this but have run into a number of
(unrelated) hurdles on the way on my system. I think I've eliminated
these patches but it might be a regression.

Does running /sbin/ldconfig work ok for you?

--=20
Alex Benn=C3=A9e

