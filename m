Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AEEC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDBC21726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AoEPPt0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDBC21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQRT-0004RT-Na
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:33:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQLE-0007lz-V7
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQLE-0007Yq-4d
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:26:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQLD-0007XI-Sg
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:26:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id v80so10842463pfa.3
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=H8uxDlAHxWJWjAcw2vTX2K1K8B3wiOmOMgTuYkt2Ptg=;
	b=AoEPPt0NAjq+Bt2iDzh2YfAwHEw6fS6q3UwlcaZaZEG/nBcC/bk1J21mGwCUOcgQqF
	sXRLmAEmUCp9I5PQ51gBNk4TLtGnfscN0fB30RTPUXyRgZIYLSEZzFcrMZQz9gUElOqU
	7JixoGo4FhReZw/8Oo0IWkS5d57qmFmMAoAXOWbBO5my6Jay8DELHS4l9lxIQOqFKplc
	CIWCfhycr5WUuHvTGmXBdScrj0vt5CoNg67d72JxAqHJlXJvDiT2aneOvUf9VAD/1KO0
	rFRVu9//3JiWXb0/Ft9a7UUHWIAHnpQtVM4qJK70fFtSXRgXrY1EYmqCKaBBVh2n5OfJ
	8HiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=H8uxDlAHxWJWjAcw2vTX2K1K8B3wiOmOMgTuYkt2Ptg=;
	b=OlKxSfWEgDPzWLg5ENwHhhBhGdGgKsRv7YAyauKZ62qMZPfB28lMGuabHozlofi/TA
	wEY7kbOvMuzEkkvFXV1lJ55nYGF3EpdasWhuTg5KbeVoLcwvBjnuYQIISPoDISl7ZNDw
	nGFxvWELpPS1r1GSmsuC4VopcCE6T3X/y5B99h82dlclc/r6GHNFCM4JZAWe5KFY10g8
	OTyW/KqddaSux/b7Ybdirs1+dIF2qj4sAaOWQpuk/VPDBedD/u0339oUCXLsFWYwOFo8
	CHz70UeHaGELiUVXeXDrKLy7+M1z2QJPHuR0JwgPVCN6eUg6ceJnrfxZZ412Mg/VZlkC
	0LgA==
X-Gm-Message-State: APjAAAXq+VPBSmHmD3IBfysgJuxJHvA9e3hQvn4M9+MJ49F9EZAxTpaN
	Lzd4kEO8rEBAVokz8FuCWlQXFQ==
X-Google-Smtp-Source: APXvYqxtQhPjqTxo/2n+dHv22em9xVoirzW2Yw+UoLYo05TO1pd0bXOHGEfZ3pU73lCwv1pffXU7tw==
X-Received: by 2002:a63:3dcf:: with SMTP id k198mr29055315pga.60.1557336409336;
	Wed, 08 May 2019 10:26:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	h4sm10871431pgn.13.2019.05.08.10.26.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:26:48 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-6-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <85c8f540-1bdd-6e2a-5a1f-efe362e84a30@linaro.org>
Date: Wed, 8 May 2019 10:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-6-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v10 05/13] target/rx: Miscellaneous files
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 7:56 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/gdbstub.c     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/rx/monitor.c     |  38 ++++++++++++++++
>  target/rx/Makefile.objs |  12 ++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 target/rx/gdbstub.c
>  create mode 100644 target/rx/monitor.c
>  create mode 100644 target/rx/Makefile.objs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


