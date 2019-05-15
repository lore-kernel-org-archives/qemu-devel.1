Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56244C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A82520815
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeWp3X+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A82520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxcy-0008DO-6M
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:23:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQxbb-0007Ne-1N
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQxba-0006h1-1H
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:22:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQxbZ-0006gC-Rv
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:22:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id z26so306074pfg.6
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=nGKsW0NO32z1+K+fLqIuZ/U0jXcS2+BP0ManIoisqjQ=;
	b=JeWp3X+S0UZwkylHTi7hAddWPRLO4LUQX0/N1i1+3h3+o9MWrsU3nOhyRrKcnyFdTf
	jncQVCbyqwxHQjadcbEgHxDBZwxabs31M74UY2eyQ3/VNkenwCa8b81Z4Mhjkba3Qjl3
	Kvv0UKVsiEN4XdxAVxDAxOp5Zq82q6vZdsC5r/uqQVJRyW0RNjCDFxVgwgwcX7Du+UbO
	iin4zYGoa79xox95oGRlWYgnM+X71HMFtAk4wO7W0AiD76aHKRcZtoOE3uCMx+egrxxe
	wKW++IfKlVNqHtrcHlFhwGPG4wadAQxr6P9JSRA/c2+qMnp0y2o+rjV496yhBI5ULLYx
	3O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nGKsW0NO32z1+K+fLqIuZ/U0jXcS2+BP0ManIoisqjQ=;
	b=F4zpokgIdG6b1Mls0R29kP1MgoHvsJH+N75aP/bH7CSC+WTHeJ9NgalogLlDOBTR2o
	9Q+L6M/pTY1FiyO3QHtXqunv06VZXbCuID0DqDccPEn4Zdq9v+2WpiquHoF9md9yxSG2
	Y/NGRIEPlbBImzCtk3Iqbl4TXDB2wILYOziO5L+rbyxpcpMoYqVmiQoYs/QWhNGBYdQd
	3uY4nkPKNWD3A5cRcffCNU/M22ihAUEV4a7HffPImr4oTAo6sGKoL+aNdH8vFuVBwbK9
	Zrr2DEcUVNUffDBnkDFD/TEiTfj0n9UhVYcOtQrPFWHsVH+kxOT1rgMWe25F3d4RVcyI
	Ni6g==
X-Gm-Message-State: APjAAAXB8vgYpDUkjhDDfz2Av71zhgjyOdFv514ksnsz57tMAZ0kym3O
	KCmRdWI4j/IYqBUXx8st2j1t6w==
X-Google-Smtp-Source: APXvYqxptlzLjpXb09z9I6k2GfwlBqma322ykStA5I8AHWGR3wCOusy/n4dv0ZVzmHkq4+eRYEtOkw==
X-Received: by 2002:a63:27c3:: with SMTP id
	n186mr42254173pgn.189.1557940931814; 
	Wed, 15 May 2019 10:22:11 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	e6sm6544548pfl.115.2019.05.15.10.22.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 10:22:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
	<20190515165328.GK4751@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <314ae411-2d75-00e6-109a-2604a36973b7@linaro.org>
Date: Wed, 15 May 2019 10:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515165328.GK4751@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v7 01/24] build: Link user-only with
 crypto-rng-obj-y
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 9:53 AM, Daniel P. Berrangé wrote:
> On Tue, May 14, 2019 at 12:16:30PM -0700, Richard Henderson wrote:
>> For user-only, we require only the random number bits of the
>> crypto subsystem.
>>
>> We need to preserve --static linking, which for many recent Linux
>> distributions precludes using GnuTLS or GCrypt.  Instead, use our
>> random-platform module unconditionally.
> 
> I don't think we need to special case in this way.
> 
> Today if you do a default build with all targets & tools and want
> to use --static, but don't have static libs available for some
> things you can achieve that
> 
>  ./configure --static --disable-gnutls --disable-gcrypt --disable-nettle

But we don't really want all of those --disable arguments by default.  It would
be one thing if one explicitly used --enable-gnutls and got link errors.  We
must preserve --static working all by itself.

> Previously if you took care to disable system emulators & tools
> you could avoid the need to pass the --disable-* args, but I
> think that's fairly minor.

Well, no, you get link errors.

(As an aside, IMO pkg-config is stupid in being only able to ask "is version X
installed" without also being about to ask "is a static version of X
installed".  pkg-config has a --static option, it just doesn't use it.)

But suppose we add back the patch for --static sanity check from v6.  What are
we left with?  No crypto libraries remain on Fedora 30.  It appears that Ubuntu
Bionic ships a static version of nettle, but nothing else.  Is that useful on
its own?


> So I think we should just use $(crypto-obj-y) unconditionally in
> the user emulators, and get rid of crypto-aes-obj-y too.
> 
> This will give a consistent crypto story across all the things we
> build with no special cases.

Well, maybe.  But what are we trying to accomplish?

What use is crypto to the host side of linux-user?  In general, all the crypto
that the application will do is on the guest side, within guest versions of
gnutls etc.  All crypto that the guest expects of its kernel is done passing
off the syscall to the host kernel.

That's why, here in v7, I began to think that perhaps all the faffing about
with pkg-config vs --static was just a waste of time.

Have I missed something?


r~

