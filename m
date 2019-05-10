Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A12FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D5B216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEoVbXin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D5B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6TL-0000oJ-7U
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:26:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6Pu-0006pr-S0
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6Pu-0000CO-0c
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:22:30 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP6Pt-0000CG-SA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:22:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id t187so1323561oie.10
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=SnOzh2ahj3YiiDODmURqcGg1qqqpBwipaak6Ip4l7LI=;
	b=jEoVbXinaFORcXOIeFHISNbuKPkyftnZ1TmoNWu1EN05JIYXGNslgULptfdjXV2aJk
	xxePc5qHgD89GvpwViADqEINU48CxYS8UDbX8RfLgzxKsXTMBmWvgNJIG39UkCeXEKcH
	NMytkO0EEJPa+Qw5bVrgH8Wmi0XAnS+caE6mqOyx/4YCcdE2lhXXPdg7Xv1JY2Mrwtp/
	4mZnG1W4DLbk+yg5NabgcurfIEJd4Q4rYR7iiLzTLANhVXiK9NE/QNkrT37XcUPQjHs0
	yxK7HJE7tAtAs9MKMYptPgAhWHawKIuO5MvFlx4rqjTezjpIFnVgo2MtFQ1iqVmLLg7z
	ejBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=SnOzh2ahj3YiiDODmURqcGg1qqqpBwipaak6Ip4l7LI=;
	b=KMCez3QdBzPz0vx5dI8mv1nlRs/1uzwNKkR8yXX0iar51k0AUCiT+shz2YoXebO6Jr
	R25F9paDC2S8Sg/vKYFcuquoU7aJjwUTTeJAT3TAGTQkd/OFAFe0sdTlOBsVpnSWjQz0
	GB5UqEqMdesrvaxgdrUc7iR9I0WrDq+vspOR3FCBX2ovY8AGSsenBjauGUXeLqS+CDdZ
	Tqo/pTYaHfSlLeNKKLZkcKto5nar20BzpoZ9Hj7FTWOnJFeQKZsOwEqIrAPrrMSKHLWr
	ku5VqdG+VnxgJ3ksaLBpo4G/u8lBNeQ8ul0seumeiY0uGfOvEAHf1OHiHOeEtg/XJvF5
	RkOQ==
X-Gm-Message-State: APjAAAWa+YTy1i1jdKb2UPUodJXIt0alz3nKk77Hsla4SQ9vmcqeYqtT
	j/gMusSQQvWIu0NJhAAJUXUHE3KRnEqSmsOf+DrUXA==
X-Google-Smtp-Source: APXvYqzY05TNMKEMuju3VfTTUPwLbVg3TWvpHUHWDklHZE85H+Cs8DbkHKUIfjhrBXlpprnOsOj/6e8w4G1FOUb6QkQ=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr5563521oif.98.1557498149188; 
	Fri, 10 May 2019 07:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
In-Reply-To: <20190509165912.10512-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 15:22:18 +0100
Message-ID: <CAFEAcA8Dsdp2rnORnzqemWspfFxfhVwkAz=2EXdupo8iDj_=Hw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 17:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> For running system tests we want to be able to re-direct output to a
> file like we do with serial output. This does the wiring to allow us
> to treat semihosting like just another character output device.
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 51802cbb266..6aa3a08c2fb 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3975,12 +3975,12 @@ STEXI
>  Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
>  ETEXI
>  DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
> -    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,a=
rg=3Dstr[,...]]\n" \
> +    "-semihosting-config [enable=3Don|off][,target=3Dnative|gdb|auto][,c=
hardev=3Did][,arg=3Dstr[,...]]\n" \
>      "                semihosting configuration\n",
>  QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
>  QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)

As you can see in the docs here, semihosting is supported on
five guest architectures, so we should implement this new
feature for all of them, not just arm.

thanks
-- PMM

