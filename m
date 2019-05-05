Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E44C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DC2208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1pU2wwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DC2208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNIui-00047S-Hc
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:18:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNItE-0003OB-NN
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNItD-0002es-SO
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:17:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNItD-0002dX-KL
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:17:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id z28so5385199pfk.0
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=My8sDQvGu+Fg0iVvD8cvROlUTp1h1gAQL8ZBXONfrdE=;
	b=z1pU2wwDq80nej6RFCBc/SVJD+JVgirPnGE39o0bDRhlWwYmgHM/J5/8nBFFysWYP3
	SQirZkMjHJpnP96Kyg2F0lOpmYJO+oWZl9rnSl4El8ZUCd6asmfUUh25+4DAbFOgDeEs
	kVVQj26i6WxeVjy+SgmKgmGavj/aGgnwx4Mmbcrmf8qKWTQc8KOL3KFIQOy/4WjSjXD3
	qmmBqdDt766KTgWdkfF9+P2pkEajo0Z0os8H3b65KdaABqtGQb9/pe4dHl4svvp4NlUc
	Ti0oAo1PBjLhgcLq+gRd/wmM6GjbblHjXSRhB+07ed+21aGTKXcONiq/SyQuNfnp1NPX
	TsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=My8sDQvGu+Fg0iVvD8cvROlUTp1h1gAQL8ZBXONfrdE=;
	b=dPYtU8BBVZ1mDeJEvEWH82YJrl37tX49JH7/7YdrFDpaKJbz6isXSIlgSXUKjLedZO
	5TB6g9wlrAu6S3rmhhWbioSXzdEXMVRDaojIPqN5p8sQDDddVsMO8IAdUXqE58l0zSCe
	N4YfHGqE1Pm7FQELCiP5QVWPEJQggKJoFifs4YW3ej9DRdxElUuzSH2XFuX+kv13NGHq
	F5cTFJSI7lUhkhqWeY6YrNOckcf+udfehsK0NEmUlVOyFVDNi6PixNDgH6G7Qmz9VTHh
	v8kMcVCfTWJaiOiLM0S9jiVeh1MuOEkrfhIvPi2v7rvUeJE2rzch2v9ynTfkCeFwL/ti
	ePdw==
X-Gm-Message-State: APjAAAUxrKncPLu28HL11/anMmJUb3+roAG6X8gNglHNXFnzicsEgwmm
	NkyiG4gppL9L+0cwq2CzVlm5/A==
X-Google-Smtp-Source: APXvYqwOcnXOm3RKcGsccIZqN4XuwFaqfeb+6N27OaMbkoVUY6zcCULW6v7Shmd/VM+Li+hlT/EJpw==
X-Received: by 2002:a63:a54:: with SMTP id z20mr25444779pgk.27.1557069438253; 
	Sun, 05 May 2019 08:17:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	h25sm4739503pfd.142.2019.05.05.08.17.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 08:17:17 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
	<3c05b552-a692-e439-fc28-90ad69767cf2@linaro.org>
	<e8968236-5ab2-568f-fd32-e9208c0f2ebe@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f0e80eda-9f10-f39f-708a-1dc08575bd9b@linaro.org>
Date: Sun, 5 May 2019 08:17:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e8968236-5ab2-568f-fd32-e9208c0f2ebe@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 14/14] target/ppc: improve VSX_FMADD with
 new GEN_VSX_HELPER_VSX_MADD macro
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
Message-ID: <20190505151715.a9KgMFZP4CUQ5_L6c_2-1ovhx0OWkR5h-huJWABLQ20@z>

On 5/5/19 3:20 AM, Mark Cave-Ayland wrote:
>> The afrm argument is no longer used.
>> This also means that e.g.
>>
>> VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
>> VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)
>>
>> are redundant.  Similarly with all of the other pairs.
> 
> Agreed. What do you think is the best solution here - maybe a double macro that looks
> something like this?
> 
> #define VSX_MADD(op, prec, nels, tp, fld, maddflgs, sfprf, r2sp)
> _VSX_MADD(op##aprec, nels, tp, fld, maddflgs, sfprf, r2sp)
> _VSX_MADD(op##mprec, nels, tp, fld, maddflgs, sfprf, r2sp)
> 
> VSX_MADD(xsmadd, dp, 1, float64, VsrD(0), MADD_FLGS, 1, 0)

I have no idea what you're suggesting.

I am suggesting one function, xsmadddp, replacing xsmaddadp + xsmaddmdp, that
is used by both instructions.


r~

