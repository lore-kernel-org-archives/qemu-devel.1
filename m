Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1059ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5958206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5958206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoq8-00080B-Ou
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHonz-0006QY-Km
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHonx-0008DO-Iv
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHonx-0008Cg-A3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:41:29 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 661F11555C
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 12:41:28 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id m6so937896wmf.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sZGhZOzzGj383dhulzsjDYcyeCN4RRUdMfmCwxPxDR4=;
 b=sckDOjYMtztyOOhASiQPatI1bwl4KN+JLXFKLnYe25mQMlIWjcYNKjz0IHWGTrfY4n
 iJL4UPxQ9xBvp1gb2pEdpJ+uAjiJBg7SwpqF48K3amk21fKIceDlfbMWlleKQ0C8pICT
 S16CYt9qmmH6tANe3noqJ5jzQ/AKZGxm2b2B4YWfkZi/OWjbei1fr/TcbVPo7Xw7rEdI
 DDsnQA9R52K33l8+ohZzYPeADYLajN55b945JX+9TDlMfQYFjc8Y4HgpamWPKK0g54QA
 50a/UPMXlbehd/A0pefNdvZb0KIUHCHobIeOycAO2rLa3sCUlKOcSDN3pYk9fY5Huy2R
 dNqg==
X-Gm-Message-State: APjAAAUV4BNgGOTByQQUa4k8snh70lun9d46zUYrDAKJqiwOrryVoYjn
 qX7TKQCcfCthN/1mRuCOwyghFic9moqpjkhjRSAaKAepuEcrsaAAkO6RThU8ukYb5eX616fXbqf
 irFDm2EyHuho70Lw=
X-Received: by 2002:a5d:6943:: with SMTP id r3mr5017279wrw.21.1570538487197;
 Tue, 08 Oct 2019 05:41:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8KH51n7d0obuSsqLgQvIcHRsB8JGHaVJrXit+wjiYHZw5N3yGc5Zv50tCI9Pq1jqV7ymY0A==
X-Received: by 2002:a5d:6943:: with SMTP id r3mr5017258wrw.21.1570538487028;
 Tue, 08 Oct 2019 05:41:27 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id j1sm38610417wrg.24.2019.10.08.05.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 05:41:26 -0700 (PDT)
Subject: Re: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191008113318.7012-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b7466af-2c05-f47e-f218-30a8b5ed5663@redhat.com>
Date: Tue, 8 Oct 2019 14:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008113318.7012-1-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
 hpoussin@reactos.org, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 10/8/19 1:33 PM, Igor Mammedov wrote:
> Series cleans up remaining boards that call memory_region_allocate_system_memory()
> multiple times, violating interface contract (the function should be called only
> once).
> 
> With that cleaned up, it should be possible to switch from adhoc RAM allocation
> in memory_region_allocate_system_memory()->allocate_system_memory_nonnuma() to
> memory-backend based allocation, remaining roadblock for doing it is deprecated
> -mem-path fallback to RAM allocation, which is scheduled for removal at 4.3
> merge window. So remaining patches to consolidate system RAM allocation around
> memory-backends and aliasing -mem-path/mem-prealloc to it are postponed till
> then.

How do we protect the codebase for new boards to not make the same mistake?

What about some code like this snippet (or nicer, but since this is a 
developer error, and assert is enough IMO):

-- >8 --

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 4dfec5c95b..a487677672 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -484,6 +484,11 @@ static void 
allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
                                             const char *name,
                                             uint64_t ram_size)
  {
+    static bool nonnuma_system_memory_allocated;
+
+    g_assert(!nonnuma_system_memory_allocated);
+    nonnuma_system_memory_allocated = true;
+
      if (mem_path) {
  #ifdef __linux__
          Error *err = NULL;
---

$ hppa-softmmu/qemu-system-hppa
**
ERROR:/home/phil/source/qemu/hw/core/numa.c:489:allocate_system_memory_nonnuma: 
assertion failed: (!nonnuma_system_memory_allocated)
Aborted (core dumped)

