Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED71C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B926820724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMTbrteb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B926820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRc7L-00057n-T9
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRc6f-0004hX-8W
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:41:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRc6e-0000oD-7t
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:41:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRc6d-0000o4-Sm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:41:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id k1so6916485wrx.4
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vE7OGwF4ZeEpuUsNmS5LjbZ+lsEu59roranbFvjP230=;
 b=pMTbrtebIywjkJ/D6IHD6ReDNIptY+yJpM2/YoYxS9LsoLX+sbY9xV4Vqo3MxfPTuj
 Y8EEvqoQ/D2d+H/9iyhFMWoFmtJOih8klWGCTeyePDwDcO2PmtU7a0+5A3m315leEogb
 Ld1I6enKV1nyqswbEQl7lBqvCZMAyNLxYArQ+KrvHWezSQahKxPp3EE2OuvC6NiBsVzB
 LDtX2N8FiOzYLiIe3DCKeKuE9U/pZtBFppll7W/etShcoto4xigQeENgGyS1YaGr0qaQ
 WOcOq1cqaE+7+kAtB0I7z87gTWVDfkL6ryitwKXjPSRd82ITeUu+kRhgWQ6yezCeoKQb
 80Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vE7OGwF4ZeEpuUsNmS5LjbZ+lsEu59roranbFvjP230=;
 b=rNKemI4pA0i6ZAcopPSCwL5Z6jyqDTsoHNQt+RwCju0GeQCorRKqJ25aP2qjJbCs1Q
 XKXWeOtvk7esdVlHIFWHNj+qvdTgADgsGUeo0znB5owPrKURqakBiymAUIMj8OV0mLJS
 rI7fbYc8Aa0OX5hKYtAz19ttwAUPsaTFKyXFukc7jqYj5dvQhzg1fR0wrw5SJNb/EwsV
 lUUd6uSPPmxSHQQtf9qbFexkcAlm6tzuIz3EYnjy9IFuA0Th9h0aJV13QofJ+SLvKvmb
 kDUuVDDlBH3IRkt+8p5fiqbXzhRm0B6QvJhrShEJvYQzC4/tdMa4m+hdqqJxFNAE7vU6
 tNJA==
X-Gm-Message-State: AGi0PuacLUaKxxKoVqg47ZOzHiiI6RqUyW45BfdrRCesZX7rxdZB3noE
 oETqB3Rxw4iRaO8kjPRAhww/Pw==
X-Google-Smtp-Source: APiQypIS88mqQWFyEQ4QqlrGCY3sASOwj2JPgRSoBNlEa67/PSwjC9FMPq8uxX1xXbe6FAiEQHIzhw==
X-Received: by 2002:a5d:42c7:: with SMTP id t7mr4965920wrr.336.1587649290338; 
 Thu, 23 Apr 2020 06:41:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm3618332wmi.27.2020.04.23.06.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 06:41:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B48151FF7E;
 Thu, 23 Apr 2020 14:41:27 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-30-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 29/36] tcg: Implement gvec support for rotate by vector
In-reply-to: <20200422011722.13287-30-richard.henderson@linaro.org>
Date: Thu, 23 Apr 2020 14:41:27 +0100
Message-ID: <871roeb9q0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

> No host backend support yet, but the interfaces for rotlv
> and rotrv are in place.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

