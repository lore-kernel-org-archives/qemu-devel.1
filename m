Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B459C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A4020652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evktaQtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A4020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6Yd-0007Au-ET
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:42:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6WG-0005a8-1D
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6WF-0001Hc-4P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:31 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6WC-0001Er-GE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:40:30 -0400
Received: by mail-ot1-x341.google.com with SMTP id f23so8583475otl.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=AOjt+4SFsFgMiCPWWsxOThEMNQDW3psmN72wc/WQD/w=;
	b=evktaQtjHmGWhriOoXexq5zWhCdgybc6e6kunffkZ7UlvGKA57QnSMqfMyvdUhm3DL
	RXGpsyrnRpghEtXB4GERl1DeaHOVNB6mISuzFNnH8tY2CPz7ZNKDG+PYltjqq6zAqg2v
	JEwGPqFQC7JChyht8tqeOup52qucIa901lvUP5SjCD2s0hyZHuCD1nT1JtXrKVpD1TYU
	qJf3kpslu+8AyFRly1+YAD4HViL1SPCF4ahpFC5kiTWbbMqoFAYZMBEzdOIiDpI5u9uS
	4dG5OcOHUoFnSmktsbuRXN4wLM/YfHYeTJNl/OEaLW+Ceual83VOJOG010VFZiQ9NPN/
	IWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=AOjt+4SFsFgMiCPWWsxOThEMNQDW3psmN72wc/WQD/w=;
	b=hFzc4cOj4dKH2DM1Rcr/SBYG6/+o7FzexaWyY8VvNM1qlRwju/K77oOut+PBCfCzjR
	DTqB7TD6zPSgMDg7k9+WcXUPi3U/j+xTWnvCeIHdwNktIdAwfmoR0hvfrYOWI/exDqGl
	vDZ2kv+aFgBzvfORwH58UwSVizB77mZUueta7/gsObkIRmNNsIDlBO4Td/GXUkVxKRDe
	RqxJvBjWGSvDWQq53er6K9JH8FyY/pJ33UZcWqP/NMKAtOIrthsyZFWWbT7ByoCytH4l
	jtfr6IpPIQ3+NGNXH82ZQ+E+RThA5aN62YZ9DSwf0rlctJZhfdjyroqdcDmCcf9YfmTi
	BIkQ==
X-Gm-Message-State: APjAAAX4O0bgBZgXWJhl7xNf3yuBIZiQg5hyvRYK7BZHp+WGrYSrAb7b
	K7xprpLwQgHKIIJnKUcQ7I8D3H/P6nM+gUhFEBLkLw==
X-Google-Smtp-Source: APXvYqyou3Vaqk/Ko5JtbRfeVgpYQ0pWBO1BSomP8A5Hp1suOaxBYnYnEN6POthihMbEEPx8b2TJTf63PSYW03tbz3E=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr8551152otk.363.1556545224685; 
	Mon, 29 Apr 2019 06:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-4-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:40:13 +0100
Message-ID:
 <CAFEAcA8q2ZTvFco28XTqgfMq9LQDJg6m9Dq98Y+N2xKYR1zJqQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 03/36] tcg: Create struct CPUTLB
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429134013.qxBCFhUQgwr-xTf4Kx2BSxXPcZqNDSfqwoK8N-M932w@z>

On Thu, 28 Mar 2019 at 23:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move all softmmu tlb data into this structure.  Arrange the
> members so that we are able to place mask+table together and
> at a smaller absolute offset from ENV.
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

