Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E6C04AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4988920656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijMxWvZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4988920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50347 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO3gq-0007lC-Da
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 13:15:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hO3fp-0007MP-Bz
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hO3fn-0005Tk-0U
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:14:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hO3fj-0005OW-JY
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:14:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id g9so1084484plm.6
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=MKpHh4wOTt15dGnSW++o5jiZJPmWdwfmVpYKbzTofig=;
	b=ijMxWvZb+lt5Wad0FzcPLdLjoTBwKDB7pFoO6NIiRXz+SQKh5PtFGxE/CuwZ2lMgGT
	5zAYB/Bso+zL7t4+yRJG4RUnJRbipDnReIhbdevtQJQAIiH+Vbf1W0B4QraQZnCVdStc
	dxrvZJJp5kHAtyn95i6QXU2aOSIPdqM5bZG7Lu4b0AoL/G88WsJ+31ZYtgGFB2G2vfOi
	9CU3PsbiMjmOEiBZBrXcO7jzGrNliPPn+R+MbKNHyKYNNfzQ46lNZEF5CAMGqsHoYe+M
	GatUxHEW3PdlqnGW/9rGJ3QNgcFPZnQbEXC8y7t586xMKVgwktLGU4sqCFj+Hy5Z5vtD
	iXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MKpHh4wOTt15dGnSW++o5jiZJPmWdwfmVpYKbzTofig=;
	b=L7fm4IM/95KqJZdgrju9sYndPv2KvaP4cWxY0Y3axdgyvddhkX9IHhd2ILDzHbHj1k
	cEWe9Ox/7pvGlinmeUJB/k0ZXvTdvr0XcZgCJTQL02nrY5rTaTdDbzrHFa+1fHr/0rGi
	fnvxjfcmpsPpmYwxfq5+IDJ90Dp3LkVrM0TJOH1AbdE8AkpmTE2Gxp2mdamt+ejRRx27
	NjiBnLkjjkUZ1JHsMBa1xrlUjB8v8MBd39IvFPWME6KD9qYpgKuPII1XNTUTNLGY/d/z
	C9HQdzDt5emjwf4n1zWIKm5fL/xxyNyqxgqVCGYsBZ8ToT135HwPHc5Hx5rujpTw79ze
	o+sg==
X-Gm-Message-State: APjAAAVs2cug94w2PYOQmtNCwq6673MMLm9+wYh8cLAU32oO8B8y3qv8
	xn1rah/MEGkHu8i2+s6U2MC7Xw==
X-Google-Smtp-Source: APXvYqyflyguI4HWK3fec5ja/3qAbgn59HvEt+ZRCJJaTi8ctk9u3QhHY5GErHZMspGRZ+DhxCSVDg==
X-Received: by 2002:a17:902:b715:: with SMTP id
	d21mr41516559pls.103.1557249268462; 
	Tue, 07 May 2019 10:14:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	i12sm20839431pgb.61.2019.05.07.10.14.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 10:14:27 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Nikos Mavrogiannopoulos <nmav@redhat.com>
References: <20180921154323.GS28120@paraplu> <20190502180201.GA31376@paraplu>
	<CADh2w8TEVZt3KMDiiT8c7Ez+80=gaTB6=8azJQt0Ni58L7e0WQ@mail.gmail.com>
	<20190507152211.GU27205@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <82f77ed6-b308-c5b0-2bdc-3f18472d7061@linaro.org>
Date: Tue, 7 May 2019 10:14:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507152211.GU27205@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RFC] Virtio RNG: Consider changing the default
 entropy source to /dev/urandom?
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
Cc: Markus Armbruster <armbru@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	"Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 8:22 AM, Daniel P. Berrangé wrote:
> On Tue, May 07, 2019 at 11:59:05AM +0200, Nikos Mavrogiannopoulos wrote:
>> In terms of RHEL what is preferred is (1) use a crypto lib, and (2) if
>> that's not possible use getrandom(). That is summarized in this
>> article:
>>
>> https://www.redhat.com/en/blog/understanding-red-hat-enterprise-linux-random-number-generator-interface
> 
> For QEMU this would mean re-writing the code to use qcrypto_random_bytes
> instead. This internal API is backed by a crypto lib if available,
> falling back to /dev/urandom or /dev/random on UNIX, or CryptGenRandom
> on Windows. We could add getrandom() support there too.

At least this last step is done:

  https://patchwork.ozlabs.org/patch/1056828/


> The main question is whether to implement a new backends/rng-builtin.c
> or modify backends/rng-random.c so that it has a NULL filename by
> default, which would be taken as meaning use the qcrypto_random_bytes
> API.  The latter benefits that all existing VMs which don't have a
> filename set would get the new behaviour. The latter has downside
> that it is not discoverable from mgmt apps, so they won't know if
> they can rely on it or not.
> 
> Thus I'd probably tend towards a new backend for discoverability.

What does it mean to rely on the filename, really?

We could special case "/dev/urandom" as qcrypto_random_bytes, which would end
up using getrandom(2) or /dev/urandom via the crypto lib anyway.

We could even special case "/dev/random" as getrandom(2) w/GRND_RANDOM, if we
cared to bypass the crypto lib.

Only oddballs like "/dev/myhwrng" truly need to go through the filesystem
interface in order to preserve behaviour, I would think.


r~

