Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B51C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C38E20674
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeEuCPco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C38E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ7oi-0004Dv-CR
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 22:39:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7l4-0001LH-9a
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7X9-0006Km-U6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:21:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:46180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7X8-0006HW-0V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:21:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id o7so6214092pll.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=awSJgQAoQVA5ExwYBvo16thb3xfdL8UgbbmHfDB5SYI=;
	b=HeEuCPcob66BMK78I7Achv0OG1p1gwK67/AjuXy0y1BFK/uWO+Y2tihJsniM5c32S4
	DVWFN2vEoTT/nFEyMrRqey74OgZBJvCHDcXP9SvIMAfih7+6++bXFPOT8Skmbu/YEkZy
	d6w1OJ5GUknKAHyv3GVMwwlg0RWqEJnf/CWIxf3Mwpq+GCmUwDXGzKmw7NS7TKd6Fzwt
	yaoye1ejquc4MY9/hLyYx0WjEk0OczLQZ+4QzNJuNp+tfGGhu/qC8/kLRmyh7WabvzX4
	ZPXVBaX3tFC+thg+eGKTpNKbOmShg+gzanlTWYGiKP1DD2E0qqDhOMWYZ1Y7IdBFR5Cf
	h4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=awSJgQAoQVA5ExwYBvo16thb3xfdL8UgbbmHfDB5SYI=;
	b=YHJGoR8a92BpFUG7UZHqlgZwl61+H6b/cEOfxfBoojMY2eA7VKRqKLR1I/3FbLiiFN
	U2cg4A1spb+2X8bg5Oz1R8fldE+E5JySIBLhEov5iFHvdoRwmSdTMnn4fwbwYs+GrTQ5
	yomHPctc1YXfCHieBNUyoyxvNoGSmyxt4kNIFQ9v3WSYyO4MCjTKYKMWshp/KYpYjRKN
	BLMMvWrk0CvmUH4k+JVoIyOMQZz6rNKzGatb14h9B42T1hQZcgH0mGR0Hth2HQxZY6sO
	qFUwjWJqlBuhQlwO9MOVQqaPFRbiE4oP57ilmvg8JtIrXzWAjIh2KXI4glQq+NgvXiHa
	L3qg==
X-Gm-Message-State: APjAAAX/vnhU6/6QZjBYJt87QpZmL47rDH/i+r77KIP9KfH5FQtpFrw1
	J/knJ5g4GY8zwuzqEsWp8GzgRr7qONw=
X-Google-Smtp-Source: APXvYqxNbyxIRFLFHtE0AQB7EJNsS9LJkl+ozlEcI1InHS6qvSBCV5kk1nZdOCSTWGchd4BiosjEpA==
X-Received: by 2002:a17:902:7294:: with SMTP id
	d20mr22204808pll.300.1556072472439; 
	Tue, 23 Apr 2019 19:21:12 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	v1sm25573039pff.81.2019.04.23.19.21.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 19:21:11 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-26-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <772b2b44-cdaf-7fb3-2c1e-a9ad5f7ba76e@linaro.org>
Date: Tue, 23 Apr 2019 19:21:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: Re: [Qemu-devel] [PATCH 25/26] target/arm: Implement VLLDM for v7M
 CPUs with an FPU
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
Message-ID: <20190424022109.Lzq--U8rCOPyTVoPtqolI5ej_Xwd4CcrQl1rpUPov6c@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Implement the VLLDM instruction for v7M for the FPU present cas.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h    |  1 +
>  target/arm/helper.c    | 54 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c |  2 +-
>  3 files changed, 56 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


