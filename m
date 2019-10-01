Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FAEECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581572168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cwl9Ha0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581572168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLSD-0007rk-7r
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFKtt-0002rL-G4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFKts-0007jC-0Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:21:20 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFKtr-0007hz-NC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:21:19 -0400
Received: by mail-pg1-x542.google.com with SMTP id y35so10010457pgl.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MVWLUa58yr8Pk5/U60QLji+ouS0ZyXlMTMpvCvRvkQQ=;
 b=Cwl9Ha0W28ir6lhSI0zEEN5lPPsoGDw1gtt0pe9aRZ5TJz8DFyzkRJR66siAJA3kZO
 z87xKyJgzkUS0opyeR4oGOfCFPryrTGErsLtTA1cu06FChIYxPRwekluJzslp3jnhtc4
 DrzT9X+ln+XzektpS7IqFo3IJZlTrVion6Sg/CtMiwbJPoVikDCkEayZVhdjgBeGuSGR
 EjLhr21OQkp7nqPkDhWUX4me1OjJVJfMKcLqvFwZPcMUBq/nwsSF9ueiVeA/vSaMIUvX
 nmG0+DTI5IKEdxsm35ElxShLjNIhDc2Q5s/Bm+XIPKIF7EQJ1qj6e78P/hBT3NPVOY6d
 jkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MVWLUa58yr8Pk5/U60QLji+ouS0ZyXlMTMpvCvRvkQQ=;
 b=S07SkiDq88kVA8XmG3VjRG/KcpWqA1CmJYjL1xTdjJZWsInP6ge+PpFGqUI+x4RnGC
 exE1CAhR5UxevIqLtGgkIxwDbaNshIL1eZKAeP88hKXdOQZjXmHR8Sukz5rK3LVi8TTg
 HbkGuMMheFk0832AUwRECoUutwBDeY7ii5/cHdpbbv1t11G6S5Ucg5IMQoBvEyonzsK5
 04Cggp+0tZZ/3B246Rs65ztpxGBOuLZWHWEvgv7hMWPulvpTS4Klh62dOwwByaQ9jvsm
 Rb+Nv1gXWWTEteBRTJiq4oE/fLi5Vo8Kk1/N6PeVaJQjGLt9Gi/QvSk3S4H9ha+M8Tyb
 3QAg==
X-Gm-Message-State: APjAAAX7KrV6KzbHXge6S6tJ8e+ouPyGtPrrMw47haKwG4GyC0OrRPZt
 llaJDhoquL71lGW5LRtXm1K1vA==
X-Google-Smtp-Source: APXvYqwz9yGSVgpikBPwXBqsXtT5tdviXokaugGSuLOE4vWSvJJPq8m4B5P27aYsdS+7ToWL0gnQBA==
X-Received: by 2002:a65:5186:: with SMTP id h6mr30849410pgq.304.1569946878227; 
 Tue, 01 Oct 2019 09:21:18 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a16sm5255539pfa.53.2019.10.01.09.21.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 09:21:17 -0700 (PDT)
Subject: Re: [PATCH v4 09/18] target/s390x: Return exception from mmu_translate
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190927193925.23567-1-richard.henderson@linaro.org>
 <20190927193925.23567-10-richard.henderson@linaro.org>
 <68d9b84b-7c89-46c3-a97d-2c67d75aeddf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c1ab1031-e8ea-a472-e1df-1dc68905ad04@linaro.org>
Date: Tue, 1 Oct 2019 09:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <68d9b84b-7c89-46c3-a97d-2c67d75aeddf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 8:30 AM, David Hildenbrand wrote:
>   TEST    check-qtest-s390x: tests/test-hmp
> Broken pipe
> tests/libqtest.c:149: kill_qemu() detected QEMU death from signal 11
> (Segmentation fault) (core dumped)

Missed a change to s390_cpu_get_phys_page_debug:

(gdb) bt 4
#0  0x00005555557a4923 in mmu_translate (env=0x555555f7c330,
vaddr=vaddr@entry=0, rw=rw@entry=0, asc=0, raddr=raddr@entry=0x7fffffffd010,
flags=flags@entry=0x7fffffffd00c, tec=0x0) at
/home/rth/qemu/qemu/target/s390x/mmu_helper.c:376
#1  0x000055555575a135 in s390_cpu_get_phys_page_debug (cs=<optimized out>,
vaddr=0) at /home/rth/qemu/qemu/target/s390x/helper.c:70
#2  0x0000555555752219 in cpu_get_phys_page_attrs_debug (attrs=0x7fffffffd034,
addr=0, cpu=<optimized out>) at /home/rth/qemu/qemu/include/hw/core/cpu.h:605
#3  0x0000555555752219 in hmp_gva2gpa (mon=0x555555f53310, qdict=<optimized
out>) at /home/rth/qemu/qemu/monitor/misc.c:850

Irritating that the "0" produced an implicit null instead of a compile-time
failure.  Anyway, will fix and rebase on your mmu branch.


r~

