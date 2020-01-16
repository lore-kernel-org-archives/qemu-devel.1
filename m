Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CAC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA162053B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGYXd+Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA162053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isAy3-0000PA-Co
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 14:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isAxN-0008Iw-CA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isAxM-0002vj-2t
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:37:28 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isAxL-0002ux-RP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 14:37:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id w62so10717626pfw.8
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 11:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UXxTG7rpZERHU0+nNveHy4MlWEWUoaB79PkykwUjZhs=;
 b=XGYXd+Zi4A/G/KITe0BU1h7b2IL4DuWNWkogGtTrsJHf8t4uR3qoXNkjQgloHuUP7e
 sNBqC+r9dAUTlpTIrpzDFquVWoqZ8m23mrgGdc3bn7kvT+fj9hsadTOUcltTofARcaeg
 3LFUbKdqOPo84S+eSzYIulXbi44hMVRPKLmK3wj/5YBH2ctWI1cBrfW+d1BsnS5b+7I+
 BBHtjx1X1RBiLEBrLkX1LOXGKa9fXolUfOPB+dTmLuB2/jVXkSQub/sAahNiWQ8ttPj9
 aNvfOEJRnF2ZihO77N6hr4cgsIHgRLfk+zdxK76VruRYB+Wd00JYJOCT/4T/jjqf9Hs/
 4o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UXxTG7rpZERHU0+nNveHy4MlWEWUoaB79PkykwUjZhs=;
 b=ULRXD6JDSjDzlPrGmyaqiskMNG+oC6odusbcxrdyiR3I3/AtSvBWRRsTWMBEiacWja
 ZrqkTS7wi9hLxX02+2ZBumSPX2ekdtuYJVsqf1ape5Ukw4f+xt1MscfM5lXs7NFdg0qo
 C0oGLNGV4AW10PNUPWeTilRfOupMUzA0xoclsX8IRa2G4mvTaZ4Vyb5BlMtUpROy0SVw
 Xb8aytzOmwC4TlSUKHQQLi+4E6slJgCwbl+j0LNNbmRbcKigDQiPh+RSsdnUBkWz/47n
 LwV1VSNQMXMfGJ2LNqYzLat12sLEM1pgOL0TzOF1PJA52UZXWIN8GCXkhfEp3fs3vsh3
 dTcQ==
X-Gm-Message-State: APjAAAXGYf7uHsDkdHhNWwn1r/TBFyiTGHsA8JayrSfG5/p5ov1o/Djj
 Qk/Or4C8Ja3qTygVdqlDMOAmSDuheU8=
X-Google-Smtp-Source: APXvYqyjDb27Wbt8W64y41TFuuXaEFxi8VyjrNWmpXJUjGHPOxbVfiX22CsBqRfFltM4QLr7CNsdyw==
X-Received: by 2002:a63:3404:: with SMTP id b4mr40705879pga.438.1579203446087; 
 Thu, 16 Jan 2020 11:37:26 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id 133sm26494491pfy.14.2020.01.16.11.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 11:37:25 -0800 (PST)
Subject: Re: [PATCH 0/3] linux-user: Implement x86_64 vsyscalls
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <87lfq7lcns.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8aca9cc6-4224-55f7-cd9b-b0553a92e9d1@linaro.org>
Date: Thu, 16 Jan 2020 09:37:21 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87lfq7lcns.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 4:05 AM, Alex Bennée wrote:
> It turns out the /sbin/ldconfig crash is a regression w.r.t from
> stretch->buster so unrelated to these patches. However I've been giving
> them a spin with the linux vdso selftests and stuff is breaking which I
> guess means it's incomplete?
...
> Also from selftests/vDSO:
> 
> alex@23eb55f27ff8:~/lsrc/linux.git/tools/testing/selftests/vDSO$ ./vdso_test 
> AT_SYSINFO_EHDR is not present!

This patch set is for vsyscall only, not vdso.


r~

