Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCBDC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72B526B3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nC3GKnZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72B526B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWj2O-0006kw-Uk
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:01:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWj04-0005AJ-BY
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWj03-0006tV-8M
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:59:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWj03-0006s5-0T
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:59:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id n14so9471829otk.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=j1ZHhwe+yzamYZOOliGnDRxB/h8lFwkpybiuXwA5Gf4=;
	b=nC3GKnZMdGhVv/936AhSJJB6ZW/LUZX166DETf5HUUWlcxsScx4psQpdQs1/Hc2qZq
	l+2dg95MLHHjL29U6OgIFWj41TRAVw8M1btvlgxcNXvpoFtzkLLAt/ZTilTLJ+1+V3uy
	BCG9yvDF77ZBQPzjahOiyN+cz+WmzoM09LXgsXIyxcDOM54WuPxs0G5KaBr2kiu6gfyX
	33LiBQxinsSHVio6h3iRTaWeFa3CzArshqB7C53izwP2UsHMs2oFm5maWs89wvZRY7Lk
	HCHNW0JB/GvJRSibeVeQUIE19O8+wMmWYs7qknTedv2PvYxLSN99gRk187vTJl9p+Ytf
	W8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=j1ZHhwe+yzamYZOOliGnDRxB/h8lFwkpybiuXwA5Gf4=;
	b=CQ5H0p+Yj+aEgrmIHWGY94bXMNQVuYpnIMUi5eXIjbeSUcu6HeL9YrQztfz1SvNq2C
	TiuLwAYrLIjuyaHbfm9QMSiS8/FdTx+ML4PPwJW3Rz24fZObew5gAvVx0+wvS6ooiWCc
	khhh6RQZsAVi4wmNDiTMhObVeNA10BYJ1fYRZph9AL3dHzHv6cEJ3glZs43jv8J2oC5w
	h0Iat3hOK4BU+8ui1nX/0pSXLayHk6NDQxRoQXgcbyRZQwmwlI6cUQAoyw7Le84bOcE1
	k9xT+b9/OiIS12GSWajlcUvDF3Pgcxgo2DvlWuzRUgCDMZoFXd7UCxerb79V0iIwi/9t
	lu6Q==
X-Gm-Message-State: APjAAAW+Wp1xSobShdrbbguPuxxm8xiIBOIubUrUsXlRHFjxFzGHqFWH
	cGdBm22vR7croBX9dYscyFDb6A==
X-Google-Smtp-Source: APXvYqzm+cu0o4V+Y+n3s7LvIU2zG4T3yxHgvSZxQPF0CJPzrL6nAf8O96PEemhI87tiqXcJ9fI4tw==
X-Received: by 2002:a05:6830:118:: with SMTP id
	i24mr2136027otp.307.1559314757493; 
	Fri, 31 May 2019 07:59:17 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	f186sm2114205oia.52.2019.05.31.07.59.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 07:59:16 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-14-richard.henderson@linaro.org>
	<20190531162341.3743eb45@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6e7ec64f-43e2-fb66-3e47-ea7ff0f86eb4@linaro.org>
Date: Fri, 31 May 2019 09:59:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531162341.3743eb45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v16 13/23] target/rx: Fix cpu types and
 names
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 9:23 AM, Igor Mammedov wrote:
> On Fri, 31 May 2019 08:43:05 -0500
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
>> There was confusion here about abstract classes and naming cpus.
>> We had registered a concrete class named "-rxcpu".  This was put
>> into the default cpu fields, and matched, so basic tests worked.
>> However, no value for -cpu could ever match in rx_cpu_class_by_name.
>>
>> Rename the base class to "rx-cpu" and make it abstract.  This
>> matches what we do for most other targets.  Create a new concrete
>> cpu with the name "rx62n-rx-cpu".
> 
> since it hasn't been merged yet, it would be better to squash this
> fixup into 3/23

Except that it's not just 3/23 but also 8/23.  Which is why it was so much
easier to leave it separate for review.

I suppose this could be split and squashed, it you insist.  I don't see any
particular value in that though.

>> -    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
>> +    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
>>      oc = object_class_by_name(typename);
> 
> in case of new cpu, I'd allow only typename as cpu_model
> 
> s/typename/cpu_model/
>   
> which is compatible with '-device' naming and QMP/monitor interfaces
> that we support.
> 
> and I would not add other naming schemes /like adding suffix to cpu_model or .../
> that  are existing in QEMU for legacy reasons.

I don't understand what you're looking for.

Do you want a type called "rx62n" for the concrete cpu instance?
That seems to be contrary to every other device in our system.

I hope you're not suggesting that the command-line be "-cpu rx62n-rx-cpu".
That seems pointlessly verbose.

If we're going to change the way we do things, we should do that everywhere,
and not make things different for only one target.


r~

