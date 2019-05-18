Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A3C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 16:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF36A20872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxJEyiPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF36A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1ow-00065N-GK
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 12:04:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1la-0003n3-M4
	for qemu-devel@nongnu.org; Sat, 18 May 2019 12:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1lZ-0004Ds-Nw
	for qemu-devel@nongnu.org; Sat, 18 May 2019 12:00:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:43746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1lY-0004Aq-Ll
	for qemu-devel@nongnu.org; Sat, 18 May 2019 12:00:56 -0400
Received: by mail-pl1-x633.google.com with SMTP id gn7so558444plb.10
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=GJzjp01b8e54L61pvPwut/EieHixGIxiDwyZ0C/n5EM=;
	b=sxJEyiPpdiEwMSRWOHx4LFtwSnEHs6SpvC10cShHLUZaeyoms+vin2uqdwsarkkQDm
	MgADo+7uD/BRqcCQVt3O25LDywrW59RmCcGD2T5s2+FQhFUME67N08LV/FVuvnD38reI
	pdXu6ZCN6iDIYkQTJEnfWo6yIChgFdxExbrpNfNTLcPWdIqphXMREpmZouzVae2VWcJ8
	Dh7FPj+HrROrQ0PqQvyD9qfRdqgBHlcqC/SXHIw1TF3RMzzG5IXp5fTjy72KsRXS8ZbB
	E+PXM9x6LSEARlRrejsFgr9CEp1He8wmc3z5cJCMpO7RFKML3Mly7v2B5aU3We9Ujmim
	/a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GJzjp01b8e54L61pvPwut/EieHixGIxiDwyZ0C/n5EM=;
	b=dSQ9GbsH0yWUp6Z2assVLX7mhheGHa04Ffd0A5ik430RwJ55nrAdV0V2u9JavDsIO1
	cbNdD1LJoD1ysTX6YVblHQ2ezh9zPqRvV2cfpDUuG5m0IGTGCYXBufyEBfn6b1VvVaaS
	jb5dJ9SQ1Fex3dcvTGZ3BCfpO0tsnc0kYEhEhBWm9+ru2K/u5AsDCAVBWbd64EgJlVWm
	QxHNIlsKCw1cnloeN8zjmxFSJJWqMx6+X02PDRGIPZfiTM4x+IRpONglpDWVQv6tHx/i
	T3c2ttQ2N859jMH2esCUNc4lya2qUn7SAmCHF0/ZEAUC6vC8wWolZyMb32SneXC+rRdS
	xsRg==
X-Gm-Message-State: APjAAAUqTOwGTT4OIbfTMZwB1A5hd01PoTrV8ns0LzzrVS9X/nmF6dIh
	omJM5coOQfhfJzPXAl+SD74fsw==
X-Google-Smtp-Source: APXvYqxPi/DJmXdGYa7XloJr/fSmpS4n7uKM9esnNNMXhjV3cuzyRauqj4/VaPr0k74SOwNnUyG2rw==
X-Received: by 2002:a17:902:298a:: with SMTP id
	h10mr37775078plb.6.1558195254635; 
	Sat, 18 May 2019 09:00:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	19sm20411986pgz.24.2019.05.18.09.00.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 09:00:53 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-12-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6f4c45ea-09b2-0fc4-5c11-ad2e6c01c893@linaro.org>
Date: Sat, 18 May 2019 09:00:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-12-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: Re: [Qemu-devel] [RISU v2 11/11] risu_reginfo_i386: accept named
 feature sets for --xfeature
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> Have the --xfeature option accept "sse", "avx" and "avx512" in
> addition to a plain numerical value, purely for users' convenience.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_reginfo_i386.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


