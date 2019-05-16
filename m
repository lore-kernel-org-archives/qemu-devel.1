Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FF0C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6308C20815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmrHiNy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6308C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHii-0004Yq-HD
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:50:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRHgY-0003N1-NN
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRHgX-00018W-T5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:48:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRHgW-00010Q-6P
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:48:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so1986203pfk.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=rbj/JTRpmJ4qvtcjSCBikwalrx2fdMdtUKF2Pxbp92Y=;
	b=XmrHiNy1SEzM+nJQKtLSACkHoHi6vtRagcd2kSrmP57GoCaR0l6jZWH4/MSAnx4ndr
	IZ3cKmyCzkqQsIkZ+JKus9Tg4wqtdLLBysyHXr8qM8+jYQHgpaqK21MhA8B+i7YbpMiR
	84gqTNaLxRt40sJ17Iit4iJVHrZ0G9RJgqf+lewVvHcg9NYNOqthV6Z4dZShtp6h4TPI
	gm8e1ry5PJwxzVtcki2eBCemxpzly8gJRkgimFMWiGewhP/JGlVhA+tURKatvl2k+CMs
	qEt72cfxi0T3AVIEAWSlHQBEIGx2PEObgEwdjxLK9p8pvwXeDNLxpYiQbw1r0yZnA3No
	tQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=rbj/JTRpmJ4qvtcjSCBikwalrx2fdMdtUKF2Pxbp92Y=;
	b=QCVE1m7TxekpBGjw+rdu0ztWN48Gv2+gKQNVEPbTa3kNPZkDI5I+dQzt27addJqDpt
	LsA2e0y+95ZO4EjjxqVTZ9pbKpnKXB99CaRd0tNdKAb55vsQECHoZJPnurnJPUMkjyDs
	IVQsWX7pQiEnJ0zF1LPbsocEXvJrK6TRKpMGyAKMxHaCpWZwnMfDLO1ZfZenovjN2J9B
	jm/VDkUvPr1zVQ6n6QxuH90Min7HoS2YmYJqeT5kU37UehrA6dqD9dQNRhRtpimyaUui
	qQn+3o2DNOfX4wPQWPdF0W2Lfdosj37XMVKG2OGo5mV0VaawXyNsemsxKrvScMq0vF7n
	+ZRQ==
X-Gm-Message-State: APjAAAXc9iHK3RaX+DUm5B/YDZPqYT8O7xLm/nY4YNGC3BTCIa49wtqV
	HfLWMIf6h697vYjL6RnK6yN8MA==
X-Google-Smtp-Source: APXvYqy9FYrzBk/PGG1UAkmmBoDjD1LRzc5xochcdT/S7iL4/ARKH6enEi56hJnNmaoJg6rbir+xDQ==
X-Received: by 2002:a63:7:: with SMTP id 7mr51528947pga.108.1558018113858;
	Thu, 16 May 2019 07:48:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	q5sm7309286pfb.51.2019.05.16.07.48.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 07:48:32 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
	<20190515165328.GK4751@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1715ce98-7aef-9a2b-d74c-280796da456a@linaro.org>
Date: Thu, 16 May 2019 07:48:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515165328.GK4751@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
> So I think we should just use $(crypto-obj-y) unconditionally in
> the user emulators, and get rid of crypto-aes-obj-y too.

That results in

  LINK    arm-linux-user/qemu-arm
../crypto/tlssession.o: In function `qcrypto_tls_session_check_certificate':
/home/rth/qemu/qemu/crypto/tlssession.c:356: undefined reference to
`qauthz_is_allowed_by_id'
collect2: error: ld returned 1 exit status

which means all of the authz objects need to come in as well.
I suppose they're not big, but still...

I'm leaning toward reviving crypto-user-obj-y, with just the
crypto random and aes objects in.

Thoughts?


r~

