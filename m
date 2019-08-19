Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0FC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A134218BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 17:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A134218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzllJ-0003Nh-FX
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzlkI-0002pq-RT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzlkH-0003Sj-JO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzlkH-0003SD-EO
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 13:47:05 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5687CC01DDF1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 17:47:04 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w11so5586140wru.17
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aW/7EqmxYl7V/aRqLkPYLm5gG+Dfznres2rcMuTGzh4=;
 b=HdjrsVqcRPcHyIg8sV9cXijAsoyk1OP6SaY858NfM5IdMK2zgxbU3lqRJV/UpznhmG
 Mq3BYyrjtd7D6i2asl9GClTrk6MSSlfrMk1HPsGMWzwJbykzL+5RIEh8B67uvbi4EkWe
 39J/zSsS33INWKPGOPal/f7NM5YRAKfD0+xYCUTgG+fM7kYwln7S/z3VYLTYlnAcm3xp
 Ly7QzYdEMNxj/IM0zZxjoRyYG4m3GVKNejio8HrzhVGpUvCYah/b41gA7v9TjRlnXID4
 Vx8WWdgEsTMgIwqlJAYSbgHt4w3P5+1WLNQGgdAEzOimsUP/xUxA1TpTA4l9HIzXjWY7
 APMQ==
X-Gm-Message-State: APjAAAVBjwru0zQP1Q9FS6Y684nj/Uu/tniyGElUdsx6v5a2gr1PKDkc
 q96zRAySJr7G0YtykP/j9yg9usB1txzwF55lcVviRZZtE4Ns2iqg+0wA8NTX7gBCoWFAxRyo3oA
 twd5vPFI6h4ZqUKw=
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr30591446wrn.87.1566236822959; 
 Mon, 19 Aug 2019 10:47:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaTdOF6gInx2vjdYEVkWbDoXZ3Uau8yyZAhUfRia5ZF8v7rlcktuPGQncdfowiQ1/0Dis7nw==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr30591428wrn.87.1566236822694; 
 Mon, 19 Aug 2019 10:47:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399c:411e:1ccb:f240?
 ([2001:b07:6468:f312:399c:411e:1ccb:f240])
 by smtp.gmail.com with ESMTPSA id w5sm15254093wmm.43.2019.08.19.10.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2019 10:47:02 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190817101931.28386-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1cbbb720-2ee7-18b3-dd7b-e03c485db6de@redhat.com>
Date: Mon, 19 Aug 2019 19:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817101931.28386-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Kconfig switches
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/08/19 12:19, Thomas Huth wrote:
> Here are some more Kconfig patches that clean up the switches of
> existing devices and introduce proper config switches for some
> other devices that were always enabled before.

Thomas, you can go ahead and send a pull request as I will be on
vacation soon.

Paolo

