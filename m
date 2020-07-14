Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F486C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D13022227
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqETjWVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D13022227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMAQ-0000rB-E4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvM8v-0007x1-1S; Tue, 14 Jul 2020 10:42:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvM8r-0002lc-RM; Tue, 14 Jul 2020 10:42:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id a6so22106437wrm.4;
 Tue, 14 Jul 2020 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=47+FT9oeed/M2shgqjzJ/r4CcNXiJBJKXWzRjImMqTQ=;
 b=NqETjWVcV7EEhsLcusmo+zuCUlhuzfnqFvsKZ6t9f2I2xbDIFKuCApO7qjw5Lu9szv
 ZkFg/EqZmoUWO1KX9S7oqCZJTHtjLNW/WIlBJBwOYMZlMCCyma0d45KtctV5ZGhctvy8
 o4rceuQeEv7yA9Ic0tyn9LQE/QYzb21uLgfiAZWhWDGoB5tyAXY0mzgtiH6yAZ4Ihbgi
 la1qUnLeB/j8hSao3c/DdwDhmoWu7Zw1je72+miLb++0kZUF2PB4AQ96tn5Alaq+62Yo
 BXozulBW0BBbiYH68d4+jAq4D/xxvjGJFA3yCZ0w0EPfkaNZ/Y6N+oEFxdJ6Bu40hqab
 CpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=47+FT9oeed/M2shgqjzJ/r4CcNXiJBJKXWzRjImMqTQ=;
 b=Gb812xkJuiquTd5b3AqoCRvi8jY0joQf5K7Vbk0Zu8az3cclkk0LhGEJs9+K7pVc7D
 M3ukixtGUC6HzzzsPwBprE51QKTyKilAzPw2h90GUzhocfrDYG128StqDIXKoklVulZ+
 VzTCXK1XmghIbtofmsUQ/5t9DQINFJlpa8To4FKia5H/XFkSAF4PiCxYrtbv57pe9wvk
 tpYgvL8imITj9CkhXM70m8Yhsb87eS+DzhdGFSRnqd6BXD/zUnuTB5v1J3r14wHGV6R8
 1RpLJB1dl++7HdvfPqGj136WGzGIZZpn5K+QxHNCcfUynk7qHrr/v1zkr55Xim/Ae479
 7zZw==
X-Gm-Message-State: AOAM532DHPvH488zYx5T7i0IMmAcZ1+0Db0nuKQDjkY0KOb2cFl4hVlw
 kykJXD3nN2q6VSja0YgdU+/abrc9nuc=
X-Google-Smtp-Source: ABdhPJyyGfShoRgzel/rsjp2ee5o9BrbU9lf4RZk3o0F9f/KF0raWcmtPTagOL1kCTPvgmkoOOT+qA==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr6093280wrr.391.1594737761510; 
 Tue, 14 Jul 2020 07:42:41 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u2sm4441753wml.16.2020.07.14.07.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 07:42:40 -0700 (PDT)
Subject: Re: Test failure with Smartfusion2 emac block (msf2-emac)
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
References: <e010da48-cfbe-9616-d750-a922cb463a94@redhat.com>
 <f457f5d9-2405-4456-4a26-b3a9784e2cd9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <efc16370-869b-15b9-36db-19ea28398e0c@amsat.org>
Date: Tue, 14 Jul 2020 16:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f457f5d9-2405-4456-4a26-b3a9784e2cd9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

On 7/7/20 7:32 AM, Thomas Huth wrote:
> On 07/07/2020 07.18, Thomas Huth wrote:
>>
>>  Hi Subbaraya,
>>
>> today, I noticed that there is a test failure with msf2-emac when
>> running the device-introspect-test in slow mode. Either run:
>>
>>  make check-qtest-aarch64 SPEED=slow
>>
>> or as a shortcut:
>>
>>  make tests/qtest/device-introspect-test
>>  QTEST_QEMU_BINARY="aarch64-softmmu/qemu-system-aarch64" \
>>   ./tests/qtest/device-introspect-test -m slow
>>
>> Then the test fails with:
>>
>> Unexpected error in error_set_from_qdev_prop_error() at
>> hw/core/qdev-properties.c:1251:
>> Property 'msf2-emac.netdev' can't take value 'hub0port0', it's in use
>>
>> Could you please have a look?
> 
> The problem might be related to m2sxxx_soc_initfn() in msf2-soc.c. Looks
> like you are using nd_table in an instance_init function. This is almost
> always wrong, and should be done by the machine code instead (e.g. in
> msf2-som.c).
> 
>  Thomas
> 
> 
> PS: Maybe also have a look at this article, it might help to understand
> the idea behind instance_init a little bit:
> http://people.redhat.com/~thuth/blog/qemu/2018/09/10/instance-init-realize.html
> 
> 

