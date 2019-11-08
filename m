Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53586FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B979206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UV+W1+Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B979206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3yJ-00067Q-B3
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iT3xe-0005gl-Pu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iT3xd-00043c-Nt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:05:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iT3xd-00042s-Hu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:05:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id q130so6174558wme.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e+tnVJwiSi0negK6RMY0UK7F0x4S8fjEfhzI1qpMdBw=;
 b=UV+W1+RrPp6uh2hsIh+/n+VzKibK15WvJIr1j2AAaIMzBMW+5BWNWOYJt9skvlPxXd
 Te3cOqYz2aAz7V156CMSNQUtTlGZOtgbFhknvQnLcA0tXxUvEGTNJLSllNUCYXtjgchh
 EcN94nOtUE2WsVlTdXiIxxuS3eTtCCaOqtGKSSNyOaRR/kRkIDBgkTcOWUNf3Fb2qHZD
 6czZsbj3UweiISLnF3ns2ZOCuKi5ogZAaPGwm+mks2hn68hmAavl24mzQtEweEgSqTnh
 kiiwhQBktmzOKQiJv/8HvGrrlS5IuLP/xxZLgMQil2rAD2Z84KcUvmWtoGS203LHDdLf
 g0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e+tnVJwiSi0negK6RMY0UK7F0x4S8fjEfhzI1qpMdBw=;
 b=HhpJeR9RJwBu329YJbUZCNzsOKBZhVQklkImVoNxWkc58lYBEGVovoFG3047LH8zZN
 hgmdlJBafmTnXY4r48UIpPw/COnxAhnowHYFlpIk2WGvl94rMEK0wRX+2oSINfJOFnuI
 iACOAIWMh8d3+hL+mxWB8ALEdZaqSD0skoubnkgAq5Ek8TLI6qYbOEMLRbUpA39re/Vc
 k16n3vDNAlSbuhkVUYffqGydzbdaQa4R07BiqHMOEbJpRdbkXIA7BwF8q3yX0J0pPJjG
 xcN8VN/IveFtE/K0UV/H9E2wOdDijKnNNPIYfi/JYX7i77qXvrNQ75pASyOSSjs5ubIB
 YCZw==
X-Gm-Message-State: APjAAAUJSKDkz7+XghmFAncqh7vfUTNXMtPKQOZnUL0BQiNhpg0LDdaF
 7JncbW4O62ygljX7PVjZDYd5TA==
X-Google-Smtp-Source: APXvYqxGSFqfpqFoseQ+9l62Z+zO4TtVPHJyR/SojFMH2kQlAbZFtT1Y2rrdPP/111loE6xmDAd7FA==
X-Received: by 2002:a1c:dc44:: with SMTP id t65mr7522229wmg.169.1573218356246; 
 Fri, 08 Nov 2019 05:05:56 -0800 (PST)
Received: from [192.168.8.102] (212.red-213-99-162.dynamicip.rima-tde.net.
 [213.99.162.212])
 by smtp.gmail.com with ESMTPSA id t12sm5402151wrx.93.2019.11.08.05.05.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Nov 2019 05:05:55 -0800 (PST)
Subject: Re: Looking for issues/features for my first contribution
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <87a796hh1n.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <afe76e1b-bad8-e531-b284-cedd5dd7d5cf@linaro.org>
Date: Fri, 8 Nov 2019 14:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87a796hh1n.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 10:08 AM, Alex Bennée wrote:
> Rajath Shashidhara <rajaths@cs.utexas.edu> writes:
>> [b] As per the datasheet, DS3231 has a built-in temperature sensor.
>> Temperature can be read from a dedicated register. There can be two
>> approaches to emulating this: (1) Return a constant temperature value
>> on every read (2) Throw a not-supported exception/warning. What is the
>> qemu convention for handling such features ?
> 
> Don't throw an exception. You can at the minimum do a
> qemu_log_mask(LOG_UNIMP) to indicate the system is using currently
> unimplemented functionality. Alternatively wire-up a device property via
> QOM so the user can vary the reported temperature.

FWIW, Phillipe recently added a dummy temp sensor for raspi4:

  git show 99c641370b52348b2893b2cd19624bf9a416ccfa

wherein he hard-codes 25C.  Unless you're wanting to test the
guest kernel handling of overheating, this seems sufficient.


r~

