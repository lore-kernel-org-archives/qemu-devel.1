Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5629AC04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9E42081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQ2f/2GQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9E42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSYkU-000651-4y
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 23:14:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSYgS-0002ZS-Hz
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSYgR-0001yf-NZ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSYgR-0001xz-0U
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id f97so5994106plb.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=YmvqVAIDHWkRj/6ft4/eUzWjHu7tcK7uvoe5yvIYvzE=;
	b=iQ2f/2GQ/tnObCNrIqo6/6gQSxSAnvymV/7tJO8xLsZsKavE10ZzAjuvLxQXfytsrL
	b3I5ARqgiHDk2DSNV6VwOexiKha8jbdo/+0G2izmN9Bg2x9mc5xfBKmtBYIWkrgxM49k
	hw1bMyRyqrhwOghzisWYAwo3f4pkkbx+6N1F/CnBeG7ZWY/3xLebxFZGrIPD/PKDKX2q
	fswCxEjC9q4GJRBFny/3drKXm17vDe5bLmiI8zXSwmpTGdnsUwabqqnvFD1xVvexQH7N
	ctI3IzMobIrIFjwORTDtSpzeWSlOqFbqKmR/KHxazl5v93/Va3Y57qCEH9VXHNYm8wwr
	XoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YmvqVAIDHWkRj/6ft4/eUzWjHu7tcK7uvoe5yvIYvzE=;
	b=Z4B7Ze0XsphC2HdxtPOD7G/IIlapLDQ35JM2Y8vdis24O8l9dE9cDtLihgxRvteTX3
	PQVYc4pKzCkmlx5eAkUXVelLI5iRjxph50vlyFGeu8Mc4i1Pp4/QM3i1/DRf0xwouols
	qWarC/LZZPqAPlp2UjM2OKycONYc+VyoibgEWJePr3DjVslnFX6nOdfqGmYgZZ1DGdYM
	AJSUk0Rg+X+Nx0AM7AcMQCkNePysle0w2o2WOZFMjq32o5zZ8JyH/nqiUaZa/HVx/noP
	yBJMrK52IdNRPradcvGcuwl+oNGyHL3trx8SHI4FQAm0qX0mOarYYRlZI7sUAeMFricF
	QGFg==
X-Gm-Message-State: APjAAAV2VSoo3C49QXml7OXgexDF8MBIedz22AxmyKXQYoECArlR5eEC
	JCQsqnQwz1YYcbHJ6+/WTiSY19d/JYo=
X-Google-Smtp-Source: APXvYqzXw2+SlzFudHemk4/kwqBpv8ZwuimupaK5r6Q2E6974XLCzszE8iuBs+S0ymcQwRhdvPpYMA==
X-Received: by 2002:a17:902:2869:: with SMTP id
	e96mr49737468plb.150.1558321788791; 
	Sun, 19 May 2019 20:09:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	w6sm17148143pge.30.2019.05.19.20.09.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 20:09:47 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190510032710.23910-1-richard.henderson@linaro.org>
	<20190510032710.23910-4-richard.henderson@linaro.org>
	<492ec7a8-b5bf-b873-8ed2-2a1faf0968b4@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <31f54a09-23bc-9d66-a720-9027c48d27fa@linaro.org>
Date: Sun, 19 May 2019 20:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <492ec7a8-b5bf-b873-8ed2-2a1faf0968b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 3/8] target/sparc: Define an enumeration
 for accessing env->regwptr
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 10:44 PM, Philippe Mathieu-Daudé wrote:
>> +/* Windowed register indexes.  */
>> +enum {
>> +    WREG_O0,
>> +    WREG_O1,
>> +    WREG_O2,
>> +    WREG_O3,
>> +    WREG_O4,
>> +    WREG_O5,
>> +    WREG_O6,
>> +    WREG_O7,
>> +
>> +    WREG_L0,
>> +    WREG_L1,
>> +    WREG_L2,
>> +    WREG_L3,
>> +    WREG_L4,
>> +    WREG_L5,
>> +    WREG_L6,
>> +    WREG_L7,
>> +
>> +    WREG_I0,
>> +    WREG_I1,
>> +    WREG_I2,
>> +    WREG_I3,
>> +    WREG_I4,
>> +    WREG_I5,
>> +    WREG_I6,
>> +    WREG_I7,
> 
> I'd feel safer if you initialize those enums (better safe than sorry!).

What are you suggesting?  This is how C works, and always has...


r~

