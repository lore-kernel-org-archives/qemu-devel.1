Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA47C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86B620818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImMY5Frd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86B620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39545 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQwik-0007RB-3h
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:25:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQwgy-0006T8-AP
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQwgv-0007RK-Vr
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:23:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQwgu-0007Pd-0I
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:23:40 -0400
Received: by mail-pg1-x543.google.com with SMTP id h1so46866pgs.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KaFkHyunCS4jwSNfDRGtpMoWhF+IG64thTV60pVDjJE=;
	b=ImMY5FrdVS+uvauyVrjBFWbfdfhyH3ZaldwJeuGKNjGFUd3q7keYA0uEXQxxfjzMSI
	u/nWvFA8N3ZMpdhd9HfkC4mfvZLfqeam6cmZMqQr52qqJNAwpgLtqWbf4HbTsJTNbI1T
	4btSgn6Zwp6sZQ0aLzRGjCS7nO1ouMMhbmsoc8n91z9Rj6J+ENfcDnHIBAAtWpoDuOjN
	RqCcPLZ6FkcdKohvVfqdL6cW792dhXGQmw1fYQs68maQfJHeTi+S+q8zF2n/ULPuwkCw
	5gsYuTSsdwmZPIi90arQEfex3WTQ1BRxMfX4iGv4jHYQzM12d1p9cn4CGfOSkYjbwvKH
	51uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KaFkHyunCS4jwSNfDRGtpMoWhF+IG64thTV60pVDjJE=;
	b=VsBXtS7i0zzPHJbfjAsNsNFeP+2iZ19We8WDGRf6MhcxPG/VUEZgnlUC6cLxusVs+8
	wmsnjYkfIHIn5HcIDSsKMMr79dIWA4rOhgt5UDBHE3UmP2N8vUhi5uSuQd1Q6mWwBO3O
	Iy84zP5j99yc4GaoP8LENY7Eo2oOdPiq4ZD2pxWK0wu5kgr9BozI6UNTJSi0wZjlePg1
	hBaUUR8UHuy2lXSDL2hGpjMi46QjwbCyh+hBjpX0TECFaWOYGKHIn07gVTrsgpwdhzlh
	dGAzu2sjpw7KYz5TOGl1FHVJ7KZ6fvFhGn2peYU7kCq1J8ZIUKhsQNlKtegHvugGz9xZ
	HhyA==
X-Gm-Message-State: APjAAAWxolIMWBnrt1kNvsN3ab0P7KfB1j0xKA0o4e5Y0tB1f7hVAkjW
	SlvSQf08cgaJocIWAT8d7yqnvw==
X-Google-Smtp-Source: APXvYqxVzOLcFutlvmldgfXu+tVDRWLzKr5vNt6+UvxxnAdMJSGr2lE4N5CO9dS/Rtx6kARmhq/ZVA==
X-Received: by 2002:a65:60c7:: with SMTP id r7mr43341842pgv.22.1557937418505; 
	Wed, 15 May 2019 09:23:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	b67sm5199728pfb.150.2019.05.15.09.23.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 09:23:37 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190514061458.125225-1-ysato@users.sourceforge.jp>
	<20190514061458.125225-13-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5a4f806c-cd74-9851-f1ac-6b69cdafb514@linaro.org>
Date: Wed, 15 May 2019 09:23:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514061458.125225-13-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v12 12/12] MAINTAINERS: Add RX
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 11:14 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  MAINTAINERS | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

