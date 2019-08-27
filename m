Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA055C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7517B20679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROckNjNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2iY3-0002wW-MB
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chmeeedalf@gmail.com>) id 1i2iXC-0002M2-RM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1i2iXB-0002kN-U5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:57:46 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1i2iXB-0002j9-NC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:57:45 -0400
Received: by mail-io1-xd41.google.com with SMTP id q12so815552iog.4
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vN4+sJ0VLVCM4HQphrZck4ZnRPSSdLmC9yNr6/kM0qI=;
 b=ROckNjNz8EOuLwup8eu0su5T8HqWTH7+u3DNWskQWtoDxeQjsCcibR6+VlejvAEoVq
 Tq7pDn+mXi8f8yFBvC2LNAPwZr74OvTqo494IsCa3jq8ZgSUx7BkqpfYAUbgggpMe8VM
 5j50anWGvSeKU/W9FRdtIbljRDRpL9yJdJIqd7HswEyoVBa6lu+7UcI11i0DHGAADKC/
 jbLyhqPprEgdhLOEVFGIY3hT13xwhJw/0BNwz8QldoyFEV1cE8Aeu0S/oluis4BdtH+9
 8fjBl8xlCiv3LwcS1xRkf6bqA1C8cVYcdFfUSkVYbPMjcyWWcAMnqhwqthN8obPGS2gN
 VYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vN4+sJ0VLVCM4HQphrZck4ZnRPSSdLmC9yNr6/kM0qI=;
 b=KTHY9Q3rQ9e2Z7bGl0iYKY2wWAy0LKhOzCURxtTfcy8o9/pg+FuVX3/sl07s0nNzlb
 rK3FulAVnacYr1IWahknq5O/7AmVzgrwVpLoukQtlmevTTQgY5YXeidV1Wt2N9U8zBck
 k9CN+h1J+ArgF77R2viO4Y3a3cAfJDUD43sGAAl3RCOBVLxjkWjbfZ9kfHT5kzZ+9tNG
 EOY8XtUMv5WY1xsEihysru/wFVkKKIIQQiIGBB29dfWkAvyum5erh9xM+d0fsJYSGr5p
 ggULVDch0lEXx6SSl35F0BaUGQUY9Euc9//vXTBPl7ioUKrS67Zt9fyYMjVZPOV1j8yB
 iNsw==
X-Gm-Message-State: APjAAAX32Qe3lfdge+uPQOmWeJKk4IAaQUVns4m4yly0Uo+48uKDyrK3
 YaQDPhs0nKC9FW0mABovv9EszevX
X-Google-Smtp-Source: APXvYqx5z1mJA57tzkQ9KAktJZ3YrSnofLlpW+xRXYBTlV0ArOydR8KerPDFyPDEh7aNTYtwdYjfkw==
X-Received: by 2002:a02:a812:: with SMTP id f18mr851054jaj.1.1566939464115;
 Tue, 27 Aug 2019 13:57:44 -0700 (PDT)
Received: from ralga.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id n22sm269077iob.37.2019.08.27.13.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 13:57:43 -0700 (PDT)
Date: Tue, 27 Aug 2019 15:57:39 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190827155739.4f759f70@ralga.knownspace>
In-Reply-To: <20190821082546.5252-1-laurent@vivier.eu>
References: <20190821082546.5252-1-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Subject: Re: [Qemu-devel] [PATCH 0/1] Fix cacheline detection on
 FreeBSD/powerpc
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 10:25:45 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> This is the patch originally sent by Justin, modified
> to change the parameter size on FreeBSD only.
> 
> Justin, could you review and test on FreeBSD?
> Peter, could you run "make check" on your MacOS X host?
> 
> Thanks,
> Laurent
> 
> Justin Hibbits (1):
>   Fix cacheline detection on FreeBSD/powerpc.
> 
>  util/cacheinfo.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 

Hi,

Sorry for the delay, I'll get to testing it tonight or tomorrow.  The
patch looks good from inspection.

- Justin

