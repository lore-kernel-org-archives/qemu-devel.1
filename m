Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB73C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55F5206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55F5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMu6-0004eF-AZ
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1haMlY-0005GZ-W3
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1haMlV-0001Ij-8A
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:03:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1haMlT-0001Fu-7x
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:03:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so9741774wrq.11
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 09:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EMEIUl3j847StX1Rt48Sbec7vmv0DT9VVKAzaHTI9b8=;
 b=oGiaXUIag9lVJAcDaod5+5q910xC/Lo3s5JX+HO2fJOyUndt/jX4UyKVSW2exS6ASJ
 193MvF9ipMxPv0Hkp8tzRG/1ks5U6VFRelzzGAMQuyEJKu1djiUBIPvnjjlYn0xO9nRX
 G6+TaLoqEwwHS7Ic6Bl5z+oXIkcsDnbaCywSMxjsNJm8B2eakv3fv1/66JfNYLeciajW
 JcTT1L1Z0x7/f6edoPVf/Yfd/zwOXAc3cZadjWJaTanHEsBI0HLtrnZ7ZKM0evVOYZpP
 YpoBexSwIK1YY/9JBSUoxrgXyb9oA/4YEzfJTtz9xqlv/Bnm7NLOyeUFS8scz873SUNd
 mReQ==
X-Gm-Message-State: APjAAAXUKYXGragTB7xQs+hyrItJTkW2LoLzt/GUjZfQoF+ngQvL1gVe
 s7uFxkbxd7evPHqdIZ0HO3+NqA==
X-Google-Smtp-Source: APXvYqwJ3Zj0eez7E+KsfPPCZGNEcMxVQcdzUN/n15dDUQDlOejYwcZgHv2c1nFL2N/tYjOPF2Ay2A==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr3057986wrv.45.1560182595228;
 Mon, 10 Jun 2019 09:03:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id x15sm7988665wrt.87.2019.06.10.09.03.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 09:03:14 -0700 (PDT)
To: l00284672 <lizhengui@huawei.com>, stefanha@redhat.com, mreitz@redhat.com, 
 kwolf@redhat.com
References: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
 <1a218c83-7167-68c4-798f-2870f2f98475@redhat.com>
 <49e6310d-1c1c-2379-47e6-7239e0058e78@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <487a3a9d-92b3-bed4-4082-5701cd4bd08d@redhat.com>
Date: Mon, 10 Jun 2019 18:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <49e6310d-1c1c-2379-47e6-7239e0058e78@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-posix: unlock
 qemu_global_mutex before pread when attach disk
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
Cc: jiangyiwen@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, wangjie88@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/19 16:51, l00284672 wrote:
> The pread will hang in attaching disk just when backend storage network
> disconnection .

Would the "open" hang as well in that case?
> I think the locking range of qemu_global_mutex is too large when do qmp
> operation. what
> does the qemu_global_mutex  really protect?

Basically everything.

> what is the risk of unlocking qemu_global_mutex in qmp?

It's not QMP; it's specifically the code that calls raw_probe_alignment.

Paolo

