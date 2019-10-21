Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5493CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C5A214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C5A214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbPt-0002bb-8H
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMbPG-0002B4-1Q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMbPE-0003K7-B6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:23:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMbPE-0003Iv-5N
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:23:44 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C1C6C85363
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 17:23:42 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id m68so1500579wme.7
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2H/QDkkMx9fpQlbXLe05v/8C11JV66QG+Mf2FlCPPig=;
 b=Kztv9Kx6xGTDq0CpdiTTy0DJJJubId7HyL/t86QQIh4fvFS19+/FbrB81I5+T8Arr0
 1yHmOl6EjHBlOMDoNYW05x6ajDLUUYhttZuO7B8pJbHNCp8VU7WboIiUXKv4mIu0DkD6
 eW2Q4g6iykR3o9t9LgX6mvOOu9YNekZ3VAFQ4CdaTJ6X865CMiPPpd1eRrBldbk7cSA9
 qW2TbputjjSEgfvkToRSRYxYREcRmTATyI2kYy9LHF2tfiXe46ZCUEDnMoAvB5zC6htN
 kCEZUV+CluZYOFouMpO3U4uqvExGK6RZ6ErCAnjps/B+X/Wqj94dwEIUdVo6JP0twE9g
 EHJw==
X-Gm-Message-State: APjAAAWoErWko3NDJnlmPX1IOwrHb9111JAtBe0qDjzWucXYwaMomCId
 ylBjg+gQ8dogq8egzg6i76Hk+ZZz4qfIn4oYdiVTz/8tg48QvEUT3cYL9wFPJAN2x3o51Y2vhFc
 Z/S/lWLdTN8YSkLA=
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr17012082wmc.41.1571678621409; 
 Mon, 21 Oct 2019 10:23:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAL24SXn4saCQlistyKPXpwal5EzmUj6+g4hP4mDNy7Zbre82yACahqDcRg7FdLf/yHNLjkg==
X-Received: by 2002:a05:600c:1007:: with SMTP id
 c7mr17012069wmc.41.1571678621167; 
 Mon, 21 Oct 2019 10:23:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd?
 ([2001:b07:6468:f312:847b:6afc:17c:89dd])
 by smtp.gmail.com with ESMTPSA id x21sm2109862wmj.42.2019.10.21.10.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:23:40 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
To: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <20191016112209.9024-2-chen.zhang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dccc1c86-cc78-9136-ff47-3d7308c795ad@redhat.com>
Date: Mon, 21 Oct 2019 19:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016112209.9024-2-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/19 13:22, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> This patch introduce a new module named Advanced Watch Dog, and
> defined the input and output parameter. AWD use standard chardev as
> the way of communicationg with the outside world. Demo command: 
> -object
> advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000
Is there a standard or specification for how to interact with this?  Is
this something that was developed explicitly for these patches, or did
it exist before?

Paolo

