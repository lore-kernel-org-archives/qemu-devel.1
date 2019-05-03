Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08681C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 03:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33632075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 03:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pvyl2zsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33632075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMOxN-0007sv-3a
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 23:33:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMOwZ-0007aL-D8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMOwX-0004cB-NG
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:33:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMOwX-0004bv-HQ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:33:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id g3so2181977pfi.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 20:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=dZnP0XcimJS7z9KtdMLIRwywIzsv8ucqImnPRGwp+Ac=;
	b=Pvyl2zsHQpFQl7CRTScGioVcYzEb+Rm8R8VZmd2Ndqc1sVhZymJ55l46KuPNX487xk
	C4Bzbi4e8DVZx8skRTfao0YMEZmfexz72KFTDZ5lrC0iU8xazYfUoBE9+R3LnIEy/4s3
	0oacX6yI1Kr5L3Eyd31BbZkcWc2B2VoOVCO1bgKXBwbT4aOG4NYGTIjIjHYISoG9tYK3
	Yuo42Yx+qEkaat7ZLQZ0+kPtMbBvuFyXI5/TuFlm+f7mNgWBvRjlr49GOF2ZkbOdxaWC
	oqHIWNSEBu2tqbbqz4R4oK5ezCiomJFH9EKanYOV9DxWLk86L6+GEDcIY4tX1aRLhsbC
	6q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dZnP0XcimJS7z9KtdMLIRwywIzsv8ucqImnPRGwp+Ac=;
	b=tplzkFhjJKVsBjZPYqHQrxbMLufq7vQwQ5Fl1sbOfCY8PUkw/giTIiFBYgVqUN2Js4
	IlZsSBMmbB79UMZjB+3ZgeSyF49JYU3nDTvukqL4yc+GdokQfXBN9SXTWZUOOwNyFj3x
	CeFYeK+I1mOpfrePT1HJhm3FuGmoUtJEqQK9ExB2M2qyp8+fJMAujUKKFeFMQk0OnSdz
	vcq1F1j89UV/faeYOUPtaBDWG1IXGaxWOo0fKe21/3/tSGHv6+oLDg2UL6ui5fCRo6B2
	7hew0jRME7ElyHVhdVKA1Ukk92xnZLk09zluhFmcWdqUz7UDE7J051ddF6UxgM4wpVYY
	3ZnA==
X-Gm-Message-State: APjAAAXImVCCFbQnsrHz+r9uEerPdJXe7Ldnfo2fFgsn7gv3xErFFAto
	pmJ9G+de++76LY72uS91nCsbdHWHgtU=
X-Google-Smtp-Source: APXvYqy+ci4HFwbNXd2LtGSz38vhyceTn508pP+e/doaSXeJ99GORrUgcpsHDgg3Kt4poPy2ywUr9w==
X-Received: by 2002:a63:5d46:: with SMTP id o6mr7536129pgm.217.1556854379757; 
	Thu, 02 May 2019 20:32:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id t13sm778296pgj.49.2019.05.02.20.32.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 02 May 2019 20:32:59 -0700 (PDT)
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003650.10137-1-driver1998@foxmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <45252654-7451-69ed-326e-9807f529de16@linaro.org>
Date: Thu, 2 May 2019 20:32:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503003650.10137-1-driver1998@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qga: Fix mingw compilation warnings
 on enum conversion
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
Message-ID: <20190503033257.ETMDmk_TYhYK5_1q9ZjeB7qCPCt9OkT15sfXtD7A5tM@z>

On 5/2/19 5:36 PM, Cao Jiaxi wrote:
> The win2qemu[] is supposed to be the conversion table to convert between
> STORAGE_BUS_TYPE in Windows SDK and GuestDiskBusType in qga.
> 
> But it was incorrectly written that it forces to set a GuestDiskBusType
> value to STORAGE_BUS_TYPE, which generates an enum conversion warning in clang.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d40d61f605..6b67f16faf 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -457,7 +457,7 @@ void qmp_guest_file_flush(int64_t handle, Error **errp)
>  
>  #ifdef CONFIG_QGA_NTDDSCSI
>  
> -static STORAGE_BUS_TYPE win2qemu[] = {
> +static GuestDiskBusType win2qemu[] = {
>      [BusTypeUnknown] = GUEST_DISK_BUS_TYPE_UNKNOWN,
>      [BusTypeScsi] = GUEST_DISK_BUS_TYPE_SCSI,
>      [BusTypeAtapi] = GUEST_DISK_BUS_TYPE_IDE,
> 


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


