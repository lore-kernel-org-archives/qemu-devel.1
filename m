Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7568EC282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC9C20674
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anGQZu9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC9C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54994 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwsX-0004Oo-DN
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:58:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIwrJ-0003ln-Mt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIwrI-0008Lc-H0
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:21 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIwrI-0008JK-7R
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:57:20 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so7747325pgh.0
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=K2oNKXGsG7fXuJXlW/At34A1OLB+bFRg0EpKS1um5D8=;
	b=anGQZu9t+prQE0AnjlE938qY+OkFQ5AZS4AxOiWvOdKqJuP89BDYQKrdPNbvnTkIhF
	7DY2GQ5SV9zjXKoTX/OQmt/FmVKlicMClaKO/talwyX//7gaEtGKNQotClSaVvuzmzEH
	R+/exZVISQVeqKMeMfqNEx8TG0j/FL9NakjzGFnH8B1pZAv9h6frEmXIIoUnSvgzsEsc
	xdRW0fz69IFIw+lmUP5QiUUckkUV4ktrwK/P3J/mx6IYCV1h6q9eaKY3HeyIt4LP8Oo9
	UPdHX8SdvGfHLdrxe6QGC3akCvPmx4WQ5GmSqcJm8NkO83B8EFxRJhj7vIx+7k1gxt8j
	PANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=K2oNKXGsG7fXuJXlW/At34A1OLB+bFRg0EpKS1um5D8=;
	b=sEd9M3Gt+ct6Yb9gjdTp88nw64U5nnJ+NE7CHRp6ilwYKVHFWExwwyUwrM7/3knKpi
	yqGhyq2WW0Ik1TlF8XmNATtDZQtEc4KZJPUbRFIUcmquwHVqHw4d64bMIbKfRHH2yU4T
	JzvJWCBCfn/DaIhTjbQgerXEJSj61iL3NdqvoiHZ/iNo/XXCutX/en3p3lvDD7UThLHf
	gVZuQEjswfgTqL31lxq8ictUol4+K+XBcy+ilztiFWcCYslGm+LeCyCNXqMmpUDyqIJ0
	HnDIADFw82bXXCLhZaUbKRPIozxZnn4e7rSniYs3sYL9g6ABk1cCqEOdH+9+eG+Vy0xW
	oPcA==
X-Gm-Message-State: APjAAAVXgqbOlQriLqr8R5NXv/i19HDpdmwyIiUOdD2QCU3qDbOvtB+n
	9WTStIjQ+Sg1blzrSKpX33Ksbg==
X-Google-Smtp-Source: APXvYqzjwHcY5ehlsHM2bfz3+BBptOGp740JxIe1YAZNrNIf828j2W1ygco/nQMGDNLaf0HsEdqPtg==
X-Received: by 2002:a62:b418:: with SMTP id h24mr26718482pfn.145.1556031438259;
	Tue, 23 Apr 2019 07:57:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	t21sm21834230pfe.22.2019.04.23.07.57.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 07:57:17 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org
References: <20190423102145.14812-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7319f017-da46-a2ec-ff9d-29987c2d0999@linaro.org>
Date: Tue, 23 Apr 2019 07:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102145.14812-1-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [PATCH 0/2] tcg: more tcg_gen_abs() uses
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423145715.IUIe5VMg8-Ygj9ILllT4PN_NvLkYmCX0lyfEICcPMgM@z>

On 4/23/19 3:21 AM, Philippe Mathieu-Daudé wrote:
> Hi Richard, 2 patches to complete your series.
> 
> Based on Richard's "tcg vector improvements" series:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03430.html
> 
> Regards,
> 
> Phil.
> 
> Based-on: <20190420073442.7488-1-richard.henderson@linaro.org>

Thanks!  It's hard to track down all uses like this.  ;-)


r~

