Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71640C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AF321852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 13:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AF321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1Zv-0001xy-Ff
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hj1YP-0007zP-0m
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hj1YN-0001zw-FS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:13:36 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hj1YN-0001zL-9a
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 09:13:35 -0400
Received: by mail-wm1-f51.google.com with SMTP id h19so5283571wme.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 06:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3zHHXWY23w/ptfveHslpgSC4FAfwoX8P6NDxx83th/E=;
 b=psVbOTgMqcCGycADgStzAzRawMh0hQ54JAaLQAWVAIA4RN/ltkKJFhwtlr8K32dcPx
 y1BKjj1WvDQkhblJG0DIi+piwP6R4m/aJlFl8aqhcpa3jpfT1esVGp/+ozmbsybS1HD/
 ZxBfjTSohZo8tfvlKsdv1MDAYWEd77d03ElYOivKJlvIMLQlskOdJQnIgvtJK85xmCAb
 Ja9vrWnrcN8rnv5vaA2G6A1fMCayXHygTwgtsaGkyurEoCcNuXUO4Cv4jsn1qHKsCjRt
 omYfUi7fEorsggWHnPocNecnXYEgLvOubepAsI348AHAVTkKTZgcUDjDH4JGz6uQ6WBp
 pDxw==
X-Gm-Message-State: APjAAAXQLuhTjliJbNzgf5YGYUBTQampzJTnDHGi1f3XC8o3n2W/A0/s
 HSW+fGxhgPb6YWHvlCOb4DQaJvBBPMXkPQ==
X-Google-Smtp-Source: APXvYqzUlCcps+/VeR9NapcEul0rnCV6FVBkaW2P+dua6la1pvJD3b14mw1GwuulnVTm8ziLjw9gzA==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr13328434wmj.13.1562246014017; 
 Thu, 04 Jul 2019 06:13:34 -0700 (PDT)
Received: from [10.201.49.68] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id w20sm14931726wra.96.2019.07.04.06.13.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 06:13:33 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Li Qiang <liq3ea@gmail.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
 <1557953433-19663-20-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CK+FYYOFefek55yrFWRfC=NYBH5g8uPw9iO1QWZLh6r5A@mail.gmail.com>
 <CAKXe6SL43HsCZwq9LZTN-Pgy1u-Kwbi5Ako+gFhMTabXma2nHg@mail.gmail.com>
 <CAJ+F1CLWpEzCM=2ooX3XrSQD=utvFGRJjUjGLxD5_Bw3wZiv2Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62f2a46d-c7c7-6b11-8504-76dd7f13416a@redhat.com>
Date: Thu, 4 Jul 2019 15:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLWpEzCM=2ooX3XrSQD=utvFGRJjUjGLxD5_Bw3wZiv2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.51
Subject: Re: [Qemu-devel] [PULL 19/21] ioapic: allow buggy guests
 mishandling level-triggered interrupts to make progress
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/19 15:05, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jul 4, 2019 at 5:01 PM Li Qiang <liq3ea@gmail.com> wrote:
>>
>> I have posted a fix for this several weeks ago:
>>
>> -->https://www.mail-archive.com/qemu-devel@nongnu.org/msg626186.html
> 
> Your patch looks reasonable, but I am not really able to review it.
> 
> I hope Paolo and Vitaly will take care of it.

I have queued the patch, thanks Marc-André and Li Qiang.

Paolo

