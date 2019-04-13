Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52AC10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0F20850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 00:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/mfhs5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF6GW-0008TS-Ea
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 20:11:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Do-0006Ua-8j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Dn-0004gI-GM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6Dn-0004fQ-3N
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id n8so5838378plp.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/pDyRQfR3ZVOhvXfljJIxVFld0AG5wzOACBlLJIMEgo=;
	b=R/mfhs5zY/9ARhYYl2F6h3aUfpYWtL3xknS5M4BobPKVUO9sE8V3+ufhAdhTYH1yhO
	J8XN289Wb0lf713cOIMHDJJi9Ui4UdVIa7iCA5lIz1TdeCAzxkqgHDynHzCgGbIe/aaX
	eEIB31kRcyTohkJEDzSaLt1xm2rslZkjgBWQxOYeo+xTfqUt4VD/atmhd40iznRK8X4B
	mtcJ16nb1BErgPgjwLmi2IRE3NV3Lo6G47wPY8o/Jkx0d+OB545vurltX01VxiqP3QqQ
	IKaFBwZDxjE3QizEmmZ5qICTydP146ZvstjQR3TZUyOt61mn0HeR1O+g1qlApe8kJAHz
	H03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=/pDyRQfR3ZVOhvXfljJIxVFld0AG5wzOACBlLJIMEgo=;
	b=ejeTvWWbQQ21sIJN3gfRBbj0Ls8KRiT4aUwIhrbCiyJIIBncvQKr5xwZetDEGDlPdr
	xtx89tNZ6LwNHspp/6WJGePJeaY8kL0miFkLKHJxSUJOA6Y+UOF7yxpZWUqHCKI+0svN
	pgCSUfkuZWIBBaNGBnKZakNOQxuil3+/mVjH0xF768mOTz/jlbxdjhldz/hCh9Vmw/sQ
	gCXv+dI8o2nzCG64rqroWCv4/ZOHSSPJ09DK+FWyU/AFp3eqp7wW5HuuBQ7VH0sX4rVT
	eHTQEz77KsYH88wD54vCLCo52elMF/IgISw4UbBcw/NV/IfdRe/3hOyqocrmc0nGeMBQ
	Ia1w==
X-Gm-Message-State: APjAAAVvs/U7MrP+Fj1px2sJw+X/QozWn8iaxShkTCumLWzwp7EttoMw
	UyHyBQiJPniaNijDrn+hohqM8LvQiwg=
X-Google-Smtp-Source: APXvYqxUJYmgurmHX1PzbGZH5FCrKFoJqqrld7zdfM60cI5U+NdHrJ9ae2DJb5LZe6p/KGmiaAYoCg==
X-Received: by 2002:a17:902:6bc7:: with SMTP id
	m7mr12500399plt.146.1555114118274; 
	Fri, 12 Apr 2019 17:08:38 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	t129sm58001077pfb.127.2019.04.12.17.08.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 17:08:37 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-27-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <614f17af-4445-a3f5-62b4-30a8a05de8d8@linaro.org>
Date: Fri, 12 Apr 2019 14:08:34 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-27-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: Re: [Qemu-devel] [PATCH v1 26/41] s390x/tcg: Implement VECTOR
 POPULATION COUNT
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
Message-ID: <20190413000834.Y9mNYSMZrytgFWxmcfAqKkk_9Tz0Y4VbQ68WUcsadds@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR COUNT TRAILING ZEROES.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 19 +++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++++
>  4 files changed, 37 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

