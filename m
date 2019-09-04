Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32252C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E5D2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eT+fF16H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E5D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ZCM-0005sz-1C
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5YuI-0005BY-Ag
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5YuH-0000bn-Bn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:17:22 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5YuE-0000ZI-IO
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:17:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id bd8so3530993plb.6
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LqfvCooUecTcAvY3I97IQS0lczVLAEae8uSNHnFIF2o=;
 b=eT+fF16Hu+H61ByhBofnafkbT0vrygmlfMN1mIumFvXJOsv/jHDGwo3LCSntLQNoEZ
 Sj73TG5pmrh8eo15buBubV/MmKvF6mDwb9PdutpJaKW3iY/UI6Tv2swyf+Ip3VFl9E54
 wzc9AFy6O88B6z+bTov8g/MG60Czs6c4aeqBUtC5d2DVfcTa3Vcl6XSf5IzoKr5TNWSi
 Y1P869O85P8xeLwgqbzMvuLH5hJQ0cLyQRNa7qum/UI6dMo8w+hIIhvxtqk8Bo7SAt0A
 nGWW0/yaVBmD0tg7tJ5pWsyJDf+VCZBPH7wXNSe5tcfYf5WPzzcJhG3kDKoRdfLjmSj2
 G7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LqfvCooUecTcAvY3I97IQS0lczVLAEae8uSNHnFIF2o=;
 b=YkLDHqforbf/vACGQveSd2skastalPDfXvcRTEreh11W1BMefEq/pRQxoKDEzes1Jf
 DI9os8ISEMqn3NUldcO7QIA/khKvcd9t9bOg2D5LNvasLNEJfwb0sBFpAeHnA//4yhJ5
 ukD5EJfuexeMlSVRng4Vm0c4AWYD7vXQjloK6DxACGCl8PLW1lEYY7z6CEDioQb9HxRk
 8gHSOe7UNtWvySoO5JyD2fr14yei2PJjWbOjAaym6XVuTc3EbB5EPgQ+ZmKjSlZoaZhn
 Sc4DIphw8eWe5gWMagG89AsbJtQOd66m7p9YmS9ZiZofIsQAfgiVRF4O7qENQ6eVDxjw
 KfuA==
X-Gm-Message-State: APjAAAVJE1x0MzC5YRruCVySkgKuGiEoROKmk9MZJ8n2Dy+YHEN10XnY
 +K1Ab5vi02J1Bn9bpLgj+8P7ZA==
X-Google-Smtp-Source: APXvYqw3ekoIyNs3yjKqa/ffWJLc8hXJev7ip5jdWCSqsTHnoxKIL+ItX1INdVC5wtcILCzBcVystQ==
X-Received: by 2002:a17:902:fe0f:: with SMTP id
 g15mr19168537plj.2.1567617434713; 
 Wed, 04 Sep 2019 10:17:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e192sm22825379pfh.83.2019.09.04.10.17.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Sep 2019 10:17:13 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190810013112.28732-1-richard.henderson@linaro.org>
 <20190904083252.7pmmjvbynik7dk33@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <63d5994b-3834-a011-3853-a76986f8e6c5@linaro.org>
Date: Wed, 4 Sep 2019 10:17:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904083252.7pmmjvbynik7dk33@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH] HACK: Centralize sve property checks
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eric.auger@redhat.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 1:32 AM, Andrew Jones wrote:
> How would you suggest
> I apply credit for it? I can give you authorship for any patches that
> mainly contain your code. Or I can keep authorship and add mentions of
> your contributions in the commit messages. Just let me know your
> preference.

I don't mind either way.  The latter sounds easier.

r~

