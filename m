Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D6AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA25620882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA25620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRgj-0007WT-TR
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCRXc-0005mQ-Vt
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCRXb-0000gY-TI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCRXb-0000g6-Nv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:50:23 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0A9E76520
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:50:22 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so5209370wme.5
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+9MIoogSi04qbEM4kUnN48So0U0Za51LpTDDBnnhERA=;
 b=DO1Dbq39tPxk2Q5nv2m8dBqfNlbft0VsiusHq8ctr+PVImeBuClSbb4y0nsD8iiyDF
 oSQ83R9F7RR8h2oG67BQRtYhTe0cdpJyMVDp/lqQ8X9L0EMqF4pgxMZSzYayC+RSE9WN
 q8DL9Viaodco6hU+xqXeY/tgXSdaEZvzmIpIoWBmCl66E63DJHASUGW28wkDzx1Ve43l
 oxxd9RFX8WjLjzh7xxbaXLulmAJXNXjGGE3ZTxFer+8Ow9RXfUZHIBuW0fhms/zvML7e
 HS/ZxHFE+7lJ4z7dSN63Guhue5QkB9CJPT6yohWfP2sK6eNeKKVaXzgWf4Ax3tPLrV2o
 toJw==
X-Gm-Message-State: APjAAAWOOJ4YXEJGO5lG/UwTleWbgwK9GiGPEYDfmwkpJJMX5fP2QRjh
 umEO/65wA1i9qk0nKeIlOOkfqoSlrHttRv1QZIIxEs/ALj2/hkuCy3upcTYXs058RkVBEDMbHgB
 L2LO0DTRVhvN7HD4=
X-Received: by 2002:a5d:4590:: with SMTP id p16mr339547wrq.82.1569257421620;
 Mon, 23 Sep 2019 09:50:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKf5tlCunYpfP2+gEF9p2nNs0Zgjkqc4GGmDcoGkUtQ8lz1WDlOmgRr9QnvczcTL/4ful1SA==
X-Received: by 2002:a5d:4590:: with SMTP id p16mr339532wrq.82.1569257421383;
 Mon, 23 Sep 2019 09:50:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id e3sm6929448wme.39.2019.09.23.09.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 09:50:20 -0700 (PDT)
Subject: Re: [PATCH v3 18/20] cputlb: Remove tb_invalidate_phys_page_range
 is_cpu_write_access
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-19-richard.henderson@linaro.org>
 <4926b925-7019-3146-c9c7-a7fe18b8c378@redhat.com>
 <5410485a-d14b-57ad-67a2-c4eb876417af@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <83a40fac-cfb1-1a5c-dd15-dff32529eeb2@redhat.com>
Date: Mon, 23 Sep 2019 18:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5410485a-d14b-57ad-67a2-c4eb876417af@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 18:05, Richard Henderson wrote:
> On 9/23/19 1:52 AM, David Hildenbrand wrote:
>>> -    tb_invalidate_phys_page_range__locked(pages, p, start, end,
>>> -                                          is_cpu_write_access);
>>> +    tb_invalidate_phys_page_range__locked(pages, p, start, end, 0);
>>
>> I'd prefer "false" to highlight the semantics, but as it's and int ...
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I did think of that, but then the next patch changes this last argument to
> "uintptr_t retaddr", so then it's not really a boolean argument anymore, and
> "0" is exactly what we want.

Yeah, 0 is fine here.

Paolo


