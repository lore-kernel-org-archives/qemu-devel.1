Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B1C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14742054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9Qk8ECu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14742054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWfN-0004Ri-3C
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jYWT6-0002UU-0t
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:05:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jYWT4-0002xV-Sx
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:05:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id f134so9975837wmf.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 08:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JiKMCkAz1U/iycP9Kf5GYdxP8RqoYzzFqEWx1kd6UNk=;
 b=j9Qk8ECuQOw6qTJl3BYgAle2MuPQWsOy2eTp449ybGNjgiTk+lg5I11KRud+wfIkGG
 sahoCEYNDGtNVNyJE/8kcy8qzmcPxYFo53+llUkPBhNDkdP/m3M1QD8B9ILt6Hm8eU7N
 KWIMY+JxvkY8Myhj0IUoWOkJ7fHenkHyS77SDwvQ2OkC+inkizJUGDfGgo3tdkmpRi5w
 5eZiF3wGYYv1lVebFWXTjLvomfFmSdDxOh8pzk5JQYJQrKLC2lPpl00pXA0FezmJVE63
 1YKgRtPUB5MtrCIKFmLSuoRFtcD881jleJ2ZTDpdSCNdkY1Kje3hs/DQT0B1wlQsgYkK
 vTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JiKMCkAz1U/iycP9Kf5GYdxP8RqoYzzFqEWx1kd6UNk=;
 b=Fz4JnXAIe+gKpq5wvzN41T6iYLKpRVw2aFBlTD85ZihQYuBsCZcUHuqyDsMHCPv4zY
 nNGpgkL+Yn03iV17XUcP+z14HaIK2UV+JAbCc+n08oRoYkNNa1nAmM2MfkKylPpYjx72
 124iby4AmoM1ceq9aYWE5tIRLQddgqn4ItDDo7kj7Ooxok5dRbC2b5jF6euWaTTl/ETP
 L5vCUHQNPKXEy5SXjLuDBUI3DPvb3MIk6IByr8VPwZBdC7Dg6fATTcs3rlMXZ2VbITCV
 hn95482K9RfNSeyqrAEXMEJPyXYDWXKPoaOnHX+XpwlPoWdzeJPs4Ny8y4glePt+uxZu
 msaw==
X-Gm-Message-State: AGi0PuaYs80TA/GBBPfZD++hvrJ/dB/ZedMDRuTj7wBM11NKm0kdi40w
 oFMOhs+JPzxl1ooSe+J2EHk=
X-Google-Smtp-Source: APiQypKgHC7AQBiYer4fEuDhbZKAkUMFal1g20qUXF8kLYdJjKZwDWAw2Fpgs9uRvRGa78us5gizoQ==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr15811488wme.48.1589295913142; 
 Tue, 12 May 2020 08:05:13 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id g15sm14783197wro.71.2020.05.12.08.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 08:05:12 -0700 (PDT)
Date: Tue, 12 May 2020 18:05:11 +0300
From: Jon Doron <arilou@gmail.com>
To: Roman Kagan <rvkagan@yandex-team.ru>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200512150511.GJ2862@jondnuc>
References: <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
 <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
 <20200408041639.GA7606@jondnuc> <20200408204742.GA709224@rvkaganb>
 <20200409033518.GC7606@jondnuc>
 <20200512140542.GA9944@rvkaganb.lan>
 <20200512150123.GI2862@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200512150123.GI2862@jondnuc>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020, Jon Doron wrote:
>On 12/05/2020, Roman Kagan wrote:
>>On Thu, Apr 09, 2020 at 06:35:18AM +0300, Jon Doron wrote:
>>>On 08/04/2020, Roman Kagan wrote:
>>>> On Wed, Apr 08, 2020 at 07:16:39AM +0300, Jon Doron wrote:
>>>> > Well I have implemented the hyperv synthetic kernel debugger interface, but
>>>> > on Windows 10 it requires to have a working VMBus (it's not really using it,
>>>> > but without a function vmbus that will answer to the initiate contact then
>>>> > the kdnet will simply be stuck in a loop.
>>
>>I tried to google for this interface but the only thing I managed to
>>find was this
>>
>>https://withinrafael.com/2015/02/01/how-to-set-up-synthetic-kernel-debugging-for-hyper-v-virtual-machines/
>>
>>Is this what you're trying to implement?  Are there any more
>>authoritative descriptions of the feature?
>>
>>The document doesn't quite explain the inner workings of the feature,
>>but it looks like the regular network debugging interface, except that
>>IP is forwarded by the hypervisor app, so that the debugger has to
>>connect to the host and avoid setting up full-fledged network
>>connectivity to the guest.  That would be essentially hv-net + slirp.
>>OTOH you say it doesn't use VMBus so I'm confused...
>>
>>Thanks,
>>Roman.
>>
>>>> > In addition to that Michael Kelley from Microsoft has informed us that
>>>> > Microsoft might be dropped the synthetic kernel debugger interface sometime
>>>> > in the future, and it seems like the new mode is simply to use hvnet device
>>>> > for the communication (which is again much faster).
>
>Yes that's indeed the interface I have implemented this part of the 
>patch it not full ready for commit, but I think we can keep going with 
>the VMBUS.
>
>Based on your previous reply it sounds like there is not a real issue 
>with the current patch of ACPI DSDT entry, right?
>
>Thanks,
>-- Jon.

I suggest referring to the KVM patches I have already submitted that 
Paolo said will probably get in soon.
https://patchwork.kernel.org/patch/11507663/

