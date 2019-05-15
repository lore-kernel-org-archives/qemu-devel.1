Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B61C04AB7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 00:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758F420862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 00:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gukC8KrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56919 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQhq5-00066U-LE
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 20:32:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQhpA-0005p3-CV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQhp9-0004lH-HN
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:31:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQhp9-0004ku-B3
	for qemu-devel@nongnu.org; Tue, 14 May 2019 20:31:11 -0400
Received: by mail-pl1-x642.google.com with SMTP id g9so409071plm.6
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ay36xswJnI9uCkH/zcYhwSWZ6KaPY3ZfMAXmPgj9ujY=;
	b=gukC8KrUtWsAn+eR3g7mI8xVm/ru6N+XvB1BT02cOQHoxzr+7rhzHkLJcJPhItyp7V
	Q0tAxxSmMo2lcCDGIEDNdMFL4nBm/blB4mZNOpJDFWhSCcAUA3DSgJc5WQ0XU66TVZK3
	VGKLZg1O0469iSMWMhM1Nntoob+MxbKBHddjonpFJ8gso+ksI7l/n46z/vCaeaugTw2u
	isUzWc+8rNgT+ajN72EZ5Wi1acB6GuZZP7CLi28wMad1QDWF6d/4W+n2PKN6YtoKF61Q
	rSQdI6/kH9SrHylweSrazamtDsOOtis04GYU3ANRMr7Be0qtF9yhKhNewcH+XeV4tXYN
	7+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ay36xswJnI9uCkH/zcYhwSWZ6KaPY3ZfMAXmPgj9ujY=;
	b=DLe5kP9jiaVCv8+RzfMWhnyflH/TeN60M9mdk+fGbiFrDkKZOeQ3vbYwfEyXBrZxEe
	ZwTXlDC9/RnxBT+GLg0bb3lgR6IzSANDm0g8pyIZAdK3vIyt+HQAIA5k2E9ThxSHhtbR
	hjsSXNo3W4toUCbOJx7QjkdVfpwsnk+0k9cYFKv9oN2P+H2u6Ayq1IRlAw3yo9+9/PLe
	3w/gDqxYPzOUeGK3+v6Au2UI7eqE5J5JLGRCoyPPWU/pDGNVtjk+bXb0WNvb38XaQwgt
	UNPQcddeGeuD/EwFka6scnCssRkfd2kU7UvGH6d84VhTvjd5AQMNNy86KUcEagopyN/D
	qmLw==
X-Gm-Message-State: APjAAAVIwg+c9kU3y5RCbBnwLl1J+lveceZzbPDik1lXNaFJftKJeKQf
	VCm3rYQH6zDmWwHZ+DCw1thaKLDNhzU=
X-Google-Smtp-Source: APXvYqwXwqRHnv4M4e0nqCKzeFWx+C+nuPSrtY3tCVruCPpemOwY/qF9lQci97dUvokvmfc9aVZuMw==
X-Received: by 2002:a17:902:4624:: with SMTP id
	o33mr22845023pld.268.1557880269166; 
	Tue, 14 May 2019 17:31:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	r64sm390826pfa.25.2019.05.14.17.31.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 17:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190510032710.23910-1-richard.henderson@linaro.org>
	<20190510032710.23910-2-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <360bb191-e9cb-51ef-1527-0e0767a9146b@linaro.org>
Date: Tue, 14 May 2019 17:31:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510032710.23910-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 1/8] linux-user: Disallow setting newsp
 for fork
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 8:27 PM, Richard Henderson wrote:
> Or really, just clone devolving into fork.  This should not ever happen
> in practice.  We do want to reserve calling cpu_clone_regs for the case
> in which we are actually performing a clone.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf86d..f7d0754c8d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5553,10 +5553,14 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>          pthread_mutex_destroy(&info.mutex);
>          pthread_mutex_unlock(&clone_lock);
>      } else {
> -        /* if no CLONE_VM, we consider it is a fork */
> +        /* If no CLONE_VM, we consider it is a fork.  */
>          if (flags & CLONE_INVALID_FORK_FLAGS) {
>              return -TARGET_EINVAL;
>          }
> +        /* As a fork, setting a new sp does not make sense.  */
> +        if (newsp) {
> +            return -TARGET_EINVAL;
> +        }

This causes failures for aarch64 and riscv.

We have to allow no-op setting of sp as well.
Other targets set newsp to 0 for in vfork.S in glibc.


r~

