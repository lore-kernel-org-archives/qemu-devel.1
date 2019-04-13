Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A6C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1C6218AF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsRgPu2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1C6218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6Ce-0005P6-Ei
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:07:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6BX-0004VL-VS
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6BW-0003IL-2q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:06:19 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6BU-0003HI-CN
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:06:17 -0400
Received: by mail-pl1-x644.google.com with SMTP id w24so5854970plp.2
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ah0N9MOzWRJWYhYxnfFUZ6U0nM7pZnUix3/LrLVnVyg=;
	b=PsRgPu2QXV0nkeRbPrSraL7JS+fCV6HH48x/+NTUb5nbuAcLMhczI4qUQCknxQ6WEd
	e05jeUcoHLFAse6+P4Z4vkfOpf9cyjEh76UsFtv0uUZ8o3kEA7eVEQ0wfHgKX9Rs6eDK
	PxXAM4RBTz2xug5/e2RyAlCO/isXg4CxAhQ5BpeN3SOn9YOmKEKq20p4LGUdctNIGJpo
	4ToumJLTZ4U+K2epXBBmGJoefl5x8PN3iyOmdUjTU2cQM6lIXXhj33wsP+z1OJzJvbBQ
	+wRpP9XomTyWUJW+5gyaL6kLJEVRatHPlhpDa2IOwrrEpwlEOSPWx9G8THuoFl1XjUyb
	zOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ah0N9MOzWRJWYhYxnfFUZ6U0nM7pZnUix3/LrLVnVyg=;
	b=NTnjppI03j9ddw4jBgLk2DgP+jSL9n5fMveXvcAefu5u4xnnIG4foRnU1w6zLz7joL
	sE5kJKFHs53NDqf4oV76Nj8TW37Oqt7aFP0s10zUnLx8BFP3s04zJCpPfolJvtidPqVf
	wfP2NPQCyhVk9iueIFt3O2I5HqUjahiBsALWuPOSZ2R+3S8Ws8kiyCTzonrta+7g4nih
	FlEKygVzkxkjX+QgfhDivTn71kTXBRiQirNy10DSHg+h2jD7XgMlNvnrTOR9dHEeITkI
	BWP5TqseKV9ObzNL20jnCQOdzuEb8es670Hxqng+XSa9IgUnFVnSbdcNoVWYZHrK9xfc
	WV5g==
X-Gm-Message-State: APjAAAWerqZJu4VNUeApFPRqMj/O722lbkB6i6L46vAUuY6okXw5Tmxz
	zv1HXRfmIa634k8t7WMjzi0dvg==
X-Google-Smtp-Source: APXvYqxj/hzD0cHXrdS9M6Ahnhs1NLuDgEZWDSrfp/rCknt3t8nZxKgqzl61CO3cSlR6s78t7HOFkQ==
X-Received: by 2002:a17:902:ac1:: with SMTP id
	59mr7095984plp.294.1555113975011; 
	Fri, 12 Apr 2019 17:06:15 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	c17sm64110393pfd.76.2019.04.12.17.06.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:06:14 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-24-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <77204b5c-c3d0-6232-e546-a1ccec9bcffa@linaro.org>
Date: Fri, 12 Apr 2019 14:06:10 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-24-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 23/41] s390x/tcg: Implement VECTOR NOT
 EXCLUSIVE OR
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
Message-ID: <20190413000610.8rN3AapS_5ef2AtcfZ8wzNej0EtUH1zNXBONtCe4c3A@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Again, part of vector enhancement facility 1. The operation corresponds
> to an bitwise equality check.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

