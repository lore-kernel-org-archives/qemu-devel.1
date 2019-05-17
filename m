Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A8C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620DD205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620DD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40383 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRT5d-0004Ql-Lu
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:59:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRT3y-0003HT-AL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRT3x-0003Az-5O
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:57:38 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hRT3w-0003Ah-VD
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:57:37 -0400
Received: by mail-wr1-f43.google.com with SMTP id s17so5455820wru.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VaY38fhqOGP9PGDK3srRL28PeYkiAkOCubxu5ar7h0w=;
	b=D1dhoeLcvTojtOIm6TzYdvUfEFbBibfaAX43qCj0qxhDGKe93kR9o400zbjde16vNQ
	TUVjaLRYzMTlbnULBmzQmZC1D0WUQu2jbjgRceJLOd0EQaxI5fFCVFNAgo/8qxeSxkGb
	dF9SYzNPB0PR+qWIr4su68ZlECRrICcI80056weWK6dr3h2zG4u+1cLfa8LUXe7CGOKr
	GkkO+nltDudJHWVfFDkTE4mlRCUvKUnzkx8pID8kYyjtv1eUJxuwct4MpAWmbSWm07/U
	qd3oWxd5NL7KmpfTEGmX5weE9QPrTDgQk+J3wWxeV1eBwSNYYxmozgOdXXFkP9sdd0RR
	cv7w==
X-Gm-Message-State: APjAAAUXxIUKsghY9oZwIQ1jZRbMNxb8FpcAKjr0VyiwGTAzdWVgiYnO
	zx6ifQUSG2ut3mMZKuPHZR9+cg==
X-Google-Smtp-Source: APXvYqzKE8LEDwWLJOE4JJLdgs+lPK+nJedePsPCU1t8xftIdWFSEsQSJhxUF2o/JLIH0kS081et3g==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr31492093wrn.39.1558061855614; 
	Thu, 16 May 2019 19:57:35 -0700 (PDT)
Received: from [172.27.174.155] (23-24-245-141-static.hfc.comcastbusiness.net.
	[23.24.245.141])
	by smtp.gmail.com with ESMTPSA id w2sm5114184wrm.74.2019.05.16.19.57.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:57:35 -0700 (PDT)
To: whiteheadm@acm.org
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
	<6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
	<ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
	<CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a471eb8d-0cc0-0205-c51d-ce3a75b6d799@redhat.com>
Date: Fri, 17 May 2019 04:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.43
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/05/19 02:30, tedheadster wrote:
> Paolo,
>   I am running the kvm32 machine and I see a problem. Here is the
> output of /proc/cpuinfo :
> 
> flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
> cmov constant_tsc
> 
> I see something rather important missing: cpuid.
> 
> A lot of stuff breaks without cpuid, and I am fairly sure that qemu is
> supposed to 'hard code' in support for it. It is present with both my
> i486 and i586 virtual machines.
> 
> - Matthew
> 

That's weird... The cpuid flag does not come from QEMU, it is a "soft"
flag determined by trying to toggle EFLAGS.ID and EFLAGS.ID behaves the
same for all CPU models.  What else do you see in /proc/cpuinfo?

Paolo

