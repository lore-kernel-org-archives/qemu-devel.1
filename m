Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB1EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 20:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD34D20881
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 20:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ougrnLSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD34D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53642 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQdqw-0006ug-4L
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 16:16:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQdpE-0005yG-T6
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQdpE-0003Hz-1r
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:15:00 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:40866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQdpD-0003Hc-QO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:14:59 -0400
Received: by mail-pg1-x52f.google.com with SMTP id d31so111864pgl.7
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=LUOl7Aa8oTxi3OWMpOoCWP+3n8pVS5vMOJqGBVgPMS4=;
	b=ougrnLSG3PyQRkAX8A4JaGP7yc2Km4TL474VywuvtZuGk1+AaO4q9O63GDUQ90IhOs
	FRsaFVWtoRLFRwHq5Qy6q0MrLll/nh0kALOdKiYd/UqFxlNx2K0DMhTDG3wtlOVuv3NG
	QRGHlBaAS7G9tG7Sc9SozB1JoSsOFOJvoYwEp9U1WKYvgOJHVmN8KTliV4MYc4MLP8AN
	ERFQ/G/fDqrv++1cgavRNL+xVGEcyS3oY2gr/FHtoWdGDwQKC8kjiJ9/5A+sQK+zJH6B
	EgSVQc134fT5MeuIaj3CcRYgdMVi1URubl9FK8EUoNE0Dy90l4iwpi/eVoYTtiYmPdww
	h89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=LUOl7Aa8oTxi3OWMpOoCWP+3n8pVS5vMOJqGBVgPMS4=;
	b=hrASuu06WpQp3hnMeacjN63SQseUOqsx7Nl6VjuBm8/+MTnN2c2w2KQMda/hHEMf6g
	cbAu+d48Z3i4cFq/qzmLWwZ5YI4zq11o6x5Md8+SvIULB80GAOeM8y5jxQcLCsUxniDs
	W8b9idTqZtVyQsYaPt53+bkF84qVwf0hKycbvRlQxKymXgWdMYJySmopk5/rc+FzsV5o
	p6lxYmf2cm8wHsomz6Dw+6g2a3BFE+gjZtvKIqOIPdTSN4Kb9X8LtJ7icp6LxfFdVNkC
	o/QvC/vOcHdSUeHu45Qhedmbr1x0AA1cb+I8Y4G7IhVoPQ8Jz6nNK6iLR3SnmYJ4udNn
	P1Cw==
X-Gm-Message-State: APjAAAWQ1+Bk+Ss+RPKZuzQbzWUw8EupCP2Z2B9QdmoQBJup/lMd96v8
	FV5IMlm7mbdzmuojEg5D6vNJiQ==
X-Google-Smtp-Source: APXvYqwlWY0f/6uOfFGLZRJxSRd2xpO5gsjvQ7kbAU4M0+MEKc8QhdrPsEZqnLOLK9MzUpCT8TfKPQ==
X-Received: by 2002:a63:db10:: with SMTP id e16mr39990150pgg.142.1557864898126;
	Tue, 14 May 2019 13:14:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	n9sm2540875pfq.53.2019.05.14.13.14.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:14:57 -0700 (PDT)
To: Andrea Bolognani <abologna@redhat.com>, Andrew Jones <drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
	<20190513123656.6iu7ebu7zucn5mxt@kamzik.brq.redhat.com>
	<e38aac8cb33c5782499b4ca0356c43267f05dc5e.camel@redhat.com>
	<20190514125329.mi7ctaoujirwm6gs@kamzik.brq.redhat.com>
	<1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1cd94ba6-2bfa-645e-1034-dd05e8a77000@linaro.org>
Date: Tue, 14 May 2019 13:14:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1857a74ef586a4e41d93b184498cfcf6c2927cec.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
	qemu-arm@nongnu.org, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 9:03 AM, Andrea Bolognani wrote:
> On Tue, 2019-05-14 at 14:53 +0200, Andrew Jones wrote:
>> We already have sve-max-vq, so I'm not sure we want to rename it.
> 
> Oh, I didn't realize that was the case. And of course it already
> takes a number of quadwords as argument, I suppose? That's pretty
> unfortunate :(
> 
> Perhaps we could consider deprecating it in favor of a user-friendly
> variant that's actually suitable for regular humans, like the one I
> suggest above?

Why is =4 less user-friendly than =512?

I don't actually see "total bits in vector" as more user-friendly than "number
of quadwords" when it comes to non-powers-of-2 like =7 vs =896 or =13 vs =1664.


r~

