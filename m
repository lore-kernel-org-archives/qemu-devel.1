Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A548DC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747C826D8E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBPcW8uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747C826D8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWllu-00015K-JH
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:56:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlkD-0008OE-Kh
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWlk7-0004bT-Fz
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:55:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWlk5-0004ZO-IT
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:55:02 -0400
Received: by mail-oi1-x244.google.com with SMTP id e189so1630319oib.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=NRHVbA9gBwkSnfl0Zau2HY6xRzRzLCx/HaNqpNvVpNI=;
	b=jBPcW8uSj0F8c97C3GLL14FAdIFPBbmgxAebRStwqQqI9oT4mUaDbxrVN0dVp/E3Ou
	IWEoDE/VXNQTu2zsFGRTt9iQqejmi8Blh4x81Hi63IUk2L2QWawlyl/OX25OcpouN1bw
	xPIJjKPQehgaZ2KmpwQl3X0iJNjpvJlUbpkoEwLm1wSsxTdjuguGs1LEdxAgZ8kARvFq
	yIuZ+57Xdjp/M1eNKizsxlZcUmivCVXvfJVVbinnYgYtSHBaEkSrjLgtBmYR6+P4lE3L
	SnLf4IVuJ+F+++1/rgd2R9fpZZwskU4PSMBXfzCCmonavY/lldvO4eLnf6z0p5OKE8gy
	3L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NRHVbA9gBwkSnfl0Zau2HY6xRzRzLCx/HaNqpNvVpNI=;
	b=GHaPKSwdCwrguGHIt8Cs2YxZoxKzZmcCIBY2LQIxurQevHddqXtyWUYp/Fc+U5MD35
	DTPHbOUNOZTQhnuXJcBOXBORl2jKyvml/j7ttkwS8CFYDz2QJ8zjmzPddIvXLWG2dPyq
	/cAifqKGto67G8GMFXwCO2/s97ukZoBYj7avkZG387ZR21Gxz6a+I27aNoDKZTwY5JAN
	NKZL41kZL3o+DiTm8GdNO7G+BwotYjcFAMOSLfOvt+U8jf1PVj5BCL9K3xc1cpmAb3TW
	Nk/xCsKNyxcT1LBRIRdwiSUoo/CvMaSmmACXoj+ykOPjV1NuC3KknloFnzcI0cJhiD6W
	yX+A==
X-Gm-Message-State: APjAAAW7N2IG77KeZ86ogLc+nbhyg9t/Vqz1PMFSmHvIbziBfMtIlJpK
	/U3twV/7FP1nMiP+OOMYCkbvibPXohu4FA==
X-Google-Smtp-Source: APXvYqxSyt3CtJtLX1t/IYanoiuwJ0BqsTaTCJeIa2P0b8k0JYB05RAuN3Y2TpHhph0NQWBqNMUQWw==
X-Received: by 2002:aca:e044:: with SMTP id x65mr31858oig.70.1559325299539;
	Fri, 31 May 2019 10:54:59 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	w79sm2296974oia.46.2019.05.31.10.54.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:54:59 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-22-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cf23d18a-18e9-58f1-9f30-1501684b8268@linaro.org>
Date: Fri, 31 May 2019 12:54:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-22-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 21/23] s390x/tcg: Allow linux-user to
 use vector instructions
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> Once we unlock S390_FEAT_VECTOR for TCG, we want linux-user to be
> able to make use of it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



