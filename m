Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E352EC04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A547321670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ob8hA5EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A547321670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW42-0005dh-RH
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:57:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW24-00048d-1W
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW0o-0001Tf-1J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:46 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW0n-0001TT-Qi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id e6so7115726pgc.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3NqDeYV0Nj6ByvUe9BJGz1BAe5jeSxAl9JuVW6QSr0Q=;
	b=ob8hA5EN1p5toEXXn4jEWNoS++lTc8t/Jgmq6aOZ7yTwQZgBMrch2wtiAtCfxQleFa
	+3djZeQr+vScPC4naGWO7l/cNGKfzUT0SXXrYBAl3rQqqbvkoFExB8ZC2eXrgbK9S4Qp
	RYD4pFw5eJiz886DMx4KJSrZs1pWpzq5x2qx5lyObMaCrBPsQgcoZ+4p+MnFWPwm3ku/
	xfiXPFwcL+aKjR1w+rJgXweMM+GENq29vc2kiO/KnoVfWarwzEgNLDNW8GeVayO8BWEa
	2dT9uP63zSqLZPf04dd8ZE92qksKyxGSr0A45heiQ1kAGqrxybR30JdkprC66VY69xfH
	BlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3NqDeYV0Nj6ByvUe9BJGz1BAe5jeSxAl9JuVW6QSr0Q=;
	b=PWAwFx0v03g66wTHuLLt2PkZ8YVDxWQmifIKROeLv2+Fv0GpVmJrWVCbmjmztVz09f
	x0uHJXX+8eI/EnzxSa2sWFirugez4ggSi9Qxm9MQijItPxorP2vVjjZXfmWOi5NWiflH
	NoBDNmJGakJ3x/ItSO6nspq2hrr5QGbuTmx+4fhbnW3XV7QoxDBS45RB2ikAmOMge0sg
	uKZZWPdkFN7jdTDQD7zpGhGobVC7vOhqtdDTLWkZqAj1sqr8iDW6URanl1S2zA/Xcebb
	KtZBTc3zRoZ3OWwUvODQejmJ3oY+GKFAPCiapsRvX84gzXHp3vFexWn525mTk0rss19v
	CWcg==
X-Gm-Message-State: APjAAAXBlBOquHm30dfWKdxnrCqiYcWtzYhdHOqNnP3MYOSx3Uitwpl0
	PdPgn/UPf41+a/66ZxQgVTOAHg==
X-Google-Smtp-Source: APXvYqzJMlaCifz1/rXIwLAS4eeN5dGQBI8a9sd3lIo6QpCIJoMHcBaViKJ+N/PHkvF8vU4cpCOKig==
X-Received: by 2002:a62:5fc7:: with SMTP id
	t190mr71326366pfb.191.1556643224977; 
	Tue, 30 Apr 2019 09:53:44 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	p3sm8569695pgp.32.2019.04.30.09.53.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:53:44 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-13-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1f693689-a908-1499-8bfe-6f06c2afac44@linaro.org>
Date: Tue, 30 Apr 2019 09:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-13-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: Re: [Qemu-devel] [PATCH 12/14] target/ppc: decode target register
 in VSX_EXTRACT_INSERT at translation time
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165333.SeC3EUOyKSAaHJKU6TosQRolUsGblmGEbQd-s3Kapqw@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/helper.h                 |  4 ++--
>  target/ppc/int_helper.c             | 12 ++++--------
>  target/ppc/translate/vsx-impl.inc.c | 10 +++++-----
>  3 files changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


