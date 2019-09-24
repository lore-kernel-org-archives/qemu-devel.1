Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F37C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A523720820
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 00:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A523720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCYYh-0000dB-N1
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 20:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCYY2-00008r-ED
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCYY1-00027G-5o
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCYY0-00025c-Vh
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 20:19:17 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D578882EF
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 00:19:16 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so20257wrm.20
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 17:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J52WwaKRJjEmwAL0Sy80mf9xLpoSWAPq0RbzWPhKHEY=;
 b=WUzcjevfHnHCZSs8LzWi7X/khDnH2ptdsK9yRhq0Vnz+E9yH4Dtr3RqOuhaZnbNy4+
 q6owlEZBslwvDzk6yVxvfzoigyMgSQK4E/YNA/Ia+2Tl+80rOUpsyetpB0/MSLxhB/bR
 r0H4iGmwE7p7yyGiMf5uT5S6sUMb5pe9Ap38A3NFhYMClehM7ok1YHsUerimevpdvGOY
 YFt/DljiTCKwt3j8+53GdpaDmm9wmPtOTNP1sYNr9sPf+hk5hOL2niyw+sjqN/CLEFfU
 qzqr5yorjIlGoddFd3Y7RaQ/6IyfXPexljWxuJLAmXYK8U3fn0Q+z3IywC1az08RgaUp
 UXJw==
X-Gm-Message-State: APjAAAWdvFkh9NgOhs6ab6Z9v4DQVjgXlCi007gwFMJMHD33dB8uLfqk
 ugKtSvqCl8YFOZJZTkJeAiEcWyuQmgxGbDsIohhZaT/hMb48s6R2wlNJJL/KCUbU8rasSadVn8X
 VGD6xrbPujDN5rpU=
X-Received: by 2002:adf:e488:: with SMTP id i8mr7913wrm.20.1569284354599;
 Mon, 23 Sep 2019 17:19:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7s/PGZ3ki+4zn1vMF77frr4mP8PvccOkpPh/Moepsam4SgOinfJ6dZ/ANTRDr8Guttqi6Cg==
X-Received: by 2002:adf:e488:: with SMTP id i8mr7900wrm.20.1569284354294;
 Mon, 23 Sep 2019 17:19:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id f8sm14457181wmb.37.2019.09.23.17.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 17:19:13 -0700 (PDT)
Subject: Re: Migration failure when running nested VMs
To: Jintack Lim <incredible.tack@gmail.com>
References: <CAHyh4xhYrUbK0aEJmKp3_kOJG2E+AQLMUjyf7_pXVJgbqgv5JA@mail.gmail.com>
 <20190923104245.GA2866@work-vm>
 <6fa1b7a6-52c8-fc98-c532-f2c0484d04b0@redhat.com>
 <CAHyh4xgwTpM5rQ1qrwfjtqjHLj_U4Fes2Qmch0g=84yNxBQuZA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <34912741-907f-a170-6b0a-93d423c7abee@redhat.com>
Date: Tue, 24 Sep 2019 02:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHyh4xgwTpM5rQ1qrwfjtqjHLj_U4Fes2Qmch0g=84yNxBQuZA@mail.gmail.com>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/19 20:32, Jintack Lim wrote:
> On Mon, Sep 23, 2019 at 4:48 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 23/09/19 12:42, Dr. David Alan Gilbert wrote:
>>>
>>> With those two clues, I guess maybe some dirty pages made by L2 are
>>> not transferred to the destination correctly, but I'm not really sure.
>>>
>>> 3) It happens on Intel(R) Xeon(R) Silver 4114 CPU, but it does not on
>>> Intel(R) Xeon(R) CPU E5-2630 v3 CPU.
>>
>> Hmm, try disabling pml (kvm_intel.pml=0).  This would be the main
>> difference, memory-management wise, between those two machines.
>>
> 
> Thank you, Paolo.
> 
> This makes migration work successfully over 20 times in a row on
> Intel(R) Xeon(R) Silver 4114 CPU where migration failed almost always
> without disabling pml.
> 
> I guess there's a problem in KVM pml code? I'm fine with disabling
> pml. But if you have patches to fix the issue, I'm willing to test it
> on the CPU.

Yes, it's a known bug in the PML code (that I thought was not an issue
for migration, but I was wrong).  I'll try to get you a patch this week.

Paolo

