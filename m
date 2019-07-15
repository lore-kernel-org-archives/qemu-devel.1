Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE364C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A842083D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A842083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxEQ-0002sl-UZ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmxEG-0002UG-Bi
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmxEF-0008QX-GQ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:25:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmxEF-0008Q2-Al
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:25:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so14373391wmj.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sboa60kAGx4FM7+ZdR/J+yo2KeEdT1Mg8k+K0kVN7+8=;
 b=Q/6qr8twhtiVBKPlIZRuGjSqRo06sR6MiD+XDdYr72oN/6BreqUBoxfUvX5477HfTY
 WuhbcyG0Ebuxn8LVfh3Hyj3HvTEjIRUX3Bz1rbkP4Kv5XPIhcufQRnOT2nTt/B6EPNhA
 pfXao29NelTgW6VxOmyCpZ3fgINOF3ViSzT35yPh1aFoVhBKcPGpnkECANZkMG/4XH1o
 HhMCZrAzl3p/y8OUpywLFJFp9E4yKvJQ1G3Po5QHw17U7aX5PgP+D5FTRZhItS62CmRl
 yXz0eJTUbK7l+/4CV4o5RA4L3JekIrvBruX7CdgYX1l//lABR3bQBQkwgZ5LjYix1uMa
 Lcgg==
X-Gm-Message-State: APjAAAXM8X60V5ExDGvvuGslKR7ElLpy9YT0OnBmQSfevWv5G5c0bKyF
 E34K3Fv5SCUVqvItW3lVDhjpaQ==
X-Google-Smtp-Source: APXvYqxAtgnMbAOfPsZD6XPwZuy6QtYj9Aqb5hpyt5zQD9vzvm25PhbKiephOvksBnge8FUjjh8WBg==
X-Received: by 2002:a05:600c:212:: with SMTP id
 18mr23010974wmi.88.1563182702251; 
 Mon, 15 Jul 2019 02:25:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e983:8394:d6:a612?
 ([2001:b07:6468:f312:e983:8394:d6:a612])
 by smtp.gmail.com with ESMTPSA id c11sm28105171wrq.45.2019.07.15.02.25.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 02:25:01 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190705210636.3095-1-liran.alon@oracle.com>
 <20190705210636.3095-5-liran.alon@oracle.com>
 <8423C5FD-2F44-48B8-8E1F-A2E8D62E8F2B@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e1e48ece-b571-5229-589d-3525f505887f@redhat.com>
Date: Mon, 15 Jul 2019 11:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8423C5FD-2F44-48B8-8E1F-A2E8D62E8F2B@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 4/4] target/i386: kvm: Demand nested
 migration kernel capabilities only when vCPU may have enabled VMX
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
Cc: Joao Martins <joao.m.martins@oracle.com>, ehabkost@redhat.com,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/19 11:20, Liran Alon wrote:
> Gentle ping.
> 
> Should this be considered to be merged into QEMU even though QEMU is now in hard freeze?
> As it touches a mechanism which is already merged but too restricted.

Yes, I have it queued and will send the pull request later today.

Paolo

> Anyway, I would like this to be reviewed even if it’s merged is delayed for early feedback.
> 
> Thanks,
> -Liran


