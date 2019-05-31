Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C70C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E0D218DA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuCHmoPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E0D218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlnt-0002Bv-HQ
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:58:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWln9-0001tE-1l
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWln0-00084D-FM
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:58:04 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWln0-0007ek-6q
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:58:02 -0400
Received: by mail-ot1-x341.google.com with SMTP id k24so4929484otn.6
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=pfFDW6nDCaHvEe9R2InzlAHFQJKyxceko0mAGRagKI4=;
	b=MuCHmoPpe3POhnpCaR8W0Ey22VoaJgOCCaiJqP+9hJiJ+RzeWXLS1aJedNkwjG1hRH
	ROdN4UhbKNjbthPOiCR8C3LbKYaH6sEqapyyJNxjDbokLhLflpytBTGDoGsdJYYa8jbZ
	05o5BK2GWN5l23cZoUzYkQkal3mK1mjWkiP7V+MdhGg9aIAwhb/jrB+R09e5F+8Ebi8a
	tvdFY4G8kCkQlHT61dyP4fqHM16IC+TK7QtTbmGP0dfG1wLwj9QFAa43QeAdLoif9412
	FJKj6XXVlggC8QwnI85egVd1CWBVK3Rys5sLMGRum2vjCqCMU+x+ghmIqDbBVj3myO33
	LagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pfFDW6nDCaHvEe9R2InzlAHFQJKyxceko0mAGRagKI4=;
	b=b1Wr9T4ICaEDZq74Fr/7vyFVibSa6+fH8d4lOliAdKQSY66ZwygAwCLiL6YMpWe5rv
	56o8/FQ7wVKLz7wCa4lLOCNGbwnB9P7h4yRB+8B4oDWKQpsGIQaCQbnmP2v7KXYBtzIQ
	PIOJRPvvNp2pwQiXqFR0T/9v2xcz6A4Tlfg5I0bZBi321boVEt3uPF6G04hujxhgJWTJ
	98z88oRQ4Dcp1m0wicgCImjdDXiREF135hITng1z7f3x0ytd77bbt8qPWV5nM4wLQq0s
	3uLrw6zDA5PR0ZID3gCF4Elq+/Ji8ppvAs0ENxnkSn30sPyLoDgL+GDJmmRwfzmJLa9h
	IH4Q==
X-Gm-Message-State: APjAAAWE9LIUD5g0VaG6RbAeGJzKRnYq3h1GdldgK9NqkT51Qe/AgL57
	0/4gq6DsBAXm6JOJIVNNeZGQk/f8PCriqA==
X-Google-Smtp-Source: APXvYqyfdtpyG9RToygNGgb7TEg0ltpftzxKkmgBbsvvDhtROuUb7g4tzgxAQzO5Y3at9JDr3JGx/A==
X-Received: by 2002:a9d:7b4d:: with SMTP id f13mr2798117oto.82.1559325472712; 
	Fri, 31 May 2019 10:57:52 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id 37sm2620541oti.45.2019.05.31.10.57.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 10:57:52 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-24-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a65ae6d5-e9cd-a3ab-c770-5d8f3fcaa6e9@linaro.org>
Date: Fri, 31 May 2019 12:57:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-24-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 23/23] s390x: Bump the "qemu" CPU model
 up to a stripped-down z13
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
> We don't care about the other two missing base features:
> - S390_FEAT_DFP_PACKED_CONVERSION
> - S390_FEAT_GROUP_GEN13_PTFF
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>  target/s390x/cpu_models.c   |  4 ++--
>  target/s390x/gen-features.c | 11 +++++++----
>  3 files changed, 11 insertions(+), 6 deletions(-)

We should get around to supporting DFP at some point.
The code is all there, used by target/ppc/.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

