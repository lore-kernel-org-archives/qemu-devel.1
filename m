Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62343C74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A522086D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A522086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlEjk-00083J-IO
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlEib-00075z-66
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlEiZ-0005um-5v
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:41:17 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:36391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlEiX-0005tM-8M
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:41:13 -0400
Received: by mail-wr1-f50.google.com with SMTP id n4so2998518wrs.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 08:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZqJtaq4MsF6xGIt7c7isyPRuOSya3UoPfm+iGAPvqWY=;
 b=RnoxSw4hV2jtajCyngVGgXT+C2psx/Lf3mcokWlbuNjXr9CJ5MwASg3k+60XU2g256
 EIIlqJrTgFXEzIz3GyGcWFcK0fm/Fz3YHT97zzfNFRAJ9jKMIdjPndReyC5HB11OAsFz
 Fqubx7mB+n4ZVp8lwV8wPCk7YOuLvzs4yCUf5yPbjpWVPyd2mjaXkwdBLqvM1kNXjI3H
 dUrnOVBDWCMStrasrChVRxytEY1ePxxf6/PKr6+8JaLvsGyrbMnZ3JZY7SJOFmW3opVb
 Do/Bwo5xTuxzbmBNYKU315NOO2g2GWRGY+RxZ6dxkCYfF8bdcjtXqQOk5wbE4NSWvxlw
 Ga1Q==
X-Gm-Message-State: APjAAAXZX9h0+qu4zbhelzu/ijfuJuuWzJ5KpFkW+zStdSdwcmeU1zT9
 7/JuS1iRYCJIWyya/k2A5zOuoA==
X-Google-Smtp-Source: APXvYqwkuwg2cSReIswXneeRD487T9Z9ZyCCfNV8kZo3fwebzhDKWjtQnI0wVfVMbfFV3BX2JCOwbw==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr17511668wrq.78.1562773271186; 
 Wed, 10 Jul 2019 08:41:11 -0700 (PDT)
Received: from [192.168.1.103] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id j10sm2674691wrw.96.2019.07.10.08.41.10
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 08:41:10 -0700 (PDT)
To: ddm <hope2hope@163.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <c49fcb4.af77.16bdae2795a.Coremail.hope2hope@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <adefe3b6-f8ff-5010-58e5-45a4445a648f@redhat.com>
Date: Wed, 10 Jul 2019 17:41:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c49fcb4.af77.16bdae2795a.Coremail.hope2hope@163.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.50
Subject: Re: [Qemu-devel] Can not relocate APIC registers address from
 0xFEE00000 to self-defined physical addr
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing x86 ppl

On 7/10/19 9:56 AM, ddm wrote:
> hi guys, 
> 
> 
> I wrote a Small OS (based on linux0.11) support SMP, and it can run well on bochs, 
> Now i want to migrate it to Qemu, i found that when i use wrmsr command to relocate the APIC regsiters addr to a new physical address, 
> it can not work, i can not initial APIC timer to trigger timer interrupt by the new physical addr just i relocate, but when use rdmsr to get APIC base addr has been changed to the new physical address, it's strange. 
> In SMP env, if can not relocate APIC registers addr for each processor with  different addr, it will result in conflict. 
> So, i want to know qemu4.0 whether support remaping APIC base address by wrmsr command?
> if support, please tell me how to remap APIC base addr for each processor.
> 
> 
> Thank you!
> 

