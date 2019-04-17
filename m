Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A559C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D9E20835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSVs8nGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D9E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46851 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcUi-00082W-DJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:48:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcTp-0007jH-4m
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcTo-00064i-9O
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:47:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcTn-00064B-ST
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:47:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id k3so11403464pga.6
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=uAEC4lLieL3CqivpBO6pmAhhzzPimAnBM2PiZ//ClwM=;
	b=YSVs8nGeebdcsZ+nYxj79nslVOeEP2OUGvveZprReGak2Qe3KPbz7akl8Va8UczmpH
	Shvha09AXrj53B4KdEmadKfI+kzNM0dZ2Z0AxQVJWn2IIRWNST91SBA5awPsVbtH+dgR
	u7SkDtW228boVabK6xFwTu6XrZRMmWOmv64Rp6/XIZTQJ3OwvDeaXGyZzd5XTxfO4PxW
	P+MRp8ptxfuEkXBA1ZkaP/ZV1d0eLjycm92p+vKVIoM8CQ8z4dVA0ua+YtqESmsEtax1
	1lfv7K/SGFhm3w+gT4jKjR6Dsv+LNJp1OSIUmg24mcP7OXrX9EECnThJoo1qJpGQ2Uh5
	USIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=uAEC4lLieL3CqivpBO6pmAhhzzPimAnBM2PiZ//ClwM=;
	b=lazMYX3LTqyiuQwE0ac1tdKaD/1aBrZ0frcWdBQMrzN2MJYzZq0UYs6rqM7AIwLQ3G
	qCGLgatpkVoCNPniWWqJF42uhdSNenNdDxJQ6wX+jDA8Jk+mFxpdq0C52vDgYKquKB9p
	Q6pvAvmEcxZwvAQyIOQkzk6Kx+3rrt4q3AXsvacVFan8B1Zo758J2dSornDEvgpiEcPY
	Z3GQZqOHxVMgGjE2LrrWtLkGgVUR9i38B6AuOk26AsGOqXxVpRmAKfoao/zDnhWLqaIN
	X/RKcLgItiHaZSE6TobC/aHGx5ZLdR2t5yKSrMIzWxZpcorReUk9zD0rc5yO5nrWUa/C
	UNZQ==
X-Gm-Message-State: APjAAAVJ/3PV8MxM8MDGwC7I2l7vhOC+SZPvQjCFmPLSyXZpJQjmOyk5
	vrR0OKlyhVV6wS7RPgj2jt7gyg==
X-Google-Smtp-Source: APXvYqwoasjiZMnM0A29ujtnKOArlN7KvpkBOhtoS4UY9Km1PVGD4b7tOV/HQRlCHEzgFvJO9+nc8g==
X-Received: by 2002:a63:4241:: with SMTP id p62mr80918795pga.379.1555476446772;
	Tue, 16 Apr 2019 21:47:26 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	m23sm80141165pfa.117.2019.04.16.21.47.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:47:26 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-29-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b50e9346-f917-1b7d-0ceb-f0c171e8e9ce@linaro.org>
Date: Tue, 16 Apr 2019 18:47:22 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-29-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2 28/41] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE AND INSERT UNDER MASK
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417044722.6TFPs5oJxyAr5h4FvAMsDgqc0al4sFeUJlNzjEiqH7A@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Use the new vector expansion for GVecGen3i.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 51 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 20 +++++++++++++
>  4 files changed, 75 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


