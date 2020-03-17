Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DCC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3F920663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d90oVx/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3F920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8FJ-0000R3-El
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE8Ec-0008ME-KV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE8Eb-0001U9-9L
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:10:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE8Eb-0001OA-4P
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584436200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AiYdozBARCeTEYQgpxtk+UHw18e8cr3OkMZXSlfhe7s=;
 b=d90oVx/rZXGZsAxqS122rWDIyrqIvceJ3EIBuj3Fcu0L9BGtmIbB9Ha77dzhFCWY/2wZ1d
 y4wS/8BF2vJe2BWroBdSY7xrz5IpIS+ngBJsmd2j5CQr41lEKHE/metvMBLTcRfLmXlbDy
 wtN+UKIItq20l7GlGI/1QKvE/UwbHew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-JJEdChibP3GxeCUw7JPaeQ-1; Tue, 17 Mar 2020 05:09:58 -0400
X-MC-Unique: JJEdChibP3GxeCUw7JPaeQ-1
Received: by mail-wr1-f71.google.com with SMTP id t4so7435368wrv.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 02:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=33HOQxyjSNkaXfQU6fJkB48HoXWoJZs0ADNmqK4BWjc=;
 b=fqJEqr7Qncc0ombY7RMaaIljTXCJWG9deNLZ8xRowLZnMaCfa6s1JuFaJAOIr3J8JZ
 jQ3uuo4RXt869FBs9cqyV+x5lGajWkhul1cgiQ59hk1Zg+YqdM/CWyl4382NzuBZes8o
 fvBpWgOZZx0pXkI6RWn0MjraixEj1Sa+28Sq5bO5uirCb5Af/AyRBIz9b1HhYu7791Rw
 x5NcORN/EvzmxeRYuIZlj5ROy6YvXs9WX31WsXjuir588h5sI4vd2RL9Fc4CmoEO5j8w
 I06KeO2xp+Bpv5SgdSuwZvNGS38BtYsdsuP/3mnJqgpsc9F5awa48YCm2hkIn7jbfOVd
 rbaA==
X-Gm-Message-State: ANhLgQ20TH4+wza06Yy4MRZDhDRNzafkY4Rfgp9pycN63jp3HhwP4rtK
 U5Rw8AA11vAy99idiBR313uW3/P5pn8JqS2j+NvY1KOPope0i0RhzXhjlAuRS8tpDUv0FGycdK4
 h7Bk2ln35C1Cr8dQ=
X-Received: by 2002:a7b:c552:: with SMTP id j18mr4165529wmk.42.1584436197584; 
 Tue, 17 Mar 2020 02:09:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsVhMPn0HH0yjUz3wkQv8Y+81cQSZkbZuYdWOMMNo1uHPo3ZbzVny9ih/PRaMnKHtKR3ZdflA==
X-Received: by 2002:a7b:c552:: with SMTP id j18mr4165486wmk.42.1584436197243; 
 Tue, 17 Mar 2020 02:09:57 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id s1sm3673452wrp.41.2020.03.17.02.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 02:09:56 -0700 (PDT)
Subject: Re: [PATCH v3 01/19] target/arm: Rename KVM set_feature() as
 kvm_set_feature()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-2-philmd@redhat.com>
 <cb3178f1-5a0c-b11c-a012-c41beeb66cd2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3dc0e645-05a5-938c-4277-38014e4a68a3@redhat.com>
Date: Tue, 17 Mar 2020 10:09:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cb3178f1-5a0c-b11c-a012-c41beeb66cd2@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:16 PM, Richard Henderson wrote:
> On 3/16/20 9:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> +++ b/target/arm/kvm32.c
>> @@ -22,7 +22,7 @@
>>   #include "internals.h"
>>   #include "qemu/log.h"
>>  =20
>> -static inline void set_feature(uint64_t *features, int feature)
>> +static inline void kvm_set_feature(uint64_t *features, int feature)
>=20
> Why, what's wrong with the existing name?
> Plus, with patch 2, you can just remove these.

The prototypes are different:

   void set_feature(uint64_t *features, int feature)

   void set_feature(CPUARMState *env, int feature)

Anyway you are right, I'll use the later prototype instead, thanks.


